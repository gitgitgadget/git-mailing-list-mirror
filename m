From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v3] blame: CRLF in the working tree and LF in the repo
Date: Fri, 01 May 2015 13:02:47 +0200
Message-ID: <55435D57.8060906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, johannes.schindelin@gmx.de, kasal@ucw.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 13:02:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yo8if-0003xr-Hz
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 13:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbbEALCx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 07:02:53 -0400
Received: from mout.web.de ([212.227.15.14]:60664 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712AbbEALCw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 07:02:52 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LaCmk-1ZZ33v24FC-00lzvo; Fri, 01 May 2015 13:02:49
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:HpqpUrzjffmqThKVpiyn1gU7YWEuq4hke4pFhzt9zx11mkLjIfn
 w6pY3miL05fOKiLL19bwGOa/AipeOWlOpJYrqmxMuRWlUETqWdK98JQfQtRMZAQRi8tFVd/
 UsD18xHscSaCd4GETI4YgR1a9BYfPoGY6AStMDcJsAbQsT3fIFEpnSSx/e3Sg0owDyYRrGV
 lG+od+45fw22H4pvLrrcQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268113>

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
Added test cases again.
Since we have test files with only one line, grep should be OK
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
index 32895e5..244959a 100755
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
+test_expect_success 'blaming files with CRLF attributes text' '
+	git config core.autocrlf false &&
+	echo "crlffile text" >.gitattributes &&
+	git blame crlffile >actual &&
 	grep "A U Thor" actual
 '
=20
--=20
2.2.0.rc1.790.ge19fcd2
