From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t0003: do not chdir the whole test process
Date: Thu, 06 Feb 2014 13:26:39 -0800
Message-ID: <xmqqd2j0x78w.fsf@gitster.dls.corp.google.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
	<1391712033-9443-1-git-send-email-gitster@pobox.com>
	<20140206194521.GU30398@google.com>
	<xmqqvbwsxa2b.fsf@gitster.dls.corp.google.com>
	<20140206203101.GX30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lasse Makholm <lasse.makholm@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 22:26:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBWTG-0005yj-5C
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 22:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbaBFV0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 16:26:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbaBFV0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 16:26:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B82446A1EC;
	Thu,  6 Feb 2014 16:26:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6s6TjT1DWx/SHqpA82lRlLiOy6s=; b=D+cv1f
	IUT0skguOhKfJxa33DQedsJy5CRl/vbDpLB5GiW7O/T6Wmf+L8CB/IuabSvLSu4k
	krUFgxiqWBDuO5S4xJXPRun6V1L8NsTOS0Cxo5+KIb4ZjiVnDFoTNpTbLTTrgPgW
	xgRsZ8UWu0gFjTV5iX+AWSAUVRr5wGGiHFa/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jbGI+088vsupQGlIUOgnlCiyNblQlL6m
	C8LhnfJDxsV48IPWJERyRWNmDFqybqj1NlhqkslxHMcMstcoSz01uPV/c2taoSgQ
	zgwShbQV+X+EURA7q2qOirZTeGkZWZGTzesSvYY7uq1iDhL0ZdYhTWOusRCdFydI
	kg1LZb9PW9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 917D56A1EB;
	Thu,  6 Feb 2014 16:26:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB4B46A1E7;
	Thu,  6 Feb 2014 16:26:40 -0500 (EST)
In-Reply-To: <20140206203101.GX30398@google.com> (Jonathan Nieder's message of
	"Thu, 6 Feb 2014 12:31:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E5DF442-8F75-11E3-BBA7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241745>

Jonathan Nieder <jrnieder@gmail.com> writes:

> For a while I've been wanting to teach GIT_SKIP_TESTS not to skip
> tests with 'setup' or 'set up' in their name, but I never got around
> to it.

Yeah, that would be a good thing.  As part of doing so, we might
want to come up with a way to test the tests, randomly skipping
pieces that are not "setup" and find ones that break the later tests
when skipped, and mark test scripts that fail such a test for fixing.

> If I try to skip the setup test this patch touches, then there
> is no bare.git and lots of later tests fail.  Perhaps it would be
> better for each test to do
>
> 	rm -fr bare.git &&
> 	git clone --bare . bare.git &&
> 	(
> 		cd bare.git &&
> 		...
> 	)
>
> for itself to make the state easier to think about.

That is a better and worse way to do it at the same time ;-)  It
definitely is better from maintainability POV to keep each test as
independent as possible.  It however also is worse if it forces us
to be repetitive X-<.

> On the other hand I agree that the 'cd' here is a bad practice.  I
> just don't think it's about skipping setup --- instead, it's about it
> being hard to remember the cwd in general.

Exactly.
