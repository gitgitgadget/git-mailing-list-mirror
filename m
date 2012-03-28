From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/2] mergetools: fail if display needed but not present
Date: Wed, 28 Mar 2012 15:58:13 -0400
Message-ID: <1332964693-4058-2-git-send-email-tim.henigan@gmail.com>
References: <1332964693-4058-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 28 21:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCz1I-00078a-TV
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758483Ab2C1T64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:58:56 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:40527 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758273Ab2C1T6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:58:55 -0400
Received: by mail-qa0-f53.google.com with SMTP id c11so1066535qad.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hHw49PUTRWPzQXgfGHCQ53dRd1HuzGJrFO4OlmqNbFY=;
        b=hnsbEV5cVYMMf7+z6u+8RZsTIy071UNCLcc6L/gH93W+yUdvjIGXTULsO1BmVzOZll
         qrc8FQQ/itlhqJOXyjY7g5nsKMb/SOHKfxW20/niw5/CCoNvybcT0KDO6LFZ57qNUKm+
         uHUWc+4bfxgRFEd/RaRpZwHeJaZPRYwdaWBoI3zKmiRvYulRjLQiMQU15jHNQ9aCMW3n
         pT09+SLcTVc0ZqMylpT2HsFezaUU5WOB6HVNznTpmFIYpuWeAzx1nVJvULP9CbsAK4d8
         2WzAIfafVRDaGAvpBBACaDu5MV4K+a2mDEzPBS33im+o8vS91ISCC2Ibfs8kUXmyqoxs
         dDkg==
Received: by 10.224.208.1 with SMTP id ga1mr39998786qab.21.1332964735549;
        Wed, 28 Mar 2012 12:58:55 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id fq1sm8223989qab.10.2012.03.28.12.58.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 12:58:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc2.21.g8cb1a
In-Reply-To: <1332964693-4058-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194180>

Prior to this commit, if 'git mergetool' or 'git difftool' were run in a
terminal-only session, they might still try to open a tool that required
a windowed environment.

This commit teaches 'git-mergetool--lib.sh' to test for the presence of
a display prior to opening tools that require one.

NOTE: The DISPLAY variable is not set in msysgit or cygwin Git.  In the
absence of that variable, the script assumes that a window environment
is always available when running msysgit or cygwin.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Only 2 of the current diff/merge tools (vim and emerge) can operate
without a display.

The assumption that a display is always available on msys or cygwin is
probably not optimal.  However, I was not able to find a better work-
around.  It also matches the previous behavior that did not test for
the DISPLAY prior to opening the tool.


 git-mergetool--lib.sh |   23 +++++++++++++++++++++++
 mergetools/defaults   |    4 ++++
 mergetools/emerge     |    4 ++++
 mergetools/vim        |    4 ++++
 4 files changed, 35 insertions(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 89b16dc..75c8b11 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -12,6 +12,19 @@ translate_merge_tool_path () {
 	echo "$1"
 }
 
+display_available() {
+	if test -n "$DISPLAY"
+	then
+		return 0
+	fi
+
+	case "$(uname -s)" in
+	MINGW*|CYGWIN*) return 0; break;;
+	esac
+
+	return 1
+}
+
 check_unchanged () {
 	if test "$MERGED" -nt "$BACKUP"
 	then
@@ -190,6 +203,16 @@ get_merge_tool_path () {
 			 "'$merge_tool_path'"
 		exit 1
 	fi
+	if ! display_available
+	then
+		if tool_requires_display
+		then
+			echo >&2 "The $TOOL_MODE tool $merge_tool cannot"\
+			"be run from a terminal-only session.  A window"\
+			"environment is required."
+			exit 1
+		fi
+	fi
 	echo "$merge_tool_path"
 }
 
diff --git a/mergetools/defaults b/mergetools/defaults
index 1d8f2a3..f150227 100644
--- a/mergetools/defaults
+++ b/mergetools/defaults
@@ -7,6 +7,10 @@ can_diff () {
 	return 0
 }
 
+tool_requires_display() {
+	return 0
+}
+
 diff_cmd () {
 	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
 	if test -z "$merge_tool_cmd"
diff --git a/mergetools/emerge b/mergetools/emerge
index f96d9e5..c7eb80b 100644
--- a/mergetools/emerge
+++ b/mergetools/emerge
@@ -1,3 +1,7 @@
+tool_requires_display () {
+	return 1
+}
+
 diff_cmd () {
 	"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE"
 }
diff --git a/mergetools/vim b/mergetools/vim
index 6817708..ffd9fd6 100644
--- a/mergetools/vim
+++ b/mergetools/vim
@@ -1,3 +1,7 @@
+tool_requires_display () {
+	return 1
+}
+
 diff_cmd () {
 	"$merge_tool_path" -R -f -d \
 		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
-- 
1.7.10.rc2.21.g8cb1a
