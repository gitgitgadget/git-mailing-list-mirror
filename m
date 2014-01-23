From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] ewah: support platforms that require aligned reads
Date: Thu, 23 Jan 2014 15:44:56 -0800
Message-ID: <20140123234456.GF18964@google.com>
References: <20140123212036.GA21299@sigill.intra.peff.net>
 <20140123212752.GC21705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:45:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6TxP-0005Rr-Nk
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbaAWXpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:45:05 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:63241 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaAWXpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 18:45:03 -0500
Received: by mail-bk0-f49.google.com with SMTP id v15so742897bkz.8
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 15:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vpyfK+vPw/p6T6RM8e9hyLpI64SBEuRMboaGJ53R0sw=;
        b=NjpmTjnb/0rVOGryzUzrr1dh69OCW+TTdwKYv1B+vR2uJbPi9xrTZNmWgw0Ona1H2V
         86iSO/axZzCP6XQJiblk4hNOQVSPBNTUXQub7W6qgsjwz0gQuKHI0qgyi3EWHSq/p7ru
         NeV491fd4/F+pC4NUY2w1oN00rQtjPW5egpyeXopE4EqW7ZWY1MKqWvIt+MTpzOEujlk
         KWO5X59FwN3roNbCyXfU4NmudzNa2RmUmaS+tubCc5cBZNO4yzlMRpizc+8Wj7rYjCOA
         yPXdHLX/jRTjtQkVo+omd8BoTVBflHDvo9j4rxv0lrlN+zTsres68rZ/3+3oXvwIOgeX
         SE8g==
X-Received: by 10.204.60.71 with SMTP id o7mr4892200bkh.33.1390520701555;
        Thu, 23 Jan 2014 15:45:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id s9sm672757bkg.15.2014.01.23.15.44.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 15:45:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123212752.GC21705@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240974>

Jeff King wrote:

> --- a/ewah/ewah_io.c
> +++ b/ewah/ewah_io.c
> @@ -112,23 +112,38 @@ int ewah_serialize(struct ewah_bitmap *self, int fd)
[...]
> +#if __BYTE_ORDER != __BIG_ENDIAN

Is this portable?

On a platform without __BYTE_ORDER or __BIG_ENDIAN defined,
it is interpreted as

	#if 0 != 0

which means that such platforms are assumed to be big endian.
Does Mingw define __BYTE_ORDER, for example?


> +	{
> +		size_t i;
> +		for (i = 0; i < self->buffer_size; ++i)
> +			self->buffer[i] = ntohll(self->buffer[i]);
> +	}
> +#endif

It's tempting to guard with something like

	if (ntohl(1) != 1) {
		...
	}

The optimizer can tell if this is true or false at compile time, so
it shouldn't slow anything down.

With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the quick fix.

diff --git i/ewah/ewah_io.c w/ewah/ewah_io.c
index 4a7fae6..5a527a4 100644
--- i/ewah/ewah_io.c
+++ w/ewah/ewah_io.c
@@ -135,13 +135,11 @@ int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
 	memcpy(self->buffer, ptr, self->buffer_size * sizeof(uint64_t));
 	ptr += self->buffer_size * sizeof(uint64_t);
 
-#if __BYTE_ORDER != __BIG_ENDIAN
-	{
+	if (ntohl(1) != 1) {
 		size_t i;
 		for (i = 0; i < self->buffer_size; ++i)
 			self->buffer[i] = ntohll(self->buffer[i]);
 	}
-#endif
 
 	self->rlw = self->buffer + get_be32(ptr);
 
