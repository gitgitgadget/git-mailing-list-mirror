From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] mergetools: add config option to disable auto-merge
Date: Tue, 16 Jun 2015 17:35:14 -0400
Message-ID: <1434490514-36204-2-git-send-email-rappazzo@gmail.com>
References: <1434490514-36204-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: davvid@gmail.com, ssaasen@atlassian.com, john@keeping.me.uk,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 16 23:35:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4yWJ-0007eV-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 23:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757498AbbFPVfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 17:35:42 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:36754 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbbFPVfb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 17:35:31 -0400
Received: by qcej3 with SMTP id j3so8638250qce.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/HsIFKsdDXLznYAEs3MNRKYTfURwmDaldJ7npf/EN2s=;
        b=QdqEIyeqo/Jh8Vq1FdEtgVmEWbRBtFul6MC97zmugBaAuHMGPMTl2oKCwtGj80kwDl
         W/WeV4PUg3+dhmCNnYNO9gkoNhn4f8badZhIfQAAjuKEFup1JJsgNxgJ2OkuyiFxqHsA
         GeG78ug5uILv2CuG7O4nEJuvkNoYyIgaZc6CdM+jHMuIMY9i1elk1XPWQGBFHAd25aIA
         Uzrl5X4bEVIWFlZiYD/2YeTJuMVEMSnGuB19oIT99lY3MRiKEealsRW8kxOaX5gkVPn0
         OkZ1NSYvCAeDPzdjKAEvrS+ezNIdQG0rOAkhxL04hXb6NoLn7kZsEP7FiNKFL6KV+nUM
         CFZQ==
X-Received: by 10.55.26.165 with SMTP id l37mr5913157qkh.88.1434490531106;
        Tue, 16 Jun 2015 14:35:31 -0700 (PDT)
Received: from ool-45729003.dyn.optonline.net (ool-45729003.dyn.optonline.net. [69.114.144.3])
        by mx.google.com with ESMTPSA id 139sm1100038qhx.22.2015.06.16.14.35.30
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 14:35:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434490514-36204-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271800>

For some mergetools, the current invocation of git mergetool will
include an auto-merge flag.  By default the flag is included, however if
the git config option 'merge.automerge' is set to 'false', then that
flag will now be omitted.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/config.txt        |  6 ++++++
 Documentation/git-mergetool.txt | 19 +++++++++++++------
 mergetools/araxis               |  4 +++-
 mergetools/diffmerge            |  4 +++-
 mergetools/kdiff3               |  4 +++-
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43bb53c..658d8f7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1864,6 +1864,12 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
 
+mergetool.automerge::
+	When invoking a custom merge tool which includes an auto-merge
+	option, Git will include that option by default.  If this variable
+	is set to `false` then the auto-merge option is not used when 
+	invoking the custom merge tool.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e846c2e..3461d3a 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -79,16 +79,23 @@ success of the resolution after the custom tool has exited.
 	Prompt before each invocation of the merge resolution program
 	to give the user a chance to skip the path.
 
-TEMPORARY FILES
----------------
-`git mergetool` creates `*.orig` backup files while resolving merges.
-These are safe to remove once a file has been merged and its
-`git mergetool` session has completed.
-
+CONFIGURATION OPTIONS
+---------------------
+mergetool.keepBackup::
+	`git mergetool` creates `*.orig` backup files while resolving merges.
+	These are safe to remove once a file has been merged and its
+	`git mergetool` session has completed.
++
 Setting the `mergetool.keepBackup` configuration variable to `false`
 causes `git mergetool` to automatically remove the backup as files
 are successfully merged.
 
+mergetool.automerge::
+	For some mergetools, the current invocation of git mergetool will
+	include an auto-merge flag.  By default the flag is included, however if
+	the git config option `merge.automerge` is set to `false`, then that
+	flag will be omitted.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/mergetools/araxis b/mergetools/araxis
index 64f97c5..00e63da 100644
--- a/mergetools/araxis
+++ b/mergetools/araxis
@@ -6,7 +6,9 @@ merge_cmd () {
 	touch "$BACKUP"
 	if $base_present
 	then
-		"$merge_tool_path" -wait -merge -3 -a1 \
+		automerge="-merge"
+		test "$(git config --get --bool mergetool.automerge)" = false && automerge=''
+		"$merge_tool_path" -wait ${automerge} -3 -a1 \
 			"$BASE" "$LOCAL" "$REMOTE" "$MERGED" >/dev/null 2>&1
 	else
 		"$merge_tool_path" -wait -2 \
diff --git a/mergetools/diffmerge b/mergetools/diffmerge
index f138cb4..287489b 100644
--- a/mergetools/diffmerge
+++ b/mergetools/diffmerge
@@ -5,7 +5,9 @@ diff_cmd () {
 merge_cmd () {
 	if $base_present
 	then
-		"$merge_tool_path" --merge --result="$MERGED" \
+		automerge="--merge"
+		test "$(git config --get --bool mergetool.automerge)" = false && automerge=''
+		"$merge_tool_path" ${automerge} --result="$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
 		"$merge_tool_path" --merge \
diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index 793d129..8e1d063 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -7,7 +7,9 @@ diff_cmd () {
 merge_cmd () {
 	if $base_present
 	then
-		"$merge_tool_path" --auto \
+		automerge="--auto"
+		test "$(git config --get --bool mergetool.automerge)" = false && automerge=''
+		"$merge_tool_path" ${automerge} \
 			--L1 "$MERGED (Base)" \
 			--L2 "$MERGED (Local)" \
 			--L3 "$MERGED (Remote)" \
-- 
2.4.2
