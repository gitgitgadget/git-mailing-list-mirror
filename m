From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 25/40] Windows: Implement a cpio emulation in git-clone.sh.
Date: Wed, 27 Feb 2008 19:54:48 +0100
Message-ID: <1204138503-6126-26-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVP-00022R-2F
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182AbYB0Szo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbYB0Szl
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:41 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40438 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605AbYB0SzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 9D9009771A;
	Wed, 27 Feb 2008 19:55:08 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75270>

We use 'xargs cp' to emulate 'cpio -pumd'.

cpio is fed from the output of 'find --depth' without filtering out
directories. We don't need to copy directories except the empty ones, so
we need to filter out non-empty directories. Then we can use 'cp -r' and
it will not actually recurse anything.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-clone.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 1fc5c92..87fc0fb 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -39,6 +39,33 @@ case $(uname -s) in
 	find () {
 		/usr/bin/find "$@"
 	}
+	# need an emulation of cpio
+	cpio() {
+		case "$1" in
+		-pumd)	cp_arg=-pr;;
+		-pumdl)	cp_arg=-lr;;
+		*)	die "cpio $1 unexpected";;
+		esac
+		# copy only files and empty directories
+		prev=
+		while read f; do
+			if test -d "$f"; then
+				# here we assume that directories are listed after
+				# its files (aka 'find -depth'), hence, a directory
+				# that is not empty will be a leading sub-string
+				# of the preceding entry
+				case "$prev" in
+				"$f"/* ) ;;
+				*)	echo "$f";;
+				esac
+			else
+				echo "$f"
+			fi
+			prev="$f"
+		done |
+		xargs --no-run-if-empty \
+			cp $cp_arg --target-directory="$2" --parents
+	}
 	# pwd must return a path with a drive letter
 	bin_pwd() {
 		# there are no symlinks to resolve: /bin/pwd is not needed
-- 
1.5.4.1.126.ge5a7d
