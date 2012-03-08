From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Maintaince script for l10n files and commits
Date: Fri,  9 Mar 2012 00:05:06 +0800
Message-ID: <1331222706-81728-1-git-send-email-worldhello.net@gmail.com>
References: <7vr4x4mdae.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 17:05:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5fqV-0006xA-OZ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 17:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917Ab2CHQFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 11:05:34 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46437 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757830Ab2CHQFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 11:05:34 -0500
Received: by gghe5 with SMTP id e5so297667ggh.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dxxEJktnCCp8gsTPguDEB5JohbevxvzK5F1KoQd4jy0=;
        b=drikI2hnWFyiLuV0RnRvxJrXP6uRMuBgm2v/HcW6O76H3EnvGOd3v1YEXU5iUYxiqs
         HJ1HjApMVpOaG5yx1vEBnb93udsFC9HtK7eEtPfPFh2yxR5smdE3x35vXqZd3AXC5zqx
         st345HWstVy5La76UOCm8vtX9JtwK33T1aH5nir2eQNuqy71ttgYpNV2BGElPFa7Rj/I
         03fEG94Rudv2G6tIboRpYND5ErEel2FbW5dIuvsjOpA2Aa5LX3ZU3gXADEx5iLaj4QJE
         7CeCVpCsX0wM39h2DCfezHe+/UEArgqrVrQKFDz8mw6KapuqpqEgK8rkaUJ/W4kUZACB
         NFtQ==
Received: by 10.236.189.98 with SMTP id b62mr11880343yhn.9.1331222733328;
        Thu, 08 Mar 2012 08:05:33 -0800 (PST)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id t43sm5789498yht.11.2012.03.08.08.05.29
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 08:05:32 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.330.gaa956.dirty
In-Reply-To: <7vr4x4mdae.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192613>

Usage of this script:

 * po-helper.sh XX.po   : Init or update XX.po from git.pot

 * po-helper.sh check [XX.po]
                        : Perform all the checks for XX.po

 * po-helper.sh commits [since] [til]
                        : Check non-ascii chars in commit logs

                          Don't write commit log with non-ascii chars
                          without proper encoding settings.

                          Subject of commit log must written in English.

                          Don't change files outside this directory (po/)

 * po-helper.sh pot     : Display summary of updates of git.pot file

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/po-helper.sh |  271 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 271 insertions(+)
 create mode 100755 po/po-helper.sh

diff --git a/po/po-helper.sh b/po/po-helper.sh
new file mode 100755
index 0000000..dd370a5
--- /dev/null
+++ b/po/po-helper.sh
@@ -0,0 +1,271 @@
+#!/bin/bash
+#
+# Copyright (c) 2012 Jiang Xin
+
+POTFILE=git.pot
+
+usage()
+{
+    cat <<-END_OF_USAGE
+Maintaince script for l10n files and commits.
+
+Usage:
+
+ * po-helper.sh XX.po   : Init or update XX.po from git.pot
+
+ * po-helper.sh check [XX.po]
+                        : Perform all the checks for XX.po
+
+ * po-helper.sh commits [since] [til]
+                        : Check non-ascii chars in commit logs
+
+                          Don't write commit log with non-ascii chars
+                          without proper encoding settings.
+
+                          Subject of commit log must written in English.
+
+                          Don't change files outside this directory (po/)
+
+ * po-helper.sh pot     : Display summary of updates of git.pot file
+
+END_OF_USAGE
+
+    exit 1
+}
+
+# Display summary of updates of git.pot
+show_pot_update_summary()
+{
+    pnew="^.*:([0-9]+): this message is used but not defined in"
+    pdel="^.*:([0-9]+): warning: this message is not used"
+    new_count=0
+    del_count=0
+    new_lineno=""
+    del_lineno=""
+
+    status=$(git status --porcelain -- $POTFILE)
+    if [ -z "$status" ]; then
+        echo "Nothing changed."
+    else
+        tmpfile=$(mktemp /tmp/git.po.XXXX)
+        LANGUAGE=C git show HEAD:./git.pot > $tmpfile
+        LANGUAGE=C msgcmp -N --use-untranslated $tmpfile $POTFILE 2>&1 |
+        {    while read line; do
+                if [[ $line =~ $pnew ]]; then
+                    new_count=$(( new_count + 1 ))
+                    if [ -z "$new_lineno" ]; then
+                        new_lineno="${BASH_REMATCH[1]}"
+                    else
+                        new_lineno="${new_lineno}, ${BASH_REMATCH[1]}"
+                    fi
+                fi
+                if [[ $line =~ $pdel ]]; then
+                    del_count=$(( del_count + 1 ))
+                    if [ -z "$del_lineno" ]; then
+                        del_lineno="${BASH_REMATCH[1]}"
+                    else
+                        del_lineno="${del_lineno}, ${BASH_REMATCH[1]}"
+                    fi
+                fi
+            done
+            [ $new_count -gt 1 ] && new_plur="s" || new_plur=""
+            [ $del_count -gt 1 ] && del_plur="s" || del_plur=""
+            echo "Updates of $POTFILE since last update:"
+            echo
+            echo " * Add ${new_count} new l10n message${new_plur}" \
+                 "in the new generated \"git.pot\" file at" \
+                 "line${new_plur}:"
+            echo "   ${new_lineno}"
+            echo
+
+            echo " * Remove ${del_count} l10n message${del_plur}" \
+                 "from the old \"git.pot\" file at line${del_plur}:"
+            echo "   ${del_lineno}"
+        }
+        rm $tmpfile
+    fi
+}
+
+# Syntax check on XX.po, or all .po files if nothing provided
+check_po()
+{
+    if [ $# -eq 0 ]; then
+        ls *.po | while read f; do
+            echo "============================================================"
+            echo "Check $f..."
+            check_po $f
+        done
+    fi
+    while [ $# -gt 0 ]; do
+        po=$1
+        shift
+        if [ -f $po ]; then
+            msgfmt -o /dev/null --check --statistics $po
+        else
+            echo "Error: File $po does not exist." >&2
+        fi
+    done
+}
+
+# Create or update XX.po file from git.pot
+create_or_update_po()
+{
+    if [ $# -eq 0 ]; then
+        usage
+    fi
+    while [ $# -gt 0 ]; do
+        po=$1
+        shift
+        if [ -f $po ]; then
+            msgmerge --add-location --backup=off -U $po $POTFILE
+        else
+            msginit -i $POTFILE --locale=${po%.po}
+            perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' $po
+        fi
+        mo="build/locale/${po%.po}/LC_MESSAGES/git.mo"
+        mkdir -p $(dirname $mo)
+        msgfmt -o $mo --check --statistics $po
+    done
+}
+
+
+verify_commit_encoding()
+{
+    c=$1
+    subject=0
+    non_ascii=""
+    encoding=""
+    log=""
+
+    git cat-file commit $c |
+    {
+        while read line; do
+            log="$log - $line"
+            # next line would be the commit log subject line,
+            # if no previous empty line found.
+            if [ -z "$line" ]; then
+                subject=$((subject + 1))
+                continue
+            fi
+            pencoding="^encoding (.+)"
+            if [ $subject -eq 0 ] && [[ $line =~ $pencoding ]]; then
+                encoding="${BASH_REMATCH[1]}"
+            fi
+            # non-ascii found in commit log
+            pnonascii="([^[:alnum:][:space:][:punct:]]+)"
+            if [[ $line =~ $pnonascii ]]; then
+                non_ascii="${BASH_REMATCH[1]} >> $line <<"
+                if [ $subject -eq 1 ]; then
+                    report_nonascii_in_subject $c "$non_ascii"
+                    return
+                fi
+            fi
+            # subject has only one line
+            [ $subject -eq 1 ] && subject=$((subject += 1))
+            # break if there are non-asciis and has already checked subject line
+            if [ -n "$non_ascii" ] && [ $subject -gt 0 ]; then
+                break
+            fi
+        done
+        if [ -n "$non_ascii" ]; then
+            if [ -z "$encoding" ]; then
+                echo $line | iconv -f UTF-8 -t UTF-8 -s >/dev/null ||
+                report_bad_encoding "$c" "$non_ascii"
+            else
+                echo $line | iconv -f $encoding -t UTF-8 -s >/dev/null ||
+                report_bad_encoding "$c" "$non_ascii" "$encoding"
+            fi
+        fi
+    }
+}
+
+report_nonascii_in_subject()
+{
+    c=$1
+    non_ascii=$2
+
+    echo "============================================================" >&2
+    echo "Error: Non-ASCII in subject of commit $c:"                    >&2
+    echo "       ${non_ascii}"                                          >&2
+    echo
+    git cat-file commit $c | head -15 | while read line; do
+        echo "\t$line"                                                  >&2
+    done
+}
+
+report_bad_encoding()
+{
+    c=$1
+    non_ascii=$2
+    encoding=$3
+
+    echo "============================================================" >&2
+    if [ -z "$encoding" ]; then
+        echo "Error: Not have encoding setting for commit $c:"          >&2
+    else
+        echo "Error: Wrong encoding ($encoding) for commit $c:"         >&2
+    fi
+    echo "       ${non_ascii}"                                          >&2
+    echo                                                                >&2
+    git cat-file commit $c | head -15 | while read line; do
+        echo "\t$line"                                                  >&2
+    done
+}
+
+# Check commit logs for bad encoding settings
+check_commits()
+{
+    if [ $# -gt 2 ]; then
+        usage
+    fi
+    since=${1:-origin/master}
+    til=${2:-HEAD}
+
+    git diff-tree -r $since $til | awk '{print $6}' |
+    while read f; do
+        if [[ ! $f =~ ^po/ ]]; then
+            echo "Error: changed files ($f...) outside po directory!"   >&2
+            echo "       reference: git diff-tree -r $since $til"       >&2
+        fi
+    done
+
+    count=0
+    git rev-list ${since}..${til} |
+    {   while read c; do
+            verify_commit_encoding $c
+            count=$(( count + 1 ))
+        done
+        echo
+        echo "$count commits check complete."
+    }
+}
+
+
+[ $# -eq 0 ] && usage
+
+while [ $# -ne 0 ]; do
+    case "$1" in
+    pot|git.pot)
+        show_pot_update_summary
+        ;;
+    *.po)
+        create_or_update_po $1
+        ;;
+    check)
+        shift
+        check_po $*
+        exit 0
+        ;;
+    commit|commits)
+        shift
+        check_commits $*
+        exit 0
+        ;;
+    *)
+        usage
+        ;;
+    esac
+    shift
+done
+
+# vim: et ts=4 sw=4
-- 
1.7.9.2.330.gaa956.dirty
