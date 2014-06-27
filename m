From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/4] verify-commit: verify commit signatures
Date: Fri, 27 Jun 2014 12:07:35 -0700
Message-ID: <xmqqoaxe1894.fsf@gitster.dls.corp.google.com>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
	<cover.1403877430.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 21:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0bUw-0008GT-CR
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 21:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbaF0THm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 15:07:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61451 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbaF0THm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 15:07:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9FEA21AB9;
	Fri, 27 Jun 2014 15:07:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=31Ye3ut5FMiw/NgKo+ShTZjsi3w=; b=YlOOBh
	OOjZLYVtt0EBsR+xDDaOF2qL/RYyIO3ikTEC4j5svNq/ymB6N6c2BSFrO1gjfIjA
	ugQUhjLRhVGaOa+Ef9e1UihdyNk41UgfM4gps38swRsHp2CSUxdRtgAYi5tFr/Iw
	T4fhASgUkDXS5PCBqtOK61rIKqxtKVPN8QsoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cK3wcHroOXlZzzPc4AuylmQp1Z7cF3tt
	YM0bNtY3Y+3RfuXvIYoj0pTAWKEVUbtL6VoynsEPSHwGEfnCaHimhHi4keKgSmXT
	J4XLo2qcjdlXw66UpDiY7+1QnEUvA4EhqNHi6JYUbuuNRn1/dkjTN0JuihqxQSa6
	L2/NfGnMwZM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFFE421AB8;
	Fri, 27 Jun 2014 15:07:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C97721AB2;
	Fri, 27 Jun 2014 15:07:27 -0400 (EDT)
In-Reply-To: <cover.1403877430.git.git@drmicha.warpmail.net> (Michael
	J. Gruber's message of "Fri, 27 Jun 2014 16:13:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 47F7F676-FE2E-11E3-A508-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252572>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This is v3 rebased on current next (the %G works by Jeff & Junio).
>
> Open questions:
>
> - Should one of git verify-{commit,tag} learn how to verify mergetags?
> (Probably no, it differs from both other cases.)

If we were to teach one of them, "verify-commit" as part of
"verifying what is recorded in the commit object", would be the
logical place to do so.

It is OK to implement only verification of signatures on commit
objects themselves, but we would need a plan for handling other
kinds of verifications later, so that we can give a stable output to
scripts.

If we decide to signal successful verification of the signature on
the commit itself one way in this implementation, that should
reliably be the way to do so even if we later add verification of
other aspects on the commit object (e.g. mergetags it carries).  If
running "verify-commit $commit" and checking the zero-ness of its
exit status is the way, that should not change if later versions of
Git learns to verify mergetags as well; even if the given $commit
carries a mergetag that does not verify, as long as the signature in
the commit itself is valid, the script should continue to receive
"success" from the command.

> - Should we do this now or go for generic "git verify" right away?

I do not think we are ready to do "git verify" yet.  We first need
to design how "verify-commit" should communicate failure/success
combinations of verification of a commit that has a signature on
itself and a mergetag on one of its parents, and of a commit that
has zero or one signature on itself and two or more mergetags on its
parents.  Do we fail unless all of them are found to be valid?  Do
we use bits in exit status?  Output to the standard output, one line
per signature verified?
