From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Tue, 22 Jul 2014 09:47:48 -0700
Message-ID: <xmqqk375gx1n.fsf@gitster.dls.corp.google.com>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com>
	<20140722110720.GA386@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:48:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9dEi-0007nd-9I
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 18:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbaGVQsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 12:48:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55709 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756244AbaGVQsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 12:48:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCBF12992A;
	Tue, 22 Jul 2014 12:48:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+KmzHOfkYxq1G8D7sV1vaYjNwkA=; b=vK+zxb
	NUb7uplRfZBuslVlzU97Oy9WRucfNkFLelIgkKAHs2RSR34xck2sIqLnNgYuqH5A
	8tlH0HAhjFyv3tt9CyZLPsB2WkqjtGergQDh0j+QGP8XFaftUjKulNXDhCP9sHH9
	ODDXeL7LoywFILqMmbU/ksfjRpsvje0m8XlFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SIZbD8BaIy1O1z4XbpngZvaazRQBgc3H
	YhoxuchtMLI+GPwQEq6QEw/9D5ZYt6VSlus8qNjJzGsH8DY6G6UPUWewIiZ7u/z2
	A/Ls1Yq6XunJXVZeMdXhA6Kk/vM1SldWmqqVOXj5ZdPVNfm7mJdKSjSLh+hUDQAD
	/Zst64EN6sI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB08929927;
	Tue, 22 Jul 2014 12:48:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A766729906;
	Tue, 22 Jul 2014 12:47:50 -0400 (EDT)
In-Reply-To: <20140722110720.GA386@peff.net> (Jeff King's message of "Tue, 22
	Jul 2014 07:07:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EAFF27A0-11BF-11E4-A5E7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254021>

Jeff King <peff@peff.net> writes:

> So I would not mind lifting this unnecessary restriction on
> git_config_string, but I do not see a way to do it without making the
> rest of the code much uglier (and I do not see a particular advantage in
> modifying git_config_string here that would make it worth the trouble).

I do not think changing the existing one is warranted, either.

Given that C's type system does not allow us to pass "const char *"
as "char *" without cast (and vice versa), a function that takes an
out parameter that points at the location to store the pointer to a
string (instead of returning the pointer to a string as value) has
to take either one of these forms:

	get_mutable(char **dest);
        get_const(const char **dest);

and half the callers need to pass their variables with a cast, i.e.

        char *mutable_string;
	const char *const_string;

	get_mutable((char **)&const_string);
        get_mutable(&mutable_string);
	get_const(&const_string);
	get_const((const char **)&mutable_string);

If we have to cast some [*1*], I'd prefer to see the type describe
what it really is, and I think a function that gives a newly
allocated storage for the callers' own use is better described by
taking a pointer to non-const "char *" location.  So I'd encourage a
new function being introduced that does not have existing callers to
use that as the criterion to decide which to take.

Changing the existing function with existing calling site needs two
other pros-and-cons evaluation, in addition to the above "does the
type describe what it really is?", which are "is it worth the
churn?" and "does the end result make more sense than the original?"


[Footnote]

*1* We have safe_create_leading_directories_const() that works
around this for input parameter around its _const less counterpart,
which is ugly but livable solution.
