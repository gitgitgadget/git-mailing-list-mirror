From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3] Maintaince script for l10n files and commits
Date: Sat, 10 Mar 2012 17:17:29 +0800
Message-ID: <1331371049-37208-1-git-send-email-worldhello.net@gmail.com>
References: <7v399iddw3.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 10:18:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6IRJ-0000OQ-1T
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 10:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab2CJJRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 04:17:45 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab2CJJRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 04:17:42 -0500
Received: by dajr28 with SMTP id r28so2492998daj.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LJRFHoDuRhCEPsJsKuqatlv2Mr0tUz54iKOKWINscaY=;
        b=h2KXDruXP/9B0mwwgdHrTleSg5XZKAC6gVPpWcYWQ0cNsHS03t7filQhN5IZcEu1Ob
         pkytQHij8ribnLhefeEndoOGfxtl1kCCh00uPm8pbvrwN0EjNOgR7D6zGPgLgQeL1A5J
         WqsnPg7CdDI99WMoY1ictpbY069M+vbyzG4AfPYbNWsobaWJ61d0XC81VnOutCTsOEt9
         HlvQ1MCLtBsaP3xheDTsxDgeNhrney/N2q+CgjSZSkgtMhjv5vwKYLXhVqA6Uc6jpP0M
         dpXp4Ctx+Mq6llMA65XxHLJ0Y9FXYkfrnE8grKio5A5DySxR/kNnnC/hUWhbRDOhV+KL
         jV6g==
Received: by 10.68.233.99 with SMTP id tv3mr7926022pbc.73.1331371061706;
        Sat, 10 Mar 2012 01:17:41 -0800 (PST)
Received: from localhost.localdomain (li381-10.members.linode.com. [106.187.38.10])
        by mx.google.com with ESMTPS id d4sm5950090pbe.36.2012.03.10.01.17.38
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 01:17:40 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.330.gaa956.dirty
In-Reply-To: <7v399iddw3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192775>

There are routine tasks translators need to perform that can be automated.
Add a helper script which can help:

 - Initialize or update the message files;

 - Check errors in the message files they edited;

 - Check errors in their commits; and

 - Review recent updates to the message template file
   they base their translations on.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/po-helper.sh |  411 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 411 insertions(+)
 create mode 100755 po/po-helper.sh

diff --git a/po/po-helper.sh b/po/po-helper.sh
new file mode 100755
index 0000000..2398f52
--- /dev/null
+++ b/po/po-helper.sh
@@ -0,0 +1,411 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Jiang Xin
+
+PODIR=$(git rev-parse --show-cdup)po
+POTFILE=$PODIR/git.pot
+
+usage () {
+	cat <<-\END_OF_USAGE
+Maintaince script for l10n files and commits.
+
+Usage:
+
+ * po-helper.sh init XX.po
+       Create the initial XX.po file in the po/ directory, where
+       XX is the locale, e.g. "de", "is", "pt_BR", "zh_CN", etc.
+
+ * po-helper.sh update XX.po ...
+       Update XX.po file(s) from the new git.pot template
+
+ * po-helper.sh check XX.po ...
+       Perform syntax check on XX.po file(s)
+
+ * po-helper.sh check commits [ <since> <til> ]
+       Check proper encoding of non-ascii chars in commit logs
+
+       - don't write commit log with non-ascii chars without proper
+         encoding settings;
+
+       - subject of commit log must written in English; and
+
+       - don't change files outside this directory (po/)
+
+ * po-helper.sh diff [ <old> <new> ]
+       Show difference between old and new po/pot files.
+       Default show changes of git.pot since last update.
+END_OF_USAGE
+
+	if test $# -gt 0
+	then
+		echo >&2
+		echo >&2 "Error: $*"
+		exit 1
+	else
+		exit 0
+	fi
+}
+
+# Init or update XX.po file from git.pot
+update_po () {
+	if test $# -eq 0
+	then
+		usage "init/update needs at least one argument"
+	fi
+	for locale
+	do
+		locale=${locale##*/}
+		locale=${locale%.po}
+		po=$PODIR/$locale.po
+		mo=$PODIR/build/locale/$locale/LC_MESSAGES/git.mo
+		if test -n "$locale"
+		then
+			if test -f "$po"
+			then
+				msgmerge --add-location --backup=off -U "$po" "$POTFILE"
+				mkdir -p "${mo%/*}"
+				msgfmt -o "$mo" --check --statistics "$po"
+			else
+				msginit -i "$POTFILE" --locale="$locale" -o "$po"
+				perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' "$po"
+				notes_for_l10n_team_leader "$locale"
+			fi
+		fi
+	done
+}
+
+notes_for_l10n_team_leader () {
+	cat <<-END_OF_NOTES
+	============================================================
+	Notes for l10n team leader:
+
+	    Since you create a initialial locale file, you are
+	    likely to be the leader of the $1 l10n team.
+
+	    You can add your team infomation in the "po/TEAMS"
+	    file, and update it when necessary.
+
+	    Please read the file "po/README" first to understand
+	    the workflow of Git l10n maintenance.
+	============================================================
+	END_OF_NOTES
+}
+
+# Check po files and commits. Run all checks if no argument is given.
+check () {
+	if test $# -eq 0
+	then
+		ls $PODIR/*.po |
+		while read f
+		do
+			echo "============================================================"
+			echo "Check ${f##*/}..."
+			check "$f"
+		done
+
+		echo "============================================================"
+		echo "Show updates of git.pot..."
+		show_diff
+
+		echo "============================================================"
+		echo "Check commits..."
+		check commits
+	fi
+	while test $# -gt 0
+	do
+		case "$1" in
+		*.po)
+			check_po "$1"
+			;;
+		commit | commits)
+			shift
+			check_commits "$@"
+			break
+			;;
+		*)
+			usage "Unkown task '$1' for check"
+			;;
+		esac
+		shift
+	done
+}
+
+# Syntax check on XX.po
+check_po () {
+	for locale
+	do
+		locale=${locale##*/}
+		locale=${locale%.po}
+		po=$PODIR/$locale.po
+		mo=$PODIR/build/locale/$locale/LC_MESSAGES/git.mo
+		if test -n "$locale"
+		then
+			if test -f "$po"
+			then
+				mkdir -p "${mo%/*}"
+				msgfmt -o "$mo" --check --statistics "$po"
+			else
+				echo >&2 "Error: File $po does not exist."
+			fi
+		fi
+	done
+}
+
+# Show summary of updates of git.pot or difference between two po/pot files.
+show_diff () {
+	pnew="^.*:\([0-9]*\): this message is used but not defined in.*"
+	pdel="^.*:\([0-9]*\): warning: this message is not used.*"
+	new_count=0
+	del_count=0
+	new_lines=
+	del_lines=
+
+	case $# in
+	0)
+		status=$(cd $PODIR; git status --porcelain -- ${POTFILE##*/})
+		if test -z "$status"
+		then
+			echo "Nothing changed."
+			return 0
+		fi
+		tmpfile=$(mktemp /tmp/git.po.XXXX)
+		(cd $PODIR; LANGUAGE=C git show HEAD:./${POTFILE##*/} >"$tmpfile")
+		oldpot=$tmpfile
+		newpot=$POTFILE
+		oldtitle="the old 'git.pot' file"
+		newtitle="the new generated 'git.pot' file"
+		# Remove tmpfile on exit
+		trap 'rm -f "$tmpfile"' 0
+		echo "Changes of po/git.pot since last update:"
+		;;
+	2)
+		oldpot=$1
+		newpot=$2
+		oldtitle=${oldpot##*/}
+		newtitle=${newpot##*/}
+		echo "Difference between $oldtitle and $newtitle:"
+		;;
+	*)
+		usage "show_diff takes 2 or null arguments."
+		;;
+	esac
+
+	LANGUAGE=C msgcmp -N --use-untranslated "$oldpot" "$newpot" 2>&1 | {
+		while read line
+		do
+			# Extract line number "NNN"from output, like:
+			#     git.pot:NNN: this message is used but not defined in /tmp/git.po.XXXX
+			m=$(echo $line | grep "$pnew" | sed -e "s/$pnew/\1/")
+			if test -n "$m"
+			then
+				new_count=$(( new_count + 1 ))
+				if test -z "$new_lines"
+				then
+					new_lines="$m"
+				else
+					new_lines="${new_lines}, $m"
+				fi
+				continue
+			fi
+
+			# Extract line number "NNN" from output, like:
+			#     /tmp/git.po.XXXX:NNN: warning: this message is not used
+			m=$(echo $line | grep "$pdel" | sed -e "s/$pdel/\1/")
+			if test -n "$m"
+			then
+				del_count=$(( del_count + 1 ))
+				if test -z "$del_lines"
+				then
+					del_lines="$m"
+				else
+					del_lines="${del_lines}, $m"
+				fi
+			fi
+		done
+		if test $new_count -eq 0 && test $del_count -eq 0
+		then
+			echo "Nothing changed."
+			return 0
+		fi
+		if test $new_count -gt 0
+		then
+			test $new_count -ne 1 && new_plur="s" || new_plur=""
+			echo
+			echo " * Add ${new_count} new l10n message${new_plur}" \
+				 "in $newtitle at" \
+				 "line${new_plur}:"
+			echo "   ${new_lines}"
+		fi
+		if test $del_count -gt 0
+		then
+			test $del_count -ne 1 && del_plur="s" || del_plur=""
+			echo
+			echo " * Remove ${del_count} l10n message${del_plur}" \
+				 "from $oldtitle at line${del_plur}:"
+			echo "   ${del_lines}"
+		fi
+	}
+}
+
+verify_commit_encoding () {
+	c=$1
+	subject=0
+	non_ascii=""
+	encoding=""
+	log=""
+
+	git cat-file commit $c | {
+		while read line
+		do
+			log="$log - $line"
+			# next line would be the commit log subject line,
+			# if no previous empty line found.
+			if test -z "$line"
+			then
+				subject=$(( subject + 1 ))
+				continue
+			fi
+			if test $subject -eq 0
+			then
+				if echo $line | grep -q "^encoding "
+				then
+					encoding=${line#encoding }
+				fi
+			fi
+			# non-ascii found in commit log
+			m=$(echo $line | sed -e "s/\([[:alnum:][:space:][:punct:]]\)//g")
+			if test -n "$m"
+			then
+				non_ascii="$m >> $line <<"
+				if test $subject -eq 1
+				then
+					report_nonascii_in_subject $c "$non_ascii"
+					return
+				fi
+			fi
+			# subject has only one line
+			test $subject -eq 1 && subject=$(( subject + 1 ))
+			# break if there are non-asciis and has already checked subject line
+			if test -n "$non_ascii" && test $subject -gt 0
+			then
+				break
+			fi
+		done
+		if test -n "$non_ascii"
+		then
+			if test -z "$encoding"
+			then
+				echo $line | iconv -f UTF-8 -t UTF-8 -s >/dev/null ||
+					report_bad_encoding "$c" "$non_ascii"
+			else
+				echo $line | iconv -f $encoding -t UTF-8 -s >/dev/null ||
+					report_bad_encoding "$c" "$non_ascii" "$encoding"
+			fi
+		fi
+	}
+}
+
+report_nonascii_in_subject () {
+	c=$1
+	non_ascii=$2
+
+	echo >&2 "============================================================"
+	echo >&2 "Error: Non-ASCII in subject of commit $c:"
+	echo >&2 "       ${non_ascii}"
+	echo >&2
+	git cat-file commit "$c" | head -15 |
+	while read line
+	do
+		echo >&2 "\t$line"
+	done
+	echo >&2
+}
+
+report_bad_encoding () {
+	c=$1
+	non_ascii=$2
+	encoding=$3
+
+	echo >&2 "============================================================"
+	if test -z "$encoding"
+	then
+		echo >&2 "Error: Not have encoding setting for commit $c:"
+	else
+		echo >&2 "Error: Wrong encoding ($encoding) for commit $c:"
+	fi
+	echo >&2 "       ${non_ascii}"
+	echo >&2
+	git cat-file commit "$c" | head -15 |
+	while read line
+	do
+		echo >&2 "\t$line"
+	done
+	echo
+}
+
+# Check commit logs for bad encoding settings
+check_commits () {
+	if test $# -gt 2
+	then
+		usage "check commits only needs 2 arguments"
+	fi
+	since=${1:-origin/master}
+	til=${2:-HEAD}
+
+	if git diff-tree -r "$since" "$til" | awk '{print $6}' | grep -qv "^po/"
+	then
+		echo >&2 "============================================================"
+		echo >&2 "Error: changed files outside po directory!"
+		echo >&2 "       reference: git diff-tree -r $since $til"
+	fi
+
+	count=0
+	git rev-list ${since}..${til} | {
+		while read c
+		do
+			verify_commit_encoding $c
+			count=$(( count + 1 ))
+		done
+		echo "$count commits checked complete."
+	}
+}
+
+
+test $# -eq 0 && usage
+
+if ! test -f "$POTFILE"
+then
+	echo "Cannot find git.pot in your workspace. Are you in the workspace of git project?"
+	exit 1
+fi
+
+while test $# -ne 0
+do
+	case "$1" in
+	init | update)
+		shift
+		update_po "$@"
+		break
+		;;
+	check)
+		shift
+		check "$@"
+		break
+		;;
+	diff)
+		shift
+		show_diff "$@"
+		break
+		;;
+	*.po)
+		update_po "$1"
+		;;
+	-h | --help)
+		usage
+		;;
+	*)
+		usage "Unknown command '$1'."
+		;;
+	esac
+	shift
+done
-- 
1.7.9.2.330.gaa956.dirty
