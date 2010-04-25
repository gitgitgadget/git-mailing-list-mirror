From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC v2 4/4] t/t0021: Test that conversion changes are detected.
Date: Sun, 25 Apr 2010 18:29:08 +0200
Message-ID: <2be6dfd1358e8eda4d2ebb9b8a763602b46b60d8.1272210580.git.grubba@grubba.org>
References: <cover.1272210580.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 18:29:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O64iA-0005ro-RI
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 18:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0DYQ3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 12:29:30 -0400
Received: from mail.roxen.com ([212.247.29.220]:56131 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab0DYQ32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 12:29:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 6F95D6282D8
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 18:29:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IHqJmHq8NXr8 for <git@vger.kernel.org>;
	Sun, 25 Apr 2010 18:29:27 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 53E5A628332
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 18:29:27 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3PGTRfu012727;
	Sun, 25 Apr 2010 18:29:27 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3PGTRk4012726;
	Sun, 25 Apr 2010 18:29:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1272210580.git.grubba@grubba.org>
In-Reply-To: <cover.1272210580.git.grubba@grubba.org>
References: <cover.1272210580.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145750>

Signed-off-by Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
Thanks to Junio C Hamano for some of the tests.

 t/t0021-conversion.sh |   50 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 6cb8d60..b6de203 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -89,4 +89,54 @@ test_expect_success expanded_in_repo '
 	cmp expanded-keywords expected-output
 '
=20
+# Check that files that have had their canonical representation
+# changed since being checked in aren't reported as modified
+# directly after being checked out.
+test_expect_success keywords_not_modified '
+	{
+		echo "File with foreign keywords"
+		echo "\$Id\$"
+		echo "\$Id: NoTerminatingSymbol"
+		echo "\$Id: Foreign Commit With Spaces \$"
+		echo "\$Id: GitCommitId \$"
+		echo "\$Id: NoTerminatingSymbolAtEOF"
+	} > expanded-keywords2 &&
+
+	git add expanded-keywords2 &&
+	git commit -m "File with keywords expanded" &&
+
+	echo "expanded-keywords2 ident" >> .gitattributes &&
+
+	rm -f expanded-keywords2 &&
+	git checkout -- expanded-keywords2 &&
+
+	test "x`git status --porcelain -- expanded-keywords2`" =3D x
+'
+
+# Test detection of CRLF conversion changes CRLF =3D=3D> LF.
+test_expect_success crlf_conversion_change_crlf_to_lf '
+	# step 0. a blob with CRLF
+	git init one && cd one &&
+	echo -e "a quick brown fox\015" >kuzu &&
+	git add kuzu && git commit -m kuzu &&
+	# step 1. you want CRLF in work area, LF in repository
+	git config core.autocrlf true &&
+	# step 2. user edit and revert.
+	touch kuzu &&
+	git update-index --refresh
+'
+
+# Test detection of CRLF conversion changes LF =3D=3D> CRLF.
+test_expect_success crlf_conversion_change_lf_to_crlf '
+	# step 0 & 1. a project with LF ending
+	git init two && cd two &&
+	echo a quick brown fox >kuzu &&
+	git add kuzu && git commit -m kuzu &&
+	# step 2. you want CRLF in your work area
+	echo -e "a quick brown fox\015" >kuzu &&
+	git config core.autocrlf true &&
+	# step 3. oops, refresh
+	git update-index --refresh
+'
+
 test_done
--=20
1.7.0.4.369.g81e89
