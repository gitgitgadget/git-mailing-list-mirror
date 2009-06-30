From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Don't clean any untracked submodule's .git dir by default in git-clean
Date: Tue, 30 Jun 2009 16:05:48 -0700
Message-ID: <7vws6t490z.fsf@alter.siamese.dyndns.org>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com>
	<1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>
	<1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>
	<4A49B36D.2080103@viscovery.net>
	<7vljna9nuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Holden <jason.k.holden@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 01 01:05:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLmOj-0003WF-35
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 01:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbZF3XFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 19:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbZF3XFq
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 19:05:46 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47921 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbZF3XFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 19:05:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630230549.BYLL20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jun 2009 19:05:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id AP5o1c0074aMwMQ03P5o5E; Tue, 30 Jun 2009 19:05:48 -0400
X-VR-Score: -264.00
X-Authority-Analysis: v=1.0 c=1 a=9cvXoET4qPUA:10 a=ybZZDoGAAAAA:8
 a=t6zedZttOqBoxkJb0-4A:9 a=dSobN0XZXOAA-wY2AoMA:7
 a=X822pa-CFmqds6IPWtf-I5HoUkgA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7vljna9nuz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 30 Jun 2009 00\:34\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122550>

Junio C Hamano <gitster@pobox.com> writes:

> I think protecting users from mistakes is a very good idea, but I see at
> least two small problems with the patch.  For brevity I'll name the "not a
> submodule in the HEAD commit of the superproject" directory "Meta/" in the
> following.
>
>  (1) Protecting Meta/.git is not goot enough. If it were, and if this is
>      only about submodules, then you can use the "gitdir:" facility to
>      relocate Meta/.git directory to somewhere under superproject's .git
>      and be done with it.
>
>      You _must_ protect the checked out files, their uncommitted contents
>      and untracked but unignored files.  After all, Meta/ is a valid git
>      repository in its own right.  Noticing that "rm -r" is about to
>      remove Meta/.git after it has already touched many other files in
>      Meta/ is one recursion level too late.
>
>  (2) Naming the option to force removal "-m" is wrong; this is not about
>      submodule at all.  Can we use double-force "-f -f", perhaps?

Perhaps like this.

Untested, as I never use "git clean" myself.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 30 Jun 2009 15:33:45 -0700
Subject: [PATCH] clean: require double -f options to nuke nested git repository and work tree

When you have an embedded git work tree in your work tree (be it
an orphaned submodule, or an independent checkout of an unrelated
project), "git clean -d -f" blindly descended into it and removed
everything.  This is rarely what the user wants.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-clean.c  |    7 ++++++-
 dir.c            |   12 ++++++++++--
 dir.h            |    5 ++++-
 refs.c           |    2 +-
 t/t7300-clean.sh |   39 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 1c1b6d2..04ea181 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -31,6 +31,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int i;
 	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, baselen = 0, config_set = 0, errors = 0;
+	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir;
 	const char *path, *base;
@@ -70,6 +71,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		die("clean.requireForce%s set and -n or -f not given; "
 		    "refusing to clean", config_set ? "" : " not");
 
+	if (force > 1)
+		rm_flags = 0;
+
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
 	if (!ignored)
@@ -141,7 +145,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				   (matches == MATCHED_EXACTLY)) {
 				if (!quiet)
 					printf("Removing %s\n", qname);
-				if (remove_dir_recursively(&directory, 0) != 0) {
+				if (remove_dir_recursively(&directory,
+							   rm_flags) != 0) {
 					warning("failed to remove '%s'", qname);
 					errors++;
 				}
diff --git a/dir.c b/dir.c
index bbfcb56..d0cfe74 100644
--- a/dir.c
+++ b/dir.c
@@ -800,12 +800,20 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
-int remove_dir_recursively(struct strbuf *path, int only_empty)
+int remove_dir_recursively(struct strbuf *path, int flag)
 {
-	DIR *dir = opendir(path->buf);
+	DIR *dir;
 	struct dirent *e;
 	int ret = 0, original_len = path->len, len;
+	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
+	unsigned char submodule_head[20];
 
+	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
+	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head))
+		/* Do not descend and nuke a nested git work tree. */
+		return 0;
+
+	dir = opendir(path->buf);
 	if (!dir)
 		return -1;
 	if (path->buf[original_len - 1] != '/')
diff --git a/dir.h b/dir.h
index 541286a..8c69bdd 100644
--- a/dir.h
+++ b/dir.h
@@ -89,7 +89,10 @@ static inline int is_dot_or_dotdot(const char *name)
 extern int is_empty_dir(const char *dir);
 
 extern void setup_standard_excludes(struct dir_struct *dir);
-extern int remove_dir_recursively(struct strbuf *path, int only_empty);
+
+#define REMOVE_DIR_EMPTY_ONLY 01
+#define REMOVE_DIR_KEEP_NESTED_GIT 02
+extern int remove_dir_recursively(struct strbuf *path, int flag);
 
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
diff --git a/refs.c b/refs.c
index 24438c6..a7dd5ae 100644
--- a/refs.c
+++ b/refs.c
@@ -820,7 +820,7 @@ static int remove_empty_directories(const char *file)
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
-	result = remove_dir_recursively(&path, 1);
+	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
 
 	strbuf_release(&path);
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 929d5d4..118c6eb 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -380,4 +380,43 @@ test_expect_success 'removal failure' '
 '
 chmod 755 foo
 
+test_expect_success 'nested git work tree' '
+	rm -fr foo bar &&
+	mkdir foo bar &&
+	(
+		cd foo &&
+		git init &&
+		>hello.world
+		git add . &&
+		git commit -a -m nested
+	) &&
+	(
+		cd bar &&
+		>goodbye.people
+	) &&
+	git clean -f -d &&
+	test -f foo/.git/index &&
+	test -f foo/hello.world &&
+	! test -d bar
+'
+
+test_expect_success 'force removal of nested git work tree' '
+	rm -fr foo bar &&
+	mkdir foo bar &&
+	(
+		cd foo &&
+		git init &&
+		>hello.world
+		git add . &&
+		git commit -a -m nested
+	) &&
+	(
+		cd bar &&
+		>goodbye.people
+	) &&
+	git clean -f -f -d &&
+	! test -d foo &&
+	! test -d bar
+'
+
 test_done
-- 
1.6.3.3.362.g3c77e
