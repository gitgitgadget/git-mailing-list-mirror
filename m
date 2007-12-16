From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Sun, 16 Dec 2007 17:15:45 -0500
Message-ID: <20071216221545.GA32596@coredump.intra.peff.net>
References: <20071215111621.GA8139@coredump.intra.peff.net> <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 23:16:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J41mM-0003yh-TE
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 23:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759727AbXLPWPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 17:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759178AbXLPWPt
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 17:15:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1681 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757197AbXLPWPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 17:15:48 -0500
Received: (qmail 3812 invoked by uid 111); 16 Dec 2007 22:15:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 16 Dec 2007 17:15:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2007 17:15:45 -0500
Content-Disposition: inline
In-Reply-To: <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68495>

On Sun, Dec 16, 2007 at 01:49:17PM -0800, Junio C Hamano wrote:

> Kind'a embarrassing that both of us cannot get this right without so
> many rounds, isn't it?

Good thing we can just delete the emails and nobody will be the wiser...

> +echo >expect <<\EOF

This would probably work better as 'cat'.

> +test_expect_success 'diff -U0' '
> +
> +	git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
> +	diff -u expect actual

Aren't we using "git diff" for the second diff there nowadays?

> -	while (recovered < trimmed && ctx)
> +	while (recovered < trimmed && 0 <= ctx)
>  		if (ap[recovered++] == '\n')
>  			ctx--;
>  	a->size -= (trimmed - recovered);

Oops (I think maybe I misunderstood what you were asking in the last
email). This fix is correct, though the code is now kind of subtle. I
think it would be more obvious as:

  /* finish off any changed line we are in */
  while (recovered < trimmed && ap[recovered++] != '\n')
    /* nothing */;
  /* recover context lines */
  while (recovered < trimmed && ctx)
    if (ap[recovered++] == '\n')
      ctx--;

Your loop does both actions in the same loop, which is correct, but took
me 10 minutes of thinking and staring to realize what was going on.

-Peff
