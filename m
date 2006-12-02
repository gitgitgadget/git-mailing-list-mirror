X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Patch: git-add --exclude=pattern
Date: Sun, 3 Dec 2006 05:29:50 +0800
Message-ID: <20061203052950.A26793@freya>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
NNTP-Posting-Date: Sat, 2 Dec 2006 21:25:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.2i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33055>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqcMK-0007Yn-FG for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162488AbWLBVZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162490AbWLBVZQ
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:25:16 -0500
Received: from [61.149.22.133] ([61.149.22.133]:51331 "EHLO
 freya.yggdrasil.com") by vger.kernel.org with ESMTP id S1162488AbWLBVZN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:25:13 -0500
Received: from freya.yggdrasil.com (localhost [127.0.0.1]) by
 freya.yggdrasil.com (8.13.8/8.13.8) with ESMTP id kB2LToBL027833; Sun, 3 Dec
 2006 05:29:51 +0800
Received: (from adam@localhost) by freya.yggdrasil.com (8.13.8/8.13.8/Submit)
 id kB2LTot4027832; Sun, 3 Dec 2006 05:29:50 +0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	git-ls-files has an argument "--exclude=<pattern>".  I have
copied the relevant code snippets to do the same for git-add-files.

	I want this facility so that I can disable processing of
.gitignore files for some shell scripts that I've cobbled together
to update git repositories from tar files of new versions of software
packages.  Adding "!*" to .git/info/exclude does not achieve this,
because the .gitignore files have priority, and I can see arguments
why this should be so, so that .git/info/exclude can just encode
defaults and individual directories can have more specific rules.
In comparison, passing "--exclude='!*'" apparently does have priority
over the .gitignore files.

	By the way, the particular situation where I had this problem
was in linux-2.6.19, which shoots itself in the foot a bit by including
.gitignore files that exclude source files like arch/*/kernel/vmlinux.ld.S,
include/asm-*/{alternative-asm,frame}.i and the .cvsignore files themselves.
However, fixing this linux kernel problem is not the point of this email.
I want a facility that can reliably add files from source trees even if
they have minor bugs like this in their .gitignore rules.

	Many thanks to ShadeHawk on the git IRC channel for pointing
out to me that the git-find-ls manual page actually describes the problem
and a fix for the case of vmlinux.ld.S in the linux kernel tree, and for
suggesting --exclude=pattern instead of --exclude-per-directory=filename.

Adam Richter

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="add-exclude.diff"

diff --git a/src/builtin-add.c b/src/builtin-add.c
index febb75e..a501b50 100644
--- a/src/builtin-add.c
+++ b/src/builtin-add.c
@@ -11,7 +11,7 @@
 #include "cache-tree.h"
 
 static const char builtin_add_usage[] =
-"git-add [-n] [-v] <filepattern>...";
+"git-add [--exclude=<pattern>] [-n] [-v] <filepattern>...";
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
@@ -55,7 +55,6 @@ static void fill_directory(struct dir_st
 	int baselen;
 
 	/* Set up the default git porcelain excludes */
-	memset(dir, 0, sizeof(*dir));
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
 	if (!access(path, R_OK))
@@ -90,6 +89,7 @@ int cmd_add(int argc, const char **argv,
 	const char **pathspec;
 	struct dir_struct dir;
 
+	memset(&dir, 0, sizeof(dir));
 	git_config(git_default_config);
 
 	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
@@ -106,6 +106,10 @@ int cmd_add(int argc, const char **argv,
 			i++;
 			break;
 		}
+		if (!strncmp(arg, "--exclude=", 10)) {
+			add_exclude(arg+10, "", 0, &dir.exclude_list[EXC_CMDL]);
+			continue;
+		}
 		if (!strcmp(arg, "-n")) {
 			show_only = 1;
 			continue;

