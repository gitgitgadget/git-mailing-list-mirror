Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2054B1F461
	for <e@80x24.org>; Mon, 22 Jul 2019 21:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfGVVMV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 17:12:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:48752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730092AbfGVVMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 17:12:20 -0400
Received: (qmail 32542 invoked by uid 109); 22 Jul 2019 21:12:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Jul 2019 21:12:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4591 invoked by uid 111); 22 Jul 2019 21:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jul 2019 17:13:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jul 2019 17:12:19 -0400
From:   Jeff King <peff@peff.net>
To:     "Raitanen, Adam" <araitane@ciena.com>
Cc:     James Knight <james.d.knight@live.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Possible bug in Makefile when executing curl-config
Message-ID: <20190722211219.GB31664@sigill.intra.peff.net>
References: <DM6PR04MB47939645A97D099241AD25F0D0C40@DM6PR04MB4793.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR04MB47939645A97D099241AD25F0D0C40@DM6PR04MB4793.namprd04.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc the author of that patch]

On Mon, Jul 22, 2019 at 07:46:37PM +0000, Raitanen, Adam wrote:

> I believe there may be a bug in the Makefile introduced by the following commit:
> 
> https://github.com/git/git/commit/23c4bbe28e61974577164db09cbd1d1c7e568ca4
> 
> The commit was merged in 2.20.0:
> 
> * The way -lcurl library gets linked has been simplified by taking
>    advantage of the fact that we can just ask curl-config command how.
> 
> Unfortunately it assumes that curl-config is in the path which is not
> always the case. When using "--with-curl=/path/to/curl" in the
> configure command, the path to the actual curl-config executable is
> ignored and the build fails around here:
> 
>     CC http-fetch.o
> make: curl-config: Command not found
>     LINK git-http-fetch
> http.o: In function `fill_active_slots':
> /tmp/git-2.21.0/http.c:1385: undefined reference to `curl_easy_cleanup'
> .
> 
> We were able to workaround this by forcing the correct path into the make env:
> 
> make CURL_LDFLAGS="$(/path/to/curl/curl-config --libs)".
> 
> I reproduced the problem in the latest version 2.22.0.

For the case without autoconf, I think using CURL_LDFLAGS is the
intended safety valve. Though perhaps we should be falling back more
gracefully to the old behavior, like:

diff --git a/Makefile b/Makefile
index 11ccea4071..27e546bbfc 100644
--- a/Makefile
+++ b/Makefile
@@ -1343,7 +1343,7 @@ else
 ifdef CURL_LDFLAGS
 	CURL_LIBCURL += $(CURL_LDFLAGS)
 else
-	CURL_LIBCURL += $(shell $(CURL_CONFIG) --libs)
+	CURL_LIBCURL += $(shell $(CURL_CONFIG) --libs || echo -lcurl)
 endif
 
 	REMOTE_CURL_PRIMARY = git-remote-http$X

which should work on most systems.

For your specific case, where you _do_ have curl-config but it's just
not in the PATH, then I think:

  make CURL_CONFIG=/path/to/curl-config

would be a slightly cleaner solution.

But it sounds like you _did_ use the autoconf script, but it did not
correctly set CURL_CONFIG. Do you have a config.mak.autogen file after
running ./configure, and if so, does it have an entry for CURL_CONFIG?

I'm not too familiar with our configure.ac, but it looks like
--with-curl might just point some paths for header/include files, and
not actually update the curl-config path.

-Peff
