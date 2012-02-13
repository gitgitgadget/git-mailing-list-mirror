From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [BUG] git-merge-octopus creates an empty merge commit with one parent
Date: Mon, 13 Feb 2012 12:48:56 +0100
Message-ID: <1329133736-20817-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 12:49:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwuPX-0005FW-JD
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 12:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab2BMLtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 06:49:01 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60500 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab2BMLtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 06:49:00 -0500
Received: by eaah12 with SMTP id h12so1758456eaa.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 03:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=zDGkCNsaSK+JQIQq2E/NHPNcrFggQRgkWV6yApy3OAY=;
        b=GZKU3Jv+dw49WFPUqCMktBf06Lqk7c0kgHqaktSS/QqpVbMqUzqBGFtbXr5T4Qq8ZS
         eYLadXWFX9D48ZMd1cq1vrd7kNBXLw1IAWAUnZrJd7Gcn5E4FXmEfx8gvwsMMtsaV+PF
         nDYeS/PJumEN6IUY62sIf7p6lTUfPMXYUoz6w=
Received: by 10.213.14.147 with SMTP id g19mr1954183eba.126.1329133739078;
        Mon, 13 Feb 2012 03:48:59 -0800 (PST)
Received: from localhost (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id c16sm60302068eei.1.2012.02.13.03.48.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 03:48:58 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.155.g2e96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190625>

This happens when git merge is run to merge multiple commits that are
descendants of current HEAD (or are HEAD).  We've hit this while updati=
ng master
to origin/master but accidentaly we called (while being on master):

	$ git merge master origin/master

Here is a minimal testcase:

	$ git init a

	$ cd a

	$ echo a>a

	$ git commit -minitial

	$ echo b>a

	$ git add a

	$ git commit -msecond

	$ git checkout master^

	$ git merge master master
	Fast-forwarding to: master
	Already up-to-date with master
	Merge made by the 'octopus' strategy.
	 a |    2 +-
	  1 files changed, 1 insertions(+), 1 deletions(-)

	$ git cat-file commit HEAD
	tree eebfed94e75e7760540d1485c740902590a00332
	parent bd679e85202280b263e20a57639a142fa14c2c64
	author Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> 1329132996=
 +0100
	committer Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> 1329132=
996 +0100

	Merge branches 'master' and 'master' into HEAD

=2E.. and below is a patch that adds a testcase to Git's testsuite.

I would expect `git merge master master` to just 'Fast forward'.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 t/t6028-merge-up-to-date.sh |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/t/t6028-merge-up-to-date.sh b/t/t6028-merge-up-to-date.sh
index a91644e..824fca5 100755
--- a/t/t6028-merge-up-to-date.sh
+++ b/t/t6028-merge-up-to-date.sh
@@ -16,7 +16,12 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m second &&
 	git tag c1 &&
-	git branch test
+	git branch test &&
+	echo third >file &&
+	git add file &&
+	test_tick &&
+	git commit -m third &&
+	git tag c2
 '
=20
 test_expect_success 'merge -s recursive up-to-date' '
@@ -74,4 +79,14 @@ test_expect_success 'merge -s subtree up-to-date' '
=20
 '
=20
+test_expect_failure 'merge fast-forward octopus' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge c1 c2
+	expect=3D$(git rev-parse c2) &&
+	current=3D$(git rev-parse HEAD) &&
+	test "$expect" =3D "$current"
+'
+
 test_done
--=20
1.7.9.rc2.155.g2e96
