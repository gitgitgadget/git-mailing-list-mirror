From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/4] mergetool--lib: Refactor tools into separate files
Date: Thu, 18 Aug 2011 00:23:46 -0700
Message-ID: <1313652227-48545-4-git-send-email-davvid@gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:24:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtwxq-0005Ui-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab1HRHYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 03:24:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39953 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162Ab1HRHYN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 03:24:13 -0400
Received: by ywf7 with SMTP id 7so1290946ywf.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C63lbEv9YgMPFT1Qt0DqqkK7+QU3dbGzzWnRSs4Lrsw=;
        b=VC0I/oFfsLBW36wSp30X1TUyctnCSf/qgaif4vx0AyaEBIhS770RXtOykbdLUHocry
         je1XvcxmOxzTVvAncrdHDEivDS6J446Jys6c2G2XSbhgGI/BdUozfvvizQ9Y5xhZ2hIt
         CH71itv9DbxYUlfFFoRgVJcmpb0Uc/3xDwFDA=
Received: by 10.42.145.133 with SMTP id f5mr447011icv.350.1313652251228;
        Thu, 18 Aug 2011 00:24:11 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id hq1sm1677692icc.14.2011.08.18.00.24.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 00:24:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.476.g57292
In-Reply-To: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179576>

Individual merge tools are now defined in a mergetools/$tool
file which is sourced at runtime.

The individual files are installed into $(git --exec-path)/mergetools/.
New tools can be added by creating a new file instead of editing the
git-mergetool--lib.sh scriptlet.

http://thread.gmane.org/gmane.comp.version-control.git/134906/focus=135006

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Makefile                 |   11 ++
 git-mergetool--lib.sh    |  385 ++++++---------------------------------------
 mergetools/araxis        |   21 +++
 mergetools/bc3           |   20 +++
 mergetools/defaults      |   46 ++++++
 mergetools/diffuse       |   17 ++
 mergetools/ecmerge       |   16 ++
 mergetools/emerge        |   23 +++
 mergetools/kdiff3        |   24 +++
 mergetools/kompare       |    7 +
 mergetools/meld          |    9 +
 mergetools/opendiff      |   16 ++
 mergetools/p4merge       |   10 ++
 mergetools/tkdiff        |   12 ++
 mergetools/tortoisemerge |   17 ++
 mergetools/vim           |   44 ++++++
 mergetools/xxdiff        |   25 +++
 17 files changed, 370 insertions(+), 333 deletions(-)
 create mode 100644 mergetools/araxis
 create mode 100644 mergetools/bc3
 create mode 100644 mergetools/defaults
 create mode 100644 mergetools/diffuse
 create mode 100644 mergetools/ecmerge
 create mode 100644 mergetools/emerge
 create mode 100644 mergetools/kdiff3
 create mode 100644 mergetools/kompare
 create mode 100644 mergetools/meld
 create mode 100644 mergetools/opendiff
 create mode 100644 mergetools/p4merge
 create mode 100644 mergetools/tkdiff
 create mode 100644 mergetools/tortoisemerge
 create mode 100644 mergetools/vim
 create mode 100644 mergetools/xxdiff

diff --git a/Makefile b/Makefile
index 8dd782f..6a68e3a 100644
--- a/Makefile
+++ b/Makefile
@@ -302,6 +302,7 @@ bindir = $(prefix)/$(bindir_relative)
 mandir = share/man
 infodir = share/info
 gitexecdir = libexec/git-core
+mergetoolsdir = $(gitexecdir)/mergetools
 sharedir = $(prefix)/share
 gitwebdir = $(sharedir)/gitweb
 template_dir = share/git-core/templates
@@ -2257,6 +2258,13 @@ endif
 gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
 export gitexec_instdir
 
+ifneq ($(filter /%,$(firstword $(mergetoolsdir))),)
+mergetools_instdir = $(mergetoolsdir)
+else
+mergetools_instdir = $(prefix)/$(mergetoolsdir)
+endif
+mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
+
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
 install: all
@@ -2266,6 +2274,9 @@ install: all
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	(cd mergetools && $(TAR) cf - .) | \
+	(cd '$(DESTDIR_SQ)$(mergetools_instdir_SQ)' && umask 022 && $(TAR) xof -)
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C gitweb install
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 03cfb19..2421700 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -9,26 +9,7 @@ merge_mode() {
 }
 
 translate_merge_tool_path () {
-	case "$1" in
-	araxis)
-		echo compare
-		;;
-	bc3)
-		echo bcompare
-		;;
-	emerge)
-		echo emacs
-		;;
-	gvimdiff|gvimdiff2)
-		echo gvim
-		;;
-	vimdiff|vimdiff2)
-		echo vim
-		;;
-	*)
-		echo "$1"
-		;;
-	esac
+	echo "$1"
 }
 
 check_unchanged () {
@@ -49,40 +30,55 @@ check_unchanged () {
 	fi
 }
 
+valid_tool_config () {
+	if test -n "$(get_merge_tool_cmd "$1")"
+	then
+		return 0
+	else
+		return 1
+	fi
+}
+
 valid_tool () {
+	setup_tool "$1" || valid_tool_config "$1"
+}
+
+setup_tool () {
 	case "$1" in
-	araxis | bc3 | diffuse | ecmerge | emerge | gvimdiff | gvimdiff2 | \
-	kdiff3 | meld | opendiff | p4merge | tkdiff | vimdiff | vimdiff2 | xxdiff)
-		;; # happy
-	kompare)
-		if ! diff_mode
-		then
-			return 1
-		fi
-		;;
-	tortoisemerge)
-		if ! merge_mode
-		then
-			return 1
-		fi
+	vim*|gvim*)
+		tool=vim
 		;;
 	*)
-		if test -z "$(get_merge_tool_cmd "$1")"
-		then
-			return 1
-		fi
+		tool="$1"
 		;;
 	esac
+	mergetools="$(git --exec-path)/mergetools"
+
+	# Load the default definitions
+	. "$mergetools/defaults"
+	if ! test -f "$mergetools/$tool"
+	then
+		return 1
+	fi
+
+	# Load the redefined functions
+	. "$mergetools/$tool"
+
+	if merge_mode && ! can_merge
+	then
+		echo "error: '$tool' can not be used to resolve merges" >&2
+		exit 1
+	elif diff_mode && ! can_diff
+	then
+		echo "error: '$tool' can only be used to resolve merges" >&2
+		exit 1
+	fi
+	return 0
 }
 
 get_merge_tool_cmd () {
 	# Prints the custom command for a merge tool
-	if test -n "$1"
-	then
-		merge_tool="$1"
-	else
-		merge_tool="$(get_merge_tool)"
-	fi
+	merge_tool="$1"
 	if diff_mode
 	then
 		echo "$(git config difftool.$merge_tool.cmd ||
@@ -92,6 +88,7 @@ get_merge_tool_cmd () {
 	fi
 }
 
+# Entry point for running tools
 run_merge_tool () {
 	# If GIT_PREFIX is empty then we cannot use it in tools
 	# that expect to be able to chdir() to its value.
@@ -102,288 +99,15 @@ run_merge_tool () {
 	base_present="$2"
 	status=0
 
-	case "$1" in
-	araxis)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			if $base_present
-			then
-				"$merge_tool_path" -wait -merge -3 -a1 \
-					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
-					>/dev/null 2>&1
-			else
-				"$merge_tool_path" -wait -2 \
-					"$LOCAL" "$REMOTE" "$MERGED" \
-					>/dev/null 2>&1
-			fi
-			check_unchanged
-		else
-			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
-				>/dev/null 2>&1
-		fi
-		;;
-	bc3)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			if $base_present
-			then
-				"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
-					-mergeoutput="$MERGED"
-			else
-				"$merge_tool_path" "$LOCAL" "$REMOTE" \
-					-mergeoutput="$MERGED"
-			fi
-			check_unchanged
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE"
-		fi
-		;;
-	diffuse)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			if $base_present
-			then
-				"$merge_tool_path" \
-					"$LOCAL" "$MERGED" "$REMOTE" \
-					"$BASE" | cat
-			else
-				"$merge_tool_path" \
-					"$LOCAL" "$MERGED" "$REMOTE" | cat
-			fi
-			check_unchanged
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
-		fi
-		;;
-	ecmerge)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			if $base_present
-			then
-				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
-					--default --mode=merge3 --to="$MERGED"
-			else
-				"$merge_tool_path" "$LOCAL" "$REMOTE" \
-					--default --mode=merge2 --to="$MERGED"
-			fi
-			check_unchanged
-		else
-			"$merge_tool_path" --default --mode=diff2 \
-				"$LOCAL" "$REMOTE"
-		fi
-		;;
-	emerge)
-		if merge_mode
-		then
-			if $base_present
-			then
-				"$merge_tool_path" \
-					-f emerge-files-with-ancestor-command \
-					"$LOCAL" "$REMOTE" "$BASE" \
-					"$(basename "$MERGED")"
-			else
-				"$merge_tool_path" \
-					-f emerge-files-command \
-					"$LOCAL" "$REMOTE" \
-					"$(basename "$MERGED")"
-			fi
-			status=$?
-		else
-			"$merge_tool_path" -f emerge-files-command \
-				"$LOCAL" "$REMOTE"
-		fi
-		;;
-	gvimdiff|vimdiff)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			if $base_present
-			then
-				"$merge_tool_path" -f -d -c "wincmd J" \
-					"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
-			else
-				"$merge_tool_path" -f -d -c "wincmd l" \
-					"$LOCAL" "$MERGED" "$REMOTE"
-			fi
-			check_unchanged
-		else
-			"$merge_tool_path" -R -f -d -c "wincmd l" \
-				-c 'cd $GIT_PREFIX' \
-				"$LOCAL" "$REMOTE"
-		fi
-		;;
-	gvimdiff2|vimdiff2)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			"$merge_tool_path" -f -d -c "wincmd l" \
-				"$LOCAL" "$MERGED" "$REMOTE"
-			check_unchanged
-		else
-			"$merge_tool_path" -R -f -d -c "wincmd l" \
-				-c 'cd $GIT_PREFIX' \
-				"$LOCAL" "$REMOTE"
-		fi
-		;;
-	kdiff3)
-		if merge_mode
-		then
-			if $base_present
-			then
-				"$merge_tool_path" --auto \
-					--L1 "$MERGED (Base)" \
-					--L2 "$MERGED (Local)" \
-					--L3 "$MERGED (Remote)" \
-					-o "$MERGED" \
-					"$BASE" "$LOCAL" "$REMOTE" \
-				>/dev/null 2>&1
-			else
-				"$merge_tool_path" --auto \
-					--L1 "$MERGED (Local)" \
-					--L2 "$MERGED (Remote)" \
-					-o "$MERGED" \
-					"$LOCAL" "$REMOTE" \
-				>/dev/null 2>&1
-			fi
-			status=$?
-		else
-			"$merge_tool_path" --auto \
-				--L1 "$MERGED (A)" \
-				--L2 "$MERGED (B)" "$LOCAL" "$REMOTE" \
-			>/dev/null 2>&1
-		fi
-		;;
-	kompare)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-	meld)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
-			check_unchanged
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE"
-		fi
-		;;
-	opendiff)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			if $base_present
-			then
-				"$merge_tool_path" "$LOCAL" "$REMOTE" \
-					-ancestor "$BASE" \
-					-merge "$MERGED" | cat
-			else
-				"$merge_tool_path" "$LOCAL" "$REMOTE" \
-					-merge "$MERGED" | cat
-			fi
-			check_unchanged
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
-		fi
-		;;
-	p4merge)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			$base_present || >"$BASE"
-			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
-			check_unchanged
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE"
-		fi
-		;;
-	tkdiff)
-		if merge_mode
-		then
-			if $base_present
-			then
-				"$merge_tool_path" -a "$BASE" \
-					-o "$MERGED" "$LOCAL" "$REMOTE"
-			else
-				"$merge_tool_path" \
-					-o "$MERGED" "$LOCAL" "$REMOTE"
-			fi
-			status=$?
-		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE"
-		fi
-		;;
-	tortoisemerge)
-		if $base_present
-		then
-			touch "$BACKUP"
-			"$merge_tool_path" \
-				-base:"$BASE" -mine:"$LOCAL" \
-				-theirs:"$REMOTE" -merged:"$MERGED"
-			check_unchanged
-		else
-			echo "TortoiseMerge cannot be used without a base" 1>&2
-			status=1
-		fi
-		;;
-	xxdiff)
-		if merge_mode
-		then
-			touch "$BACKUP"
-			if $base_present
-			then
-				"$merge_tool_path" -X --show-merged-pane \
-					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-					-R 'Accel.Search: "Ctrl+F"' \
-					-R 'Accel.SearchForward: "Ctrl-G"' \
-					--merged-file "$MERGED" \
-					"$LOCAL" "$BASE" "$REMOTE"
-			else
-				"$merge_tool_path" -X $extra \
-					-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-					-R 'Accel.Search: "Ctrl+F"' \
-					-R 'Accel.SearchForward: "Ctrl-G"' \
-					--merged-file "$MERGED" \
-					"$LOCAL" "$REMOTE"
-			fi
-			check_unchanged
-		else
-			"$merge_tool_path" \
-				-R 'Accel.Search: "Ctrl+F"' \
-				-R 'Accel.SearchForward: "Ctrl-G"' \
-				"$LOCAL" "$REMOTE"
-		fi
-		;;
-	*)
-		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
-		if test -z "$merge_tool_cmd"
-		then
-			if merge_mode
-			then
-				status=1
-			fi
-			break
-		fi
-		if merge_mode
-		then
-			trust_exit_code="$(git config --bool \
-				mergetool."$1".trustExitCode || echo false)"
-			if test "$trust_exit_code" = "false"
-			then
-				touch "$BACKUP"
-				( eval $merge_tool_cmd )
-				check_unchanged
-			else
-				( eval $merge_tool_cmd )
-				status=$?
-			fi
-		else
-			( eval $merge_tool_cmd )
-		fi
-		;;
-	esac
+	# Bring tool-specific functions into scope
+	setup_tool "$1"
+
+	if merge_mode
+	then
+		merge_cmd "$1"
+	else
+		diff_cmd "$1"
+	fi
 	return $status
 }
 
@@ -449,12 +173,7 @@ get_configured_merge_tool () {
 
 get_merge_tool_path () {
 	# A merge tool has been set, so verify that it's valid.
-	if test -n "$1"
-	then
-		merge_tool="$1"
-	else
-		merge_tool="$(get_merge_tool)"
-	fi
+	merge_tool="$1"
 	if ! valid_tool "$merge_tool"
 	then
 		echo >&2 "Unknown merge tool $merge_tool"
@@ -483,7 +202,7 @@ get_merge_tool_path () {
 
 get_merge_tool () {
 	# Check if a merge tool has been configured
-	merge_tool=$(get_configured_merge_tool)
+	merge_tool="$(get_configured_merge_tool)"
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
diff --git a/mergetools/araxis b/mergetools/araxis
new file mode 100644
index 0000000..69a9c8c
--- /dev/null
+++ b/mergetools/araxis
@@ -0,0 +1,21 @@
+diff_cmd () {
+	"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" >/dev/null 2>&1
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" -wait -merge -3 -a1 \
+			"$BASE" "$LOCAL" "$REMOTE" "$MERGED" >/dev/null 2>&1
+	else
+		"$merge_tool_path" -wait -2 \
+			"$LOCAL" "$REMOTE" "$MERGED" >/dev/null 2>&1
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	echo compare
+}
+
diff --git a/mergetools/bc3 b/mergetools/bc3
new file mode 100644
index 0000000..27b3dd4
--- /dev/null
+++ b/mergetools/bc3
@@ -0,0 +1,20 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
+			-mergeoutput="$MERGED"
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" \
+			-mergeoutput="$MERGED"
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	echo bcompare
+}
diff --git a/mergetools/defaults b/mergetools/defaults
new file mode 100644
index 0000000..1d8f2a3
--- /dev/null
+++ b/mergetools/defaults
@@ -0,0 +1,46 @@
+# Redefined by builtin tools
+can_merge () {
+	return 0
+}
+
+can_diff () {
+	return 0
+}
+
+diff_cmd () {
+	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
+	if test -z "$merge_tool_cmd"
+	then
+		status=1
+		break
+	fi
+	( eval $merge_tool_cmd )
+	status=$?
+	return $status
+}
+
+merge_cmd () {
+	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
+	if test -z "$merge_tool_cmd"
+	then
+		status=1
+		break
+	fi
+	trust_exit_code="$(git config --bool \
+		mergetool."$1".trustExitCode || echo false)"
+	if test "$trust_exit_code" = "false"
+	then
+		touch "$BACKUP"
+		( eval $merge_tool_cmd )
+		status=$?
+		check_unchanged
+	else
+		( eval $merge_tool_cmd )
+		status=$?
+	fi
+	return $status
+}
+
+translate_merge_tool_path () {
+	echo "$1"
+}
diff --git a/mergetools/diffuse b/mergetools/diffuse
new file mode 100644
index 0000000..02e0843
--- /dev/null
+++ b/mergetools/diffuse
@@ -0,0 +1,17 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" \
+			"$LOCAL" "$MERGED" "$REMOTE" \
+			"$BASE" | cat
+	else
+		"$merge_tool_path" \
+			"$LOCAL" "$MERGED" "$REMOTE" | cat
+	fi
+	check_unchanged
+}
diff --git a/mergetools/ecmerge b/mergetools/ecmerge
new file mode 100644
index 0000000..13c2e43
--- /dev/null
+++ b/mergetools/ecmerge
@@ -0,0 +1,16 @@
+diff_cmd () {
+	"$merge_tool_path" --default --mode=diff2 "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
+			--default --mode=merge3 --to="$MERGED"
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" \
+			--default --mode=merge2 --to="$MERGED"
+	fi
+	check_unchanged
+}
diff --git a/mergetools/emerge b/mergetools/emerge
new file mode 100644
index 0000000..f96d9e5
--- /dev/null
+++ b/mergetools/emerge
@@ -0,0 +1,23 @@
+diff_cmd () {
+	"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		"$merge_tool_path" \
+			-f emerge-files-with-ancestor-command \
+			"$LOCAL" "$REMOTE" "$BASE" \
+			"$(basename "$MERGED")"
+	else
+		"$merge_tool_path" \
+			-f emerge-files-command \
+			"$LOCAL" "$REMOTE" \
+			"$(basename "$MERGED")"
+	fi
+	status=$?
+}
+
+translate_merge_tool_path() {
+	echo emacs
+}
diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
new file mode 100644
index 0000000..28fead4
--- /dev/null
+++ b/mergetools/kdiff3
@@ -0,0 +1,24 @@
+diff_cmd () {
+	"$merge_tool_path" --auto \
+		--L1 "$MERGED (A)" --L2 "$MERGED (B)" \
+		"$LOCAL" "$REMOTE" >/dev/null 2>&1
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		"$merge_tool_path" --auto \
+			--L1 "$MERGED (Base)" \
+			--L2 "$MERGED (Local)" \
+			--L3 "$MERGED (Remote)" \
+			-o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" \
+		>/dev/null 2>&1
+	else
+		"$merge_tool_path" --auto \
+			--L1 "$MERGED (Local)" \
+			--L2 "$MERGED (Remote)" \
+			-o "$MERGED" "$LOCAL" "$REMOTE" \
+		>/dev/null 2>&1
+	fi
+	status=$?
+}
diff --git a/mergetools/kompare b/mergetools/kompare
new file mode 100644
index 0000000..433686c
--- /dev/null
+++ b/mergetools/kompare
@@ -0,0 +1,7 @@
+can_merge () {
+	return 1
+}
+
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
diff --git a/mergetools/meld b/mergetools/meld
new file mode 100644
index 0000000..73d70ae
--- /dev/null
+++ b/mergetools/meld
@@ -0,0 +1,9 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+	check_unchanged
+}
diff --git a/mergetools/opendiff b/mergetools/opendiff
new file mode 100644
index 0000000..0942b2a
--- /dev/null
+++ b/mergetools/opendiff
@@ -0,0 +1,16 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" "$LOCAL" "$REMOTE" \
+			-ancestor "$BASE" -merge "$MERGED" | cat
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" \
+			-merge "$MERGED" | cat
+	fi
+	check_unchanged
+}
diff --git a/mergetools/p4merge b/mergetools/p4merge
new file mode 100644
index 0000000..1a45c1b
--- /dev/null
+++ b/mergetools/p4merge
@@ -0,0 +1,10 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	$base_present || >"$BASE"
+	"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
+	check_unchanged
+}
diff --git a/mergetools/tkdiff b/mergetools/tkdiff
new file mode 100644
index 0000000..618c438
--- /dev/null
+++ b/mergetools/tkdiff
@@ -0,0 +1,12 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
+	else
+		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
+	fi
+}
diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
new file mode 100644
index 0000000..ed7db49
--- /dev/null
+++ b/mergetools/tortoisemerge
@@ -0,0 +1,17 @@
+can_diff () {
+	return 1
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		touch "$BACKUP"
+		"$merge_tool_path" \
+			-base:"$BASE" -mine:"$LOCAL" \
+			-theirs:"$REMOTE" -merged:"$MERGED"
+		check_unchanged
+	else
+		echo "TortoiseMerge cannot be used without a base" 1>&2
+		return 1
+	fi
+}
diff --git a/mergetools/vim b/mergetools/vim
new file mode 100644
index 0000000..619594a
--- /dev/null
+++ b/mergetools/vim
@@ -0,0 +1,44 @@
+diff_cmd () {
+	case "$1" in
+	gvimdiff|vimdiff)
+		"$merge_tool_path" -R -f -d \
+			-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
+		;;
+	gvimdiff2|vimdiff2)
+		"$merge_tool_path" -R -f -d \
+			-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
+		;;
+	esac
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	case "$1" in
+	gvimdiff|vimdiff)
+		if $base_present
+		then
+			"$merge_tool_path" -f -d -c 'wincmd J' \
+				"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+		else
+			"$merge_tool_path" -f -d -c 'wincmd l' \
+				"$LOCAL" "$MERGED" "$REMOTE"
+		fi
+		;;
+	gvimdiff2|vimdiff2)
+		"$merge_tool_path" -f -d -c 'wincmd l' \
+			"$LOCAL" "$MERGED" "$REMOTE"
+		;;
+	esac
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	case "$1" in
+	gvimdiff|gvimdiff2)
+		echo gvim
+		;;
+	vimdiff|vimdiff2)
+		echo vim
+		;;
+	esac
+}
diff --git a/mergetools/xxdiff b/mergetools/xxdiff
new file mode 100644
index 0000000..05b4433
--- /dev/null
+++ b/mergetools/xxdiff
@@ -0,0 +1,25 @@
+diff_cmd () {
+	"$merge_tool_path" \
+		-R 'Accel.Search: "Ctrl+F"' \
+		-R 'Accel.SearchForward: "Ctrl-G"' \
+		"$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" -X --show-merged-pane \
+			-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+			-R 'Accel.Search: "Ctrl+F"' \
+			-R 'Accel.SearchForward: "Ctrl-G"' \
+			--merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+	else
+		"$merge_tool_path" -X $extra \
+			-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+			-R 'Accel.Search: "Ctrl+F"' \
+			-R 'Accel.SearchForward: "Ctrl-G"' \
+			--merged-file "$MERGED" "$LOCAL" "$REMOTE"
+	fi
+	check_unchanged
+}
-- 
1.7.6.476.g57292
