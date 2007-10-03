From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Be nice with compilers that do not support runtime paths at all.
Date: Wed, 03 Oct 2007 16:18:08 -0700
Message-ID: <7vejgbdbyn.fsf@gitster.siamese.dyndns.org>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org>
	<1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Oct 04 01:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdDU2-00037q-45
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 01:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXJCXSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 19:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbXJCXSP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 19:18:15 -0400
Received: from rune.pobox.com ([208.210.124.79]:56665 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbXJCXSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 19:18:15 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id F1331141414;
	Wed,  3 Oct 2007 19:18:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3ABE81406DE;
	Wed,  3 Oct 2007 19:18:33 -0400 (EDT)
In-Reply-To: <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr> (Benoit
	Sigoure's message of "Thu, 4 Oct 2007 00:20:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59907>

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

> diff --git a/Makefile b/Makefile
> index a1fe443..7c6c453 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -100,6 +100,9 @@ all::
>  # that tells runtime paths to dynamic libraries;
>  # "-Wl,-rpath=/path/lib" is used instead.
>  #
> +# Define NO_RPATH if your dynamic loader doesn't support runtime paths at
> +# all.
> +#
>  # Define USE_NSEC below if you want git to care about sub-second file mtimes
>  # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
>  # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely

Thanks for this part;

> @@ -507,6 +510,7 @@ ifeq ($(uname_S),Darwin)
>  			BASIC_LDFLAGS += -L/opt/local/lib
>  		endif
>  	endif
> +        NO_RPATH = YesPlease
>  endif

I'll let Darwin users to fight the defaults for this part out.

> @@ -521,7 +525,10 @@ ifndef NO_CURL
>  	ifdef CURLDIR
>  		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
>  		BASIC_CFLAGS += -I$(CURLDIR)/include
> -		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
> +		CURL_LIBCURL = -L$(CURLDIR)/$(lib) -lcurl
> +ifndef NO_RPATH
> +		CURL_LIBCURL += $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
> +endif
>  	else
>  		CURL_LIBCURL = -lcurl
>  	endif

> @@ -539,7 +546,10 @@ endif
>  
>  ifdef ZLIB_PATH
>  	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
> -	EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
> +	EXTLIBS += -L$(ZLIB_PATH)/$(lib)
> +ifndef NO_RPATH
> +	EXTLIBS += $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
> +endif
>  endif
>  EXTLIBS += -lz
>  

While these parts are ugly but correct, I think...

> @@ -547,7 +557,10 @@ ifndef NO_OPENSSL
>  	OPENSSL_LIBSSL = -lssl
>  	ifdef OPENSSLDIR
>  		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
> -		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib) $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(lib)
> +		OPENSSL_LINK = -L$(OPENSSLDIR)/$(lib)
> +ifndef NO_RPATH
> +		OPENSSL_LINK = $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(lib)
> +endif
>  	else
>  		OPENSSL_LINK =
>  	endif

this and the ICONV one are missing s/=/+=/.

If we do not care about supporting too old GNU make, we can do
this by first adding this near the top:

        ifndef NO_RPATH
        LINKER_PATH = -L$(1) $(CC_LD_DYNPATH)$(1)
        else
        LINKER_PATH = -L$(1)
        endif

and then doing something like:

	CURL_LIBCURL = $(call LINKER_PATH,$(CURLDIR)/$(lib))
	OPENSSL_LINK = $(call LINKER_PATH,$(OPENSSLDIR)/$(lib))

to make it easier to read and less error prone.
