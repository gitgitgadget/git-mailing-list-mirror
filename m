From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] commit: fix too generous RFC-2822 footer handling
Date: Wed,  4 Nov 2009 04:09:06 +0100
Message-ID: <1257304146-15543-1-git-send-email-szeder@ira.uka.de>
References: <20091103165951.GA2241@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 04:11:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5WGw-0006oe-Gx
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 04:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbZKDDJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 22:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbZKDDJo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 22:09:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:51201 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbZKDDJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 22:09:43 -0500
Received: from [127.0.1.1] (p5B1312A0.dip0.t-ipconnect.de [91.19.18.160])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LodLS-1MUWo80hvW-00gO7f; Wed, 04 Nov 2009 04:09:35 +0100
X-Mailer: git-send-email 1.6.5.2.201.g0f47
In-Reply-To: <20091103165951.GA2241@neumann>
X-Provags-ID: V01U2FsdGVkX19AIDZ+QRG+blcqNYFHP6ieC5y7zzYD7NLLLuN
 BYe2XrdfHdWeC1fpUB/Qpu3nNql2Amn/zL+US3GzWl9ZkMEnxJ
 plsZ4pRwMP7mon6wgTrjw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132029>

Since commit c1e01b0c (commit: More generous accepting of RFC-2822
footer lines, 2009-10-28) RFC-2822-looking lines at the end of the
message are considered part of the footer and 'git commit -s -m'
doesn't add a newline between that footer and the new S-O-B line.
This new behaviour causes problems with subject-only commit messages
which happens to look like an RFC-2822 header (e.g. 'git commit -s -m
"subsystem: coolest feature ever"').  In such cases there won't be any
newline between the subject and the S-O-B line, and the S-O-B line
will show up at places where it should not (e.g. in the output of 'git
shortlog').

With this patch the newline will be always added if a commit message
has only a single line, even if it looks like an RFC-2822 header.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

 Maybe something like this?  Be careful when reviewing, it's 4AM
 here...


 builtin-commit.c  |    8 ++++++++
 t/t7501-commit.sh |    4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index beddf01..4971156 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -429,6 +429,14 @@ static int ends_rfc2822_footer(struct strbuf *sb)
 		hit =3D (buf[i] =3D=3D '\n');
 	}
=20
+	for (j =3D i-1; j > 0; j--)
+		if (buf[j] =3D=3D '\n') {
+			hit =3D 1;
+			break;
+		}
+	if (!hit)	/* one-line message */
+		return 0;
+
 	while (i < len - 1 && buf[i] =3D=3D '\n')
 		i++;
=20
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d2de576..aaeedda 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -215,10 +215,10 @@ test_expect_success 'sign off (1)' '
=20
 	echo 1 >positive &&
 	git add positive &&
-	git commit -s -m "thank you" &&
+	git commit -s -m "subsystem: coolest feature ever" &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
-		echo thank you
+		echo subsystem: coolest feature ever
 		echo
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
--=20
1.6.5.2.201.g0f47
