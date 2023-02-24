Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3EFC677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBXGiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBXGiM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:38:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B32687
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:38:11 -0800 (PST)
Received: (qmail 3658 invoked by uid 109); 24 Feb 2023 06:38:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:38:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31084 invoked by uid 111); 24 Feb 2023 06:38:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:38:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:38:10 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/21] serve: use repository pointer to get config
Message-ID: <Y/hbUsGPVNAxTdmS@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few of the v2 "serve" callbacks ignore their repository parameter and
read config using the_repository (either directly or implicitly by
calling wrapper functions). This isn't a bug since the server code only
handles a single main repository anyway (and indeed, if you look at the
callers, these repository parameters will always be the_repository). But
in the long run we want to get rid of the_repository, so let's take a
tiny step in that direction.

As a bonus, this silences some -Wunused-parameter warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 bundle-uri.c  | 2 +-
 ls-refs.c     | 8 ++++----
 serve.c       | 2 +-
 upload-pack.c | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 8a3c39ce57..177c181040 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -884,7 +884,7 @@ int bundle_uri_command(struct repository *r,
 	 * Read all "bundle.*" config lines to the client as key=value
 	 * packet lines.
 	 */
-	git_config(config_to_packet_line, &writer);
+	repo_config(r, config_to_packet_line, &writer);
 
 	packet_writer_flush(&writer);
 
diff --git a/ls-refs.c b/ls-refs.c
index 4863813655..bd9ab2c348 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -12,11 +12,11 @@ static enum {
 	UNBORN_IGNORE = 0,
 	UNBORN_ALLOW,
 	UNBORN_ADVERTISE /* implies ALLOW */
-} unborn_config(void)
+} unborn_config(struct repository *r)
 {
 	const char *str = NULL;
 
-	if (repo_config_get_string_tmp(the_repository, "lsrefs.unborn", &str)) {
+	if (repo_config_get_string_tmp(r, "lsrefs.unborn", &str)) {
 		/*
 		 * If there is no such config, advertise and allow it by
 		 * default.
@@ -168,7 +168,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 				strvec_push(&data.prefixes, out);
 		}
 		else if (!strcmp("unborn", arg))
-			data.unborn = !!unborn_config();
+			data.unborn = !!unborn_config(r);
 		else
 			die(_("unexpected line: '%s'"), arg);
 	}
@@ -199,7 +199,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 
 int ls_refs_advertise(struct repository *r, struct strbuf *value)
 {
-	if (value && unborn_config() == UNBORN_ADVERTISE)
+	if (value && unborn_config(r) == UNBORN_ADVERTISE)
 		strbuf_addstr(value, "unborn");
 
 	return 1;
diff --git a/serve.c b/serve.c
index cbf4a143cf..2ccc03c16b 100644
--- a/serve.c
+++ b/serve.c
@@ -48,7 +48,7 @@ static void object_format_receive(struct repository *r,
 static int session_id_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_sid == -1 &&
-	    git_config_get_bool("transfer.advertisesid", &advertise_sid))
+	    repo_config_get_bool(r, "transfer.advertisesid", &advertise_sid))
 		advertise_sid = 0;
 	if (!advertise_sid)
 		return 0;
diff --git a/upload-pack.c b/upload-pack.c
index 551f22ffa5..bcb702a5ba 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1775,26 +1775,26 @@ int upload_pack_advertise(struct repository *r,
 
 		strbuf_addstr(value, "shallow wait-for-done");
 
-		if (!repo_config_get_bool(the_repository,
+		if (!repo_config_get_bool(r,
 					 "uploadpack.allowfilter",
 					 &allow_filter_value) &&
 		    allow_filter_value)
 			strbuf_addstr(value, " filter");
 
-		if (!repo_config_get_bool(the_repository,
+		if (!repo_config_get_bool(r,
 					 "uploadpack.allowrefinwant",
 					 &allow_ref_in_want) &&
 		    allow_ref_in_want)
 			strbuf_addstr(value, " ref-in-want");
 
 		if (git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
-		    (!repo_config_get_bool(the_repository,
+		    (!repo_config_get_bool(r,
 					   "uploadpack.allowsidebandall",
 					   &allow_sideband_all_value) &&
 		     allow_sideband_all_value))
 			strbuf_addstr(value, " sideband-all");
 
-		if (!repo_config_get_string(the_repository,
+		if (!repo_config_get_string(r,
 					    "uploadpack.blobpackfileuri",
 					    &str) &&
 		    str) {
-- 
2.39.2.981.g6157336f25

