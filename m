From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool: add an option for writing to a temporary directory
Date: Sat, 11 Oct 2014 10:04:45 -0700
Message-ID: <1413047085-12398-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 19:04:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xd064-0001RY-4H
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 19:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbaJKREo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 13:04:44 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:52383 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaJKREn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 13:04:43 -0400
Received: by mail-pa0-f51.google.com with SMTP id lj1so3482417pab.24
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nfw0BW7TwpGoi959N8qp3T9KqJIrYaGlbFeAP13qdJ8=;
        b=gRN1a8weqcxF8/D2yXYnGaA6/cGT3R9cjEf5oqbM+82QTHoe+yrxO20fQfLhFofM96
         Ptb5Vs9podDVN9rf9KQMwTiiBXv4rn+u5Ds/Sr3xxCve1pQqk/+Y/WMChfzWhee2J+uQ
         kqzsfYywKlbDZfxpI8+n+kEBEmT5ac1dKrMGkoNRkojdO6WxTPVvg3+2zbz0dcg+DCN9
         5/T64Bk4IuGf7Mb/1H6RvpdHHB9lf/swVGQbptGx9dR1xFlZ0v3etoFJMNhp34sV7GlL
         Vk4Ly7KCKDPaDqqyMQ7aPURH92oJeBdPikrE1ytAAbewAQwDbxPdSUyQUQT0VGh9dMra
         HRHg==
X-Received: by 10.70.118.9 with SMTP id ki9mr13063364pdb.104.1413047083386;
        Sat, 11 Oct 2014 10:04:43 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id wi6sm6692145pac.47.2014.10.11.10.04.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 Oct 2014 10:04:42 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.379.gc4e1e0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach mergetool to write files in a temporary directory when
'mergetool.writeToTemp' is true.

This is helpful for tools such as Eclipse which cannot cope with
multiple copies of the same file in the worktree.

Suggested-by: Charles Bailey <charles@hashpling.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch is dependent on my previous mergetool patches:
"use more conservative temporary..." and the subsequent --tool-help
series.

 Documentation/config.txt |  6 ++++++
 git-mergetool.sh         | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04a1e2f..be6cf35 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1768,6 +1768,12 @@ mergetool.keepTemporaries::
 	preserved, otherwise they will be removed after the tool has
 	exited. Defaults to `false`.
 
+mergetool.writeToTemp::
+	Git writes temporary 'BASE', 'LOCAL', and 'REMOTE' versions of
+	conflicting files in the worktree by default.  Git will attempt
+	to use a temporary directory for these files when set `true`.
+	Defaults to `false`.
+
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 10782b8..2b788c5 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -37,6 +37,19 @@ base_present () {
 	test -n "$base_mode"
 }
 
+mergetool_tmpdir_init () {
+	if test "$(git config --bool mergetool.writeToTemp)" != true
+	then
+		MERGETOOL_TMPDIR=.
+		return 0
+	fi
+	if MERGETOOL_TMPDIR=$(mktemp -d -t "git-mergetool-XXXXXX" 2>/dev/null)
+	then
+		return 0
+	fi
+	die "error: mktemp is needed when 'mergetool.writeToTemp' is true"
+}
+
 cleanup_temp_files () {
 	if test "$1" = --save-backup
 	then
@@ -46,6 +59,10 @@ cleanup_temp_files () {
 	else
 		rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
 	fi
+	if test "$MERGETOOL_TMPDIR" != "."
+	then
+		rmdir "$MERGETOOL_TMPDIR"
+	fi
 }
 
 describe_file () {
@@ -235,10 +252,20 @@ merge_file () {
 		BASE=$MERGED
 		ext=
 	fi
-	BACKUP="./${BASE}_BACKUP_$$$ext"
-	LOCAL="./${BASE}_LOCAL_$$$ext"
-	REMOTE="./${BASE}_REMOTE_$$$ext"
-	BASE="./${BASE}_BASE_$$$ext"
+
+	mergetool_tmpdir_init
+
+	if test "$MERGETOOL_TMPDIR" != "."
+	then
+		# If we're using a temporary directory then write to the
+		# top-level of that directory.
+		BASE=${BASE##*/}
+	fi
+
+	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
+	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
+	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
+	BASE="$MERGETOOL_TMPDIR/${BASE}_BASE_$$$ext"
 
 	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
 	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
-- 
2.1.2.379.gc4e1e0c
