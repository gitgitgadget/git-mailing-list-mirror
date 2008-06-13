From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH v2 2/3] filter-branch --blob-filter: speed/flexibility improvements.
Date: Thu, 12 Jun 2008 20:52:23 -0400
Message-ID: <1213318344-26013-2-git-send-email-apenwarr@gmail.com>
References: <1213318344-26013-1-git-send-email-apenwarr@gmail.com>
Cc: gitster@pobox.com, Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 03:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6xhy-0006Da-3D
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 03:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757968AbYFMBDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 21:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758211AbYFMBDI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 21:03:08 -0400
Received: from host.237.101.mtl.cablemodem.vdn.ca ([206.223.237.101]:33078
	"EHLO insight.mtl.versabanq.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757941AbYFMBDF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 21:03:05 -0400
Received: by insight.mtl.versabanq.com (Postfix, from userid 1000)
	id 27D48E7C534; Thu, 12 Jun 2008 20:52:24 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.rc2.29.g4717e
In-Reply-To: <1213318344-26013-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84818>

Export the current file path as $GIT_BLOB_PATH, so we can filter a blob
differently based on its path, and change the caching mechanism to re-filter
a particular blob if its path changes.

Also, make it much faster by not calling 'cat'. The main loop of
munge_blobs() had to fork-exec "cat" every time through the loop, even when
a blob was already cached.  Let's use the sh builtin 'read' instead for a
huge speedup.

cd git
time git filter-branch --blob-filter 'tr a-z A-Z' HEAD~10..HEAD

(original --blob-filter)
real    3m58.569s
user    0m22.900s
sys     3m32.030s

(with 'cat' calls removed)
real	1m11.931s
user	0m8.520s
sys	1m2.900s

(with 'cat' calls removed and blob cache already filled)
real	0m19.660s
user	0m3.930s
sys	0m15.720s

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 Documentation/git-filter-branch.txt |   27 +++++++++++++++++++++++++++
 git-filter-branch.sh                |   27 +++++++++++++++++----------
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ea77f1f..0c5cd0f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 	[--index-filter <command>] [--parent-filter <command>]
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
+	[--blob-filter <command]
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[<rev-list options>...]
 
@@ -149,6 +150,16 @@ to other tags will be rewritten to point to the underlying commit.
 	The result will contain that directory (and only that) as its
 	project root.
 
+--blob-filter <command>::
+	This is the filter for modifying the contents of each file (blob) in
+	the tree.  The contents of a file are provided on stdin, and the new
+	file contents should be provided on stdout.  The pathname of the
+	blob in the current revision is in $GIT_BLOB_PATH. For efficiency,
+	the before/after results of a given blob+filename are only
+	calculated once and then cached, so your filter must always return
+	the same output blob for any given input blob.  You might use this
+	filter for converting CRLF to LF in all your files, for example.
+
 --original <namespace>::
 	Use this option to set the namespace where the original commits
 	will be stored. The default value is 'refs/original'.
@@ -196,6 +207,22 @@ git filter-branch --index-filter 'git update-index --remove filename' HEAD
 
 Now, you will get the rewritten history saved in HEAD.
 
+To convert CRLF to LF in all your files using the "fromdos" program (be
+careful: this will attempt to modify binary files too!):
+
+----------------------------------------------
+git filter-branch --blob-filter 'fromdos' HEAD
+----------------------------------------------
+
+To convert CRLF to LF in all your *.c and *.cpp files:
+
+---------------------------------------------------------
+git filter-branch --blob-filter 'case "$GIT_BLOB_PATH" in
+	*.c|*.cpp) fromdos;;
+	*) cat;;
+esac' HEAD
+---------------------------------------------------------
+
 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
 order to paste the other history behind the current history:
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a0d9a79..f1ee263 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -55,19 +55,24 @@ EOF
 eval "$functions"
 
 munge_blobs() {
-	while read mode sha1 stage path
+	while read GIT_BLOB_MODE GIT_BLOB_SHA1 stage GIT_BLOB_PATH
 	do
-		if ! test -r "$workdir/../blob-cache/$sha1"
+		export GIT_BLOB_MODE GIT_BLOB_SHA1 GIT_BLOB_PATH
+		cachefile="$cachedir/$GIT_BLOB_SHA1/$GIT_BLOB_PATH"
+		if ! test -r "$cachefile"
 		then
-			new=`git cat-file blob $sha1 |
-			     eval "$filter_blob" |
-			     git hash-object -w --stdin`
-			printf $new >$workdir/../blob-cache/$sha1
+			new=$(git cat-file blob $GIT_BLOB_SHA1 |
+			      eval "$filter_blob" |
+			      git hash-object -w --stdin)
+			mkdir -p "$(dirname "$cachefile")"
+			echo -n $new >"$cachefile"
+		else
+			read new <"$cachefile"
 		fi
 		printf "%s %s\t%s\n" \
-			"$mode" \
-			$(cat "$workdir/../blob-cache/$sha1") \
-			"$path"
+			"$GIT_BLOB_MODE" \
+			"$new" \
+			"$GIT_BLOB_PATH"
 	done
 }
 
@@ -108,6 +113,7 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
 [--index-filter <command>] [--parent-filter <command>] \
 [--msg-filter <command>] [--commit-filter <command>] \
 [--tag-name-filter <command>] [--subdirectory-filter <directory>] \
+[--blob-filter <command>] \
 [--original <namespace>] [-d <directory>] [-f | --force] \
 [<rev-list options>...]"
 
@@ -249,7 +255,8 @@ ret=0
 mkdir ../map || die "Could not create map/ directory"
 
 # cache rewritten blobs for blob filter
-mkdir ../blob-cache || die "Could not create blob-cache/ directory"
+cachedir="$workdir/../blob-cache"
+mkdir "$cachedir" || die "Could not create blob-cache/ directory"
 
 case "$filter_subdir" in
 "")
-- 
1.5.6.rc2.29.g4717e
