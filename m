From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv7 0/2] Rewriting repack in C
Date: Thu, 29 Aug 2013 22:39:32 +0200
Message-ID: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 22:39:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF90T-0000ay-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 22:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab3H2Ujk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 16:39:40 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:55154 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855Ab3H2Uji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 16:39:38 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so493876eaj.26
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nv3yMUF5HByxLVZdzW2Hg2HoHESF1VY89LLARv3dlkc=;
        b=q6d91RrfJB71m7i6wvxPTBnmnvafzKV48Rwj78K6yWcxBo5Gn/s8DmSKPMyfNfEPjt
         CqQANZv9FkfbclXP9TCxUBU2hV5UlV5gMnatPfR7bCKm1Dr0vpmJTUDRuu3vAHTSEPKZ
         NEDabktf4ZC+bAwKAgVwcevQWMLds5H+8p/x7YVo0ErXwtI0RoFaUyLgAG99ViefKY79
         U17yhrroXYEPQ2JSpwc9k7TCegf8UsXY+qcv/RUo5umT5Azw1E4hiKG3wgnyWcKCl9mn
         QIIpoNGq6KUUZoXcVSM7kTp7QUyKH2zFEO8ipq5ZqzuIeN8QiPzi/0rIiHzEhldSmU/r
         m2JQ==
X-Received: by 10.15.54.72 with SMTP id s48mr6801914eew.58.1377808777111;
        Thu, 29 Aug 2013 13:39:37 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id t6sm49127728eel.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 13:39:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233357>

Hi,
I am sorry to have been delaying this patch series for a few days,
as I was busy. I'll continue to be busy for the next 2 weeks, so 
my replies (if needed), will take some time.

The first patch rewrites the repack shell script in C and tries to
resemble the functionality as close to the original as possible.
The second patch introduces some functional changes intentionally.

Stefan

Here is a diff since the last time sending this patch series:
---
 builtin/repack.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0ace2a3..0cc823d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -41,10 +41,10 @@ static void remove_temporary_files(void)
 
 	strbuf_addstr(&buf, packdir);
 
-	/* dirlen holds the length of the path before the file name */
+	/* Point at the slash at the end of ".../objects/pack/" */
 	dirlen = buf.len + 1;
 	strbuf_addf(&buf, "%s", packtmp);
-	/* prefixlen holds the length of the prefix */
+	/* Point at the dash at the end of ".../.tmp-%d-pack-" */
 	prefixlen = buf.len - dirlen;
 
 	while ((e = readdir(dir))) {
@@ -109,9 +109,12 @@ static void remove_redundant_pack(const char *path_prefix, const char *hex)
 	}
 }
 
+#define ALL_INTO_ONE 1
+#define LOOSE_UNREACHABLE 2
+
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
-	const char *exts[2] = {".idx", ".pack"};
+	const char *exts[2] = {".pack", ".idx"};
 	struct child_process cmd;
 	struct string_list_item *item;
 	struct argv_array cmd_args = ARGV_ARRAY_INIT;
@@ -124,7 +127,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	/* variables to be filled by option parsing */
 	int pack_everything = 0;
-	int pack_everything_but_loose = 0;
 	int delete_redundant = 0;
 	char *unpack_unreachable = NULL;
 	int window = 0, window_memory = 0;
@@ -136,10 +138,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int local = 0;
 
 	struct option builtin_repack_options[] = {
-		OPT_BOOL('a', NULL, &pack_everything,
-				N_("pack everything in a single pack")),
-		OPT_BOOL('A', NULL, &pack_everything_but_loose,
-				N_("same as -a, and turn unreachable objects loose")),
+		OPT_BIT('a', NULL, &pack_everything,
+				N_("pack everything in a single pack"), ALL_INTO_ONE),
+		OPT_BIT('A', NULL, &pack_everything,
+				N_("same as -a, and turn unreachable objects loose"), LOOSE_UNREACHABLE),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
 		OPT_BOOL('f', NULL, &no_reuse_delta,
@@ -193,7 +195,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (no_reuse_object)
 		argv_array_pushf(&cmd_args, "--no-reuse-object");
 
-	if (!pack_everything && !pack_everything_but_loose) {
+	if (!pack_everything) {
 		argv_array_push(&cmd_args, "--unpacked");
 		argv_array_push(&cmd_args, "--incremental");
 	} else {
@@ -204,7 +206,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				argv_array_pushf(&cmd_args,
 						"--unpack-unreachable=%s",
 						unpack_unreachable);
-			else if (pack_everything_but_loose)
+			else if (pack_everything & LOOSE_UNREACHABLE)
 				argv_array_push(&cmd_args,
 						"--unpack-unreachable");
 		}
@@ -246,6 +248,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (!nr_packs && !quiet)
 		printf("Nothing new to pack.\n");
 
+	/*
+	 * Ok we have prepared all new packfiles.
+	 * First see if there are packs of the same name and if so
+	 * if we can move them out of the way (this can happen if we
+	 * repacked immediately after packing fully.
+	 */
 	failed = 0;
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < 2; ext++) {
@@ -366,5 +374,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		run_command(&cmd);
 		argv_array_clear(&cmd_args);
 	}
+	remove_temporary_files();
 	return 0;
 }
-- 
1.8.4

Stefan Beller (2):
  repack: rewrite the shell script in C
  repack: retain the return value of pack-objects

 Makefile                                        |   2 +-
 builtin.h                                       |   1 +
 builtin/repack.c                                | 379 ++++++++++++++++++++++++
 git-repack.sh => contrib/examples/git-repack.sh |   0
 git.c                                           |   1 +
 5 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 builtin/repack.c
 rename git-repack.sh => contrib/examples/git-repack.sh (100%)

-- 
1.8.4
