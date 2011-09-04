From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH 2/2] git svn dcommit: add a test serie for 'git svn dcommit --interactive'
Date: Sun,  4 Sep 2011 21:21:53 +0200
Message-ID: <1315164113-26539-3-git-send-email-frederic.heitzmann@gmail.com>
References: <1315164113-26539-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, normalperson@yhbt.net, jaysoffian@gmail.com,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 21:24:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0IJL-0004cr-3f
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 21:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab1IDTYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Sep 2011 15:24:47 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54568 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1IDTYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 15:24:46 -0400
Received: by wwf5 with SMTP id 5so4508049wwf.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mxTS7U+xPm8jFHUJewGnYG7X2//6MnSRYKG1JwAJw2o=;
        b=XU9Qsy1iriSbZKk0+7GdLGJeGBPZGwwRW9vQiibDtadqBwbKFuYND3SrScw19BpEGf
         KDiQk/81fFrNfJlxwhOLCE8xu53UDN5Vv2FP2ub4jf8vG2rW0wO5ZjAg5z38mqdJdjA2
         83AUyUhsqTnHIALuxyfkzCL6W956ScfKuuZv4=
Received: by 10.216.179.69 with SMTP id g47mr527492wem.10.1315164284951;
        Sun, 04 Sep 2011 12:24:44 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id et17sm5825074wbb.0.2011.09.04.12.24.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Sep 2011 12:24:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.447.gb9176
In-Reply-To: <1315164113-26539-1-git-send-email-frederic.heitzmann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180700>

test several combinations of potential answers to 'git svn dcommit
--interactive'. For each of them, test whether patches were commited to=
 SVN or
not

Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.c=
om>
---
 t/t9160-git-svn-dcommit-interactive.sh |   64 ++++++++++++++++++++++++=
++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 t/t9160-git-svn-dcommit-interactive.sh

diff --git a/t/t9160-git-svn-dcommit-interactive.sh b/t/t9160-git-svn-d=
commit-interactive.sh
new file mode 100644
index 0000000..e38d9fa
--- /dev/null
+++ b/t/t9160-git-svn-dcommit-interactive.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Fr=C3=A9d=C3=A9ric Heitzmann
+
+test_description=3D'git svn dcommit --interactive series'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize repo' '
+	svn_cmd mkdir -m"mkdir test-interactive" "$svnrepo/test-interactive" =
&&
+	git svn clone "$svnrepo/test-interactive" test-interactive &&
+	cd test-interactive &&
+	touch foo && git add foo && git commit -m"foo: first commit" &&
+	git svn dcommit
+	'
+
+test_expect_success 'answers: y [\n] yes' '
+	(
+		echo "change #1" >> foo && git commit -a -m"change #1" &&
+		echo "change #2" >> foo && git commit -a -m"change #2" &&
+		echo "change #3" >> foo && git commit -a -m"change #3" &&
+		( echo "y
+
+y" | GIT_SVN_NOTTY=3D1 git svn dcommit --interactive ) &&
+		test $(git rev-parse HEAD) =3D $(git rev-parse remotes/git-svn)
+	)
+	'
+
+test_expect_success 'answers: yes yes no' '
+	(
+		echo "change #1" >> foo && git commit -a -m"change #1" &&
+		echo "change #2" >> foo && git commit -a -m"change #2" &&
+		echo "change #3" >> foo && git commit -a -m"change #3" &&
+		( echo "yes
+yes
+no" | GIT_SVN_NOTTY=3D1 git svn dcommit --interactive ) &&
+		test $(git rev-parse HEAD^^^) =3D $(git rev-parse remotes/git-svn) &=
&
+		git reset --hard remotes/git-svn
+	)
+	'
+
+test_expect_success 'answers: yes quit' '
+	(
+		echo "change #1" >> foo && git commit -a -m"change #1" &&
+		echo "change #2" >> foo && git commit -a -m"change #2" &&
+		echo "change #3" >> foo && git commit -a -m"change #3" &&
+		( echo "yes
+quit" | GIT_SVN_NOTTY=3D1 git svn dcommit --interactive ) &&
+		test $(git rev-parse HEAD^^^) =3D $(git rev-parse remotes/git-svn) &=
&
+		git reset --hard remotes/git-svn
+	)
+	'
+
+test_expect_success 'answers: all' '
+	(
+		echo "change #1" >> foo && git commit -a -m"change #1" &&
+		echo "change #2" >> foo && git commit -a -m"change #2" &&
+		echo "change #3" >> foo && git commit -a -m"change #3" &&
+		( echo "all" | GIT_SVN_NOTTY=3D1 git svn dcommit --interactive ) &&
+		test $(git rev-parse HEAD) =3D $(git rev-parse remotes/git-svn) &&
+		git reset --hard remotes/git-svn
+	)
+	'
+
+test_done
--=20
1.7.6.447.gb9176
