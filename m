From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH 2/3] Make filter-branch --glob-filter much faster by not calling 'cat'
Date: Wed, 23 Apr 2008 15:42:36 -0400
Message-ID: <1208979757-30860-2-git-send-email-apenwarr@gmail.com>
References: <>
 <1208979757-30860-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:44:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jokt3-0006D4-Fw
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbYDWTnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbYDWTnZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:43:25 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:38967
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751350AbYDWTnY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2008 15:43:24 -0400
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Apr 2008 15:42:41 -0400
Received: (qmail 12499 invoked from network); 23 Apr 2008 19:42:40 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 23 Apr 2008 19:42:40 -0000
Received: (qmail 12491 invoked from network); 23 Apr 2008 19:42:40 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 23 Apr 2008 19:42:40 -0000
Received: (qmail 12459 invoked from network); 23 Apr 2008 19:42:38 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 23 Apr 2008 19:42:38 -0000
Received: (qmail 12417 invoked from network); 23 Apr 2008 19:42:37 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 23 Apr 2008 19:42:37 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 3AE398C4C2; Wed, 23 Apr 2008 15:42:37 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1208979757-30860-1-git-send-email-apenwarr@gmail.com>
X-OriginalArrivalTime: 23 Apr 2008 19:42:41.0048 (UTC) FILETIME=[31392180:01C8A57A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80252>

The main loop of munge_blobs() had to fork-exec "cat" every time through the
loop, even when a blob was already cached.  Let's use the sh builtin 'read'
instead for a huge speedup.

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
 git-filter-branch.sh |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 980c431..37ac99d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -57,16 +57,18 @@ eval "$functions"
 munge_blobs() {
 	while read mode sha1 stage path
 	do
-		if ! test -r "$workdir/../blob-cache/$sha1"
+		if ! test -r "$cachedir/$sha1"
 		then
-			new=`git cat-file blob $sha1 |
-			     eval "$filter_blob" |
-			     git hash-object -w --stdin`
-			printf $new >$workdir/../blob-cache/$sha1
+			new=$(git cat-file blob $sha1 |
+			      eval "$filter_blob" |
+			      git hash-object -w --stdin)
+			printf $new >$cachedir/$sha1
+		else
+			read new <"$cachedir/$sha1"
 		fi
 		printf "%s %s\t%s\n" \
 			"$mode" \
-			$(cat "$workdir/../blob-cache/$sha1") \
+			"$new" \
 			"$path"
 	done
 }
@@ -108,6 +110,7 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
 [--index-filter <command>] [--parent-filter <command>] \
 [--msg-filter <command>] [--commit-filter <command>] \
 [--tag-name-filter <command>] [--subdirectory-filter <directory>] \
+[--blob-filter <command>] \
 [--original <namespace>] [-d <directory>] [-f | --force] \
 [<rev-list options>...]"
 
@@ -249,7 +252,8 @@ ret=0
 mkdir ../map || die "Could not create map/ directory"
 
 # cache rewritten blobs for blob filter
-mkdir ../blob-cache || die "Could not create blob-cache/ directory"
+cachedir="$workdir/../blob-cache"
+mkdir "$cachedir" || die "Could not create blob-cache/ directory"
 
 case "$filter_subdir" in
 "")
-- 
1.5.4.3
