From: Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] tests: fix gzip with exported GZIP variable in environment
Date: Tue,  3 Dec 2013 09:57:34 +0100
Message-ID: <1386061054-30796-1-git-send-email-mail@eworm.de>
Cc: Christian Hesse <mail@eworm.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 10:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnluu-0000Ww-1o
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 10:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab3LCJFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 04:05:11 -0500
Received: from mx.mylinuxtime.de ([80.190.48.209]:43416 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab3LCJEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 04:04:43 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Dec 2013 04:04:43 EST
Received: from leda.eworm.de (unknown [10.10.1.2])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 0BA7911FC0F0;
	Tue,  3 Dec 2013 09:57:44 +0100 (CET)
Received: by leda.eworm.de (Postfix, from userid 1000)
	id 5BD8114A2BE; Tue,  3 Dec 2013 09:57:43 +0100 (CET)
X-Mailer: git-send-email 1.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238678>

In t/t5000-tar-tree.sh the variable GZIP is used for the command name.
From man gzip:

> The environment variable GZIP can hold a set of default options for
> gzip. These options are interpreted first and can be overwritten by
> explicit command line parameters.

So using any other variable name fixes this.
---
 t/t5000-tar-tree.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index c2023b1..01b0ed9 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,7 +25,7 @@ commit id embedding:
 '
 
 . ./test-lib.sh
-GZIP=${GZIP:-gzip}
+GZIPCMD=${GZIPCMD:-gzip}
 GUNZIP=${GUNZIP:-gzip -d}
 
 SUBSTFORMAT=%H%n
@@ -275,27 +275,27 @@ test_expect_success 'only enabled filters are available remotely' '
 	test_cmp remote.bar config.bar
 '
 
-if $GZIP --version >/dev/null 2>&1; then
-	test_set_prereq GZIP
+if $GZIPCMD --version >/dev/null 2>&1; then
+	test_set_prereq GZIPCMD
 else
 	say "Skipping some tar.gz tests because gzip not found"
 fi
 
-test_expect_success GZIP 'git archive --format=tgz' '
+test_expect_success GZIPCMD 'git archive --format=tgz' '
 	git archive --format=tgz HEAD >j.tgz
 '
 
-test_expect_success GZIP 'git archive --format=tar.gz' '
+test_expect_success GZIPCMD 'git archive --format=tar.gz' '
 	git archive --format=tar.gz HEAD >j1.tar.gz &&
 	test_cmp j.tgz j1.tar.gz
 '
 
-test_expect_success GZIP 'infer tgz from .tgz filename' '
+test_expect_success GZIPCMD 'infer tgz from .tgz filename' '
 	git archive --output=j2.tgz HEAD &&
 	test_cmp j.tgz j2.tgz
 '
 
-test_expect_success GZIP 'infer tgz from .tar.gz filename' '
+test_expect_success GZIPCMD 'infer tgz from .tar.gz filename' '
 	git archive --output=j3.tar.gz HEAD &&
 	test_cmp j.tgz j3.tar.gz
 '
@@ -306,17 +306,17 @@ else
 	say "Skipping some tar.gz tests because gunzip was not found"
 fi
 
-test_expect_success GZIP,GUNZIP 'extract tgz file' '
+test_expect_success GZIPCMD,GUNZIP 'extract tgz file' '
 	$GUNZIP -c <j.tgz >j.tar &&
 	test_cmp b.tar j.tar
 '
 
-test_expect_success GZIP 'remote tar.gz is allowed by default' '
+test_expect_success GZIPCMD 'remote tar.gz is allowed by default' '
 	git archive --remote=. --format=tar.gz HEAD >remote.tar.gz &&
 	test_cmp j.tgz remote.tar.gz
 '
 
-test_expect_success GZIP 'remote tar.gz can be disabled' '
+test_expect_success GZIPCMD 'remote tar.gz can be disabled' '
 	git config tar.tar.gz.remote false &&
 	test_must_fail git archive --remote=. --format=tar.gz HEAD \
 		>remote.tar.gz
-- 
1.8.5
