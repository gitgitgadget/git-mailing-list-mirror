From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 4/4] git-commit-interactive: Allow rebasing to preserve empty commits
Date: Fri, 30 Mar 2012 15:48:42 -0400
Message-ID: <1333136922-12872-5-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:49:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhp7-0005io-R0
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761353Ab2C3TtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:49:22 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:60983 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761338Ab2C3TtU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:49:20 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDhon-00011f-MM; Fri, 30 Mar 2012 15:49:18 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194396>

This updates git-commit-interactive to recognize and make use of the keep_empty
flag.  When not set, git-rebase -i will now comment out commits that are empty,
and informs the user that commits which they wish to explicitly keep that are
empty should be uncommented, or --keep-empty should be specified.  if keep_empty
is specified, all commits, regardless of their empty status are included.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Jeff King <peff@peff.net>
CC: Phil Hord <phil.hord@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh |   38 +++++++++++++++++++++++++++++++++++---
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..97eeb21 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -191,12 +191,24 @@ git_sequence_editor () {
 
 pick_one () {
 	ff=--ff
+	is_empty=$(git show --pretty=format:%b "$@" | wc -l)
+
+	if [ $is_empty -eq 0 ]
+	then
+		empty_args=--keep-empty
+	fi
+
+	if [ -n "$keep_empty" ]
+	then
+		empty_args=--keep_empty
+	fi
+
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	case "$force_rebase" in '') ;; ?*) ff= ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $ff "$@"
+	output git cherry-pick $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -780,9 +792,24 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
 	sed -n "s/^>//p" |
 while read -r shortsha1 rest
 do
+	local comment_out
+
+	if [ -z "$keep_empty" ]
+	then
+		comment_out=$(git show --pretty=format:%b $shortsha1 | wc -l)
+		if [ $comment_out -eq 0 ]
+		then
+			comment_out="#pick"
+		else
+			comment_out="pick"
+		fi
+	else
+		comment_out="pick"
+	fi
+
 	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
+		printf '%s\n' "$comment_out $shortsha1 $rest" >> "$todo"
 	else
 		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
@@ -801,7 +828,7 @@ do
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
+			printf '%s\n' "$comment_out $shortsha1 $rest" >> "$todo"
 		fi
 	fi
 done
@@ -849,6 +876,11 @@ cat >> "$todo" << EOF
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #
+# Note that commits which are empty at the time of rebasing are 
+# commented out.  If you wish to keep empty commits, either 
+# specify the --keep-empty option to the rebase command, or 
+# uncomment the commits you wish to keep
+#
 EOF
 
 has_action "$todo" ||
-- 
1.7.7.6
