From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/2] mergetools: Simplify how we handle "vim" and "defaults"
Date: Sat, 26 Jan 2013 16:40:07 -0800
Message-ID: <1359247207-71819-2-git-send-email-davvid@gmail.com>
References: <1359247207-71819-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 01:40:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzGIl-0004gQ-Rj
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 01:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab3A0Ak1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 19:40:27 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:56062 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab3A0Ak0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 19:40:26 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so2604768iag.31
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 16:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=PjNq3BuDWUd49E5SUQqBO0kSPHAO97VrzQ1Fa88od7w=;
        b=v0QckBywbELbsAL8v00BIrIoVzv00G/4MGI8M5LT2H4wJK/4jsSUQ3wo74PnZt4r+O
         Trk/xgHUZ9h2pHsWa5HzCb1hZAqYc6qQxcyI/e7WT5Dg9W23oOJIKIdpowkX0KPGQnRY
         dizCTFHSZUb80CisVpFaLJ0YKU6k4ASDpvV8RkkGH38EHgZwqWIFPiFuvA7V08PoKEef
         9E4KGUKyrmR0ObmLU9wF/LhB9LGYyOGCNl61Ulkha4zN/0W4Loo1Qc9cEEzQcZz5R4Eh
         NQM+EzBNbVJU4NvE7XRy7+Pma0+8WLLWydU+zP9zhD+iolDNbEt2muvoJV0eXzhka53J
         ByYw==
X-Received: by 10.50.191.164 with SMTP id gz4mr2093542igc.24.1359247225552;
        Sat, 26 Jan 2013 16:40:25 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id c3sm2781564igj.1.2013.01.26.16.40.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 26 Jan 2013 16:40:24 -0800 (PST)
X-Mailer: git-send-email 1.8.0.8.g9bc9422
In-Reply-To: <1359247207-71819-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214646>

Remove the exceptions for "vim" and "defaults" in the mergetool library
so that every filename in mergetools/ matches 1:1 with the name of a
valid built-in tool.

Make common functions available in $MERGE_TOOLS_DIR/include/.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This diffstat is much nicer now thanks to John's setup_tool rework in 1/1.

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
index f69979e..0f89032 100644
--- a/Makefile
+++ b/Makefile
@@ -2724,7 +2724,11 @@ install: all
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
-	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -m 644 $(filter-out include,$(wildcard mergetools/*)) \
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
1.8.0.8.g9bc9422
