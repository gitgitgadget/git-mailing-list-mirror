From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v4] blame: CRLF in the working tree and LF in the repo
Date: Fri, 01 May 2015 13:49:38 +0200
Message-ID: <55436852.3030002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, johannes.schindelin@gmx.de, kasal@ucw.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 13:49:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yo9S2-0006aO-Jh
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 13:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbbEALtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 07:49:45 -0400
Received: from mout.web.de ([212.227.17.11]:52682 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbbEALto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 07:49:44 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LjJPH-1ZPxdq0vJH-00dTaR; Fri, 01 May 2015 13:49:41
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:Z7ZA5AVUPeMpD3/i2GuQHKdrNvOPZFI2UvJXTr+g22k0O04BQdS
 IkUpuhx/91GS4d9xLVlYbP87IkAQVzPHwK0rZC+zZ2WkabTJjPH0QvD/muG3Pe5SS1Ig8K6
 azTouG8Y3obgv9BnuqICggoM/1i78ChmW+REvjTezmbgyUzB6M+JPGSfGB+aeHhG8jgSEGw
 vz7foHvxH5bSUdOoeRRLw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268115>

A typical setup under Windows:
core.eol is CRLF and a file is marked as "text" in .gitattributes,
or core.autocrlf is true

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
Changes since V3:
 more test cases
 Sorry for the spam

builtin/blame.c               |  1 +
 t/t8003-blame-corner-cases.sh | 48 +++++++++++++++++++++++++++++++++++=
++------
 2 files changed, 43 insertions(+), 6 deletions(-)

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
index 32895e5..8af36a6 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -191,13 +191,49 @@ test_expect_success 'indent of line numbers, ten =
lines' '
 	test $(grep -c "  " actual) =3D 9
 '
=20
-test_expect_success 'blaming files with CRLF newlines' '
-	git config core.autocrlf false &&
+test_expect_success 'setup crlf files' '
 	printf "testcase\r\n" >crlffile &&
-	git add crlffile &&
-	git commit -m testcase &&
-	git -c core.autocrlf=3Dinput blame crlffile >actual &&
-	grep "A U Thor" actual
+	printf "testcase\n" >lffile &&
+	git -c core.autocrlf=3Dfalse add lffile crlffile &&
+	git commit -m "add files" &&
+	git -c core.autocrlf=3Dfalse blame HEAD -- crlffile >crlfclean.txt
+	printf "testcase\r\n" >crlffile &&
+	git -c core.autocrlf=3Dfalse blame HEAD -- lffile >lfclean.txt
+	printf "testcase\r\n" >lffile
+	#Keep lffile with CRLF in worktree
+'
+
+test_expect_success 'blame file with CRLF in repo core.autocrlf=3Dfals=
e' '
+	git -c core.autocrlf=3Dfalse blame crlffile >crlf_repo_false &&
+	test_cmp crlfclean.txt crlf_repo_false
+'
+
+#has_cr_in_index() should suppress the normalization, see convert.c
+#but read_blob_data_from_cache() returns NULL
+test_expect_failure 'blame file with CRLF in repo core.autocrlf=3Dtrue=
' '
+	git -c core.autocrlf=3Dtrue blame crlffile >crlf_repo_true &&
+	test_cmp crlfclean.txt crlf_repo_true
+'
+
+test_expect_success 'blame file with CRLF in WS core.autocrlf=3Dtrue' =
'
+	git -c core.autocrlf=3Dtrue blame lffile >lf_repo_true &&
+	test_cmp lfclean.txt lf_repo_true
+'
+
+test_expect_success 'blame file with CRLF in WS core.autocrlf=3Dinput'=
 '
+	git -c core.autocrlf=3Dinput blame lffile >lf_repo_input &&
+	test_cmp lfclean.txt lf_repo_input
+'
+
+test_expect_success 'blame file with CRLF in WS core.autocrlf=3Dfalse'=
 '
+	git -c core.autocrlf=3Dfalse blame lffile >lf_repo_false &&
+	grep "Not Committed Yet" lf_repo_false
+'
+
+test_expect_success 'blame file with CRLF in WS core.autocrlf=3Dfalse =
attributes' '
+	printf "lffile text\r\n" >.gitattributes &&
+	git -c core.autocrlf=3Dfalse blame lffile >lf_repo_attr_text &&
+	test_cmp lfclean.txt lf_repo_attr_text
 '
=20
 test_done
--=20
2.2.0.rc1.790.ge19fcd2
