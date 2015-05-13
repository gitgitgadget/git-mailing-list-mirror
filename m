From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Tue, 12 May 2015 19:00:07 -0700
Message-ID: <1431482407-63642-1-git-send-email-davvid@gmail.com>
Cc: Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Phil Susi <phillsusi@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 04:00:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsLyC-0004Hz-4G
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 04:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbbEMCAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 22:00:19 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34797 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964909AbbEMCAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 22:00:18 -0400
Received: by pacyx8 with SMTP id yx8so33681847pac.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 19:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=E8ONzNqYaS32R6ss74yEj4VKR+Lt2c3FFdifEDfX0IA=;
        b=HoDXFFcS7/ZocfeH/zgtqysZkLKBzFAT6xSO2Sv2NnyabAFukCvXWZHpeL++sqKDsM
         qFCRsKkzXcK9cVJUg4brZeT02SfAzQ+4iH9mmvhXfCbaeXoRn4zf4EV0asmc+TzYO6yE
         lX3NUYfx9htKqfrbPIX2qrQybx6ae+EXRZ8JWh14LHD4iY3xwfVktBuPN5nFzbl15ROd
         aZThnXr9USFdRAIN+zO45hz8wBoEBSr43u/HlhYX4xkth1bN2Rjnk4gskip1LzrQWe4K
         g8DVPGanw8DTWtHjD3T5gfviC9HUUdRDURSmfgcO2GsEUC6WB/678ezMZMw5PqVIT6IB
         KUgg==
X-Received: by 10.68.112.195 with SMTP id is3mr33356850pbb.92.1431482415561;
        Tue, 12 May 2015 19:00:15 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-243-232-52.socal.res.rr.com. [23.243.232.52])
        by mx.google.com with ESMTPSA id pr5sm17458244pbc.63.2015.05.12.19.00.13
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 19:00:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268917>

Add a winmerge scriptlet with the commands described in [1] so
that users can use winmerge without needing to perform any
additional configuration.

[1] http://thread.gmane.org/gmane.comp.version-control.git/268631

Helped-by: Philip Oakley <philipoakley@iee.org>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
---

Changes since v1: we now honor the $ProgramW6432 environment variable.

 mergetools/winmerge | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 mergetools/winmerge

diff --git a/mergetools/winmerge b/mergetools/winmerge
new file mode 100644
index 0000000..db0b060
--- /dev/null
+++ b/mergetools/winmerge
@@ -0,0 +1,40 @@
+diff_cmd () {
+	"$merge_tool_path" -u -e "$LOCAL" "$REMOTE"
+	return 0
+}
+
+merge_cmd () {
+	# mergetool.winmerge.trustExitCode is implicitly false.
+	# touch $BACKUP so that we can check_unchanged.
+	touch "$BACKUP"
+	"$merge_tool_path" -u -e -dl Local -dr Remote \
+		"$LOCAL" "$REMOTE" "$MERGED"
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	# Use WinMergeU.exe if it exists in $PATH
+	if type WinMergeU.exe >/dev/null 2>&1
+	then
+		echo WinMergeU.exe
+		return
+	fi
+
+	# Look for WinMergeU.exe in the typical locations
+	winmerge_exe="WinMerge/WinMergeU.exe"
+	if test -n "$ProgramW6432" && test -x "$ProgramW6432/$winmerge_exe"
+	then
+		printf '%s' "$ProgramW6432/$winmerge_exe"
+	elif test -n "$PROGRAMFILES" && test -x "$PROGRAMFILES/$winmerge_exe"
+	then
+		printf '%s' "$PROGRAMFILES/$winmerge_exe"
+	elif test -x "/c/Program Files (x86)/$winmerge_exe"
+	then
+		printf '%s' "/c/Program Files (x86)/$winmerge_exe"
+	elif test -x "/c/Program Files/$winmerge_exe"
+	then
+		printf '%s' "/c/Program Files/$winmerge_exe"
+	else
+		echo WinMergeU.exe
+	fi
+}
-- 
1.8.5.3
