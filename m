From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH 1/3 v2] Add --blob-filter option to filter-branch.
Date: Wed, 23 Apr 2008 16:18:10 -0400
Message-ID: <1208981890-758-1-git-send-email-apenwarr@gmail.com>
References: <alpine.DEB.1.00.0804232113480.20267@eeepc-johanness>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 22:19:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JolR2-0003X0-Jr
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 22:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbYDWUSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 16:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754307AbYDWUSe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 16:18:34 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:55975
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754282AbYDWUSd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2008 16:18:33 -0400
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Apr 2008 16:18:12 -0400
Received: (qmail 26603 invoked from network); 23 Apr 2008 20:18:11 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 23 Apr 2008 20:18:11 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 23A048C4C7; Wed, 23 Apr 2008 16:18:10 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <alpine.DEB.1.00.0804232113480.20267@eeepc-johanness>
X-OriginalArrivalTime: 23 Apr 2008 20:18:12.0202 (UTC) FILETIME=[277D6CA0:01C8A57F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80258>

From: Jeff King <peff@peff.net>

This patch allows

  git filter-branch --blob-filter 'tr a-z A-Z'

However, it's _still_ horribly slow. Shell script is nice and flexible,
but running a tight loop like this is just painful. I suspect
filter-branch in something like perl would be a lot faster and just as
flexible.

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

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ea59015..980c431 100755
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
1.5.4.3
