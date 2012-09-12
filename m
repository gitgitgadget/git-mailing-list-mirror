From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] sha1: use char type for temporary work buffer
Date: Wed, 12 Sep 2012 14:38:33 -0400
Message-ID: <20120912183833.GA20795@sigill.intra.peff.net>
References: <cover.1347442430.git.ydroneaud@opteya.com>
 <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 20:38:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrpp-0006Ou-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 20:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408Ab2ILSim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 14:38:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42624 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab2ILSil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 14:38:41 -0400
Received: (qmail 27266 invoked by uid 107); 12 Sep 2012 18:39:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Sep 2012 14:39:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Sep 2012 14:38:33 -0400
Content-Disposition: inline
In-Reply-To: <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205323>

On Wed, Sep 12, 2012 at 12:30:45PM +0200, Yann Droneaud wrote:

> The SHA context is holding a temporary buffer for partial block.
> 
> This block must 64 bytes long. It is currently described as
> an array of 16 integers.
> 
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
>  block-sha1/sha1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> index b864df6..d29ff6a 100644
> --- a/block-sha1/sha1.h
> +++ b/block-sha1/sha1.h
> @@ -9,7 +9,7 @@
>  typedef struct {
>  	unsigned long long size;
>  	unsigned int H[5];
> -	unsigned int W[16];
> +	unsigned char W[64];
>  } blk_SHA_CTX;

Wouldn't this break all of the code that is planning to index "W" by
32-bit words (see the definitions of setW in block-sha1/sha1.c)?

You do not describe an actual problem in the commit message, but reading
between the lines it would be "system X would like to use block-sha1,
but has an "unsigned int" that is not 32 bits". IOW, an ILP64 type of
architecture. Do you have some specific platform in mind?

If that is indeed the problem, wouldn't the simplest fix be using
uint32_t instead of "unsigned int"?

Moreover, would that be sufficient to run on such a platform? At the
very least, "H" above would want the same treatment. And I would not be
surprised if some of the actual code in block-sha1/sha1.c needed
updating, as well.

-Peff
