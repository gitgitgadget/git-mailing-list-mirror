From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH v2 1/3] filter-branch: add new --blob-filter option.
Date: Thu, 12 Jun 2008 20:52:22 -0400
Message-ID: <1213318344-26013-1-git-send-email-apenwarr@gmail.com>
Cc: gitster@pobox.com, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 03:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6xhx-0006Da-GA
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 03:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758223AbYFMBDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 21:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758211AbYFMBDH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 21:03:07 -0400
Received: from host.237.101.mtl.cablemodem.vdn.ca ([206.223.237.101]:33080
	"EHLO insight.mtl.versabanq.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757933AbYFMBDF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 21:03:05 -0400
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2008 21:03:05 EDT
Received: by insight.mtl.versabanq.com (Postfix, from userid 1000)
	id 13DDCE7C532; Thu, 12 Jun 2008 20:52:24 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.rc2.29.g4717e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84820>

From: Jeff King <peff@peff.net>

On Tue, Apr 22, 2008 at 12:51:14PM -0400, Avery Pennarun wrote:

> Do you think git would benefit from having a generalized version of
> this script?  Basically, the user provides a "munge" script on the
> command line, and there's a git-filter-branch mode for auto-munging
> (with a cache) every file in every checkin.  Even if it's *only* ever
> used for CRLF, I can imagine this being useful to a lot of people.

It was easy enough to work up the patch below, which allows

  git filter-branch --blob-filter 'tr a-z A-Z'

However, it's _still_ horribly slow. Shell script is nice and flexible,
but running a tight loop like this is just painful. I suspect
filter-branch in something like perl would be a lot faster and just as
flexible (you could even do it in C, but you'd probably have to invent a
little domain-specific scripting language).

It is still much better performance than a tree filter, though:

  $ cd git && time git filter-branch --tree-filter '
      find . -type f | while read f; do
        tr a-z A-Z <"$f" >tmp
        mv tmp "$f"
      done
    ' HEAD~10..HEAD

  real    4m38.626s
  user    1m32.726s
  sys     2m51.163s

  $ cd git && git filter-branch --blob-filter 'tr a-z A-Z' HEAD~10..HEAD
  real    1m40.809s
  user    0m36.822s
  sys     1m14.273s

Lots of system time in both. I'm sure we spend a fair bit of time
hitting our very large map and blob-cache directories, which would be
much more nicely implemented as associative arrays in memory (if we were
using a more featureful language).

Anyway, here is the patch. I don't know if it is even worth applying,
since it is still painfully slow.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index d04c346..a0d9a79 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -54,6 +54,23 @@ EOF
 
 eval "$functions"
 
+munge_blobs() {
+	while read mode sha1 stage path
+	do
+		if ! test -r "$workdir/../blob-cache/$sha1"
+		then
+			new=`git cat-file blob $sha1 |
+			     eval "$filter_blob" |
+			     git hash-object -w --stdin`
+			printf $new >$workdir/../blob-cache/$sha1
+		fi
+		printf "%s %s\t%s\n" \
+			"$mode" \
+			$(cat "$workdir/../blob-cache/$sha1") \
+			"$path"
+	done
+}
+
 # When piped a commit, output a script to set the ident of either
 # "author" or "committer
 
@@ -105,6 +122,7 @@ tempdir=.git-rewrite
 filter_env=
 filter_tree=
 filter_index=
+filter_blob=
 filter_parent=
 filter_msg=cat
 filter_commit='git commit-tree "$@"'
@@ -150,6 +168,9 @@ do
 	--index-filter)
 		filter_index="$OPTARG"
 		;;
+	--blob-filter)
+		filter_blob="$OPTARG"
+		;;
 	--parent-filter)
 		filter_parent="$OPTARG"
 		;;
@@ -227,6 +248,9 @@ ret=0
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
+# cache rewritten blobs for blob filter
+mkdir ../blob-cache || die "Could not create blob-cache/ directory"
+
 case "$filter_subdir" in
 "")
 	git rev-list --reverse --topo-order --default HEAD \
@@ -295,6 +319,12 @@ while read commit parents; do
 	eval "$filter_index" < /dev/null ||
 		die "index filter failed: $filter_index"
 
+	if test -n "$filter_blob"; then
+		git ls-files --stage |
+		munge_blobs |
+		git update-index --index-info
+	fi
+
 	parentstr=
 	for parent in $parents; do
 		for reparent in $(map "$parent"); do
-- 
1.5.6.rc2.29.g4717e
