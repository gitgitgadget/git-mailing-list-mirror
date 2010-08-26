From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 1/8] Add testcases showing how pathspecs are ignored with rev-list --objects
Date: Thu, 26 Aug 2010 00:21:44 -0600
Message-ID: <1282803711-10253-2-git-send-email-newren@gmail.com>
References: <1282803711-10253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 08:20:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVp6-0002DN-T6
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab0HZGU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56443 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0HZGUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:25 -0400
Received: by gwj17 with SMTP id 17so532360gwj.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QWewQY7oU50iJbRLFmh7M5/IVLILGFR7Ly5xWfXvpbA=;
        b=hvgrbLBb0Qs+quIKNzqgNDhzvRVRlMOWPeSohQQkl6fdXM/Zro3NRJJQxqoDeVUhww
         gCuQ1ebgypYigJrbFj0et4HQS6Iu64XpAh4GTwkSwZKERj4PzxtT/I4FJA9MT1uypeCG
         +ShqLyIK+isMDiN0RbPQb5vAPVx/WdjcnG+d4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aW/0Mjddorj2NUn71cq0wdAbOiCoDXtFj9AaeWt+GMUVDWufm+wv14uFZvThMJPonp
         AsScIx8xtzS2qSfed/NCmRpjgTTyTseuzoaSnHa392tP7F3E67NdYCTvMm/w2XRvDA8G
         7FThGhddFTSwN2YMS8RpL0ofTFwZjfHn+qnPU=
Received: by 10.151.122.2 with SMTP id z2mr9255822ybm.435.1282803623880;
        Wed, 25 Aug 2010 23:20:23 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
In-Reply-To: <1282803711-10253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154518>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6000-rev-list-misc.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
new file mode 100755
index 0000000..a298f0d
--- /dev/null
+++ b/t/t6000-rev-list-misc.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='miscellaneous rev-list tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo content1 > wanted_file &&
+	echo content2 > unwanted_file &&
+	git add wanted_file unwanted_file &&
+	git commit -mone
+'
+
+test_expect_failure 'rev-list --objects heeds pathspecs' '
+	git rev-list --objects HEAD -- wanted_file >output &&
+	grep wanted_file output &&
+	! grep unwanted_file output
+'
+
+test_expect_failure 'rev-list --objects with pathspecs and deeper paths' '
+	mkdir foo &&
+	> foo/file &&
+	git add foo/file &&
+	git commit -mtwo &&
+
+	git rev-list --objects HEAD -- foo >output &&
+	grep foo/file output &&
+
+	git rev-list --objects HEAD -- foo/file >output &&
+	grep foo/file output &&
+	! grep unwanted_file output
+'
+
+test_expect_failure 'rev-list --objects with pathspecs and copied files' '
+	git checkout --orphan junio-testcase &&
+	git rm -rf . &&
+
+	mkdir two &&
+	echo frotz >one &&
+	cp one two/three &&
+	git add one two/three &&
+	test_tick &&
+	git commit -m that &&
+
+	ONE=$(git rev-parse HEAD:one)
+	git rev-list --objects HEAD two >output &&
+	grep "$ONE two/three" output &&
+	! grep one output
+'
+
+test_done
-- 
1.7.2.2.45.ga60f
