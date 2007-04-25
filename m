From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 2/2] Add basic support for bookmarks (create/edit/delete/list)
Date: Wed, 25 Apr 2007 23:29:42 +0100
Message-ID: <20070425225021.15383.4504.julian@quantumfyre.co.uk>
References: <200704252004.45112.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
	<200704252142.33756.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
	<20070425225021.15383.87006.julian@quantumfyre.co.uk>
Cc: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 00:51:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgqKl-0004CW-DU
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 00:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993076AbXDYWvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 18:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423399AbXDYWvc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 18:51:32 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:42117 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993076AbXDYWva (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 18:51:30 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 77D49C66C7
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 23:51:28 +0100 (BST)
Received: (qmail 16219 invoked by uid 103); 25 Apr 2007 23:50:26 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3159. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.026515 secs); 25 Apr 2007 22:50:26 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 25 Apr 2007 23:50:26 +0100
X-git-sha1: 2d30ac219b9e341acbabbe1d698c3b24baa47dbb 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <20070425225021.15383.87006.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45591>

A bookmark is basically a private tag, you can create/modify/delete
them by using the -b switch to git-tag.  You can also set
tag.alwaysShowBookmarks so that git-tag -l will always show bookmarks
in addition to tags.

(You have to refer to bookmarks as bm/foo rather than foo to keep the
namespace separate from tags.)

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 Documentation/config.txt        |    4 ++++
 Documentation/git-rev-parse.txt |    3 +++
 Documentation/git-tag.txt       |   10 +++++++---
 builtin-rev-parse.c             |    5 +++++
 git-tag.sh                      |   28 ++++++++++++++++++++--------
 refs.c                          |    5 +++++
 refs.h                          |    1 +
 7 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0aff53..6a11719 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -597,6 +597,10 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+tag.alwaysShowBookmarks::
+	Tag -l always shows bookmarks, even without -b option.
+	See gitlink:git-tag[1].
+
 tar.umask::
 	By default, gitlink:git-tar-tree[1] sets file and directories modes
 	to 0666 or 0777. While this is both useful and acceptable for projects
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index a8bf656..1d74e21 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -73,6 +73,9 @@ OPTIONS
 --tags::
 	Show tag refs found in `$GIT_DIR/refs/tags`.
 
+--bookmarks::
+	Show bookmarks (private tags) found in `$GIT_DIR/refs/bm`.
+
 --remotes::
 	Show tag refs found in `$GIT_DIR/refs/remotes`.
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 70235e8..331b741 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,13 +9,14 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git-tag' [-a | -s | -u <key-id>] [-f | -v] [-m <msg> | -F <file>]  <name> [<head>]
+'git-tag' [-b] [-a | -s | -u <key-id>] [-f | -v] [-m <msg> | -F <file>]  <name> [<head>]
 'git-tag' -d <name>...
-'git-tag' -l [<pattern>]
+'git-tag' [-b] -l [<pattern>]
 
 DESCRIPTION
 -----------
-Adds a 'tag' reference in `.git/refs/tags/`
+Adds a 'tag' reference in `.git/refs/tags/` (unless -b is given, in which case
+the reference is added in `.git/refs/bm/` instead)
 
 Unless `-f` is given, the tag must not yet exist in
 `.git/refs/tags/` directory.
@@ -45,6 +46,9 @@ OPTIONS
 -a::
 	Make an unsigned, annotated tag object
 
+-b::
+	Make a bookmark (private tag) in refs/bm instead a tag in refs/tags.
+
 -s::
 	Make a GPG-signed tag, using the default e-mail address's key
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37addb2..1c9086c 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -50,6 +50,7 @@ static int is_rev_argument(const char *arg)
 		"--remotes",
 		"--sparse",
 		"--tags",
+		"--bookmarks",
 		"--topo-order",
 		"--date-order",
 		"--unpacked",
@@ -310,6 +311,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
+			if (!strcmp(arg, "--bookmarks")) {
+				for_each_bookmark_ref(show_reference, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--remotes")) {
 				for_each_remote_ref(show_reference, NULL);
 				continue;
diff --git a/git-tag.sh b/git-tag.sh
index 4a0a7b6..e42e015 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -1,10 +1,18 @@
 #!/bin/sh
 # Copyright (c) 2005 Linus Torvalds
 
-USAGE='-l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
+USAGE='[-b] -l [<pattern>] | [-b] [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
+tag_dir="refs/tags"
+
+bm=
+if git-config --get tag.alwaysShowBookmarks > /dev/null
+then
+	bm=--bookmarks
+fi
+
 message_given=
 annotate=
 signed=
@@ -19,6 +27,10 @@ do
     -a)
 	annotate=1
 	;;
+    -b)
+	bm="--bookmarks"
+	tag_dir="refs/bm"
+	;;
     -s)
 	annotate=1
 	signed=1
@@ -32,7 +44,7 @@ do
 		set x . ;;
 	esac
 	shift
-	git rev-parse --symbolic --tags | sort | grep "$@"
+	git rev-parse --symbolic $bm --tags | sort | grep "$@"
 	exit $?
 	;;
     -m)
@@ -66,12 +78,12 @@ do
 	had_error=0
 	for tag
 	do
-		cur=$(git-show-ref --verify --hash -- "refs/tags/$tag") || {
+		cur=$(git-show-ref --verify --hash -- "$tag_dir/$tag") || {
 			echo >&2 "Seriously, what tag are you talking about?"
 			had_error=1
 			continue
 		}
-		git-update-ref -m 'tag: delete' -d "refs/tags/$tag" "$cur" || {
+		git-update-ref -m 'tag: delete' -d "$tag_dir/$tag" "$cur" || {
 			had_error=1
 			continue
 		}
@@ -82,7 +94,7 @@ do
     -v)
 	shift
 	tag_name="$1"
-	tag=$(git-show-ref --verify --hash -- "refs/tags/$tag_name") ||
+	tag=$(git-show-ref --verify --hash -- "$tag_dir/$tag_name") ||
 		die "Seriously, what tag are you talking about?"
 	git-verify-tag -v "$tag"
 	exit $?
@@ -100,10 +112,10 @@ done
 name="$1"
 [ "$name" ] || usage
 prev=0000000000000000000000000000000000000000
-if git-show-ref --verify --quiet -- "refs/tags/$name"
+if git-show-ref --verify --quiet -- "$tag_dir/$name"
 then
     test -n "$force" || die "tag '$name' already exists"
-    prev=`git rev-parse "refs/tags/$name"`
+    prev=`git rev-parse "$tag_dir/$name"`
 fi
 shift
 git-check-ref-format "tags/$name" ||
@@ -149,5 +161,5 @@ if [ "$annotate" ]; then
     object=$(git-mktag < "$GIT_DIR"/TAG_TMP)
 fi
 
-git update-ref "refs/tags/$name" "$object" "$prev"
+git update-ref "$tag_dir/$name" "$object" "$prev"
 
diff --git a/refs.c b/refs.c
index a771975..b89c946 100644
--- a/refs.c
+++ b/refs.c
@@ -569,6 +569,11 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/tags/", fn, 10, cb_data);
 }
 
+int for_each_bookmark_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref("refs/bm/", fn, 5, cb_data);
+}
+
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/heads/", fn, 11, cb_data);
diff --git a/refs.h b/refs.h
index f61f6d9..60a15a2 100644
--- a/refs.h
+++ b/refs.h
@@ -21,6 +21,7 @@ typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flag
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
+extern int for_each_bookmark_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 
-- 
1.5.1.2
