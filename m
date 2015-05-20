From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 02:07:23 -0700
Message-ID: <1432112843-973-2-git-send-email-davvid@gmail.com>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 11:07:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuzyV-0002wQ-Ej
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 11:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbbETJHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 05:07:33 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36060 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbbETJH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 05:07:26 -0400
Received: by pdfh10 with SMTP id h10so61527000pdf.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jyMdITwQp/YJ9jGSjV/N42CAI8cZ7imsCiVzCp62nLc=;
        b=urnAU2LAOBLLaR24nx7RbKWVPYAfOKczV9w1opKKTWro4k/7YZMF9n+6qsFq9uzv1C
         dpDiM1v5OoLD9KeBu81LHJeVS0nQbKPM3M/Fc2tvayua16aNWJcRIT/t6PYRy0lLlKB4
         6ukeNmIc9WZLEG8l/1TtnsbnqNIz94ooErJaL3+1I1VYd01JgOfbM3VlASshVC2hrJAs
         BBbc8Cr1oThWEHRzpL34MJwJR1sdhwKPFAblYy/PE3y8+U33I08itK9WzHtjh2ZmoZhS
         Qo6/UsSDZranFPZXhSSlNQmygzkk26duFZaqwLwhnECkH4n7UHHr1M+J/RaPwAWo3w4X
         5pvg==
X-Received: by 10.68.224.10 with SMTP id qy10mr63033556pbc.23.1432112846289;
        Wed, 20 May 2015 02:07:26 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id kr9sm15524314pab.30.2015.05.20.02.07.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 02:07:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.218.gc09a0e5
In-Reply-To: <1432112843-973-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269457>

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
Unchanged since v5.
Changes since v4: IFS is left as-is since it's done in 1/2

 mergetools/winmerge | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 mergetools/winmerge

diff --git a/mergetools/winmerge b/mergetools/winmerge
new file mode 100644
index 0000000..74a66d4
--- /dev/null
+++ b/mergetools/winmerge
@@ -0,0 +1,36 @@
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
+	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=3D=
' |
+		cut -d '=3D' -f 2- | sort -u)
+	do
+		if test -n "$directory" && test -x "$directory/$winmerge_exe"
+		then
+			printf '%s' "$directory/$winmerge_exe"
+			return
+		fi
+	done
+
+	printf WinMergeU.exe
+}
--=20
2.4.1.218.gc09a0e5
