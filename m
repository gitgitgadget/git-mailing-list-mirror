From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2] blame: CRLF in the working tree and LF in the repo
Date: Thu, 30 Apr 2015 06:42:12 +0200
Message-ID: <5541B2A4.8050108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, johannes.schindelin@gmx.de, kasal@ucw.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 06:42:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YngIu-0006F2-6D
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 06:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbbD3EmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2015 00:42:24 -0400
Received: from mout.web.de ([212.227.15.4]:62085 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbbD3EmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 00:42:23 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MFtOY-1Z2TsK17Cw-00ErvG; Thu, 30 Apr 2015 06:42:18
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:5ZIuZ/IzskCORI4feGI7pLWoUhKYJTtccVSpbaHBQX93bV3qbRP
 +TjlcOC982eb2MS3VBd4pxB03qhn4y39A84Wz/Rnh/VBYNQvZD6ho8dPGckE1LDzMfdPCQr
 ZTD6wuxblp5x2sMjBhln1jGg1keN2HfWMxRckhzxg5DcQVdolcB3LemVz6vK1MkKNba/1uh
 nfa5F8+rUdCD0uZr7iFkQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268056>

A typicall setup under Windows:
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

What happened to the test cases ?
They where improved, but it turned out that they failed
from time to time, both Windows and Mac OS.
"Spicing them" with test_tick or other things didn't help,
if they are run in a tight loop.
running with "debug=3Dt verbose=3Dt ./t8003*.sh" make the test
pass.
My suggestion is to revert 4d4813a5 and drop TC's for the moment.
=20
 builtin/blame.c               | 1 +
 t/t8003-blame-corner-cases.sh | 9 ---------
 2 files changed, 1 insertion(+), 9 deletions(-)

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
index 32895e5..a073d36 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -191,13 +191,4 @@ test_expect_success 'indent of line numbers, ten l=
ines' '
 	test $(grep -c "  " actual) =3D 9
 '
=20
-test_expect_success 'blaming files with CRLF newlines' '
-	git config core.autocrlf false &&
-	printf "testcase\r\n" >crlffile &&
-	git add crlffile &&
-	git commit -m testcase &&
-	git -c core.autocrlf=3Dinput blame crlffile >actual &&
-	grep "A U Thor" actual
-'
-
 test_done
--=20
2.2.0.rc1.790.ge19fcd2
