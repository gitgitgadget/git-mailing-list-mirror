From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Sun, 26 Apr 2015 14:02:34 +0200
Message-ID: <553CD3DA.9090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de,
	"johannes.schindelin@gmx.de >> Johannes Schindelin" 
	<johannes.schindelin@gmx.de>, kasal@ucw.cz,
	sandals@crustytoothpaste.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 14:02:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmLH0-0005YM-Br
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 14:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbDZMCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2015 08:02:47 -0400
Received: from mout.web.de ([212.227.17.12]:65038 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbbDZMCq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 08:02:46 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MRlED-1YtBob0jZx-00Sxuh; Sun, 26 Apr 2015 14:02:36
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:sPNLDmrg1F2h1EGx+AD2NRZNhV7Rszb4datdQSFDCtEy+D0R+dE
 eIHqd8XmpakonwSacLIbHEoZ9ZDNefwDpmd8S4YMXK/A0NTL9vcZLiMIp1Fui+XqP2LjbKg
 wdRWZqByP1rldXAvi5eH7A24rtu7cdvdRTNSVeiHYyF938RrQM9jHGBYodMBkMfBkqlw9ip
 fLEFvAnqEew7ye1fqIQKQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267829>

A typicall setup under Windows:
core.eol is CRLF and a file is marked as "text" in .gitattributes.

After 4d4813a5 "git blame" no longer works as expected,
every line is annotated as "Not Committed Yet",
even though the working directory is clean.

commit 4d4813a5 removed the conversion in blame.c for all files,
with or without CRLF in the repo.

Having files with CRLF in the repo and core.autocrlf=3Dinput is a tempo=
rary
situation, the files should be normalized in the repo.
Blaming them with "Not Committed Yet" is OK.

The solution is to revert commit 4d4813a5.

Reported-By: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Reference:
https://github.com/git-for-windows/git/issues/105
Although the intention of 4d4813a5 is good, it breaks
the usual EOL-handling for Windows.
Until we have a better solution, we suggest to revert it.

 builtin/blame.c               |  1 +
 t/t8003-blame-corner-cases.sh | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 06484c2..8d70623 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2348,6 +2348,7 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
+	convert_to_git(path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases=
=2Esh
index 32895e5..dcc9827 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -191,7 +191,7 @@ test_expect_success 'indent of line numbers, ten li=
nes' '
 	test $(grep -c "  " actual) =3D 9
 '
=20
-test_expect_success 'blaming files with CRLF newlines' '
+test_expect_failure 'blaming files with CRLF newlines in repo, core.au=
toclrf=3Dinput' '
 	git config core.autocrlf false &&
 	printf "testcase\r\n" >crlffile &&
 	git add crlffile &&
@@ -199,5 +199,29 @@ test_expect_success 'blaming files with CRLF newli=
nes' '
 	git -c core.autocrlf=3Dinput blame crlffile >actual &&
 	grep "A U Thor" actual
 '
+test_expect_success 'blaming files with CRLF newlines core.autocrlf=3D=
true' '
+	test_create_repo blamerepo &&
+	(
+		cd blamerepo &&
+		git config core.autocrlf true &&
+		printf "testcase\r\n" >crlffile &&
+		git add crlffile &&
+		git commit -m TRUE &&
+		git blame crlffile >actual &&
+		grep "A U Thor" actual
+	)
+'
+
+test_expect_success 'blaming files with CRLF newlines core.autocrlf=3D=
false' '
+	(
+		cd blamerepo &&
+		git config core.autocrlf false &&
+		printf ".gitattributes text\r\n" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -m FALSE &&
+		git blame .gitattributes >actual &&
+		grep "A U Thor" actual
+	)
+'
=20
 test_done
--=20
2.2.0.rc1.790.ge19fcd2
