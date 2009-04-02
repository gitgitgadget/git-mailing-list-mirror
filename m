From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 08/10] mergetool-lib: introduce run_mergetool
Date: Wed,  1 Apr 2009 21:20:39 -0700
Message-ID: <1238646040-46008-2-git-send-email-davvid@gmail.com>
References: <1238646040-46008-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de,
	charles@hashpling.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 06:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpERw-0002z2-Os
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 06:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbZDBEU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 00:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbZDBEUy
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 00:20:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:24850 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZDBEUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 00:20:53 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2560646rvb.5
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F2fSqJkSy6uywdQv2pyKaUeFpzc2oQ0LIv9/6ZIzCAI=;
        b=KqKHU6CZ0motpzif2DvLcGIYVW1Pjwlt6Jjwby+jERyF1PgKgQ1Rz3NSrwR2y2wrnf
         nTLYaR1DMsWQQrNk63WxLTHJgpQ0eHl0Zl/nOoh8M8ndZkIYnad8ED8jtIi2KEqeANj8
         9aVH2h8sbNOqmUT7KN3A6WWlvLR5JNXhgTDuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GKyrnhqGLAbRIrViBicvAwPZCZ+1caJTy+AfvB8H7nZTQ6w9HNHvH1gh25e7OvQwpY
         3ks9PM5hhIOYThD6uhDX3sFd3Lii9sc/qu+tz0mRIILahpRfyb+WcrCbBIz8X6xPOcUo
         S/FmWNimdXQ7ro9vz5hlPrYtG9+x7HOMd/33U=
Received: by 10.142.185.21 with SMTP id i21mr3354840wff.220.1238646051818;
        Wed, 01 Apr 2009 21:20:51 -0700 (PDT)
Received: from localhost (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id l31sm5110050rvb.5.2009.04.01.21.20.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 21:20:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238646040-46008-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115437>

run_mergetool contains the common functionality for launching
mergetools.  There's some context-specific behavior but overall
it's better to have all of this stuff in one place versus multiple
places.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Include fixups from Markus

 Documentation/git-mergetool-lib.txt |   10 +++
 git-mergetool-lib.sh                |  141 +++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-mergetool-lib.txt b/Documentation/git-mergetool-lib.txt
index a8d62f5..7377774 100644
--- a/Documentation/git-mergetool-lib.txt
+++ b/Documentation/git-mergetool-lib.txt
@@ -29,6 +29,16 @@ FUNCTIONS
 get_merge_tool_path::
 	returns the `merge_tool_path` for a `merge_tool`.
 
+run_mergetool::
+	launches a merge tool given the tool name and a true/false
+	flag to indicate whether a merge base is present
+
+valid_tool::
+	tests whether a merge tool is setup correctly.
+
+get_custom_cmd::
+	given a merge tool, returns the custom command for that tool.
+
 Author
 ------
 Written by David Aguilar <davvid@gmail.com>
diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
index 5f9ba97..d28be68 100644
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
@@ -40,3 +50,134 @@ get_custom_cmd () {
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
+			if merge_mode; then
+				"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
+			else
+				"$merge_tool_path" "$LOCAL" "$REMOTE"
+			fi
+		fi
+		status=$?
+		;;
+	meld)
+		if merge_mode; then
+			touch "$BACKUP"
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
