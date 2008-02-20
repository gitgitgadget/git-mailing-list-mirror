From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 09:54:35 -0800
Message-ID: <7vk5kz7btw.fsf@gitster.siamese.dyndns.org>
References: <20080209030046.GA10470@coredump.intra.peff.net>
 <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de>
 <alpine.LSU.1.00.0802091307160.11591@racer.site>
 <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802100213330.11591@racer.site>
 <20080210101756.GB26568@coredump.intra.peff.net>
 <alpine.LSU.1.00.0802101219280.11591@racer.site>
 <20080210122321.GA31009@coredump.intra.peff.net>
 <alpine.LSU.1.00.0802101303140.11591@racer.site>
 <7vzltwavf9.fsf@gitster.siamese.dyndns.org>
 <20080220140306.GA6928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 18:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtB4-0007nA-DW
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 18:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763163AbYBTRzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 12:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763050AbYBTRzc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 12:55:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbYBTRz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 12:55:28 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F24E1264C;
	Wed, 20 Feb 2008 12:55:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 D11D3264A; Wed, 20 Feb 2008 12:55:13 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74526>

Jeff King <peff@peff.net> writes:

> ... In fact, I half-expected this to
> just work without a patch, since "git push origin HEAD" already works.
> However, we don't treat command line refspecs and config refspecs the
> same way, which IMHO is a needless inconsistency. How about this:
>
> diff --git a/builtin-push.c b/builtin-push.c
> index 9f727c0..ca90150 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -68,8 +68,7 @@ static int do_push(const char *repo, int flags)
>  	if (!refspec
>  		&& !(flags & TRANSPORT_PUSH_ALL)
>  		&& remote->push_refspec_nr) {
> -		refspec = remote->push_refspec;
> -		refspec_nr = remote->push_refspec_nr;
> +		set_refspecs(remote->push_refspec, remote->push_refspec_nr);
>  	}
>  	errs = 0;
>  	for (i = 0; i < remote->url_nr; i++) {

Yeah, we are on the same page.  See the patch I sent out last night ;-)

> At which point this now works as you described:
>
>   git config remote.origin.push HEAD

Exactly.

>> I was hoping we can do without the "remote.*.push = HEAD" if we
>> can detect the remote is a shared repository while talking to
>> it, but I think it is a bit too much magic, because we cannot
>> visualize what the pushing side and the receiving side  are
>> negotiating.
>
> How are you detecting that the remote is a shared repository?

I am not.  I only said "... may even be able to" ;-).

The autodetection is not even the first step to tackle this
issue anyway.  The "HEAD" magic (or if somebody comes up with a
better design, that one) comes first, deciding if such an
autodetection is even a good idea comes next, and then iff we
decide that it is a good idea finally comes the task of finding
out how we do so.

I'd presume that the upload-pack side can internally check "int
shared_repository" and the protocol extension that conveys that
information to the other end is easy enough.  As always, dumb
transports are second class citizens and need their own hacks.

> By the core.sharedrepository config option? I use several
> shared repositories, and I never set that variable; instead
> ...

It is _your_ problem that you do not use published interface,
isn't it?
