From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v3] commit: cope with scissors lines in commit message
Date: Tue,  9 Jun 2015 02:28:34 +0200
Message-ID: <1433809714-10865-1-git-send-email-szeder@ira.uka.de>
References: <1433809461-9823-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 02:28:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z27PP-0002sm-KP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 02:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbbFIA2r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 20:28:47 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:38998 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752896AbbFIA2q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 20:28:46 -0400
Received: from x590e5e8c.dyn.telefonica.de ([89.14.94.140] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1Z27PG-0007qZ-9a; Tue, 09 Jun 2015 02:28:43 +0200
X-Mailer: git-send-email 2.4.3.384.g5790712
In-Reply-To: <1433809461-9823-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1433809723.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271145>

The diff and submodule shortlog appended to the commit message template
by 'git commit --verbose' are not stripped when the commit message
contains an indented scissors line.

When cleaning up a commit message with 'git commit --verbose' or
'--cleanup=3Dscissors' the code is careful and triggers only on a pure
scissors line, i.e. a line containing nothing but a comment character, =
a
space, and the scissors cut.  This is good, because people can embed
scissors lines in the commit message while using 'git commit --verbose'=
,
and the text they write after their indented scissors line doesn't get
deleted.

While doing so, however, the cleanup function only looks at the first
line matching the scissors pattern and if it doesn't start at the
beginning of the line, then the function just returns without performin=
g
any cleanup.  This is wrong, because a "real" scissors line added by
'git commit --verbose' might follow, and in that case the diff and
submodule shortlog get included in the commit message.

=46ix this by changing the scissors pattern to match only at the beginn=
ing
of the line, yet be careful to catch scissors on the first line as well=
=2E

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
=46ixed a typo in the commit message.
=20
 t/t7502-commit.sh | 24 +++++++++++++++++++++++-
 wt-status.c       |  9 +++++----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 2e0d557243..b39e313ac2 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -229,14 +229,36 @@ test_expect_success 'cleanup commit messages (sci=
ssors option,-F,-e)' '
 	cat >text <<EOF &&
=20
 # to be kept
+
+  # ------------------------ >8 ------------------------
+# to be kept, too
 # ------------------------ >8 ------------------------
 to be removed
+# ------------------------ >8 ------------------------
+to be removed, too
+EOF
+
+	cat >expect <<EOF &&
+# to be kept
+
+  # ------------------------ >8 ------------------------
+# to be kept, too
 EOF
-	echo "# to be kept" >expect &&
 	git commit --cleanup=3Dscissors -e -F text -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
 	test_cmp expect actual
+'
=20
+test_expect_success 'cleanup commit messages (scissors option,-F,-e, s=
cissors on first line)' '
+
+	echo >>negative &&
+	cat >text <<EOF &&
+# ------------------------ >8 ------------------------
+to be removed
+EOF
+	git commit --cleanup=3Dscissors -e -F text -a --allow-empty-message &=
&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	test_must_be_empty actual
 '
=20
 test_expect_success 'cleanup commit messages (strip option,-F)' '
diff --git a/wt-status.c b/wt-status.c
index c56c78fb6f..eaed4fed32 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -825,10 +825,11 @@ void wt_status_truncate_message_at_cut_line(struc=
t strbuf *buf)
 	const char *p;
 	struct strbuf pattern =3D STRBUF_INIT;
=20
-	strbuf_addf(&pattern, "%c %s", comment_line_char, cut_line);
-	p =3D strstr(buf->buf, pattern.buf);
-	if (p && (p =3D=3D buf->buf || p[-1] =3D=3D '\n'))
-		strbuf_setlen(buf, p - buf->buf);
+	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
+	if (starts_with(buf->buf, pattern.buf + 1))
+		strbuf_setlen(buf, 0);
+	else if ((p =3D strstr(buf->buf, pattern.buf)))
+		strbuf_setlen(buf, p - buf->buf + 1);
 	strbuf_release(&pattern);
 }
=20
--=20
2.4.3.384.g605df7b
