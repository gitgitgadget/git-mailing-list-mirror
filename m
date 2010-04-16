From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make rev_compare_tree less confusing.
Date: Fri, 16 Apr 2010 13:23:30 -0700
Message-ID: <7v1vefcfjx.fsf@alter.siamese.dyndns.org>
References: <1271321171-12176-1-git-send-email-struggleyb.nku@gmail.com>
 <201004161131.06880.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>,
	<gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 16 22:23:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2s4s-0005y6-AI
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 22:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406Ab0DPUXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 16:23:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab0DPUXm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 16:23:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9377AAB569;
	Fri, 16 Apr 2010 16:23:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s9T0wAzWVlG0VJVUPFoBoxqeOlE=; b=ccGmoE
	e0ge7TifJ4fh7ln1O7MQNmevnTBSGjC4YJ79iQ94hwZ/JwGbZmGVQlLkA5oHU6wm
	5SiCcooxJ053YviFPCP+dIKvFqMXA2IWZq5ZaO+p9e2gRky7+zQgzEi4FCzuHXFe
	VF1pr6/aLN65TnGGN30vYokanxOn1i9DHsLKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DUHa5fZVJD62HWdaE3fv0EA/ksAkub2r
	UB6fPSssYzOXBQMSMVL7Qdl18DDG6PtV+WgACKLYqhrfQVdhC31s/+zhevjLikaZ
	aUVqtOLNmx6h8mEdjXth1RojoA49A56PWIwGOtz54G2vQBXjTQPa2aTYMZwrCxsb
	SgQ+XKdk35I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C9AFAB567;
	Fri, 16 Apr 2010 16:23:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C0BCAB562; Fri, 16 Apr
 2010 16:23:31 -0400 (EDT)
In-Reply-To: <201004161131.06880.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri\, 16 Apr 2010 11\:31\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF9E8C3E-4995-11DF-A8BE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145093>

Thomas Rast <trast@student.ethz.ch> writes:

> Interestingly enough, this call survived with slight changes here and
> there from all the way back in cf48454 (Teach git-rev-list to follow
> just a specified set of files, 2005-10-20), where it was added in
> rev-list.c.  Even back then diff_tree() would always return 0.

The idea always have been that diff_tree() may some day start returning
non-fatal errors (otherwise it calls die() so that the caller does not
even have a chance to worry about the return value), and the particular
codepath the patch touches would treat such "one of the trees is unreadble
so we cannot say if/how different they are" case as "there may be a change
worth showing (even if the actual change couldn't be shown)".

So I'm a bit reluctant to accept this patch under discussion.  It doesn't
change the behaviour, it doesn't make the _interface_ any simpler, and it
removes the documentation value of what _should_ happen if diff_tree()
were to be updated in such a way.

It is entirely a different matter if the patch were to change the function
signature of diff_tree() to return "void" and adjust all the callers
involved.  That will make the _interface_ simpler without changing the
behaviour, and it makes it absolutely clear that we would _never_ enhance
git to say "some necessary data for comparison is missing---we report
error and allow the caller to err on the safe side and say 'there could be
difference but the details we cannot say'".
