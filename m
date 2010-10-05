From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3] do not depend on signed integer overflow
Date: Tue, 05 Oct 2010 00:17:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010050012490.3107@xanadu.home>
References: <1286232552-5244-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 06:17:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2yy0-0001uB-KF
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 06:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742Ab0JEERO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 00:17:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55691 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab0JEERN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 00:17:13 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L9S000V0UKJ8R60@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Oct 2010 00:17:08 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1286232552-5244-1-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158164>

On Tue, 5 Oct 2010, Erik Faye-Lund wrote:

> Signed integer overflow is not defined in C, so do not depend on it.
> 
> This fixes a problem with GCC 4.4.0 and -O3 where the optimizer would
> consider "consumed_bytes > consumed_bytes + bytes" as a constant
> expression, and never execute the die()-call.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

I like this.  Please also fix the similar case in 
builtin/pack-objects.c:write_one().

> ---
>  builtin/index-pack.c     |    2 +-
>  builtin/unpack-objects.c |    2 +-
>  git-compat-util.h        |   12 ++++++++++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 2e680d7..e243d9d 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -161,7 +161,7 @@ static void use(int bytes)
>  	input_offset += bytes;
>  
>  	/* make sure off_t is sufficiently large not to wrap */
> -	if (consumed_bytes > consumed_bytes + bytes)
> +	if (signed_add_overflows(consumed_bytes, bytes))
>  		die("pack too large for current definition of off_t");
>  	consumed_bytes += bytes;
>  }
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 685566e..f63973c 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -83,7 +83,7 @@ static void use(int bytes)
>  	offset += bytes;
>  
>  	/* make sure off_t is sufficiently large not to wrap */
> -	if (consumed_bytes > consumed_bytes + bytes)
> +	if (signed_add_overflows(consumed_bytes, bytes))
>  		die("pack too large for current definition of off_t");
>  	consumed_bytes += bytes;
>  }
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 81883e7..2af8d3e 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -28,6 +28,18 @@
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>  #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
>  
> +#define maximum_signed_value_of_type(a) \
> +    (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
> +
> +/*
> + * Signed integer overflow is undefined in C, so here's a helper macro
> + * to detect if the sum of two integers will overflow.
> + *
> + * Requires: a >= 0, typeof(a) equals typeof(b)
> + */
> +#define signed_add_overflows(a, b) \
> +    ((b) > maximum_signed_value_of_type(a) - (a))
> +
>  #ifdef __GNUC__
>  #define TYPEOF(x) (__typeof__(x))
>  #else
> -- 
> 1.7.3.1.51.g3f36d.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
