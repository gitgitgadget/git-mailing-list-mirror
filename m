Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A338D202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbdCOUMW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:12:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:44772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753747AbdCOUMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 16:12:21 -0400
Received: (qmail 29807 invoked by uid 109); 15 Mar 2017 20:05:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 20:05:39 +0000
Received: (qmail 23323 invoked by uid 111); 15 Mar 2017 20:05:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 16:05:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 16:05:36 -0400
Date:   Wed, 15 Mar 2017 16:05:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] rev-parse: use skip_prefix when parsing options
Message-ID: <20170315200535.rdno2keqnynfzmyj@sigill.intra.peff.net>
References: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315200521.qwcm5tqcdzkbwp3x@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using skip_prefix lets us avoid manually-counted offsets
into the argument string. This patch converts the simple and
obvious cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e08677e55..836ccf00e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -722,8 +722,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref(show_reference, NULL);
 				continue;
 			}
-			if (starts_with(arg, "--disambiguate=")) {
-				for_each_abbrev(arg + 15, show_abbrev, NULL);
+			if (skip_prefix(arg, "--disambiguate=", &arg)) {
+				for_each_abbrev(arg, show_abbrev, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
@@ -731,8 +731,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
-			if (starts_with(arg, "--branches=")) {
-				for_each_glob_ref_in(show_reference, arg + 11,
+			if (skip_prefix(arg, "--branches=", &arg)) {
+				for_each_glob_ref_in(show_reference, arg,
 					"refs/heads/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
@@ -742,8 +742,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-			if (starts_with(arg, "--tags=")) {
-				for_each_glob_ref_in(show_reference, arg + 7,
+			if (skip_prefix(arg, "--tags=", &arg)) {
+				for_each_glob_ref_in(show_reference, arg,
 					"refs/tags/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
@@ -753,13 +753,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-			if (starts_with(arg, "--glob=")) {
-				for_each_glob_ref(show_reference, arg + 7, NULL);
+			if (skip_prefix(arg, "--glob=", &arg)) {
+				for_each_glob_ref(show_reference, arg, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-			if (starts_with(arg, "--remotes=")) {
-				for_each_glob_ref_in(show_reference, arg + 10,
+			if (skip_prefix(arg, "--remotes=", &arg)) {
+				for_each_glob_ref_in(show_reference, arg,
 					"refs/remotes/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
@@ -769,8 +769,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
-			if (starts_with(arg, "--exclude=")) {
-				add_ref_exclusion(&ref_excludes, arg + 10);
+			if (skip_prefix(arg, "--exclude=", &arg)) {
+				add_ref_exclusion(&ref_excludes, arg);
 				continue;
 			}
 			if (!strcmp(arg, "--show-toplevel")) {
@@ -865,20 +865,20 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				}
 				continue;
 			}
-			if (starts_with(arg, "--since=")) {
-				show_datestring("--max-age=", arg+8);
+			if (skip_prefix(arg, "--since=", &arg)) {
+				show_datestring("--max-age=", arg);
 				continue;
 			}
-			if (starts_with(arg, "--after=")) {
-				show_datestring("--max-age=", arg+8);
+			if (skip_prefix(arg, "--after=", &arg)) {
+				show_datestring("--max-age=", arg);
 				continue;
 			}
-			if (starts_with(arg, "--before=")) {
-				show_datestring("--min-age=", arg+9);
+			if (skip_prefix(arg, "--before=", &arg)) {
+				show_datestring("--min-age=", arg);
 				continue;
 			}
-			if (starts_with(arg, "--until=")) {
-				show_datestring("--min-age=", arg+8);
+			if (skip_prefix(arg, "--until=", &arg)) {
+				show_datestring("--min-age=", arg);
 				continue;
 			}
 			if (show_flag(arg) && verify)
-- 
2.12.0.613.g6e7c52a0d

