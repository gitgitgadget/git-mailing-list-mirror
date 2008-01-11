From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 4/5] Use new compress helpers in http-push.c
Date: Fri, 11 Jan 2008 10:39:41 -0500
Message-ID: <1200065981.18570.8.camel@gaara.boston.redhat.com>
References: <e5bfff550801102339o757eea62h40b5e00cd904f7e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 16:40:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDLzp-00008w-Ai
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 16:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759935AbYAKPkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 10:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759971AbYAKPkH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 10:40:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759826AbYAKPkF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 10:40:05 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0BFdlSj013869;
	Fri, 11 Jan 2008 10:39:47 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0BFdk8p015485;
	Fri, 11 Jan 2008 10:39:46 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0BFdk0T017108;
	Fri, 11 Jan 2008 10:39:46 -0500
In-Reply-To: <e5bfff550801102339o757eea62h40b5e00cd904f7e1@mail.gmail.com>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70169>

On Fri, 2008-01-11 at 08:39 +0100, Marco Costalba wrote:
> A multistep compress is required here, so
> we need the full arsenal of compress helpers.
> 
> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>  http-push.c |   22 ++++++++--------------
>  1 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/http-push.c b/http-push.c
> index 55d0c94..b7fe57f 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "commit.h"
> +#include "compress.h"
>  #include "pack.h"
>  #include "tag.h"
>  #include "blob.h"
> @@ -491,31 +492,24 @@ static void start_put(struct transfer_request
>  	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
> 
>  	/* Set it up */
> -	memset(&stream, 0, sizeof(stream));
> -	deflateInit(&stream, zlib_compression_level);
> -	size = deflateBound(&stream, len + hdrlen);
> +	size = compress_alloc(&stream, zlib_compression_level, len + hdrlen);
>  	strbuf_init(&request->buffer.buf, size);
>  	request->buffer.posn = 0;
> 
>  	/* Compress it */
> -	stream.next_out = (unsigned char *)request->buffer.buf.buf;
> -	stream.avail_out = size;
> +	compress_start(&stream, (void *)hdr, hdrlen,
> +                      (unsigned char *)request->buffer.buf.buf, size);
> 
>  	/* First header.. */
> -	stream.next_in = (void *)hdr;
> -	stream.avail_in = hdrlen;
> -	while (deflate(&stream, 0) == Z_OK)
> -		/* nothing */;
> +	compress_next(&stream, Z_NO_FLUSH);

How about moving next_in and avail_in to be args of compress_next() so
the user doesn't have to deal with the z_stream object at all?  For
example:

	compress_next(&stream, hdr, hdrlen, Z_NO_FLUSH);

and of course remove them from the compress_start() function.

>  	/* Then the data itself.. */
>  	stream.next_in = unpacked;
>  	stream.avail_in = len;
> -	while (deflate(&stream, Z_FINISH) == Z_OK)
> -		/* nothing */;
> -	deflateEnd(&stream);
> -	free(unpacked);
> +	compress_next(&stream, Z_FINISH);

This whole chunk just becomes

	compress_next(&stream, unpacked, len, Z_FINISH);

cheers,
Kristian
