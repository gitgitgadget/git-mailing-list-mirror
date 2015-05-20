From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 00:42:02 -0700
Message-ID: <1432107722-98613-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 09:42:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuydn-0003Na-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 09:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbbETHmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 03:42:07 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36343 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbETHmF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 03:42:05 -0400
Received: by pdfh10 with SMTP id h10so58933975pdf.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Xry/ZztqOLiyYYBDYppgTNndIJMojHUnH2+bwfQSib8=;
        b=y6ZR3ZPUxKIBMiND/oRQnl3EAssMX/n+rh/Jm4jH6LHAxF11ZRZf7dslPrKJGQaIn0
         xo/NySuk91z8mYQUvoF5SfCFI/d4dB3SxVg8e/wH1KyZ9acFRAgc6L50Pj/jbvo+/wFd
         wFTByicKFSX6alc6rernB82R+ekEL4hOBkE2ZQDn7URYeC5bYdE3INMbjCAuriIn5VyI
         uSM0C8JPApW5Cf+Ns6N17bqUU4JGu0r2n8MwM+WfUPzaTMRxAwfnGY57A51epdO3vJd8
         qwNbeR669rQB23/7OmV7V8OAwltkCMXMzcv0IHmgUajZosu1QZEUZ3LVLFkiOfSqgPf/
         DZeA==
X-Received: by 10.66.119.239 with SMTP id kx15mr41825308pab.156.1432107724560;
        Wed, 20 May 2015 00:42:04 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id qz3sm15236349pab.19.2015.05.20.00.42.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 00:42:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.218.gc09a0e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269447>

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
Changes since v3:

* "type -p" is used instead of "type".
* printf is consistently used instead of echo.
* an env | grep pipeline is used to get the variables instead of hard-c=
oding
  a set of variables in the script, as suggested by Sebastian in
  http://thread.gmane.org/gmane.comp.version-control.git/269437/focus=3D=
269441

 mergetools/winmerge | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 mergetools/winmerge

diff --git a/mergetools/winmerge b/mergetools/winmerge
new file mode 100644
index 0000000..fc364c769
--- /dev/null
+++ b/mergetools/winmerge
@@ -0,0 +1,45 @@
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
+	if type -p WinMergeU.exe >/dev/null 2>&1
+	then
+		printf WinMergeU.exe
+		return
+	fi
+
+	# Look for WinMergeU.exe in the typical locations
+	winmerge_exe=3D"WinMerge/WinMergeU.exe"
+	found=3Dfalse
+	OIFS=3D$IFS
+	IFS=3D'
+'
+	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=3D=
' |
+		cut -d '=3D' -f 2- | sort -u)
+	do
+		if test -n "$directory" && test -x "$directory/$winmerge_exe"
+		then
+			found=3Dtrue
+			printf '%s' "$directory/$winmerge_exe"
+			break
+		fi
+	done
+	IFS=3D$OIFS
+
+	if test "$found" !=3D true
+	then
+		printf WinMergeU.exe
+	fi
+}
--=20
2.4.1.218.gc09a0e5
