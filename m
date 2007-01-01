From: Robert Fitzsimons <robfitz@273k.net>
Subject: [RFC/PATCH] Add builtin git-last-modified.
Date: Mon, 1 Jan 2007 07:55:15 +0000
Message-ID: <20070101075515.GK6558@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 01 08:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1I1C-0000BZ-TS
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 08:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbXAAHzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 02:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933249AbXAAHzg
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 02:55:36 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:38897 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933247AbXAAHzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 02:55:35 -0500
Received: from [212.2.164.25] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H1I0r-0008DH-4A
	for git@vger.kernel.org; Mon, 01 Jan 2007 07:55:17 +0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.199, required 7,
	autolearn=disabled, RCVD_IN_DSBL 1.80, RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35731>

This is a plumbing command which can be used by gitweb.  It will scan
a list of commits and/or refs and return the time in seconds for the
youngest commit.  This value can then be used to generate and check
the Last-Modified and Is-Modified-Since HTTP headers.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---


The following two commands lines are similar:

$ git for-each-ref --count=1 --sort=-committerdate '--format=%(committerdate)' refs/heads
$ git last-modified --branches

The last-modified version is a bit faster (5-10%).

I'm not 100% sure how this command and if this command should be used
by gitweb.  But I'll post the patch anyway for comments.

Robert



 .gitignore                          |    1 +
 Documentation/git-last-modified.txt |   49 ++++++++++++++++++++++++++++
 Makefile                            |    3 +-
 builtin-last-modified.c             |   61 +++++++++++++++++++++++++++++++++++
 builtin.h                           |    1 +
 git.c                               |    1 +
 t/t3810-last-modified.sh            |   57 ++++++++++++++++++++++++++++++++
 7 files changed, 172 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2904f12..ffca6c5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -58,6 +58,7 @@ git-lost-found
 git-ls-files
 git-ls-remote
 git-ls-tree
+git-last-modified
 git-mailinfo
 git-mailsplit
 git-merge
diff --git a/Documentation/git-last-modified.txt b/Documentation/git-last-modified.txt
new file mode 100644
index 0000000..4584b5d
--- /dev/null
+++ b/Documentation/git-last-modified.txt
@@ -0,0 +1,49 @@
+git-last-modified(1)
+================
+
+NAME
+----
+git-last-modified - Get the last modified time in seconds
+
+
+SYNOPSIS
+--------
+'git-last-modified' [ \--all ]
+		    [ \--branches ]
+		    [ \--tags ]
+		    [ \--remotes ]
+		    <commmit>...
+
+DESCRIPTION
+-----------
+
+Get the last modified time in seconds for the youngest commit object
+based on the search criteria.  The time value is from the 'commit'
+header of the commit object, ignoring the timezone.  The time is
+formatted as an ASCII decimal number and is the number of seconds
+since epoch.
+
+This is a plumbing command used by gitweb to generate and check the
+Last-Modified and Is-Modified-Since HTTP headers.
+
+OPTIONS
+-------
+--all::
+	Search all refs found in `$GIT_DIR/refs`.
+
+--branches::
+	Search branch refs found in `$GIT_DIR/refs/heads`.
+
+--tags::
+	Search tag refs found in `$GIT_DIR/refs/tags`.
+
+--remotes::
+	Search remote refs found in `$GIT_DIR/refs/remotes`.
+
+<commit>...::
+	Search list of commits and refs.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index fa1a022..1f169ac 100644
--- a/Makefile
+++ b/Makefile
@@ -312,7 +312,8 @@ BUILTIN_OBJS = \
 	builtin-verify-pack.o \
 	builtin-write-tree.o \
 	builtin-show-ref.o \
-	builtin-pack-refs.o
+	builtin-pack-refs.o \
+	builtin-last-modified.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/builtin-last-modified.c b/builtin-last-modified.c
new file mode 100644
index 0000000..38cfb80
--- /dev/null
+++ b/builtin-last-modified.c
@@ -0,0 +1,61 @@
+#include "cache.h"
+#include "commit.h"
+#include "refs.h"
+#include "builtin.h"
+
+static int lastmod_date(const unsigned char *sha1, unsigned long *date)
+{
+	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+
+	if (!commit)
+		return 1;
+
+	if (commit->date > *date)
+		*date = commit->date;
+
+	return 0;
+}
+
+static int process_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+{
+	return lastmod_date(sha1, (unsigned long *)cb_data);
+}
+
+int cmd_last_modified(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	unsigned char sha1[20];
+	unsigned long date = 0;
+
+	git_config(git_default_config);
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--all")) {
+			for_each_ref(process_ref, &date);
+			continue;
+		}
+		if (!strcmp(arg, "--branches")) {
+			for_each_branch_ref(process_ref, &date);
+			continue;
+		}
+		if (!strcmp(arg, "--tags")) {
+			for_each_tag_ref(process_ref, &date);
+			continue;
+		}
+		if (!strcmp(arg, "--remotes")) {
+			for_each_remote_ref(process_ref, &date);
+			continue;
+		}
+
+		if (get_sha1(arg, sha1))
+			die("last-modified: could not get sha1 for '%s'", arg);
+		if (lastmod_date(sha1, &date))
+			die("last-modified: bad revision '%s'", arg);
+	}
+
+	printf("%lu\n", date);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index df72d09..862cadb 100644
--- a/builtin.h
+++ b/builtin.h
@@ -75,5 +75,6 @@ extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
+extern int cmd_last_modified(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/git.c b/git.c
index c82ca45..e6242e6 100644
--- a/git.c
+++ b/git.c
@@ -269,6 +269,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "verify-pack", cmd_verify_pack },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
+		{ "last-modified", cmd_last_modified, RUN_SETUP },
 	};
 	int i;
 
diff --git a/t/t3810-last-modified.sh b/t/t3810-last-modified.sh
new file mode 100755
index 0000000..d85283e
--- /dev/null
+++ b/t/t3810-last-modified.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+test_description='git-last-modified'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+    for n in 1 2 3 4 5 ; do \
+        echo $n > a ; \
+        git-add a ; \
+        git-commit -m "$n" ; \
+    done ; \
+    git-tag -m "t1" t1 ; \
+    git-checkout -b o ; \
+    for n in o1 o1 o3 o4 o5 ; do \
+        echo $n > b ; \
+        git-add b ; \
+        git-commit -m "$n" ; \
+    done ; \
+    git-tag -m "t2" t2 ; \
+    git-checkout master
+'
+
+test_expect_success 'no options' '
+    test $(git-last-modified) -eq 0
+'
+
+test_expect_success 'rev HEAD' '
+    test $(git-last-modified HEAD) -gt 0 &&
+    test $(git-last-modified refs/heads/master) -gt 0 &&
+    test $(git-last-modified --all) -gt 0 &&
+    test $(git-last-modified --branches) -gt 0 &&
+    test $(git-last-modified --tags) -gt 0 &&
+    test $(git-last-modified --remotes) -eq 0
+'
+
+test_expect_success 'rev master -lt o' '
+    test $(git-last-modified master) -lt $(git-last-modified o)
+'
+
+test_expect_success 'mixed --branches HEAD t1 o' '
+    test $(git-last-modified --branches HEAD t1 o) -gt 0
+'
+
+test_expect_failure 'bad sha1' '
+    git-last-modified 000000
+'
+
+test_expect_failure 'bad rev' '
+    git-last-modified xyz
+'
+
+test_expect_failure 'bad --branches rev' '
+    git-last-modified xyz
+'
+
+test_done
-- 
1.5.0.rc0.g2708-dirty
