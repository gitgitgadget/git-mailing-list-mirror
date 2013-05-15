From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings
 on Mac OS X
Date: Wed, 15 May 2013 19:56:59 +0200
Message-ID: <5193CC6B.50909@web.de>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 19:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucfws-0004G5-LY
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 19:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759929Ab3EOR5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 13:57:05 -0400
Received: from mout.web.de ([212.227.17.12]:59667 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759891Ab3EOR5D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 13:57:03 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M5Oql-1UIxAi3Wd5-00zFJq; Wed, 15 May 2013 19:57:00
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <1368601868-42410-1-git-send-email-davvid@gmail.com>
X-Provags-ID: V02:K0:sZMhznft9bxp+BHUQqnIIpotkcWnAi6S/9veRU2Bb0I
 lUZwrjMUNd8IEr6OFy64SHgpuJdyRmdIHNYv93GSHY5e3EapFB
 L1JHOvAzZi06C+dHW5VQJgef/JWghkfqz4Gfss68skUc0p7Qm0
 xGgI/QVi+Y8QodfbM/z9Ixb8CVTVGHDd8MYeEvBOg+Z/YPWEu3
 u5xIighT+iN2fkMC0bwsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224432>

On 2013-05-15 09.11, David Aguilar wrote:
> Mac OS X 10.8 Mountain Lion prints warnings when building git:
> 
> 	warning: 'SHA1_Init' is deprecated
> 	(declared at /usr/include/openssl/sha.h:121)
> 
> Silence the warnings by using the CommonCrytpo SHA-1
> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
> 
> COMMON_DIGEST_FOR_OPENSSL is defined to enable the OpenSSL
> compatibility macros in CommonDigest.h.
> 
> Add a NO_APPLE_COMMON_CRYPTO option to the Makefile to allow
> users to opt out of using this library.  When defined, Git will
> use OpenSSL instead.
> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Both of these are replacement patches "pu".
> 
> Changes from last time:
> 
> It now uses a single APPLE_COMMON_CRYPTO definition.
> Users can now opt-out by setting NO_APPLE_COMMON_CRYPTO.
> 
>  Makefile | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index f698c1a..8309c41 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -137,6 +137,10 @@ all::
>  # specify your own (or DarwinPort's) include directories and
>  # library directories by defining CFLAGS and LDFLAGS appropriately.
>  #
> +# Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
> +# and do not want to use Apple's CommonCrypto library.  This allows you
> +# to provide your own OpenSSL library, for example from MacPorts.
> +#
>  # Define BLK_SHA1 environment variable to make use of the bundled
>  # optimized C SHA1 routine.
>  #
> @@ -1054,6 +1058,9 @@ ifeq ($(uname_S),Darwin)
>  			BASIC_LDFLAGS += -L/opt/local/lib
>  		endif
>  	endif
> +	ifndef NO_APPLE_COMMON_CRYPTO
> +		APPLE_COMMON_CRYPTO = YesPlease
> +	endif
>  	NO_REGEX = YesPlease
>  	PTHREAD_LIBS =
>  endif
> @@ -1389,10 +1396,16 @@ ifdef PPC_SHA1
>  	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
>  	LIB_H += ppc/sha1.h
>  else
> +ifdef APPLE_COMMON_CRYPTO
> +	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
> +	SHA1_HEADER = <CommonCrypto/CommonDigest.h>

Would it make sense to replace APPLE_COMMON_CRYPTO
with COMMON_DIGEST_FOR_OPENSSL ?

In the spirit of other Makefile-defines becoming Compiler defines,
a random picked example:
ifdef NO_STRTOULL
	COMPAT_CFLAGS += -DNO_STRTOULL
endif

/Torsten
