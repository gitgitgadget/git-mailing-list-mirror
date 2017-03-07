Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311C61FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 16:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755757AbdCGQmf (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 11:42:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755781AbdCGQmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 11:42:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 11769607C6; Tue,  7 Mar 2017 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1488904858;
        bh=B9pv5y1lDCXPvvEr7NAMCxe5xS0HdwpzQz7jVp+hWMo=;
        h=From:To:Cc:Subject:Date:From;
        b=UUPgulFKM0km1/a50F5zR/NXuej6EzN+d5VLTTIrDipHI7nS/BwNGacuJcVSySDmg
         eVWzcdnxF1eYrF8V7/4ivXoX1Wmr0igvvsiJLyAZvUwR2ot4Y0TLRw5blI7J0l57d1
         aWL/irxAQW0bBnkHRcU1klw5ROTuFEfEqsUh1m+A=
Received: from jmelvin1-mac.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jmelvin@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1A4F60729;
        Tue,  7 Mar 2017 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1488904856;
        bh=B9pv5y1lDCXPvvEr7NAMCxe5xS0HdwpzQz7jVp+hWMo=;
        h=From:To:Cc:Subject:Date:From;
        b=T+yVD5miC7Bvbh6qOdRI4w24k43I/wbbeJ4wXkGmalVQoBehl+v+X9i8slxFvvrmx
         vNyM5cqJFC10SP2y4E16hNGErqMPn1akqYHZmXCTuSROY7k0B5FlBBL1gZ9md7emD3
         nD+k8z00piP3Flma+XxO9OuKocjyePSY17xYOYSU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1A4F60729
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jmelvin@codeaurora.org
From:   James Melvin <jmelvin@codeaurora.org>
To:     git@vger.kernel.org
Cc:     nasserg@codeaurora.org, mfick@codeaurora.org, peff@peff.net,
        sbeller@google.com, James Melvin <jmelvin@codeaurora.org>
Subject: [PATCH] repack: Add options to preserve and prune old pack files
Date:   Tue,  7 Mar 2017 09:40:35 -0700
Message-Id: <20170307164035.27866-1-jmelvin@codeaurora.org>
X-Mailer: git-send-email 2.12.0.190.gab6997d48.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new --preserve-oldpacks option moves old pack files into the
preserved subdirectory instead of deleting them after repacking.

The new --prune-preserved option prunes old pack files from the
preserved subdirectory after repacking, but before potentially
moving the latest old packfiles to this subdirectory.

These options are designed to prevent stale file handle exceptions
during git operations which can happen on users of NFS repos when
repacking is done on them. The strategy is to preserve old pack files
around until the next repack with the hopes that they will become
unreferenced by then and not cause any exceptions to running processes
when they are finally deleted (pruned).

Signed-off-by: James Melvin <jmelvin@codeaurora.org>
---
 Documentation/git-repack.txt |  9 +++++++++
 builtin/repack.c             | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 26afe6ed5..0b19b761f 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -143,6 +143,15 @@ other objects in that pack they already have locally.
 	being removed. In addition, any unreachable loose objects will
 	be packed (and their loose counterparts removed).
 
+--preserve-oldpacks::
+	 Move old pack files into the preserved subdirectory instead
+	 of deleting them after repacking.
+
+--prune-preserved::
+	 Prune old pack files from the preserved subdirectory after
+	 repacking, but before potentially moving the latest old
+	 packfiles to this subdirectory
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 677bc7c81..f1a0c97f3 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -10,8 +10,10 @@
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
+static int preserve_oldpacks = 0;
+static int prune_preserved = 0;
 static int write_bitmaps;
-static char *packdir, *packtmp;
+static char *packdir, *packtmp, *preservedir;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [<options>]"),
@@ -108,6 +110,27 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 	closedir(dir);
 }
 
+static void preserve_pack(const char *file_path, const char *file_name,  const char *file_ext)
+{
+	char *fname_old;
+
+	if (mkdir(preservedir, 0700) && errno != EEXIST)
+		error(_("failed to create preserve directory"));
+
+	fname_old = mkpathdup("%s/%s.old-%s", preservedir, file_name, ++file_ext);
+	rename(file_path, fname_old);
+
+	free(fname_old);
+}
+
+static void remove_preserved_dir(void) {
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addstr(&buf, preservedir);
+	remove_dir_recursively(&buf, 0);
+	strbuf_release(&buf);
+}
+
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap"};
@@ -121,7 +144,10 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
 		strbuf_setlen(&buf, plen);
 		strbuf_addstr(&buf, exts[i]);
-		unlink(buf.buf);
+		if (preserve_oldpacks)
+			preserve_pack(buf.buf, base_name, exts[i]);
+		else
+			unlink(buf.buf);
 	}
 	strbuf_release(&buf);
 }
@@ -194,6 +220,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
+		OPT_BOOL(0, "preserve-oldpacks", &preserve_oldpacks,
+				N_("move old pack files into the preserved subdirectory")),
+		OPT_BOOL(0, "prune-preserved", &prune_preserved,
+				N_("prune old pack files from the preserved subdirectory after repacking")),
 		OPT_END()
 	};
 
@@ -217,6 +247,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
+	preservedir = mkpathdup("%s/preserved", packdir);
 
 	sigchain_push_common(remove_pack_on_signal);
 
@@ -404,6 +435,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	/* End of pack replacement. */
 
+	if (prune_preserved)
+		remove_preserved_dir();
+
 	if (delete_redundant) {
 		int opts = 0;
 		string_list_sort(&names);
-- 
2.12.0.190.gab6997d48.dirty

