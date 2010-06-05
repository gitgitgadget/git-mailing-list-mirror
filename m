From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.* configurations ignored for known tools
Date: Sat,  5 Jun 2010 04:31:52 +0200
Message-ID: <1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
References: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr>
Cc: git@vger.kernel.org, Sylvain Rabot <sylvain@abstraction.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 05 04:32:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKjBY-000714-Jb
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 04:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab0FECcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 22:32:14 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48064 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab0FECcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 22:32:12 -0400
Received: by mail-ww0-f46.google.com with SMTP id 28so1315338wwb.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 19:32:12 -0700 (PDT)
Received: by 10.227.128.4 with SMTP id i4mr5261557wbs.188.1275705131975;
        Fri, 04 Jun 2010 19:32:11 -0700 (PDT)
Received: from localhost.localdomain (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id r35sm15067917wbv.17.2010.06.04.19.32.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 19:32:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148449>

At this time when you define merge.tool with a known tool,
such as meld, p4merge, diffuse ... etc, mergetool.<tool>.*
configurations are ignored and git mergetool will use its
own templates.

This patch adds a detection for mergetool.<tool>.cmd configuration
in the run_merge_tool function. If the configuration is set, it will
try to run the tool with mergetool.<tool>.path if its set. It also
consider the mergetool.<tool>.trustExitCode configuration.

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 git-mergetool--lib.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 51dd0d6..2a58d88 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -84,9 +84,69 @@ get_merge_tool_cmd () {
 
 run_merge_tool () {
 	merge_tool_path="$(get_merge_tool_path "$1")" || exit
+	merge_tool_cmd="$(get_merge_tool_cmd "$1")"
+	merge_tool_cmd_base="$(echo $merge_tool_cmd | cut -f1 -d " ")"
 	base_present="$2"
 	status=0
 
+	# if mergetool.<tool>.cmd is set we execute it, not a template
+	if test -n "$merge_tool_cmd"; then
+		# mergetool.<tool>.path is empty
+		if test -z "$merge_tool_path"; then
+			# mergetool.<tool>.cmd not found
+			if ! $(which "$merge_tool_cmd_base" > /dev/null 2>&1); then
+				echo >&2 "Configuration mergetool.$1.cmd \"$merge_tool_cmd_base\" not found"
+				exit 1
+			else
+				merge_cmd="$merge_tool_path/$merge_tool_cmd"
+			fi
+		# mergetool.<tool>.path is a path
+		elif test -d "$merge_tool_path"; then
+			# mergetool.<tool>.cmd not found
+			if !test -f "$merge_tool_path/$merge_tool_cmd_base"; then
+				echo >&2 "Configuration mergetool.$1.cmd \"$(echo "$merge_tool_path/$merge_tool_cmd_base" | sed 's#//\+#/#')\" not found"
+				exit 1
+			# mergetool.<tool>.cmd not executable
+			elif !test -x "$merge_tool_path/$merge_tool_cmd_base"; then
+				echo >&2 "Configuration mergetool.$1.cmd \"$(echo "$merge_tool_path/$merge_tool_cmd_base" | sed 's#//\+#/#')\" is not executable"
+				exit 1
+			# tool ok
+			else
+				merge_cmd="$merge_tool_path/$merge_tool_cmd"
+			fi
+		# mergetool.<tool>.path is the same as mergetool.<tool>.cmd
+		elif test "$merge_tool_path" = "$merge_tool_cmd_base"; then
+			# mergetool.<tool>.cmd not found
+			if ! $(which "$merge_tool_cmd_base" > /dev/null 2>&1); then
+				echo >&2 "Configuration mergetool.$1.cmd \"$merge_tool_cmd_base\" not found"
+				exit 1
+			else
+				merge_cmd="$merge_tool_cmd"
+			fi
+		# mergetool.<tool>.path is the tool itself
+		elif $(which "$merge_tool_path" > /dev/null 2>&1); then
+			merge_cmd="$merge_tool_path $merge_tool_cmd"
+		# mergetool.<tool>.path invalid
+		else
+			echo >&2 "Configuration mergetool.$1.path \"$merge_tool_path\" is not valid path"
+			exit 1
+		fi
+
+		# trust exit code
+		trust_exit_code="$(git config --bool mergetool."$1".trustExitCode || echo false)"
+
+		if test "$trust_exit_code" = "false"; then
+			touch "$BACKUP"
+			(eval "$merge_cmd")
+			check_unchanged
+			return $status
+		else
+			(eval "$merge_cmd")
+			status=$?
+			return $status
+		fi
+	fi
+
 	case "$1" in
 	kdiff3)
 		if merge_mode; then
-- 
1.7.1
