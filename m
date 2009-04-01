From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 08/10] mergetool-lib: introduce run_mergetool
Date: Wed,  1 Apr 2009 05:55:12 -0700
Message-ID: <1238590514-41893-9-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <1238590514-41893-2-git-send-email-davvid@gmail.com>
 <1238590514-41893-3-git-send-email-davvid@gmail.com>
 <1238590514-41893-4-git-send-email-davvid@gmail.com>
 <1238590514-41893-5-git-send-email-davvid@gmail.com>
 <1238590514-41893-6-git-send-email-davvid@gmail.com>
 <1238590514-41893-7-git-send-email-davvid@gmail.com>
 <1238590514-41893-8-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01l-0004A8-L9
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764723AbZDAM4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764733AbZDAM4B
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:56:01 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:5853 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764688AbZDAMzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:44 -0400
Received: by wa-out-1112.google.com with SMTP id j5so13652wah.21
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7QmPgd2R4DQvbCSeLVDZGBABztBB6hs4l8FtrGE+e7Q=;
        b=nDQKiUD5tWSYko2dB/prG9Ud6Is+1YZJFkLB5J1fee3yGkCa7iSlbi+bJd9FYeVbDe
         F+OQyb85U/lOi4JSd2CgalHR+QoUZ1BDqaLC8eFRaW1BdI6kyNcQrbkPqv2Vnf6cBx3u
         ULg+P9ykbbYbzsY6HLIm+4L1mMOoniFdAtJ3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=knZpc360DeuKsq0ZtClfYDxDZ0SJEW7v1LZDhpdpNMu2N0YMY5xkT89x9dYJQ+3Kzu
         qQyHCpXe9WWv/ZBJbjtFqBnPWKAVH4y3FauvdfGdcABFX6hC3g3wapdVZTAHZRfK8wB4
         +mbPKey1nzlzOEIV9ekbb5WvQlb7ULgtCCK18=
Received: by 10.114.180.1 with SMTP id c1mr5192707waf.192.1238590543319;
        Wed, 01 Apr 2009 05:55:43 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n33sm156396wag.18.2009.04.01.05.55.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-8-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115388>

run_mergetool contains the common functionality for launching
mergetools.  There's some context-specific behavior but overall
it's better to have all of this stuff in one place versus multiple
places.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-mergetool-lib.txt |    4 +
 git-mergetool-lib.sh                |  141 +++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-mergetool-lib.txt b/Documentation/git-mergetool-lib.txt
index a8d62f5..3060673 100644
--- a/Documentation/git-mergetool-lib.txt
+++ b/Documentation/git-mergetool-lib.txt
@@ -29,6 +29,10 @@ FUNCTIONS
 get_merge_tool_path::
 	returns the `merge_tool_path` for a `merge_tool`.
 
+run_mergetool::
+	launches a merge tool given the tool name and a true/false
+	flag to indicate whether a merge base is present
+
 Author
 ------
 Written by David Aguilar <davvid@gmail.com>
diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
index c307a5d..9c26b5f 100644
--- a/git-mergetool-lib.sh
+++ b/git-mergetool-lib.sh
@@ -3,7 +3,12 @@ diff_mode() {
 	test $TOOL_MODE = "diff"
 }
 
+merge_mode() {
+	test $TOOL_MODE = "merge"
+}
+
 get_merge_tool_path () {
+	path="$1"
 	if test -z "$2"; then
 		case "$1" in
 		emerge)
@@ -17,6 +22,11 @@ get_merge_tool_path () {
 	echo "$path"
 }
 
+# Overridden in git-mergetool
+check_unchanged () {
+	true
+}
+
 valid_tool () {
 	case "$1" in
 	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
@@ -39,3 +49,134 @@ get_custom_cmd () {
 	test -n "$custom_cmd" &&
 	echo "$custom_cmd"
 }
+
+run_mergetool () {
+	base_present="$2"
+	if diff_mode; then
+		base_present="false"
+	fi
+	if test -z "$base_present"; then
+		base_present="true"
+	fi
+
+	case "$1" in
+	kdiff3)
+		if $base_present; then
+			("$merge_tool_path" --auto \
+			 --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
+			 -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		else
+			("$merge_tool_path" --auto \
+			 --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
+			 -o "$MERGED" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		fi
+		status=$?
+		;;
+	kompare)
+		"$merge_tool_path" "$LOCAL" "$REMOTE"
+		status=$?
+		;;
+	tkdiff)
+		if $base_present; then
+			"$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"
+		else
+			if diff_mode; then
+				"$merge_tool_path" "$LOCAL" "$REMOTE"
+			else
+				"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
+			fi
+		fi
+		status=$?
+		;;
+	meld)
+		merge_mode && touch "$BACKUP"
+		if merge_mode; then
+			"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
+		fi
+		check_unchanged
+		;;
+	vimdiff)
+		if merge_mode; then
+			touch "$BACKUP"
+			"$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
+			check_unchanged
+		else
+			"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
+		fi
+		;;
+	gvimdiff)
+		if merge_mode; then
+			touch "$BACKUP"
+			"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
+			check_unchanged
+		else
+			"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
+		fi
+		;;
+	xxdiff)
+		merge_mode && touch "$BACKUP"
+		if $base_present; then
+			"$merge_tool_path" -X --show-merged-pane \
+			    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
+			    -R 'Accel.Search: "Ctrl+F"' \
+			    -R 'Accel.SearchForward: "Ctrl-G"' \
+			    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+		else
+			merge_mode && extra=--show-merged-pane
+			"$merge_tool_path" -X $extra \
+				-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+				-R 'Accel.Search: "Ctrl+F"' \
+				-R 'Accel.SearchForward: "Ctrl-G"' \
+				--merged-file "$MERGED" "$LOCAL" "$REMOTE"
+		fi
+		check_unchanged
+		;;
+	opendiff)
+		merge_mode && touch "$BACKUP"
+		if $base_present; then
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				-ancestor "$BASE" -merge "$MERGED" | cat
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				-merge "$MERGED" | cat
+		fi
+		check_unchanged
+		;;
+	ecmerge)
+		merge_mode && touch "$BACKUP"
+		if $base_present; then
+			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
+				--default --mode=merge3 --to="$MERGED"
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE" \
+				--default --mode=merge2 --to="$MERGED"
+		fi
+		check_unchanged
+		;;
+	emerge)
+		if $base_present; then
+			"$merge_tool_path" -f emerge-files-with-ancestor-command \
+				"$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
+		else
+			"$merge_tool_path" -f emerge-files-command \
+				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
+		fi
+		status=$?
+		;;
+	*)
+		if test -n "$merge_tool_cmd"; then
+			if merge_mode &&
+			test "$merge_tool_trust_exit_code" = "false"; then
+				touch "$BACKUP"
+				( eval $merge_tool_cmd )
+				check_unchanged
+			else
+				( eval $merge_tool_cmd )
+				status=$?
+			fi
+		fi
+		;;
+	esac
+}
-- 
1.6.1.3
