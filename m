From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/1] Makefile: link libcurl before libssl
Date: Mon, 5 Oct 2015 12:41:34 -0700
Message-ID: <20151005194134.GD11993@google.com>
References: <1444073043-24618-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:41:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjBdq-0000au-4e
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 21:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbbJETlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 15:41:39 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35744 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbbJETli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 15:41:38 -0400
Received: by pacfv12 with SMTP id fv12so189120213pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2ikUi5coKH8Le/cEMFyGfT2MRAGALOzeQczm1HOkYwg=;
        b=rIojRLgOi3Bx0/M49H0Idg9fySqWFgP8TGYNaof6zst1ucTdS+SVL6vsUMliJZOZ58
         zGGJ4H4/AG2y8zi5q7owdJ7q74r3ohkcSRoni9S/uBtRp36x+WH3VVK9OjY3cop1PvSW
         USPGSzyDv2vw0p+XLmNeXkqPNNqh6lhvsHFknGLfkfQBjA0YdfH4uad7wZQ6W33WmkcY
         Lfl+SPrm3nVuDjkIJ1XNea5+TNiNVTxiQ4R2QGvib2Cc+h+EvbNFPBjFfmDzQwj5UF6T
         gGMG0H/1kgu+xqlZ84/zW0i/D184T508SyHsyLrTvYAOVkBisQ2mqsxle7BbgyR3QdAI
         /paA==
X-Received: by 10.66.145.97 with SMTP id st1mr41243042pab.145.1444074097407;
        Mon, 05 Oct 2015 12:41:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:201e:549b:492b:2feb])
        by smtp.gmail.com with ESMTPSA id jv5sm29128722pbc.47.2015.10.05.12.41.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 12:41:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444073043-24618-1-git-send-email-repk@triplefau.lt>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279071>

Remi Pommarel wrote:

> For static linking especially library order while linking is important. For

Please be more explicit for the uninitiated: during static linking, the
library that needs symbols comes before the library providing those symbols.

> example, libcurl wants symbols for libssl when building http-push, http-fetch
> and remote-curl. So for these programs libcurl has to be linked before libssl.

Based on experience with NEEDS_CRYPTO_WITH_SSL vs NEEDS_SSL_WITH_CRYPTO,
these kinds of dependencies can be platform-specific.  But a little quick
thought reveals that libssl is never going to depend on libcurl and libcurl
always needs libssl.  Good.

Based on this dependency, shouldn't CURL_LIBCURL always include -lssl when
statically linking?  How does this relate to NEEDS_SSL_WITH_CURL?

> --- a/Makefile
> +++ b/Makefile
> @@ -1029,7 +1029,6 @@ ifdef HAVE_ALLOCA_H
>  endif
>  
>  IMAP_SEND_BUILDDEPS =
> -IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)

To protect against a value that might leak in from the environment, this
should say

	IMAP_SEND_LDFLAGS =

[...]
> @@ -1971,10 +1971,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
>  
>  git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(CURL_LIBCURL)
> +		$(CURL_LIBCURL) $(LIBS)

What happens in the NEEDS_SSL_WITH_CURL=Yes case?

>  git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)

Same question.

I guess the general principle is that $(LIBS) should always go at the
end.  (That would make sense to me.)

Ideally this would be two patches:

 - one putting $(LIBS) at the end everywhere, which is the simple part of the change
 - a second doing some appropriate thing to turn on NEEDS_SSL_WITH_CURL when appropriate
   or something

Sensible?

Thanks,
Jonathan
