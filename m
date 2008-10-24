From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fixed git archive for bare repos
Date: Sat, 25 Oct 2008 00:19:49 +0200
Message-ID: <49024A05.3090100@lsrfire.ath.cx>
References: <20081022210913.GB22541@hashpling.org> <1224712023-5280-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Deskin Miller <deskinm@umich.edu>,
	kenneth johansson <ken@kenjo.org>, gitster@pobox.com
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:21:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtV1r-0003L4-OD
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbYJXWT6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Oct 2008 18:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbYJXWT5
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:19:57 -0400
Received: from india601.server4you.de ([85.25.151.105]:39627 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbYJXWT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:19:57 -0400
Received: from [10.0.1.100] (p57B7FD98.dip.t-dialin.net [87.183.253.152])
	by india601.server4you.de (Postfix) with ESMTPSA id A20CD2F8050;
	Sat, 25 Oct 2008 00:19:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <1224712023-5280-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99074>

Charles Bailey schrieb:
> This moves the call to git config to a place where it doesn't break
> the logic for using git archive in a bare repository but retains the
> fix to make git archive respect core.autocrlf.

If one combines your patch, Deskin's commit message and test and extend=
s
on the latter a bit then I think we have a winner. :)

Here are a few more tests which create a ZIP file in addition to a tar
archive and compare them to their non-bare counterparts.

Care to resend?

Thanks,
Ren=E9


 t/t5000-tar-tree.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e395ff4..bf5fa25 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -58,6 +58,11 @@ test_expect_success \
      git commit-tree $treeid </dev/null)'
=20
 test_expect_success \
+    'create bare clone' \
+    'git clone --bare . bare.git &&
+     cp .gitattributes bare.git/info/attributes'
+
+test_expect_success \
     'remove ignored file' \
     'rm a/ignored'
=20
@@ -74,6 +79,14 @@ test_expect_success \
     'diff b.tar b2.tar'
=20
 test_expect_success \
+    'git archive in a bare repo' \
+    '(cd bare.git && git archive HEAD) >b3.tar'
+
+test_expect_success \
+    'git archive vs. the same in a bare repo' \
+    'test_cmp b.tar b3.tar'
+
+test_expect_success \
     'validate file modification time' \
     'mkdir extract &&
      "$TAR" xf b.tar -C extract a/a &&
@@ -151,6 +164,14 @@ test_expect_success \
     'git archive --format=3Dzip' \
     'git archive --format=3Dzip HEAD >d.zip'
=20
+test_expect_success \
+    'git archive --format=3Dzip in a bare repo' \
+    '(cd bare.git && git archive --format=3Dzip HEAD) >d1.zip'
+
+test_expect_success \
+    'git archive --format=3Dzip vs. the same in a bare repo' \
+    'test_cmp d.zip d1.zip'
+
 $UNZIP -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	echo "Skipping ZIP tests, because unzip was not found"
