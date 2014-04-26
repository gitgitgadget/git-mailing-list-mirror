From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] blame: correctly handle files regardless of autocrlf.
Date: Sat, 26 Apr 2014 23:10:40 +0000
Message-ID: <1398553840-279066-1-git-send-email-sandals@crustytoothpaste.net>
References: <20140425150726.GA234593@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ephrim Khong <dr.khong@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 01:11:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeBkx-0006ST-QA
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 01:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbaDZXK5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 19:10:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47353 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751716AbaDZXK4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2014 19:10:56 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 41F0128087;
	Sat, 26 Apr 2014 23:10:55 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <20140425150726.GA234593@vauxhall.crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247187>

If a file contained CRLF line endings in a repository with
core.autocrlf=3Dinput, then blame always marked lines as "Not Committed=
 Yet",
even if they were unmodified.  Don't attempt to convert the line ending=
s
when creating the fake commit so that blame works correctly regardless =
of
the autocrlf setting.

Reported-by: Ephrim Khong <dr.khong@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
> On Tue, Apr 22, 2014 at 04:12:42PM -0700, Junio C Hamano wrote:
> >  I have a feeling that a fix for this should be fairly isolated and
> >  trivial (it should be just the matter of paying attention to the
> >  crlf settings when synthesizing the fake commit)---perhaps somebod=
y
> >  can squash in a fix to this?
>
> Last time I looked at this, I couldn't come up with an obvious fix fo=
r
> the problem, or I would have included one.  I'll try to have another =
go
> at it this weekend.

This was actually a very helpful hint, Junio.  Thanks for the push in
the right direction.

This includes the suggestion by Torsten B=C3=B6gershausen to use the gi=
t -c
for the blame command.

 builtin/blame.c               | 1 -
 t/t8003-blame-corner-cases.sh | 9 +++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 88cb799..eef3e86 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2088,7 +2088,6 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases=
=2Esh
index e7cac1d..2a3469b 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -191,4 +191,13 @@ test_expect_success 'indent of line numbers, ten l=
ines' '
 	test $(grep -c "  " actual) =3D 9
 '
=20
+test_expect_success 'blaming files with CRLF newlines' '
+	git config core.autocrlf false &&
+	printf "testcase\r\n" >crlffile &&
+	git add crlffile &&
+	git commit -m testcase &&
+	git -c core.autocrlf=3Dinput blame crlffile >actual &&
+	grep "A U Thor" actual
+'
+
 test_done
--=20
2.0.0.rc0
