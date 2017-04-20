Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD1C207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947468AbdDTVJN (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:09:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:37263 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947566AbdDTVJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:09:12 -0400
Received: (qmail 2092 invoked by uid 109); 20 Apr 2017 21:09:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:09:12 +0000
Received: (qmail 9686 invoked by uid 111); 20 Apr 2017 21:09:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:09:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:09:09 -0400
Date:   Thu, 20 Apr 2017 17:09:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] replace xstrdup(git_path(...)) with git_pathdup(...)
Message-ID: <20170420210909.ehy4kim6losllux7@sigill.intra.peff.net>
References: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's more efficient to use git_pathdup(), as it skips an
extra copy of the path. And by removing some calls to
git_path(), it makes it easier to audit for dangerous uses.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 5 +++--
 fast-import.c    | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4f49a0edb..3407a8b87 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -597,8 +597,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (given_config_source.blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
-		config_file = xstrdup(given_config_source.file ?
-				      given_config_source.file : git_path("config"));
+		config_file = given_config_source.file ?
+				xstrdup(given_config_source.file) :
+				git_pathdup("config");
 		if (use_global_config) {
 			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
 			if (fd >= 0) {
diff --git a/fast-import.c b/fast-import.c
index 1ea3a0860..cf58f875b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3202,7 +3202,7 @@ static char* make_fast_import_path(const char *path)
 {
 	if (!relative_marks_paths || is_absolute_path(path))
 		return xstrdup(path);
-	return xstrdup(git_path("info/fast-import/%s", path));
+	return git_pathdup("info/fast-import/%s", path);
 }
 
 static void option_import_marks(const char *marks,
-- 
2.13.0.rc0.363.g8726c260e

