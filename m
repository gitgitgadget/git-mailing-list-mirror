X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/2] Regression test for "stg mail"
Date: Sun, 12 Nov 2006 22:15:57 +0100
Message-ID: <20061112211556.19362.68287.stgit@localhost>
References: <20061112211434.19362.66077.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 12 Nov 2006 21:16:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061112211434.19362.66077.stgit@localhost>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31277>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjMgL-0007g7-L6 for gcvg-git@gmane.org; Sun, 12 Nov
 2006 22:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753190AbWKLVP7 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006 16:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbWKLVP7
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 16:15:59 -0500
Received: from mxfep03.bredband.com ([195.54.107.76]:57289 "EHLO
 mxfep03.bredband.com") by vger.kernel.org with ESMTP id S1753190AbWKLVP7
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 16:15:59 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84]) by
 mxfep03.bredband.com with ESMTP id
 <20061112211557.KXTJ25623.mxfep03.bredband.com@ironport2.bredband.com> for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 22:15:57 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport2.bredband.com with
 ESMTP; 12 Nov 2006 22:15:57 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 12B724CC24; Sun, 12 Nov
 2006 22:15:57 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>



Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1900-mail.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t1900-mail.sh b/t/t1900-mail.sh
new file mode 100755
index 0000000..6a950b4
--- /dev/null
+++ b/t/t1900-mail.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# Copyright (c) 2006 Karl Hasselstr=C3=B6m
+test_description=3D'Test the mail command'
+. ./test-lib.sh
+
+test_expect_success \
+    'Initialize the StGIT repository' \
+    '
+    for i in 1 2 3 4 5; do
+      touch foo.txt &&
+      echo "line $i" >> foo.txt &&
+      git add foo.txt &&
+      git commit -a -m "Patch $i"
+    done &&
+    stg init &&
+    stg uncommit -n 5 foo
+    '
+
+test_expect_success \
+    'Put all the patches in an mbox' \
+    'stg mail --to=3D"Inge Str=C3=B6m <inge@example.com>" -a -m \
+       -t ../../templates/patchmail.tmpl > mbox0'
+
+test_expect_success \
+    'Import the mbox and compare' \
+    '
+    t1=3D$(git cat-file -p $(stg id) | grep ^tree)
+    stg pop -a &&
+    stg import -M mbox0 &&
+    t2=3D$(git cat-file -p $(stg id) | grep ^tree) &&
+    [ "$t1" =3D=3D "$t2" ]
+    '
+
