From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] mergetool--lib: don't call "exit" in setup_tool
Date: Sat, 26 Jan 2013 16:40:06 -0800
Message-ID: <1359247207-71819-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 01:40:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzGIf-0004cl-Js
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 01:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171Ab3A0AkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 19:40:23 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:39357 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976Ab3A0AkW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 19:40:22 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so2580029iak.10
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 16:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=kS1Mfgp+LFSQujighUV7s+Iget1iPftm8kd4aSEUuiY=;
        b=Pi4rMjBtnNVAbjBy8yWopxeO8uex8cdacJPuml3jwXxQFHBfjVXRspluBOfoy3uD8B
         pBFqvibG2VTaquaKG5F+P3hb3CWv6tPFCi24aNYzowbtKFWVaAHvqJzH93tCe5jNCd5J
         021lkCk9btSCw9ocAX5bLYW/lOyHhsiWRBMYAGWqDDVmwFzzZoUp7NZy1p3soE/CNdhS
         CHVHWJMAJC7J+oiJoNq0DUKz9oAC31pszA1JSIrDtDvhcV23Dxjrm4MKU1k+4Jup3U2E
         hfeAwn120CfQCgOQOCOtkKIJkWsSRSIIFdK4TbGgtKDDIfaGJmZs87D0Bo35gj3baYrF
         kDWA==
X-Received: by 10.50.1.201 with SMTP id 9mr1945075igo.80.1359247222046;
        Sat, 26 Jan 2013 16:40:22 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id c3sm2781564igj.1.2013.01.26.16.40.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 26 Jan 2013 16:40:20 -0800 (PST)
X-Mailer: git-send-email 1.8.0.8.g9bc9422
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214645>

From: John Keeping <john@keeping.me.uk>

This will make it easier to use setup_tool in places where we expect
that the selected tool will not support the current mode.

We need to introduce a new return code for setup_tool to differentiate
between the case of "the selected tool is invalid" and "the selected
tool is not a built-in" since we must call setup_tool when a custom
'merge.<tool>.path' is configured for a built-in tool but avoid failing
when the configured tool is not a built-in.

Signed-off-by: John Keeping <john@keeping.me.uk>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This series is based on jk/mergetool in "pu".
This patch is unchanged from $gmane/214624.

 git-mergetool--lib.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index aa38bd1..f1bb372 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -58,7 +58,11 @@ setup_tool () {
 	. "$mergetools/defaults"
 	if ! test -f "$mergetools/$tool"
 	then
-		return 1
+		# Use a special return code for this case since we want to
+		# source "defaults" even when an explicit tool path is
+		# configured since the user can use that to override the
+		# default path in the scriptlet.
+		return 2
 	fi
 
 	# Load the redefined functions
@@ -67,11 +71,11 @@ setup_tool () {
 	if merge_mode && ! can_merge
 	then
 		echo "error: '$tool' can not be used to resolve merges" >&2
-		exit 1
+		return 1
 	elif diff_mode && ! can_diff
 	then
 		echo "error: '$tool' can only be used to resolve merges" >&2
-		exit 1
+		return 1
 	fi
 	return 0
 }
@@ -101,6 +105,19 @@ run_merge_tool () {
 
 	# Bring tool-specific functions into scope
 	setup_tool "$1"
+	exitcode=$?
+	case $exitcode in
+	0)
+		:
+		;;
+	2)
+		# The configured tool is not a built-in tool.
+		test -n "$merge_tool_path" || return 1
+		;;
+	*)
+		return $exitcode
+		;;
+	esac
 
 	if merge_mode
 	then
-- 
1.8.0.8.g9bc9422
