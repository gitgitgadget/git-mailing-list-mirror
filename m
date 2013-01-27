From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 2/2] mergetools: Simplify how we handle "vim" and "defaults"
Date: Sat, 26 Jan 2013 16:46:12 -0800
Message-ID: <1359247573-75825-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 01:46:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzGON-0006Ni-Ie
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 01:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3A0AqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 19:46:19 -0500
Received: from mail-ia0-f169.google.com ([209.85.210.169]:65295 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab3A0AqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 19:46:17 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so2612280iaf.28
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 16:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=yE0Lr6aBDmiJXziei+aRLj8USV9OTGfnXIom8OM3ADk=;
        b=LgL8HS9pnBASKYAZ9dl2yzLnaSpRC+ogHWJh+NDhntDzPjqkQJqADlbBbc4n18Ibwc
         1MFJGYCFzZcdYQ7dX1vMlUTNTqDE/wR5HQ0sZxfKnGzr+ndfgv/PeeEqxUFk5jpuYebS
         Eg1EX7978MD25LENdF8E7Iq7tlvElQlBglOOkZ8JaudVJ86oJHT91XQFYU8YSs4mPLfv
         0dQ5ovHVnmJqlKzyRrk59tkptbRhK/5TP6SYG0KKSaa2xdxSSo6QDVn+EnupIAQNJDdf
         j3mamYrxpJlCB3aXrdNv/s31qlruDeQohXxv7A8v8I0MMbFIPHov8RQS2KySkHAo9TuO
         puCw==
X-Received: by 10.50.40.131 with SMTP id x3mr2044934igk.10.1359247577311;
        Sat, 26 Jan 2013 16:46:17 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id s3sm2870267igb.14.2013.01.26.16.46.14
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 26 Jan 2013 16:46:16 -0800 (PST)
X-Mailer: git-send-email 1.8.0.8.gd6b90fb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214647>

Remove the exceptions for "vim" and "defaults" in the mergetool library
so that every filename in mergetools/ matches 1:1 with the name of a
valid built-in tool.

Make common functions available in $MERGE_TOOLS_DIR/include/.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
v2 used "include" instead of "mergetools/include"
in the Makefile.  Please ignore it.

 Makefile                                     |  6 +++-
 git-mergetool--lib.sh                        | 41 ++++++++--------------------
 mergetools/gvimdiff                          |  1 +
 mergetools/gvimdiff2                         |  1 +
 mergetools/{defaults => include/defaults.sh} |  0
 mergetools/{vim => vimdiff}                  |  0
 mergetools/vimdiff2                          |  1 +
 7 files changed, 19 insertions(+), 31 deletions(-)
 create mode 100644 mergetools/gvimdiff
 create mode 100644 mergetools/gvimdiff2
 rename mergetools/{defaults => include/defaults.sh} (100%)
 rename mergetools/{vim => vimdiff} (100%)
 create mode 100644 mergetools/vimdiff2

diff --git a/Makefile b/Makefile
index f69979e..26f217f 100644
--- a/Makefile
+++ b/Makefile
@@ -2724,7 +2724,11 @@ install: all
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
-	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -m 644 $(filter-out mergetools/include,$(wildcard mergetools/*)) \
+		'$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
+	$(INSTALL) -m 644 mergetools/include/* \
+		'$(DESTDIR_SQ)$(mergetools_instdir_SQ)/include'
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f1bb372..7ea7510 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 # git-mergetool--lib is a library for common merge tool functions
+MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
+
 diff_mode() {
 	test "$TOOL_MODE" = diff
 }
@@ -44,19 +46,9 @@ valid_tool () {
 }
 
 setup_tool () {
-	case "$1" in
-	vim*|gvim*)
-		tool=vim
-		;;
-	*)
-		tool="$1"
-		;;
-	esac
-	mergetools="$(git --exec-path)/mergetools"
+	tool="$1"
 
-	# Load the default definitions
-	. "$mergetools/defaults"
-	if ! test -f "$mergetools/$tool"
+	if ! test -f "$MERGE_TOOLS_DIR/$tool"
 	then
 		# Use a special return code for this case since we want to
 		# source "defaults" even when an explicit tool path is
@@ -65,8 +57,11 @@ setup_tool () {
 		return 2
 	fi
 
+	# Load the default functions
+	. "$MERGE_TOOLS_DIR/include/defaults.sh"
+
 	# Load the redefined functions
-	. "$mergetools/$tool"
+	. "$MERGE_TOOLS_DIR/$tool"
 
 	if merge_mode && ! can_merge
 	then
@@ -194,24 +189,10 @@ list_merge_tool_candidates () {
 show_tool_help () {
 	unavailable= available= LF='
 '
-
-	scriptlets="$(git --exec-path)"/mergetools
-	for i in "$scriptlets"/*
+	for i in "$MERGE_TOOLS_DIR"/*
 	do
-		. "$scriptlets"/defaults
-		. "$i"
-
-		tool="$(basename "$i")"
-		if test "$tool" = "defaults"
-		then
-			continue
-		elif merge_mode && ! can_merge
-		then
-			continue
-		elif diff_mode && ! can_diff
-		then
-			continue
-		fi
+		tool=$(basename "$i")
+		setup_tool "$tool" 2>/dev/null || continue
 
 		merge_tool_path=$(translate_merge_tool_path "$tool")
 		if type "$merge_tool_path" >/dev/null 2>&1
diff --git a/mergetools/gvimdiff b/mergetools/gvimdiff
new file mode 100644
index 0000000..04a5bb0
--- /dev/null
+++ b/mergetools/gvimdiff
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/gvimdiff2 b/mergetools/gvimdiff2
new file mode 100644
index 0000000..04a5bb0
--- /dev/null
+++ b/mergetools/gvimdiff2
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/defaults b/mergetools/include/defaults.sh
similarity index 100%
rename from mergetools/defaults
rename to mergetools/include/defaults.sh
diff --git a/mergetools/vim b/mergetools/vimdiff
similarity index 100%
rename from mergetools/vim
rename to mergetools/vimdiff
diff --git a/mergetools/vimdiff2 b/mergetools/vimdiff2
new file mode 100644
index 0000000..04a5bb0
--- /dev/null
+++ b/mergetools/vimdiff2
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
-- 
1.8.0.8.gd6b90fb.dirty
