From: Junio C Hamano <gitster@pobox.com>
Subject: Re: trim_common_tail bug?
Date: Sat, 15 Dec 2007 09:49:06 -0800
Message-ID: <7vprx7n90t.fsf@gitster.siamese.dyndns.org>
References: <20071215111621.GA8139@coredump.intra.peff.net>
	<20071215155150.GA24810@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3b99-0002Vu-3U
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 18:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137AbXLORtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 12:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933085AbXLORtZ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 12:49:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827AbXLORtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 12:49:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03BCC7D5E;
	Sat, 15 Dec 2007 12:49:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 74DA17D5C;
	Sat, 15 Dec 2007 12:49:13 -0500 (EST)
In-Reply-To: <20071215155150.GA24810@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 15 Dec 2007 10:51:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68402>

Jeff King <peff@peff.net> writes:

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 700def2..eb60e88 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -124,6 +124,8 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
>  	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
>  		while (recovered < trimmed && ap[recovered] != '\n')
>  			recovered++;
> +		if (recovered < trimmed && ap[recovered] == '\n')
> +			recovered++;
>  	}
>  	a->size -= (trimmed - recovered);
>  	b->size -= (trimmed - recovered);

Shoot.  Thanks for spotting.

Wouldn't it be enough to do:

  	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
		while (recovered < trimmed && ap[recovered++] != '\n')
	        	; /* nothing */
	}

then (warning: I haven't had my coffee yet)?
