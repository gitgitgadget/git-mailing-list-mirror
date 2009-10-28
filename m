From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] mergetool--lib: add support for p4merge
Date: Wed, 28 Oct 2009 02:11:27 -0700
Message-ID: <1256721087-72534-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 10:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N34ZO-0006rS-7A
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 10:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbZJ1JLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 05:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbZJ1JLn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 05:11:43 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:62739 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbZJ1JL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 05:11:29 -0400
Received: by pzk26 with SMTP id 26so443350pzk.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=g1SGIKDzrmNQFrj0w+lN/ZBIvcbcyAuBq9NyVWH9tAg=;
        b=HCsxsykDBlFnhovEImIxVZH4uavE32BU6U/cq7Zbp3BwCaVVdmU3ZNNd+zu9vH8/Nt
         dwc9TODaCt6EX796sVRmTLKdn5tyKkSdxF9FZDL2aNMitBSM8fdBGZof/sR6elBGeYvl
         PvyfFpSTU+/2fNNt/ycaRqwpsTV9MhrO2KP/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Oi4OYs6BMigmKI2fYoBHzVPNh9W1AKSDhnlUP0vzw6huJ9y7Lwnw8azup7LiKCJFJt
         td5Y/qrUxcjSJlTh6SrzQpyDO31t8R3VGEQhPJmCy9Td48c2IwIkzonMpHm6C3J9fq3F
         JVQXJE0eGjqlsUD13M/d24pU/ktfS7shH/Rnk=
Received: by 10.114.50.17 with SMTP id x17mr4962662wax.168.1256721094117;
        Wed, 28 Oct 2009 02:11:34 -0700 (PDT)
Received: from localhost ([69.199.155.146])
        by mx.google.com with ESMTPS id 20sm473948pzk.5.2009.10.28.02.11.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 02:11:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.74.g610f9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131437>

Add native support for p4merge as a diff / merge tool. There are two
oddities. First, launching p4merge on Mac OS X requires running a helper
shim (which in turn is looked for in a couple common locations, as it's
very unlikely to be in PATH). Second, p4merge seems to require its file
arguments be absolute paths.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
As requested by an Android developer at GitTogether09.

Only tested on Mac OS X 10.6.1. Feedback from anyone running p4merge on other
OS's would be appreciated.

 Documentation/git-difftool.txt  |    2 +-
 Documentation/git-mergetool.txt |    2 +-
 git-mergetool--lib.sh           |   44 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 96a6c51..8e9aed6 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,7 +31,7 @@ OPTIONS
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
-	ecmerge, diffuse, opendiff and araxis.
+	ecmerge, diffuse, opendiff, p4merge and araxis.
 +
 If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 68ed6c0..4a6f7f3 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	diffuse, tortoisemerge, opendiff and araxis.
+	diffuse, tortoisemerge, opendiff, p4merge and araxis.
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index bfb01f7..23b2816 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -7,6 +7,12 @@ merge_mode() {
 	test "$TOOL_MODE" = merge
 }
 
+abspath() {
+	d=$(dirname "$1")
+	d=$(cd "$d" && pwd -P)
+	echo "$d/$(basename "$1")"
+}
+
 translate_merge_tool_path () {
 	case "$1" in
 	vimdiff)
@@ -21,6 +27,19 @@ translate_merge_tool_path () {
 	araxis)
 		echo compare
 		;;
+	p4merge)
+		# Look for the Mac OS X P4Merge shim
+		for app_dir in "/Applications" "$HOME/Applications"
+		do
+				launchp4merge="$app_dir/p4merge.app/Contents/Resources/launchp4merge"
+				if type "$launchp4merge" > /dev/null 2>&1; then
+					echo "$launchp4merge"
+					return 0
+				fi
+		done
+		# Otherwise assume we're not on Mac OS X and just return p4merge
+		echo "$1"
+		;;
 	*)
 		echo "$1"
 		;;
@@ -45,7 +64,7 @@ check_unchanged () {
 
 valid_tool () {
 	case "$1" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
+	kdiff3 | tkdiff | xxdiff | meld | opendiff | p4merge | \
 	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis)
 		;; # happy
 	tortoisemerge)
@@ -284,6 +303,29 @@ run_merge_tool () {
 				>/dev/null 2>&1
 		fi
 		;;
+	p4merge)
+		# At least on Mac OS X p4merge wants absolute paths
+		ABS_LOCAL=$(abspath "$LOCAL")
+		ABS_REMOTE=$(abspath "$REMOTE")
+		if merge_mode; then
+			ABS_MERGED=$(abspath "$MERGED")
+			touch "$BACKUP"
+			if $base_present; then
+				ABS_BASE=$(abspath "$BASE")
+				"$merge_tool_path" \
+					"$ABS_BASE" "$ABS_LOCAL" "$ABS_REMOTE" "$ABS_MERGED" \
+					>/dev/null 2>&1
+			else
+				"$merge_tool_path" \
+					"/dev/null" "$ABS_LOCAL" "$ABS_REMOTE" "$ABS_MERGED" \
+					>/dev/null 2>&1
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$ABS_LOCAL" "$ABS_REMOTE" \
+				>/dev/null 2>&1
+		fi
+		;;
 	*)
 		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
 		if test -z "$merge_tool_cmd"; then
-- 
1.6.5.2.74.g610f9.dirty
