From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3] mergetools: add winmerge as a builtin tool
Date: Tue, 19 May 2015 21:20:35 -0700
Message-ID: <1432095635-96710-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 06:20:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuvUq-0001cY-I9
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 06:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbbETEUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 00:20:39 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34158 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbbETEUi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 00:20:38 -0400
Received: by pabru16 with SMTP id ru16so51870761pab.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 21:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=WB0cFQlk1Qa1FoupOCvqvtB3b2+lnnx3GziC80LC9vw=;
        b=sU6xJbY8rzvzgyRibeOunk6TJ6dJRjY/BkhNFZwnvIxInAt7j39ol1Nl8PlJyjcT1c
         oki+cHrFUV9baBS1qy03SgpvB7GzChmAaH19KPAw3S+tNX862NyOYKqBRosd4KhJ7hJ9
         VVc04b+NyZZWPoRnzz0+pOBYitcNsMCPiunbcjcn+T1Ba/HBZcRBR3YLG0k9yjc4cdq5
         JlGvTbb/Vt/U9cbqdmI5qYNKEFm7qpR96ibIJJxvlR8HGithstoDqMdjGeGrPQ08b624
         tGFb05iaBBSn9ZM3GaySt9gS4Kt8tgwex0QGZWl5jwt1yow1/bpw9selh2sft0/TLqvv
         185Q==
X-Received: by 10.68.222.167 with SMTP id qn7mr59479727pbc.136.1432095638025;
        Tue, 19 May 2015 21:20:38 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id sl9sm14632484pac.41.2015.05.19.21.20.36
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 21:20:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.218.g416b006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269437>

Add a winmerge scriptlet with the commands described in [1] so
that users can use winmerge without needing to perform any
additional configuration.

[1] http://thread.gmane.org/gmane.comp.version-control.git/268631

Helped-by: Philip Oakley <philipoakley@iee.org>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Sebastian Schuberth <sschuberth@gmail.com>
Helped-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v2: We now use "$PROGRAMFILES" exclusively
and let the shell concatenate the " (x86)" part when testing
filesystem paths.  The C:/... hard-coded fallbacks have been
removed since $PROGRAMFILES should exist in practice.

 mergetools/winmerge | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 mergetools/winmerge

diff --git a/mergetools/winmerge b/mergetools/winmerge
new file mode 100644
index 0000000..435623c
--- /dev/null
+++ b/mergetools/winmerge
@@ -0,0 +1,35 @@
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
+	winmerge_exe=3D"WinMerge/WinMergeU.exe"
+
+	if test -n "$PROGRAMFILES" && test -x "$PROGRAMFILES (x86)/$winmerge_=
exe"
+	then
+		printf '%s' "$PROGRAMFILES (x86)/$winmerge_exe"
+	elif test -n "$PROGRAMFILES" && test -x "$PROGRAMFILES/$winmerge_exe"
+	then
+		printf '%s' "$PROGRAMFILES/$winmerge_exe"
+	else
+		echo WinMergeU.exe
+	fi
+}
--=20
2.4.1.218.g416b006
