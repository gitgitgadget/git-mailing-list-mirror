Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94262C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70278206F0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfK0PRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:17:23 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:51485 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0PRX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:17:23 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 2BFD08B898
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 15:17:21 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47NPX06kD0z4BNJ;
        Wed, 27 Nov 2019 15:17:20 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id DED29CE5F; Wed, 27 Nov 2019 15:17:20 +0000 (UTC)
From:   Ed Maste <emaste@freefall.freebsd.org>
To:     git@vger.kernel.org
Cc:     Ed Maste <emaste@freebsd.org>
Subject: [PATCH] t4210: skip i18n tests that don't work on FreeBSD
Date:   Wed, 27 Nov 2019 15:17:08 +0000
Message-Id: <20191127151708.50531-1-emaste@freefall.freebsd.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

A number of t4210-log-i18n tests added in 4e2443b181 set LC_ALL to a UTF-8
locale (is_IS.UTF-8) but then pass an invalid UTF-8 string to --grep.
FreeBSD's regcomp() fails in this case with REG_ILLSEQ sequence which git
then passes to die():

fatal: command line: '�': illegal byte sequence

When these tests were added the commit message stated:

| It's possible that this
| test breaks the "basic" and "extended" backends on some systems that
| are more anal than glibc about the encoding of locale issues with
| POSIX functions that I can remember

which seems to be the case here.

Extend test-lib.sh to add a FREEBSD prereq (akin to MINGW) and add !FREEBSD
to these tests.

Signed-off-by: Ed Maste <emaste@freebsd.org>
---
 t/t4210-log-i18n.sh | 4 ++--
 t/test-lib.sh       | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 6e61f57f09..d897eea1aa 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -70,7 +70,7 @@ do
 	then
 	    force_regex=.*
 	fi
-	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
+	test_expect_success !MINGW,!FREEBSD,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not find non-reencoded values (latin1 + locale)" "
 		cat >expect <<-\EOF &&
 		latin1
 		utf8
@@ -84,7 +84,7 @@ do
 		test_must_be_empty actual
 	"
 
-	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
+	test_expect_success !MINGW,!FREEBSD,GETTEXT_LOCALE,$prereq "-c grep.patternType=$engine log --grep does not die on invalid UTF-8 value (latin1 + locale + invalid needle)" "
 		LC_ALL=\"$is_IS_locale\" git -c grep.patternType=$engine log --encoding=ISO-8859-1 --format=%s --grep=\"$force_regex$invalid_e\" >actual &&
 		test_must_be_empty actual
 	"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 46c4440843..8693ff9eec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1422,7 +1422,7 @@ else
 	'
 fi
 
-# Fix some commands on Windows
+# Fix some commands on Windows, and other OS-specific things
 uname_s=$(uname -s)
 case $uname_s in
 *MINGW*)
@@ -1453,6 +1453,12 @@ case $uname_s in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	;;
+FreeBSD)
+	test_set_prereq FREEBSD
+	test_set_prereq POSIXPERM
+	test_set_prereq BSLASHPSPEC
+	test_set_prereq EXECKEEPSPID
+	;;
 *)
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
-- 
2.24.0

