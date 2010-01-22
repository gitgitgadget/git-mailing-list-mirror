From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/5] make "git pack-redundant" a built-in
Date: Fri, 22 Jan 2010 08:28:28 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001220827140.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain> <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain> <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain> <alpine.LFD.2.00.1001220826230.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMOl-0006nl-NI
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650Ab0AVQaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755620Ab0AVQaK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:30:10 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35963 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754990Ab0AVQaI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:30:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGSSde016761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:28:29 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGSSUT015237;
	Fri, 22 Jan 2010 08:28:28 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001220826230.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137761>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Jan 2010 07:42:14 -0800

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
This has one function that now needed a 'const char *' argument 
conversion, but it's the next one that actually affects other files..

 Makefile                                     |    2 +-
 pack-redundant.c => builtin-pack-redundant.c |    8 ++------
 builtin.h                                    |    1 +
 git.c                                        |    1 +
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 88e2f8f..33f9870 100644
--- a/Makefile
+++ b/Makefile
@@ -389,7 +389,6 @@ PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
-PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-shell$X
 PROGRAMS += git-show-index$X
 PROGRAMS += git-upload-pack$X
@@ -673,6 +672,7 @@ BUILTIN_OBJS += builtin-mktree.o
 BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
 BUILTIN_OBJS += builtin-pack-objects.o
+BUILTIN_OBJS += builtin-pack-redundant.o
 BUILTIN_OBJS += builtin-pack-refs.o
 BUILTIN_OBJS += builtin-patch-id.o
 BUILTIN_OBJS += builtin-prune-packed.o
diff --git a/pack-redundant.c b/builtin-pack-redundant.c
similarity index 99%
rename from pack-redundant.c
rename to builtin-pack-redundant.c
index 21c61db..41e1615 100644
--- a/pack-redundant.c
+++ b/builtin-pack-redundant.c
@@ -568,7 +568,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		return pack_list_insert(&altodb_packs, &l);
 }
 
-static struct pack_list * add_pack_file(char *filename)
+static struct pack_list * add_pack_file(const char *filename)
 {
 	struct packed_git *p = packed_git;
 
@@ -593,7 +593,7 @@ static void load_all(void)
 	}
 }
 
-int main(int argc, char **argv)
+int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct pack_list *min, *red, *pl;
@@ -601,13 +601,9 @@ int main(int argc, char **argv)
 	unsigned char *sha1;
 	char buf[42]; /* 40 byte sha1 + \n + \0 */
 
-	git_extract_argv0_path(argv[0]);
-
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(pack_redundant_usage);
 
-	setup_git_directory();
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--")) {
diff --git a/builtin.h b/builtin.h
index d4fec89..bd7f737 100644
--- a/builtin.h
+++ b/builtin.h
@@ -78,6 +78,7 @@ extern int cmd_mktree(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
 extern int cmd_pickaxe(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 832bd2d..6cc1eba 100644
--- a/git.c
+++ b/git.c
@@ -343,6 +343,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+		{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
 		{ "patch-id", cmd_patch_id },
 		{ "peek-remote", cmd_ls_remote },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
-- 
1.6.6.1.399.g73128
