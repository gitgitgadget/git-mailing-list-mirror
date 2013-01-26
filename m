From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetools: Simplify how we handle "vim" and "defaults"
Date: Fri, 25 Jan 2013 22:50:58 -0800
Message-ID: <1359183058-51835-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 07:53:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyzdR-0004Xp-Fy
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 07:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab3AZGvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 01:51:04 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:61196 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab3AZGvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 01:51:03 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so494896dak.25
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 22:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OIIEVoZLLU3VYqhVITiNQS4wDYC4EG5aKMbHAUTPfB4=;
        b=rowtHxFM1ymBUuMRpaZLHcH5dfo/YMVEXC44f3psOnl2AK1k3sbGiFFmaNe80HvwKX
         5VljV97gzDLF0N8qL1rIIZcsi2cxE0mVrQvl8lBJ/oH5eTOEDw3FV24Kfo4RsQRYrZ6P
         b7R/9MnNoK9bIYZukQffbt09GM4xSwThypu8tLMJyiOFvSf4mUuz4PFmyyk2njilUxd6
         JWhcZPMJ8v3Yuu56XjU1VJeOWCfep5UDCknLg+w5GA0JxZBufzoALKEtiBTTRoGPj5hV
         pDNZSx5uQV16KSdXmZ2P/RzNdJLujQZkL5apHhdoWgbpsrXXKrRlLiITYbOPNsz2Yf0J
         fvXA==
X-Received: by 10.68.228.34 with SMTP id sf2mr20370145pbc.85.1359183062578;
        Fri, 25 Jan 2013 22:51:02 -0800 (PST)
Received: from lustrous.local.fas.fa.disney.com (cpe-142-129-226-149.socal.res.rr.com. [142.129.226.149])
        by mx.google.com with ESMTPS id kl5sm2079708pbc.74.2013.01.25.22.51.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 22:51:01 -0800 (PST)
X-Mailer: git-send-email 1.8.0.7.g5a013b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214610>

Remove the exceptions for "vim" and "defaults" in the mergetool library
so that every filename in mergetools/ matches 1:1 with the name of a
valid built-in tool.

Make common functions available in $MERGE_TOOLS_DIR/include/.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This should make things ok on platforms where we don't have symlinks.

 Makefile                                     |  2 +-
 git-mergetool--lib.sh                        | 41 +++++++++++-----------------
 mergetools/gvimdiff                          |  1 +
 mergetools/gvimdiff2                         |  1 +
 mergetools/{defaults => include/defaults.sh} |  0
 mergetools/{vim => include/vim.sh}           |  0
 mergetools/vimdiff                           |  1 +
 mergetools/vimdiff2                          |  1 +
 8 files changed, 21 insertions(+), 26 deletions(-)
 create mode 100644 mergetools/gvimdiff
 create mode 100644 mergetools/gvimdiff2
 rename mergetools/{defaults => include/defaults.sh} (100%)
 rename mergetools/{vim => include/vim.sh} (100%)
 create mode 100644 mergetools/vimdiff
 create mode 100644 mergetools/vimdiff2

diff --git a/Makefile b/Makefile
index f69979e..3bc6eb5 100644
--- a/Makefile
+++ b/Makefile
@@ -2724,7 +2724,7 @@ install: all
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
-	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	cp -R mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index aa38bd1..c866ed8 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 # git-mergetool--lib is a library for common merge tool functions
+MERGE_TOOLS_DIR="$(git --exec-path)/mergetools"
+
 diff_mode() {
 	test "$TOOL_MODE" = diff
 }
@@ -44,25 +46,14 @@ valid_tool () {
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
 		return 1
 	fi
-
-	# Load the redefined functions
-	. "$mergetools/$tool"
+	. "$MERGE_TOOLS_DIR/include/defaults.sh"
+	. "$MERGE_TOOLS_DIR/$tool"
 
 	if merge_mode && ! can_merge
 	then
@@ -99,7 +90,7 @@ run_merge_tool () {
 	base_present="$2"
 	status=0
 
-	# Bring tool-specific functions into scope
+	# Bring tool specific functions into scope
 	setup_tool "$1"
 
 	if merge_mode
@@ -177,18 +168,17 @@ list_merge_tool_candidates () {
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
+		if test -d "$i"
 		then
 			continue
-		elif merge_mode && ! can_merge
+		fi
+
+		. "$MERGE_TOOLS_DIR"/include/defaults.sh
+		. "$i"
+
+		if merge_mode && ! can_merge
 		then
 			continue
 		elif diff_mode && ! can_diff
@@ -196,6 +186,7 @@ show_tool_help () {
 			continue
 		fi
 
+		tool=$(basename "$i")
 		merge_tool_path=$(translate_merge_tool_path "$tool")
 		if type "$merge_tool_path" >/dev/null 2>&1
 		then
diff --git a/mergetools/gvimdiff b/mergetools/gvimdiff
new file mode 100644
index 0000000..f5890b1
--- /dev/null
+++ b/mergetools/gvimdiff
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/include/vim.sh"
diff --git a/mergetools/gvimdiff2 b/mergetools/gvimdiff2
new file mode 100644
index 0000000..f5890b1
--- /dev/null
+++ b/mergetools/gvimdiff2
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/include/vim.sh"
diff --git a/mergetools/defaults b/mergetools/include/defaults.sh
similarity index 100%
rename from mergetools/defaults
rename to mergetools/include/defaults.sh
diff --git a/mergetools/vim b/mergetools/include/vim.sh
similarity index 100%
rename from mergetools/vim
rename to mergetools/include/vim.sh
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
new file mode 100644
index 0000000..f5890b1
--- /dev/null
+++ b/mergetools/vimdiff
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/include/vim.sh"
diff --git a/mergetools/vimdiff2 b/mergetools/vimdiff2
new file mode 100644
index 0000000..f5890b1
--- /dev/null
+++ b/mergetools/vimdiff2
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/include/vim.sh"
-- 
1.8.0.6.ge6f188f.dirty
