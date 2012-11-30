From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/4] t4041 (diff-submodule-option): parse digests sensibly
Date: Fri, 30 Nov 2012 17:07:34 +0530
Message-ID: <1354275456-11104-3-git-send-email-artagnon@gmail.com>
References: <1354275456-11104-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeOv6-0002nU-T9
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 12:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757840Ab2K3Lht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 06:37:49 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55701 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab2K3Lhr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 06:37:47 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so291681pad.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 03:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jRjs8zmQBiozNQgxVI5glQfWt1dtvTxCx+fVvO5msHA=;
        b=ktkhYX+pDWDZjpuBWbZD+uMsYjaApGTpN2d/dc1PzpE8jxecD2ykGZFDGWJNBkDwRo
         R5alsuOGlr6/r/OuZBDkAYXVWLzy5gjYOwrh8ZbPGIzAucyp87E52wxZXLDWwaeyHyC+
         +0xmiuEglUQ+aqG1ymKjfj0PfO+mebRIuRT4kQT5WUjVNSdTZLeKsGw6R4O60MGEbUfA
         cybgs8mEUklCYgbgXkiv9Ulf2MTYtlEWQEXMB6e9fm4w/8XSaUc//skjTl3YS8QDyCHv
         iQM70jBOyrU8XCGX7PLwa4u8NlCDGjCUclxL0165YHmC8PWvf5DBLP9wlSvp9HCKhl7f
         Ad+Q==
Received: by 10.68.197.71 with SMTP id is7mr4807177pbc.79.1354275467739;
        Fri, 30 Nov 2012 03:37:47 -0800 (PST)
Received: from fran.foss.conf ([59.90.224.156])
        by mx.google.com with ESMTPS id ok8sm2923120pbb.42.2012.11.30.03.37.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 03:37:47 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1354275456-11104-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git rev-list --max-count=1 HEAD` is a roundabout way of saying `git
rev-parse --verify HEAD`; replace a bunch of instances of the former
with the latter.  Also, don't unnecessarily `cut -c1-7` the rev-parse
output when the `--short` option is available.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4041-diff-submodule-option.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 5377639..08d549a 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -21,7 +21,7 @@ add_file () {
 		test_tick &&
 		git commit -m "Add $name"
 	done >/dev/null
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --short --verify HEAD
 	cd "$owd"
 }
 commit_file () {
@@ -33,7 +33,7 @@ test_create_repo sm1 &&
 add_file . foo >/dev/null
 
 head1=$(add_file sm1 foo1 foo2)
-fullhead1=$(cd sm1; git rev-list --max-count=1 $head1)
+fullhead1=$(cd sm1; git rev-parse --verify HEAD)
 
 test_expect_success 'added submodule' "
 	git add sm1 &&
@@ -116,8 +116,8 @@ EOF
 	test_cmp expected actual
 "
 
-fullhead2=$(cd sm1; git rev-list --max-count=1 $head2)
 test_expect_success 'modified submodule(forward) --submodule=short' "
+fullhead2=$(cd sm1; git rev-parse --verify HEAD)
 	git diff --submodule=short >actual &&
 	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
@@ -135,7 +135,7 @@ commit_file sm1 &&
 head3=$(
 	cd sm1 &&
 	git reset --hard HEAD~2 >/dev/null &&
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --short --verify HEAD
 )
 
 test_expect_success 'modified submodule(backward)' "
@@ -220,8 +220,8 @@ EOF
 rm -f sm1 &&
 test_create_repo sm1 &&
 head6=$(add_file sm1 foo6 foo7)
-fullhead6=$(cd sm1; git rev-list --max-count=1 $head6)
 test_expect_success 'nonexistent commit' "
+fullhead6=$(cd sm1; git rev-parse --verify HEAD)
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 Submodule sm1 $head4...$head6 (commits not present)
@@ -318,8 +318,8 @@ EOF
 "
 
 (cd sm1; git commit -mchange foo6 >/dev/null) &&
-head8=$(cd sm1; git rev-parse --verify HEAD | cut -c1-7) &&
 test_expect_success 'submodule is modified' "
+head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 Submodule sm1 $head6..$head8:
@@ -461,7 +461,7 @@ EOF
 	test_cmp expected actual
 "
 
-fullhead7=$(cd sm2; git rev-list --max-count=1 $head7)
+fullhead7=$(cd sm2; git rev-parse --verify HEAD)
 
 test_expect_success 'given commit --submodule=short' "
 	git diff-index -p --submodule=short HEAD^ >actual &&
-- 
1.7.8.1.362.g5d6df.dirty
