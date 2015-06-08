From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] commit: cope with scissors lines in commit message
Date: Mon,  8 Jun 2015 03:40:39 +0200
Message-ID: <1433727639-5927-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 03:41:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1m3l-0001x9-DN
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 03:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbbFHBlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2015 21:41:00 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:55004 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762AbbFHBk6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2015 21:40:58 -0400
Received: from x590e3f67.dyn.telefonica.de ([89.14.63.103] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1Z1m3Z-0003Pu-5M; Mon, 08 Jun 2015 03:40:54 +0200
X-Mailer: git-send-email 2.4.3.384.g605df7b
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1433727654.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270988>

The diff and submodule shortlog appended to the commit message template
by 'git commit --verbose' are not stripped when the commit message
contains an indented scissors line.

When cleaning up a commit message with 'git commit --verbose' or
'--cleanup=3Dscissors' the code is careful and triggers only on a pure
scissors line, i.e. a line containing nothing but a comment character, =
a
space, and the scissors cut.  This is good, because people can embed
scissor lines in the commit message while using 'git commit --verbose',
and the text they write after their indented scissors line doesn't get
deleted.

While doing so, however, the cleanup function only looks at the first
line matching the scissors pattern and if it doesn't start at the
beginning of the line, then the function just returns without performin=
g
any cleanup.  This is bad, because a "real" scissors line added by 'git
commit --verbose' might follow, and in that case the diff and submodule
shortlog get included in the commit message.

Don't bail out if a scissors line doesn't start at the beginning of the
line, but keep looking for a non-indented scissors line to fix this.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t7502-commit.sh | 25 +++++++++++++++++++++++++
 wt-status.c       | 12 ++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 2e0d557243..77db3a31c3 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -239,6 +239,31 @@ EOF
=20
 '
=20
+test_expect_success 'cleanup commit messages (scissors option,-F,-e, s=
cissors line in commit message)' '
+	echo >>negative &&
+	cat >text <<EOF &&
+
+  # to be kept
+
+  # ------------------------ >8 ------------------------
+  # to be kept, too
+# ------------------------ >8 ------------------------
+to be removed
+# ------------------------ >8 ------------------------
+to be removed, too
+EOF
+
+	cat >expect <<EOF &&
+  # to be kept
+
+  # ------------------------ >8 ------------------------
+  # to be kept, too
+EOF
+	git commit --cleanup=3Dscissors -e -F text -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cleanup commit messages (strip option,-F)' '
=20
 	echo >>negative &&
diff --git a/wt-status.c b/wt-status.c
index c56c78fb6f..e6d171a0cb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -822,13 +822,17 @@ conclude:
=20
 void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
 {
-	const char *p;
+	const char *p =3D buf->buf;
 	struct strbuf pattern =3D STRBUF_INIT;
=20
 	strbuf_addf(&pattern, "%c %s", comment_line_char, cut_line);
-	p =3D strstr(buf->buf, pattern.buf);
-	if (p && (p =3D=3D buf->buf || p[-1] =3D=3D '\n'))
-		strbuf_setlen(buf, p - buf->buf);
+	while ((p =3D strstr(p, pattern.buf))) {
+		if (p =3D=3D buf->buf || p[-1] =3D=3D '\n') {
+			strbuf_setlen(buf, p - buf->buf);
+			break;
+		}
+		p++;
+	}
 	strbuf_release(&pattern);
 }
=20
--=20
2.4.2.423.gad3a03f
