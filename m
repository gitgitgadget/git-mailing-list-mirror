From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetools: add winmerge as a builtin tool
Date: Tue, 12 May 2015 02:29:37 -0700
Message-ID: <1431422977-61243-1-git-send-email-davvid@gmail.com>
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Phil Susi <phillsusi@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 11:29:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys6Va-0002g1-1h
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 11:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbbELJ3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 05:29:42 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35477 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbbELJ3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 05:29:38 -0400
Received: by pabtp1 with SMTP id tp1so2168816pab.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1QWvQRug4NXVe7ETuDv9L90sFe5MGAFeRspQYhP/l/4=;
        b=gKp4vs3Fp6QgWCfEvtuOtaKiRY91Sq2vF3c7AdAO8zSIy2fY3LceMQhZZ+f5ggr2aU
         W47j1WzmhsuoV5IfAE9XqPAhpIvBaXsXGC8dBnVgQ18d1YQm1oms+nKai1XlWsl8dh9l
         oqoWtgpz9mGN5cq1ZfhCreSpeJQ0vjWMqGTYU3GCHwYkJmKLpTvtlASySLnHpEhM1Ds1
         K8qeMeYwu3yi1IjMzd9qiPxKDIWRl8DKX/KmEnfuTvhElBbpKTgaMLxlaDkBp2Qqtehv
         8XeDT52A6ERbtPMgcg638nja3FwZ5tWrSvrKtjtDbFPZvyD6B2W47p8sx0lJvux+s7j1
         PI5w==
X-Received: by 10.68.167.66 with SMTP id zm2mr26694042pbb.164.1431422978121;
        Tue, 12 May 2015 02:29:38 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id fh9sm15600414pdb.17.2015.05.12.02.29.36
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 02:29:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.194.gc518059
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268850>

Add a winmerge scriptlet with the commands described in [1] so
that users can use winmerge without needing to perform any
additional configuration.

[1] http://thread.gmane.org/gmane.comp.version-control.git/268631

Helped-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---

Phil and Philip, can either of you test this patch in your environment
so that we can add a Tested-by footer above?

 mergetools/winmerge | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 mergetools/winmerge

diff --git a/mergetools/winmerge b/mergetools/winmerge
new file mode 100644
index 0000000..c3d13b1
--- /dev/null
+++ b/mergetools/winmerge
@@ -0,0 +1,37 @@
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
+	if test -n "$PROGRAMFILES" && test -x "$PROGRAMFILES/$winmerge_exe"
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
2.4.0.194.gc518059
