Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF892023D
	for <e@80x24.org>; Fri,  3 Mar 2017 10:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdCCKcA (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 05:32:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:37867 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbdCCKbt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 05:31:49 -0500
Received: (qmail 28871 invoked by uid 109); 3 Mar 2017 10:31:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 10:31:17 +0000
Received: (qmail 26652 invoked by uid 111); 3 Mar 2017 10:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 05:31:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 05:31:16 -0500
Date:   Fri, 3 Mar 2017 05:31:16 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] config: check if config path is a file before
 parsing it
Message-ID: <20170303103115.an5dg2pacest4zwo@sigill.intra.peff.net>
References: <20170303094252.11706-1-pclouds@gmail.com>
 <20170303094252.11706-2-pclouds@gmail.com>
 <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net>
 <CACsJy8DU7-o06mfuw1L02CFFR2wmoNa0MQJ8KqsV79ULzjRaRQ@mail.gmail.com>
 <20170303101503.lf2ub2c7i6w7kg3t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170303101503.lf2ub2c7i6w7kg3t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 05:15:03AM -0500, Jeff King wrote:

> But I do think option (a) is cleaner. The only trick is that for errno
> to be valid, we need to make sure we check ferror() soon after seeing
> the EOF return value. I suspect it would work OK in practice for the
> git_config_from_file() case.

Something like this is a big improvement, I think:

diff --git a/config.c b/config.c
index c6b874a7b..27b410dfe 100644
--- a/config.c
+++ b/config.c
@@ -156,15 +156,14 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		path = buf.buf;
 	}
 
-	if (!access_or_die(path, R_OK, 0)) {
-		if (++inc->depth > MAX_INCLUDE_DEPTH)
-			die(include_depth_advice, MAX_INCLUDE_DEPTH, path,
-			    !cf ? "<unknown>" :
-			    cf->name ? cf->name :
-			    "the command line");
-		ret = git_config_from_file(git_config_include, path, inc);
-		inc->depth--;
-	}
+	if (++inc->depth > MAX_INCLUDE_DEPTH)
+		die(include_depth_advice, MAX_INCLUDE_DEPTH, path,
+		    !cf ? "<unknown>" :
+		    cf->name ? cf->name :
+		    "the command line");
+	ret = git_config_from_file(git_config_include, path, inc);
+	inc->depth--;
+
 	strbuf_release(&buf);
 	free(expanded);
 	return ret;
@@ -1213,10 +1212,18 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	FILE *f;
 
 	f = fopen(filename, "r");
-	if (f) {
+	if (!f) {
+		/* a missing file is silently treated as an empty one */
+		if (errno == ENOENT || errno == EISDIR)
+			ret = 0;
+		else
+			ret = error_errno("unable to open %s", filename);
+	} else {
 		flockfile(f);
 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
 		funlockfile(f);
+		if (!ret && ferror(f))
+			ret = error_errno("unable to read from %s", filename);
 		fclose(f);
 	}
 	return ret;

Then if you do:

  cd repo.git
  git config include.path this-is-broken

you get useful errors for a variety of situations:

  $ mkdir this-is-broken
  $ git rev-parse
  error: unable to read from this-is-broken: Is a directory
  fatal: bad config line 7 in file config

  $ rmdir this-is-broken
  $ ln -s this-is-broken this-is-broken
  $ git rev-parse
  error: unable to open this-is-broken: Too many levels of symbolic links
  fatal: bad config line 7 in file config

and so on. The two caveats are:

  1. A few of the callers treat EACCES specially, so we'd potentially
     want a flag for that (or alternatively, everybody should just fopen
     the file themselves and pass in the handle).

  2. The call in read_repository_format() does not check the return
     value at all. It measures errors only as "did the parser find a
     core.repositoryformatversion field I can look at", though arguably
     it should check for other errors, too (if we read "version=2", but
     then got a read error before we were able to read the extensions,
     that would be wrong and bad).

     But either way I suspect it probably prefers the current "quiet"
     behavior, since it is used to speculatively look for repositories.

So probably git_config_from_file() needs a flags parameter, and both
"quiet" and EACCES handling can go in there.

-Peff
