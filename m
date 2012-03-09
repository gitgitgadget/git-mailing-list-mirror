From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] Maintaince script for l10n files and commits
Date: Fri,  9 Mar 2012 14:08:27 +0800
Message-ID: <1331273307-64598-1-git-send-email-worldhello.net@gmail.com>
References: <7v399iddw3.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 07:08:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5t0W-0005Do-Eq
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 07:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab2CIGIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 01:08:47 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61425 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751327Ab2CIGIq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 01:08:46 -0500
Received: by obbuo6 with SMTP id uo6so1709318obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 22:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w/v8Q+7YVm+fZ1J3dcgFK+9YPQ/apkeMlw8KlSRNqlk=;
        b=UobGgVClnjzZH6dkfC7XTg2C38Qwatc8w847vr0cmOTCpVzQliyosRcmRit/Gi0bF7
         Ve8iWyjwSG+LPx7lLBJ/ZhL2lhxCZVDd2203aARooF5AjbVxmCB7Rpa4JkykON3cYQbB
         wBW25TCntGiUqnSOzJXfI9doFA8bi0NUyS7fd3v+tljrE/02k82DHRPQtGnU9XU7NQR4
         PB/uDSNIKtUsYP0J7KAs942/vVInuoG2EtMOuzBoiPWu+LqFA8oQeyJSrvASbnjMmWVx
         0j3spAqo89D/FylZ5CQkcPWV3f9BtmE11scunasJZuUJ1xWTDIaeDlB5/IM7xuWJp73B
         Logw==
Received: by 10.182.1.104 with SMTP id 8mr438392obl.19.1331273325622;
        Thu, 08 Mar 2012 22:08:45 -0800 (PST)
Received: from localhost.foo.bar ([123.116.247.153])
        by mx.google.com with ESMTPS id xh3sm3594836obb.13.2012.03.08.22.08.41
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 22:08:44 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.330.gaa956.dirty
In-Reply-To: <7v399iddw3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192680>

There are routine tasks translators need to perform that can be automated.
Add a helper script which can help:

 - Initialize or update the message files;

 - Check errors in the message files they edited;

 - Check errors in their commits; and

 - Review recent updates to the message template file
   they base their translations on.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/po-helper.sh |  387 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 387 insertions(+)
 create mode 100755 po/po-helper.sh

diff --git a/po/po-helper.sh b/po/po-helper.sh
new file mode 100755
index 0000000..166ebb7
--- /dev/null
+++ b/po/po-helper.sh
@@ -0,0 +1,387 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Jiang Xin
+
+GIT=git
+PODIR=$($GIT rev-parse --show-cdup)po
+POTFILE=$PODIR/git.pot
+
+usage() {
+	cat <<-\END_OF_USAGE
+Maintaince script for l10n files and commits.
+
+Usage:
+
+ * po-helper.sh init XX.po
+       Create the initial XX.po file in the po/ directory, where
+       XX is the locale, e.g. "de", "is", "pt_BR", "zh_CN", etc.
+
+ * po-helper.sh update XX.po
+       Update XX.po file(s) to the new git.pot template
+
+ * po-helper.sh check XX.po
+       Perform syntax check on XX.po file(s)
+
+ * po-helper.sh check pot
+       Display summary of updates/modifications of git.pot template
+
+ * po-helper.sh check commits [since] [til]
+       Check non-ascii chars in commit logs
+
+       - don't write commit log with non-ascii chars without proper
+         encoding settings;
+
+       - subject of commit log must written in English; and
+
+       - don't change files outside this directory (po/)
+END_OF_USAGE
+
+	if test $# -gt 0
+	then
+		echo
+		echo "Error: $*"
+		exit 1
+	else
+		exit 0
+	fi
+}
+
+# Init or update XX.po file from git.pot
+update_po() {
+	if test $# -eq 0
+	then
+		usage "init/update needs at least one argument"
+	fi
+	while test $# -gt 0
+	do
+		locale=$(basename $1)
+		locale=${locale%.po}
+		po=$PODIR/$locale.po
+		mo=$PODIR/build/locale/$locale/LC_MESSAGES/git.mo
+		if test -f $po
+		then
+			msgmerge --add-location --backup=off -U $po $POTFILE
+		else
+			msginit -i $POTFILE --locale=$locale -o $po
+			perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' $po
+		fi
+		mkdir -p $(dirname $mo)
+		msgfmt -o $mo --check --statistics $po
+		shift
+	done
+}
+
+notes_for_l10n_team_leader() {
+	locale=$(basename $1)
+	locale=${locale%.po}
+
+	cat <<-END_OF_NOTES
+	============================================================
+	Notes for l10n team leader:
+
+	    Since you create a initialial locale file, you are
+	    likely to be the leader of the $locale l10n team.
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
+# Check po, pot, commits
+check() {
+	if test $# -eq 0
+	then
+		ls $PODIR/*.po |
+		while read f
+		do
+			echo "============================================================"
+			echo "Check $(basename $f)..."
+			check $f
+		done
+
+		echo "============================================================"
+		echo "Check updates of git.pot..."
+		check pot
+
+		echo "============================================================"
+		echo "Check commits..."
+		check commits
+	fi
+	while test $# -gt 0
+	do
+		case "$1" in
+		*.po)
+			check_po $1
+			;;
+		*pot)
+			check_pot
+			;;
+		commit|commits)
+			shift
+			check_commits $@
+			break
+			;;
+		*)
+			usage "Unkown task \"$1\" for check"
+			;;
+		esac
+		shift
+	done
+}
+
+# Syntax check on XX.po, or all .po files if nothing provided
+check_po() {
+	while test $# -gt 0
+	do
+		locale=$(basename $1)
+		locale=${locale%.po}
+		po=$PODIR/$locale.po
+		mo=$PODIR/build/locale/$locale/LC_MESSAGES/git.mo
+		if test -f $po
+		then
+			mkdir -p $(dirname $mo)
+			msgfmt -o $mo --check --statistics $po
+		else
+			echo "Error: File $po does not exist." >&2
+		fi
+		shift
+	done
+}
+
+# Display summary of updates of git.pot
+check_pot() {
+	pnew="^.*:\([0-9]*\): this message is used but not defined in.*"
+	pdel="^.*:\([0-9]*\): warning: this message is not used.*"
+	new_count=0
+	del_count=0
+	new_lineno=""
+	del_lineno=""
+
+	status=$(cd $PODIR; $GIT status --porcelain -- $(basename $POTFILE))
+	if test -z "$status"
+	then
+		echo "Nothing changed."
+	else
+		tmpfile=$(mktemp /tmp/git.po.XXXX)
+		(cd $PODIR; LANGUAGE=C $GIT show HEAD:./$(basename $POTFILE) > $tmpfile )
+		LANGUAGE=C msgcmp -N --use-untranslated $tmpfile $POTFILE 2>&1 | {
+			while read line
+			do
+				m=$(echo $line | grep "$pnew" | sed -e "s/$pnew/\1/")
+				if test -n "$m"
+				then
+					new_count=$(( new_count + 1 ))
+					if test -z "$new_lineno"
+					then
+						new_lineno="$m"
+					else
+						new_lineno="${new_lineno}, $m"
+					fi
+					continue
+				fi
+
+				m=$(echo $line | grep "$pdel" | sed -e "s/$pdel/\1/")
+				if test -n "$m"
+				then
+					del_count=$(( del_count + 1 ))
+					if test -z "$del_lineno"
+					then
+						del_lineno="$m"
+					else
+						del_lineno="${del_lineno}, $m"
+					fi
+				fi
+			done
+			test $new_count -gt 1 && new_plur="s" || new_plur=""
+			test $del_count -gt 1 && del_plur="s" || del_plur=""
+			echo "Updates of po/git.pot since last update:"
+			echo
+			echo " * Add ${new_count} new l10n message${new_plur}" \
+				 "in the new generated \"git.pot\" file at" \
+				 "line${new_plur}:"
+			echo "   ${new_lineno}"
+			echo
+
+			echo " * Remove ${del_count} l10n message${del_plur}" \
+				 "from the old \"git.pot\" file at line${del_plur}:"
+			echo "   ${del_lineno}"
+		}
+		rm $tmpfile
+	fi
+}
+
+verify_commit_encoding() {
+	c=$1
+	subject=0
+	non_ascii=""
+	encoding=""
+	log=""
+
+	$GIT cat-file commit $c | {
+		while read line
+		do
+			log="$log - $line"
+			# next line would be the commit log subject line,
+			# if no previous empty line found.
+			if test -z "$line"
+			then
+				subject=$((subject + 1))
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
+			test $subject -eq 1 && subject=$((subject += 1))
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
+report_nonascii_in_subject() {
+	c=$1
+	non_ascii=$2
+
+	echo "============================================================" >&2
+	echo "Error: Non-ASCII in subject of commit $c:"                    >&2
+	echo "	   ${non_ascii}"                                            >&2
+	echo
+	$GIT cat-file commit $c | head -15 |
+	while read line
+	do
+		echo "\t$line"                                              >&2
+	done
+	echo
+}
+
+report_bad_encoding() {
+	c=$1
+	non_ascii=$2
+	encoding=$3
+
+	echo "============================================================" >&2
+	if test -z "$encoding"
+	then
+		echo "Error: Not have encoding setting for commit $c:"      >&2
+	else
+		echo "Error: Wrong encoding ($encoding) for commit $c:"     >&2
+	fi
+	echo "	   ${non_ascii}"                                            >&2
+	echo                                                                >&2
+	$GIT cat-file commit $c | head -15 |
+	while read line
+	do
+		echo "\t$line"                                              >&2
+	done
+	echo
+}
+
+# Check commit logs for bad encoding settings
+check_commits() {
+	if test $# -gt 2
+	then
+		usage "check commits only needs 2 arguments"
+	fi
+	since=${1:-origin/master}
+	til=${2:-HEAD}
+
+	if $GIT diff-tree -r $since $til | awk '{print $6}' | grep -qv "^po/"
+	then
+		echo "============================================================" >&2
+		echo "Error: changed files outside po directory!"           >&2
+		echo "	   reference: git diff-tree -r $since $til"         >&2
+	fi
+
+	count=0
+	$GIT rev-list ${since}..${til} | {
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
+if ! test -f $POTFILE
+then
+	echo "Cannot find git.pot in your workspace. Are you in the workspace of git project?"
+	exit 1
+fi
+
+while test $# -ne 0
+do
+	case "$1" in
+	init)
+		shift
+		update_po $1
+		notes_for_l10n_team_leader $1
+		break
+		;;
+	update)
+		shift
+		update_po $@
+		break
+		;;
+	check)
+		shift
+		check $@
+		break
+		;;
+	*.po)
+		update_po $1
+		;;
+	pot|git.pot)
+		check pot
+		;;
+	commit|commits)
+		shift
+		check commits $@
+		break
+		;;
+	-h|--help)
+		usage
+		;;
+	*)
+		usage "Unknown command"
+		;;
+	esac
+	shift
+done
-- 
1.7.9.2.330.gaa956.dirty
