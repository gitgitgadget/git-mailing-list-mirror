From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 5/5] t/t0021: Test that conversion changes are detected.
Date: Tue,  1 Jun 2010 16:41:55 +0200
Message-ID: <99a6d5d56ff1b6a9b5005b782044939b1cfc1c5a.1275309129.git.grubba@grubba.org>
References: <cover.1275309129.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 16:42:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJSft-0004VS-Ch
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 16:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499Ab0FAOmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 10:42:19 -0400
Received: from mail.roxen.com ([212.247.29.220]:45902 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756436Ab0FAOmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 10:42:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id D3402628239
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 16:42:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LsgkNiXJ+M9F for <git@vger.kernel.org>;
	Tue,  1 Jun 2010 16:42:16 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id B777A628236
	for <git@vger.kernel.org>; Tue,  1 Jun 2010 16:42:16 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.14.4+Sun/8.14.4) with ESMTP id o51EgDug021835;
	Tue, 1 Jun 2010 16:42:13 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.14.4+Sun/8.14.4/Submit) id o51EgDPN021834;
	Tue, 1 Jun 2010 16:42:13 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1275309129.git.grubba@grubba.org>
In-Reply-To: <cover.1275309129.git.grubba@grubba.org>
References: <cover.1275309129.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148121>

Signed-off-by Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 t/t0021-conversion.sh |   54 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 6cb8d60..6d41ee7 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -89,4 +89,58 @@ test_expect_success expanded_in_repo '
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
+(
+	# step 0. a blob with CRLF
+	git init one && cd one &&
+	echo -e "a quick brown fox\015" >kuzu &&
+	git add kuzu && git commit -m kuzu &&
+	# step 1. you want CRLF in work area, LF in repository
+	git config core.autocrlf true &&
+	# step 2. user edit and revert.
+	touch kuzu &&
+	git update-index --refresh
+)
+'
+
+# Test detection of CRLF conversion changes LF =3D=3D> CRLF.
+test_expect_success crlf_conversion_change_lf_to_crlf '
+(
+	# step 0 & 1. a project with LF ending
+	git init two && cd two &&
+	echo a quick brown fox >kuzu &&
+	git add kuzu && git commit -m kuzu &&
+	# step 2. you want CRLF in your work area
+	echo -e "a quick brown fox\015" >kuzu &&
+	git config core.autocrlf true &&
+	# step 3. oops, refresh
+	git update-index --refresh
+)
+'
+
 test_done
--=20
1.7.0.4.369.g81e89
