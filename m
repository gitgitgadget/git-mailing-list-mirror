From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Change library order for static linking
Date: Thu, 17 Sep 2015 12:51:18 -0700
Message-ID: <xmqqfv2cj03t.fsf@gitster.mtv.corp.google.com>
References: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Thu Sep 17 21:51:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcfDO-0006BF-F2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 21:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbbIQTvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 15:51:20 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36788 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbbIQTvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 15:51:20 -0400
Received: by padhk3 with SMTP id hk3so27729864pad.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=txkAASvUZ5nIidES1VazJemswhxAkvKoYI1UXjoLqv0=;
        b=yIMdg9WLWMNyLbaPF2Bkq6sPzlPLdOXRP2x3VStGcXxVrwgpUW3wjqkzJdTQIfHSjo
         J0EVSTiwV9verR0gXkmdyLTEIfuxg5jpGBEgd6iu+yRgW0rdGYNPRzogWu8WsUsl1O2Q
         jFc7lisCOmGkOyDKLU/ruHcV+X+B9PiXU28u8wcXbwVECgOqg9NZCZdcuJZg9bYWYK1L
         1ARyFtZUIa3IGAjH5bkttRm6+Cx/sUnvX7fmjbOJAjcq5mX3kVt7RgxA1k9Hx+vSPE5Z
         e5RlR36Gw8scoa4Nic5YazRUKgxgb98Q7Pmh2klyqIqyw7E2wqwjWGC81/xjLVV5Cr7N
         l3Nw==
X-Received: by 10.67.22.169 with SMTP id ht9mr1724152pad.35.1442519479513;
        Thu, 17 Sep 2015 12:51:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id hp4sm4883969pbc.68.2015.09.17.12.51.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 12:51:18 -0700 (PDT)
In-Reply-To: <1442524332-10180-1-git-send-email-repk@triplefau.lt> (Remi
	Pommarel's message of "Thu, 17 Sep 2015 23:12:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278164>

Remi Pommarel <repk@triplefau.lt> writes:

> Subject: Re: [PATCH] Makefile: Change library order for static linking

s/Change/change/;

But more importantly, I think you can do much better with the same
space.  Perhaps like this.

    Makefile: link libcurl before openssl and crypto

> For static linking especially library order while linking is important. For
> example libssl contains symbol from libcrypto so the farmer should be linked
> before the latter. The global link order should be libcurl then libssl then
> libcrypto then libintl and finally zlib.

IIRC historically the division between ssl and crypto was messy.
Especially, I am not sure if the change to NEEDS_SSL_WITH_CRYPTO
in this patch is correct for platforms that require that macro
defined.

Other changes in this patch looks sensible, though.


>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 81ac5bb..26a483a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1030,7 +1030,6 @@ ifdef HAVE_ALLOCA_H
>  endif
>  
>  IMAP_SEND_BUILDDEPS =
> -IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
>  
>  ifdef NO_CURL
>  	BASIC_CFLAGS += -DNO_CURL
> @@ -1087,6 +1086,7 @@ else
>  		endif
>  	endif
>  endif
> +IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
>  
>  ifdef ZLIB_PATH
>  	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
> @@ -1117,7 +1117,7 @@ ifdef NO_OPENSSL
>  	LIB_4_CRYPTO =
>  else
>  ifdef NEEDS_SSL_WITH_CRYPTO
> -	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto -lssl
> +	LIB_4_CRYPTO = $(OPENSSL_LINK) -lssl -lcrypto
>  else
>  	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
>  endif
> @@ -1972,10 +1972,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
>  
>  git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(CURL_LIBCURL)
> +		$(CURL_LIBCURL) $(LIBS)
>  git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>  
>  git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
> @@ -1989,7 +1989,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
>  
>  $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>  
>  $(LIB_FILE): $(LIB_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
