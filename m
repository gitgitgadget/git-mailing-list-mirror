From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/3] mergetool--lib: list user configured tools in '--tool-help'
Date: Wed, 30 Jan 2013 19:55:46 +0000
Message-ID: <06855a92e18426f85f205341b6b5afba88e9ef3f.1359575447.git.john@keeping.me.uk>
References: <cover.1359575447.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 20:56:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dmB-0006c4-UG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 20:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab3A3T4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 14:56:34 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:37241 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792Ab3A3T4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 14:56:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id ECC0919807B;
	Wed, 30 Jan 2013 19:56:32 +0000 (GMT)
X-Quarantine-ID: <xSRVEaxnWTqn>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSRVEaxnWTqn; Wed, 30 Jan 2013 19:56:31 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id E53C9198047;
	Wed, 30 Jan 2013 19:56:31 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id DD66F161E4E3;
	Wed, 30 Jan 2013 19:56:31 +0000 (GMT)
X-Quarantine-ID: <y3aY79Ow3JKa>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3aY79Ow3JKa; Wed, 30 Jan 2013 19:56:31 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id B104E161E279;
	Wed, 30 Jan 2013 19:56:25 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1
In-Reply-To: <cover.1359575447.git.john@keeping.me.uk>
In-Reply-To: <cover.1359575447.git.john@keeping.me.uk>
References: <cover.1359575447.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215063>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index b44a2c8..e338be5 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -20,9 +20,24 @@ is_available () {
 	type "$merge_tool_path" >/dev/null 2>&1
 }
 
+list_config_tools () {
+	section=$1
+	line_prefix=${2:-}
+
+	git config --get-regexp $section'\..*\.cmd' |
+	while read -r key value
+	do
+		toolname=${key#$section.}
+		toolname=${toolname%.cmd}
+
+		printf "%s%s\n" "$line_prefix" "$toolname"
+	done
+}
+
 show_tool_names () {
 	condition=${1:-true} per_line_prefix=${2:-} preamble=${3:-}
 	not_found_msg=${4:-}
+	extra_content=${5:-}
 
 	shown_any=
 	( cd "$MERGE_TOOLS_DIR" && ls ) | {
@@ -41,6 +56,19 @@ show_tool_names () {
 			fi
 		done
 
+		if test -n "$extra_content"
+		then
+			if test -n "$preamble"
+			then
+				# Note: no '\n' here since we don't want a
+				# blank line if there is no initial content.
+				printf "%s" "$preamble"
+				preamble=
+			fi
+			shown_any=yes
+			printf "\n%s\n" "$extra_content"
+		fi
+
 		if test -n "$preamble" && test -n "$not_found_msg"
 		then
 			printf "%s\n" "$not_found_msg"
@@ -255,9 +283,20 @@ show_tool_help () {
 	any_shown=no
 
 	cmd_name=${TOOL_MODE}tool
+	config_tools=$({
+		diff_mode && list_config_tools difftool "$tab$tab"
+		list_config_tools mergetool "$tab$tab"
+	} | sort)
+	extra_content=
+	if test -n "$config_tools"
+	then
+		extra_content="${tab}user-defined:${LF}$config_tools"
+	fi
+
 	show_tool_names 'mode_ok && is_available' "$tab$tab" \
 		"$tool_opt may be set to one of the following:" \
-		"No suitable tool for 'git $cmd_name --tool=<tool>' found." &&
+		"No suitable tool for 'git $cmd_name --tool=<tool>' found." \
+		"$extra_content" &&
 		any_shown=yes
 
 	show_tool_names 'mode_ok && ! is_available' "$tab$tab" \
-- 
1.8.1.1
