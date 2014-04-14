From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Makefile: use curl-config to determine curl flags
Date: Mon, 14 Apr 2014 13:22:03 -0700
Message-ID: <xmqqioqboe50.fsf@gitster.dls.corp.google.com>
References: <1397344502-23459-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 22:22:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZnOR-0001vL-LF
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 22:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbaDNUWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 16:22:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36163 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754192AbaDNUWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 16:22:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD3297D655;
	Mon, 14 Apr 2014 16:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fILqmkV2kVKT7d/fuBUZd5PolSw=; b=Gwj+W4
	ceBttuA6QXkRCWpOUHZO8MoLtRXcO1EaGhXaRntUKzSAlXHTP8Q9DN7YtyoR2rmd
	c+odBDrTYI+vr4hnlIVUbBIxyIljXq5FX3NSDXZnJIhi79gp+GXPv0VWPL/AxIyT
	EqFeVrecy72Ov65pSptOBVxhSpLSkzXHdTaJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mxGcKZivoVYpPm2l2zV4V/HQSJjIqAYa
	4a7WQnmF1Q1vHy/QUeOfLnxwT1r4yljX8B+7NY+06VluUk8L7hbxzizd5tHBCWUo
	1Al+D2peovQfVJM+mtS8UgjgfZKYYjycU/Ng6iOu0xDbGayhatoGSd9YI9G3lDhU
	6gcAgcMd1wI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD1F37D654;
	Mon, 14 Apr 2014 16:22:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB1507D650;
	Mon, 14 Apr 2014 16:22:05 -0400 (EDT)
In-Reply-To: <1397344502-23459-1-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Sat, 12 Apr 2014 16:15:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 729F4BBE-C412-11E3-B913-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246261>

Dave Borowitz <dborowitz@google.com> writes:

> curl-config should always be installed alongside a curl distribution,
> and its purpose is to provide flags for building against libcurl, so
> use it instead of guessing flags and dependent libraries.
>
> Allow overriding CURL_CONFIG to a custom path to curl-config, to
> compile against a curl installation other than the first in PATH.
>
> Use this only when CURLDIR is not explicitly specified, to continue
> supporting older builds.
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>

Sounds logically the right thing to do.  Was there a particular
platform that needed this (i.e. cannot be made to work with the
existing CURLDIR and "guessing flags and dependeent libraries")
that may be worth mentioning in the log message?

> ---
>  Makefile | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 2128ce3..d6330bc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -34,8 +34,12 @@ all::
>  # git-http-push are not built, and you cannot use http:// and https://
>  # transports (neither smart nor dumb).
>  #
> +# Define CURL_CONFIG to the path to a curl-config binary other than the
> +# default 'curl-config'.
> +#
>  # Define CURLDIR=/foo/bar if your curl header and library files are in
> -# /foo/bar/include and /foo/bar/lib directories.
> +# /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
> +# but is less robust.
>  #
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push is
>  # not built, and you cannot push using http:// and https:// transports (dumb).
> @@ -143,9 +147,11 @@ all::
>  #
>  # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
>  #
> -# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).
> +# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).  Only used
> +# if CURLDIR is set.
>  #
> -# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).
> +# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).  Only
> +# used if CURLDIR is set.
>  #
>  # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
>  #
> @@ -1121,18 +1127,23 @@ else
>  		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
>  		BASIC_CFLAGS += -I$(CURLDIR)/include
>  		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
> +		ifdef NEEDS_SSL_WITH_CURL
> +			CURL_LIBCURL += -lssl
> +			ifdef NEEDS_CRYPTO_WITH_SSL
> +				CURL_LIBCURL += -lcrypto
> +			endif
> +		endif
> +		ifdef NEEDS_IDN_WITH_CURL
> +			CURL_LIBCURL += -lidn
> +		endif
>  	else
> -		CURL_LIBCURL = -lcurl
> -	endif
> -	ifdef NEEDS_SSL_WITH_CURL
> -		CURL_LIBCURL += -lssl
> -		ifdef NEEDS_CRYPTO_WITH_SSL
> -			CURL_LIBCURL += -lcrypto
> +		CURL_CONFIG ?= curl-config
> +		BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
> +		CURL_LIBCURL = $(shell $(CURL_CONFIG) --libs)
> +		ifeq "$(CURL_LIBCURL)" ""
> +			$(error curl not detected; try setting CURLDIR)
>  		endif
>  	endif
> -	ifdef NEEDS_IDN_WITH_CURL
> -		CURL_LIBCURL += -lidn
> -	endif
>  
>  	REMOTE_CURL_PRIMARY = git-remote-http$X
>  	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
