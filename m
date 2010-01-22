From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/5] make "git unpack-file" a built-in
Date: Fri, 22 Jan 2010 08:27:09 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001220826230.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain> <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain> <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:28:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMNI-0005v4-Id
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab0AVQ2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755728Ab0AVQ2l
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:28:41 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41099 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755711Ab0AVQ2k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:28:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGR9MI016697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:27:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGR922015197;
	Fri, 22 Jan 2010 08:27:09 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137760>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Jan 2010 07:38:03 -0800

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
Again.. No surprises.

 Makefile                               |    2 +-
 unpack-file.c => builtin-unpack-file.c |    5 +----
 builtin.h                              |    1 +
 git.c                                  |    1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index c5a1190..88e2f8f 100644
--- a/Makefile
+++ b/Makefile
@@ -392,7 +392,6 @@ PROGRAMS += git-index-pack$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-shell$X
 PROGRAMS += git-show-index$X
-PROGRAMS += git-unpack-file$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-http-backend$X
 
@@ -698,6 +697,7 @@ BUILTIN_OBJS += builtin-stripspace.o
 BUILTIN_OBJS += builtin-symbolic-ref.o
 BUILTIN_OBJS += builtin-tag.o
 BUILTIN_OBJS += builtin-tar-tree.o
+BUILTIN_OBJS += builtin-unpack-file.o
 BUILTIN_OBJS += builtin-unpack-objects.o
 BUILTIN_OBJS += builtin-update-index.o
 BUILTIN_OBJS += builtin-update-ref.o
diff --git a/unpack-file.c b/builtin-unpack-file.c
similarity index 89%
rename from unpack-file.c
rename to builtin-unpack-file.c
index e9d8934..608590a 100644
--- a/unpack-file.c
+++ b/builtin-unpack-file.c
@@ -22,18 +22,15 @@ static char *create_temp_file(unsigned char *sha1)
 	return path;
 }
 
-int main(int argc, char **argv)
+int cmd_unpack_file(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20];
 
-	git_extract_argv0_path(argv[0]);
-
 	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage("git unpack-file <sha1>");
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
 
-	setup_git_directory();
 	git_config(git_default_config, NULL);
 
 	puts(create_temp_file(sha1));
diff --git a/builtin.h b/builtin.h
index 2aaef74..d4fec89 100644
--- a/builtin.h
+++ b/builtin.h
@@ -103,6 +103,7 @@ extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_unpack_file(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 0b8f8a7..832bd2d 100644
--- a/git.c
+++ b/git.c
@@ -370,6 +370,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
+		{ "unpack-file", cmd_unpack_file, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
-- 
1.6.6.1.399.g73128
