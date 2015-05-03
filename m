From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v5] blame: CRLF in the working tree and LF in the repo
Date: Sun, 03 May 2015 18:38:01 +0200
Message-ID: <55464EE9.3090201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, johannes.schindelin@gmx.de, kasal@ucw.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 18:38:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YowuO-00073z-8z
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 18:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbbECQiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2015 12:38:10 -0400
Received: from mout.web.de ([212.227.15.4]:57474 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbbECQiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 12:38:08 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LbZpT-1ZZ25B3W9L-00lAWm; Sun, 03 May 2015 18:38:03
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:NLrpunVRZFV2Wziuwn5q0csfrL9/EFtYpHAKR7PKKbwStntB1w+
 NrvnqN6lTY9QLaz+LjukJMIzdlzSLA6RKc1yvnjsQjFZymfjAiINRACvI5PqdBmFZ/x7Llb
 uI75kUqNPt/NBXv3Bi8VQxNoM/vOuFFnvPP9sSuuRq0o6E8yH+LJYcgdICL5ktyJmBEV6j/
 eH+sCmusYz+F1CxSFlsZA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268269>

A typical setup under Windows is to set core.eol to CRLF, and text
files are marked as "text" in .gitattributes, or core.autocrlf is
set to true.

After 4d4813a5 "git blame" no longer works as expected for such a
set-up.  Every line is annotated as "Not Committed Yet", even though
the working directory is clean.  This is because the commit removed
the conversion in blame.c for all files, with or without CRLF in the
repo.

Having files with CRLF in the repo and core.autocrlf=3Dinput is a
temporary situation, and the files, if committed as is, will be
normalized in the repo, which _will_ be a notable change.  Blaming
them with "Not Committed Yet" is the right result.  Revert commit
4d4813a5 which was a misguided attempt to "solve" a non-problem.

Add two test cases in t8003 to verify the correct CRLF conversion.

Suggested-By: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes against pu:
- fixed typo typical
- Add the 2 test cases suggested originally be Stepan,
  mention them in the commit msg and say
  "Suggested-By" instead of "Reported-By"
- This should be in line with Junios suggestion not to introduce
  additional (and somewhat unrelated) TC's

 builtin/blame.c               |  1 +
 t/t8003-blame-corner-cases.sh | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

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
index 32895e5..16f1442 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -191,12 +191,24 @@ test_expect_success 'indent of line numbers, ten =
lines' '
 	test $(grep -c "  " actual) =3D 9
 '
=20
-test_expect_success 'blaming files with CRLF newlines' '
+test_expect_success 'setup file with CRLF newlines' '
 	git config core.autocrlf false &&
-	printf "testcase\r\n" >crlffile &&
+	printf "testcase\n" >crlffile &&
 	git add crlffile &&
 	git commit -m testcase &&
-	git -c core.autocrlf=3Dinput blame crlffile >actual &&
+	printf "testcase\r\n" >crlffile
+'
+
+test_expect_success 'blame file with CRLF core.autocrlf true' '
+	git config core.autocrlf true &&
+	git blame crlffile >actual &&
+	grep "A U Thor" actual
+'
+
+test_expect_success 'blame file with CRLF attributes text' '
+	git config core.autocrlf false &&
+	echo "crlffile text" >.gitattributes &&
+	git blame crlffile >actual &&
 	grep "A U Thor" actual
 '
=20
--=20
2.2.0.rc1.790.ge19fcd2
