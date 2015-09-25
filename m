From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] configure: make curl-config path configurable
Date: Thu, 24 Sep 2015 17:21:48 -0700
Message-ID: <xmqqio6zuz4z.fsf@gitster.mtv.corp.google.com>
References: <1443124243-15134-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Fri Sep 25 02:22:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfGlx-0002q2-SE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 02:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbbIYAVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 20:21:52 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35712 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbbIYAVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 20:21:50 -0400
Received: by pacfv12 with SMTP id fv12so88942008pac.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4Evw5s1SmXtBsSdMtHaBuSQvsVS8G3EXe0UhlnXzUpE=;
        b=NsM2p1oPrx1AUWXbSw9rJXvuQmUHn86w01Di7/U8/nh5A//+MWTScnhLyyx4ShRiVE
         /I/3hfQsBtH4xzej/WSJZ2Ar6Rw/1EYkYslfoJRQ9X/94uIVK3SstaS8zOsKpnEkqU+z
         8mZjb5ctA/jBd53iPhIkBP+XbtYytJNuvrFAxAFagYLn6jWRDcoG6+OWEvm2vZHUVSDj
         9c03Z1jg+Nx2sj0/jvyM0RuXl/JT9O+nCVenkMFUancQAI2mN7do0AcoCsbZ8W4Q1sEZ
         1RJmhzoOZ4xGH+wJlKT1fM4L134Q3G09uUQGTrLJbOAwvUz/EKTbP8dpG2HytTitzZ6m
         bReQ==
X-Received: by 10.68.220.132 with SMTP id pw4mr3075927pbc.149.1443140509966;
        Thu, 24 Sep 2015 17:21:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:9c11:78a0:634d:a891])
        by smtp.gmail.com with ESMTPSA id fx4sm559106pbb.92.2015.09.24.17.21.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 24 Sep 2015 17:21:49 -0700 (PDT)
In-Reply-To: <1443124243-15134-1-git-send-email-repk@triplefau.lt> (Remi
	Pommarel's message of "Thu, 24 Sep 2015 21:50:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278639>

Remi Pommarel <repk@triplefau.lt> writes:

> There are situations, ie during cross compilation, where curl-config program
> is not present in the PATH.
>
> Make configure check that a custom curl-config program is passed by the user
> through ac_cv_prog_CURL_CONFIG then set CURL_CONFIG variable accordingly in
> config.mak.autogen. Makefile uses this variable to get the target's curl
> configuration program.
>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  Makefile     |  5 +++--
>  configure.ac | 10 ++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index ce0cfe2..81ac5bb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -374,6 +374,7 @@ LDFLAGS =
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
> +CURL_CONFIG=curl-config

s/.*/CURL_CONFIG = curl-config/;

Please also add description in the early part of Makefile, perhaps
right after it explains CURLDIR=/foo/bar.

The officially supported way to tweak the build is to define these
variables by whatever means, and use of autoconf/configure is merely
one optional way of doing so.  Other people need to know what can be
tweaked and how, and even those who chose to use autoconf/configure
would need to know when autoconf/configure did not work correctly.

Thanks.

>  # Among the variables below, these:
>  #   gitexecdir
> @@ -1059,13 +1060,13 @@ else
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>  	PROGRAM_OBJS += http-fetch.o
>  	PROGRAMS += $(REMOTE_CURL_NAMES)
> -	curl_check := $(shell (echo 070908; curl-config --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
> +	curl_check := $(shell (echo 070908; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
>  	ifeq "$(curl_check)" "070908"
>  		ifndef NO_EXPAT
>  			PROGRAM_OBJS += http-push.o
>  		endif
>  	endif
> -	curl_check := $(shell (echo 072200; curl-config --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
> +	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
>  	ifeq "$(curl_check)" "072200"
>  		USE_CURL_FOR_IMAP_SEND = YesPlease
>  	endif
> diff --git a/configure.ac b/configure.ac
> index 14012fa..acc23fb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -525,6 +525,16 @@ GIT_UNSTASH_FLAGS($CURLDIR)
>  
>  GIT_CONF_SUBST([NO_CURL])
>  
> +if test -z "$NO_CURL"; then
> +
> +AC_CHECK_PROG([CURL_CONFIG], [curl-config], [curl-config], [no])
> +if test $CURL_CONFIG != no; then
> +    GIT_CONF_SUBST([CURL_CONFIG])
> +fi
> +
> +fi
> +
> +
>  #
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push is
>  # not built, and you cannot push using http:// and https:// transports.
