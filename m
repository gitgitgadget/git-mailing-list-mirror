Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB6AC2D0EE
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B83B208E4
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgCZII4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:08:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:51854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726296AbgCZII4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:08:56 -0400
Received: (qmail 1069 invoked by uid 109); 26 Mar 2020 08:08:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:08:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12077 invoked by uid 111); 26 Mar 2020 08:18:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:18:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:08:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] Makefile: use curl-config --cflags
Message-ID: <20200326080855.GB2200716@coredump.intra.peff.net>
References: <20200326080540.GA2200522@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326080540.GA2200522@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We add the result of "curl-config --libs" when linking curl programs,
but we never bother calling "curl-config --cflags". Presumably nobody
noticed because:

  - a system libcurl installed into /usr/include/curl wouldn't need any
    flags ("/usr/include" is already in the search path, and the
    #include lines all look <curl/curl.h>, etc).

  - using CURLDIR sets up both the includes and the library path

However, if you prefer CURL_CONFIG to CURLDIR, something simple like:

  make CURL_CONFIG=/path/to/curl-config

doesn't work. We'd link against the libcurl specified by that program,
but not find its header files when compiling.

Let's invoke "curl-config --cflags" similar to the way we do for
"--libs". Note that we'll feed the result into BASIC_CFLAGS. The rest of
the Makefile doesn't distinguish which files need curl support during
compilation and which do not. That should be OK, though. At most this
should be adding a "-I" directive, and this is how CURLDIR already
behaves. And since we follow the immediate-variable pattern from
CURL_LDFLAGS, we won't accidentally invoke curl-config once per
compilation.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't bother touching configure.ac here, because I don't think it
would do anything useful. The existing configure script will run
"curl-config --libs" to set CURL_LDFLAGS, suppressing the call to
curl-config inside the Makefile. But with the caveat that you can
convince it to pass something besides --libs (though what would be
useful there, I have no idea, and the commit introducing it didn't shed
any light). So following that pattern, at most we'd just be trading a
call during configure time for one inside the Makefile.

What _could_ be useful is if the configure script used curl-config as
part of it's check of whether we have libcurl at all. But it doesn't. We
don't even look for curl-config until we've been able to link against
-lcurl. I have a feeling this could be fixed by reversing the order of
the blocks, but I'm not sure of all of the subtle interactions with
CURLDIR. And I don't care enough about autoconf to puzzle it out. We
certainly aren't making anything worse with this patch.

 Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 93a8ef3a72..4550bf4a42 100644
--- a/Makefile
+++ b/Makefile
@@ -1359,9 +1359,10 @@ ifdef NO_CURL
 else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
-		BASIC_CFLAGS += -I$(CURLDIR)/include
+		CURL_CFLAGS = -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
 	else
+		CURL_CFLAGS =
 		CURL_LIBCURL =
 	endif
 
@@ -1370,6 +1371,11 @@ else
 	endif
 	CURL_LIBCURL += $(CURL_LDFLAGS)
 
+	ifndef CURL_CFLAGS
+		CURL_CFLAGS := $(shell $(CURL_CONFIG) --cflags)
+	endif
+	BASIC_CFLAGS += $(CURL_CFLAGS)
+
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
-- 
2.26.0.576.gb87790c3c1
