From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH resend] Makefile: Use computed header dependencies if the
 compiler supports it
Date: Sun, 14 Aug 2011 14:00:50 -0500
Message-ID: <20110814190050.GA16819@elie.gateway.2wire.net>
References: <1313347512-7815-1-git-send-email-frekui@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 21:02:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsfxE-0003Ir-UD
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 21:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab1HNTA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 15:00:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64862 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab1HNTA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 15:00:58 -0400
Received: by gya6 with SMTP id 6so2858559gya.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6EZ73B6WmN48qJh9fV4w8FHpuK4VFjmGzfENRJl1j54=;
        b=TGC1Zx6Hi9pw6rs2RP56DYk3STQ+rTPxBLc22EfHDnBkGHn4EIh/Ky2AThGSiid7vP
         W83vSO3WI0YDr2kDhknz+F7Gb8ercMU2HskAN5Q1GCHRB7v7KpVmIhbdR7ae2WJ8UkUi
         tF5GdU2JVxN1YFRzhiB3ggO7Z4hebEqXU3Kk8=
Received: by 10.236.144.226 with SMTP id n62mr10178892yhj.136.1313348457725;
        Sun, 14 Aug 2011 12:00:57 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-76-206-233-80.dsl.chcgil.sbcglobal.net [76.206.233.80])
        by mx.google.com with ESMTPS id f4sm2971673yhn.69.2011.08.14.12.00.56
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 12:00:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313347512-7815-1-git-send-email-frekui@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179343>

Hi,

Fredrik Kuivinen wrote:

> Previously you had to manually define COMPUTE_HEADER_DEPENDENCIES to
> enable this feature. It seemed a bit sad that such a useful feature
> had to be enabled manually.

Yes!  Thanks for this.

I have a few thoughts about the implementation:

> --- a/Makefile
> +++ b/Makefile
[...]
> @@ -1236,6 +1232,15 @@ endif
>  ifdef CHECK_HEADER_DEPENDENCIES
>  COMPUTE_HEADER_DEPENDENCIES =
>  USE_COMPUTED_HEADER_DEPENDENCIES =
> +else
> +dep_check = $(shell sh -c \
> +	': > ++empty.c; \
> +	$(CC) -c -MF /dev/null -MMD -MP ++empty.c -o /dev/null 2>&1; \
> +	echo $$?; \
> +	$(RM) ++empty.c')
> +ifeq ($(dep_check),0)
> +COMPUTE_HEADER_DEPENDENCIES=YesPlease
> +endif

This causes "make foo" to run gcc and create a temporary file
unconditionally, regardless of what foo is.  In an ideal world:

 - the autodetection would only happen when building targets that
   care about it

 - the detection would happen once (creating some file to store the
   result) and not be repeated with each invocation of "make"

 - (maybe) there would be a way to override the detection with
   either a "yes" or "no" result, for those who really care to
   save a little time.

I was about to say that the GIT_VERSION variable has some of these
properties, but now that I check, from the point of view of the
Makefile it doesn't.  ./GIT-VERSION-GEN is just very fast. :)

I wonder if we can make do with a faster check, like

	$(CC) -c -MF /dev/null -MMD -MP git.c --help >/dev/null 2>&1

What do you think?
