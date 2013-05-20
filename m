From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/6] t5000: integrate export-subst tests into regular tests
Date: Mon, 20 May 2013 11:58:24 +0200
Message-ID: <1369043909-59207-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 11:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeMrn-0004UC-7r
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 11:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab3ETJ6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 05:58:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:56478 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab3ETJ6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 05:58:35 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA8FE.dip0.t-ipconnect.de [79.253.168.254])
	by india601.server4you.de (Postfix) with ESMTPSA id E5C1A3E0
	for <git@vger.kernel.org>; Mon, 20 May 2013 11:58:33 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224948>

Instead of creating extra archives for testing substitutions, set the
attribute export-subst and overwrite the marked file with the expected
(expanded) content right between commiting and archiving.  Thus
placeholder expansion based on the committed content is performed with
each archive creation and the comparision with the contents of director=
y
a yields the correct result.  We can then remove the special tests for
export-subst.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5000-tar-tree.sh | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3fbd366..68b5698 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -62,6 +62,12 @@ test_expect_success \
      git update-ref HEAD $(TZ=3DGMT GIT_COMMITTER_DATE=3D"2005-05-27 2=
2:00:00" \
      git commit-tree $treeid </dev/null)'
=20
+test_expect_success 'setup export-subst' '
+	echo "substfile?" export-subst >>.git/info/attributes &&
+	git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEAD \
+		>a/substfile1
+'
+
 test_expect_success \
     'create bare clone' \
     'git clone --bare . bare.git &&
@@ -148,38 +154,6 @@ test_expect_success \
     'validate file contents with prefix' \
     'diff -r a c/prefix/a'
=20
-test_expect_success \
-    'create archives with substfiles' \
-    'cp .git/info/attributes .git/info/attributes.before &&
-     echo "substfile?" export-subst >>.git/info/attributes &&
-     git archive HEAD >f.tar &&
-     git archive --prefix=3Dprefix/ HEAD >g.tar &&
-     mv .git/info/attributes.before .git/info/attributes'
-
-test_expect_success \
-    'extract substfiles' \
-    '(mkdir f && cd f && "$TAR" xf -) <f.tar'
-
-test_expect_success \
-     'validate substfile contents' \
-     'git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEA=
D \
-      >f/a/substfile1.expected &&
-      test_cmp f/a/substfile1.expected f/a/substfile1 &&
-      test_cmp a/substfile2 f/a/substfile2
-'
-
-test_expect_success \
-    'extract substfiles from archive with prefix' \
-    '(mkdir g && cd g && "$TAR" xf -) <g.tar'
-
-test_expect_success \
-     'validate substfile contents from archive with prefix' \
-     'git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEA=
D \
-      >g/prefix/a/substfile1.expected &&
-      test_cmp g/prefix/a/substfile1.expected g/prefix/a/substfile1 &&
-      test_cmp a/substfile2 g/prefix/a/substfile2
-'
-
 test_expect_success 'git archive with --output, override inferred form=
at' '
 	git archive --format=3Dtar --output=3Dd4.zip HEAD &&
 	test_cmp b.tar d4.zip
--=20
1.8.2.3
