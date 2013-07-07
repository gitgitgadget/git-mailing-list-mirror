From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore-pickaxe: simplify has_changes and contains
Date: Sun, 7 Jul 2013 00:03:37 -0400
Message-ID: <20130707040337.GA30898@sigill.intra.peff.net>
References: <1373118807-1345-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jul 07 06:03:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvgCP-0005kS-If
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 06:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab3GGEDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jul 2013 00:03:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:44416 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3GGEDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 00:03:41 -0400
Received: (qmail 27644 invoked by uid 102); 7 Jul 2013 04:04:54 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Jul 2013 23:04:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 00:03:37 -0400
Content-Disposition: inline
In-Reply-To: <1373118807-1345-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229725>

On Sat, Jul 06, 2013 at 03:53:27PM +0200, Ren=C3=A9 Scharfe wrote:

> Halve the number of callsites of contains() to two using temporary
> variables, simplifying the code.  While at it, get rid of the
> diff_options parameter, which became unused with 8fa4b09f.

There is a slight change in behavior, too:

> -	if (!one)
> -		return contains(two, o, regexp, kws) !=3D 0;
> -	if (!two)
> -		return contains(one, o, regexp, kws) !=3D 0;
> -	return contains(one, o, regexp, kws) !=3D contains(two, o, regexp, =
kws);
> +	unsigned int one_contains =3D one ? contains(one, regexp, kws) : 0;
> +	unsigned int two_contains =3D two ? contains(two, regexp, kws) : 0;
> +	return one_contains !=3D two_contains;

Before, if (!one && !two) we would call contains(two, ...), and now we
will simply assume it is zero. Which I think is an improvement, as we
would have segfaulted before. I don't think it is a bug in the current
code (we would not ever feed the function two NULLs), but it is nice to
be more defensive.

Acked-by: Jeff King <peff@peff.net>

-Peff
