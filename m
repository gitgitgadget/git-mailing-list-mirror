From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 13:31:17 -0700
Message-ID: <7vzk7zyrfu.fsf@alter.siamese.dyndns.org>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com>
 <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com>
 <7vipen191a.fsf@alter.siamese.dyndns.org>
 <20120619201259.GB14692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh55B-0000AD-8t
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab2FSUbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:31:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162Ab2FSUbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:31:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 741A48DAC;
	Tue, 19 Jun 2012 16:31:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u5HN0Aa8ZCOiB5BtyoLaDrydCLc=; b=KWGAN8
	zRqi6x8b3kwnTJKu2GvD1PE9q4au50MvicvG2aRB+uL5ZxcYVPPPcFDoCROi5ewT
	7OvuFb8QV2Fhb9WyXM78MaDQGg9HnBwK4TbGBxuQP6XH8SMwAPQ+z+qNXbJxCXl0
	jihhEeU6PpIzu4AfafOK7AyFCyMjt96x4uSZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQOeXCcYcrnK1mcYb8PNMNifWQ5c7bj1
	makYgJcjRwrOQ9LaZEgYmb3yi3feBbyUVgybYRZo6jd0n0VCN+8N3WW3mm827yv8
	Q2j8pVokVLfe5YypQGSVwFSF+6okIBr6ike365BZXetsC/NwNeoEPEsEXmBOhno1
	WoxOczXtfgM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BA128DAB;
	Tue, 19 Jun 2012 16:31:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3B798DAA; Tue, 19 Jun 2012
 16:31:18 -0400 (EDT)
In-Reply-To: <20120619201259.GB14692@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 16:12:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9ABF71C-BA4D-11E1-8038-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200239>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 19, 2012 at 10:55:13AM -0700, Junio C Hamano wrote:
>
>> I do not have a strong opinion either way, other than that I would
>> prefer predictable behaviour over "works most of the time provided
>> if the user does X, otherwise does this random thing".  And coming
>> from that standpoint, erroring out when there needs a guess involved
>> is certainly more predictable---it is a cop-out option for me in
>> areas of the system I do not have strong preferences.
>
> One thing that makes me nervous about this patch is that it is not just a
> change to git-submodule, but rather to git-parse-remote.  So it could
> affect other parts of the system, too, where a guess might not be as
> desirable.

That is exactly what I meant when I said "to make everything ... in
a consistent way, without breaking existing users who rely on the
current behaviour" (emphasis on *everything*).  Also, I was (and am)
reasonably sure that no such acceptable change exists in the "guess
harder and pick a remote randomly" direction.  Rather, I suspect
that a consistent solution would be to tighten things to error out
when in doubt, and correct submodule codepath that blindly uses
'origin' without erroring out by mistake, if that is the case (if
what Marc alluded to was true; I didn't check).

> The number of affected code paths is fortunately quite small, since this
> is updating the shell library, and most of the remote-handling code is
> written in C these days.

Which would mean that users of git-parse-remote will end up
deviating further from the norm if we allow patches that head in
this direction to continue.  That is one more reason to reject it.

> ...
> Should this be a submodule-only thing?

I'd rather not have any "submodule-only" thing; that would give us
one less inconsistency to worry about.  As Jens and Heiko both seem
to think "pick a remote randomly" is a bad approach, I am not so
worried about this discussion breaking areas outside submodules.
