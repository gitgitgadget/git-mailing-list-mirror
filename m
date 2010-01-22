From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 18:25:20 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211823590.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211811140.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:25:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9DY-0003JU-JF
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab0AVCZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755774Ab0AVCZn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:25:43 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57236 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755560Ab0AVCZn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 21:25:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M2PLWL007855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 18:25:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M2PK8e011478;
	Thu, 21 Jan 2010 18:25:21 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001211811140.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137722>



On Thu, 21 Jan 2010, Linus Torvalds wrote:
> 
> > By the way, do you think anybody still uses "git merge-trees"?
> 
> I dunno. I think it has some conceptual advantages, but realistically, I 
> doubt anybody is willing to go through the pain to make it grow up enough 
> to become a viable alternative to our current situation.

This makes it a built-in, at least, so it doesn't waste the diskspace.

		Linus

---
 Makefile                             |    2 +-
 merge-tree.c => builtin-merge-tree.c |    4 +---
 builtin.h                            |    1 +
 git.c                                |    1 +
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 3439d2c..35aea16 100644
--- a/Makefile
+++ b/Makefile
@@ -391,7 +391,6 @@ PROGRAMS += git-hash-object$X
 PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
-PROGRAMS += git-merge-tree$X
 PROGRAMS += git-mktag$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
@@ -670,6 +669,7 @@ BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
 BUILTIN_OBJS += builtin-merge-ours.o
 BUILTIN_OBJS += builtin-merge-recursive.o
+BUILTIN_OBJS += builtin-merge-tree.o
 BUILTIN_OBJS += builtin-mktree.o
 BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
diff --git a/merge-tree.c b/builtin-merge-tree.c
similarity index 99%
rename from merge-tree.c
rename to builtin-merge-tree.c
index 37b94d9..8e16c3e 100644
--- a/merge-tree.c
+++ b/builtin-merge-tree.c
@@ -337,7 +337,7 @@ static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
 	return buf;
 }
 
-int main(int argc, char **argv)
+int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
@@ -347,8 +347,6 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	setup_git_directory();
-
 	buf1 = get_tree_descriptor(t+0, argv[1]);
 	buf2 = get_tree_descriptor(t+1, argv[2]);
 	buf3 = get_tree_descriptor(t+2, argv[3]);
diff --git a/builtin.h b/builtin.h
index 4d73d7c..06bf04e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -70,6 +70,7 @@ extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_mktree(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 5fabf18..e5964a8 100644
--- a/git.c
+++ b/git.c
@@ -335,6 +335,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge-tree", cmd_merge_tree, RUN_SETUP },
 		{ "mktree", cmd_mktree, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
