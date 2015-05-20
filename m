From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v5 2/2] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 02:02:42 -0700
Message-ID: <1432112562-400-2-git-send-email-davvid@gmail.com>
References: <1432112562-400-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 11:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuztv-0000t1-Le
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 11:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbbETJCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 05:02:51 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35922 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbbETJCq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 05:02:46 -0400
Received: by pdfh10 with SMTP id h10so61383370pdf.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MzB2w/ox3xNQRsrFnHdvOsrpnkuoBkb06rK6O1uGkAg=;
        b=BQTIQTRs+hpBzmKo6fjmDxggPtPziOEa4JbvXNrHVP+FnEYNlGIadqy/lU/lFfJCXu
         Dq5uaVtuPRy7vKYxHo1+9fFFBhcgtAlgSonfeY/Yx/6iEj4dfI6lHyBLHZDLxBKGmoiq
         L8k4EiJ2+MBC5WhmSZoAuc0d/a8SLmo3xFZVU7TAQ0nFKVAM5kY5En6wr52wfdxA+rL/
         qEawgk5ezjRSWRh94Yu6DjbcEhGDwvOJHfwE/D3cCjKwNKQaksB2fU4Z9g9LmX9Ndgiv
         vGR/WjdwMyax+c8M3ZFwY39iI66iCCqD9Cf+s8EyNXtk1SoS4vc1kJ5/U0ulJEr9ewzP
         Tgog==
X-Received: by 10.70.127.171 with SMTP id nh11mr61053266pdb.142.1432112566087;
        Wed, 20 May 2015 02:02:46 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id nm9sm4513219pdb.26.2015.05.20.02.02.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 02:02:45 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.218.gc09a0e5
In-Reply-To: <1432112562-400-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269452>

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
Changes since v4: we no longer need to worry about IFS since
it's already been set by patch 1/2.

 mergetools/winmerge | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 mergetools/winmerge

diff --git a/mergetools/winmerge b/mergetools/winmerge
new file mode 100644
index 0000000..3e9f908
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
