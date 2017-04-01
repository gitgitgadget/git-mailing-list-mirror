Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69EE1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 05:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbdDAFmE (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 01:42:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:55246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbdDAFmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 01:42:03 -0400
Received: (qmail 20437 invoked by uid 109); 1 Apr 2017 05:42:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 05:42:01 +0000
Received: (qmail 15737 invoked by uid 111); 1 Apr 2017 05:42:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 01:42:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 01:41:59 -0400
Date:   Sat, 1 Apr 2017 01:41:59 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] [GSOC] remove_temporary_files(): reimplement using
 iterators
Message-ID: <20170401054158.77ftxkba6kj2mdvp@sigill.intra.peff.net>
References: <20170401002458.3494-1-robert.stanca7@gmail.com>
 <20170401053716.yzxqxokuz3awqki4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170401053716.yzxqxokuz3awqki4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 01, 2017 at 01:37:16AM -0400, Jeff King wrote:

> We use that strbuf for the prefix-comparison, too, but the way it is
> done is rather confusing. AFAICT, we could just be comparing against
> "packtmp + strlen(packdir) + 1". Though it would be simpler still to
> make "packtmp" just the basename, rather than the full path.

Something like the patch below, which would then free you up to replace
"buf" there with the diter->path.

diff --git a/builtin/repack.c b/builtin/repack.c
index 677bc7c81..06a14d687 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -48,7 +48,7 @@ static int repack_config(const char *var, const char *value, void *cb)
 static void remove_temporary_files(void)
 {
 	struct strbuf buf = STRBUF_INIT;
-	size_t dirlen, prefixlen;
+	size_t dirlen;
 	DIR *dir;
 	struct dirent *e;
 
@@ -56,14 +56,11 @@ static void remove_temporary_files(void)
 	if (!dir)
 		return;
 
-	/* Point at the slash at the end of ".../objects/pack/" */
-	dirlen = strlen(packdir) + 1;
-	strbuf_addstr(&buf, packtmp);
-	/* Hold the length of  ".tmp-%d-pack-" */
-	prefixlen = buf.len - dirlen;
+	strbuf_addf(&buf, "%s/", packdir);
+	dirlen = buf.len;
 
 	while ((e = readdir(dir))) {
-		if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
+		if (!starts_with(e->d_name, packtmp))
 			continue;
 		strbuf_setlen(&buf, dirlen);
 		strbuf_addstr(&buf, e->d_name);
@@ -216,7 +213,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		die(_(incremental_bitmap_conflict_error));
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
-	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
+	packtmp = mkpathdup(".tmp-%d-pack", (int)getpid());
 
 	sigchain_push_common(remove_pack_on_signal);
 
@@ -274,7 +271,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (delta_base_offset)
 		argv_array_push(&cmd.args,  "--delta-base-offset");
 
-	argv_array_push(&cmd.args, packtmp);
+	argv_array_pushf(&cmd.args, "%s/%s", packdir, packtmp);
 
 	cmd.git_cmd = 1;
 	cmd.out = -1;
@@ -372,8 +369,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			int exists = 0;
 			fname = mkpathdup("%s/pack-%s%s",
 					packdir, item->string, exts[ext].name);
-			fname_old = mkpathdup("%s-%s%s",
-					packtmp, item->string, exts[ext].name);
+			fname_old = mkpathdup("%s/%s-%s%s",
+					packdir, packtmp, item->string, exts[ext].name);
 			if (!stat(fname_old, &statbuffer)) {
 				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
 				chmod(fname_old, statbuffer.st_mode);
