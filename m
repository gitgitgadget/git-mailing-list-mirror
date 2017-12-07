Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FFA20954
	for <e@80x24.org>; Thu,  7 Dec 2017 17:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbdLGRao (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:30:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57933 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932117AbdLGRal (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 12:30:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B01FC1EEC;
        Thu,  7 Dec 2017 12:30:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=fWpL
        ukimiYudGrR6VL+gCh/Ih3E=; b=JRwB/Tu36EET5WxmnkUlsRSvHnC+JzA4g+hT
        HmuGurf/5VxtUz4o7QKex4+oNZEwPlr2x5/OLaEbUWkL6gZm2ZaOJfytur0gA2LB
        iOx5wpsLjGBvMZd5p7IShjuWqaA3IBKo/hU/4ughfwdcLhO7rnwddUOYtM6G6LUh
        ZvQPZCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        JbfNrGnBQDv8noXs1fhJNCF0NRQO4aur7cxqXRc3UKyAzMMsUUeRVrndCV0HuIPD
        LnAHmy9ociEwPJHT05f/vwTtYNlApac3NOIwJg2tQoNc7g/b2LQC5oxBSDu8SlG1
        kR3kPpIVJhBW7wJZqIZan1DbR9pnMVMWFEiawTbdWN8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11527C1EEB;
        Thu,  7 Dec 2017 12:30:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BCB4C1EEA;
        Thu,  7 Dec 2017 12:30:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, jacob.e.keller@intel.com
Subject: [PATCH v2 7/7] t4045: test 'diff --relative' for real
Date:   Thu,  7 Dec 2017 09:30:34 -0800
Message-Id: <20171207173034.12865-4-gitster@pobox.com>
X-Mailer: git-send-email 2.15.1-480-gbc5668f98a
In-Reply-To: <20171207173034.12865-1-gitster@pobox.com>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
 <20171207173034.12865-1-gitster@pobox.com>
X-Pobox-Relay-ID: 587AE6DA-DB74-11E7-AC1E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing tests only checked how well -relative=<dir> work,
without testing --relative (without any value).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4045-diff-relative.sh | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index fefd2f3f81..815cdd7295 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -25,7 +25,10 @@ check_diff () {
 	+other content
 	EOF
 	test_expect_success "-p $*" "
-		git diff -p $* HEAD^ >actual &&
+		(
+			test -z "$in_there" || cd "$in_there"
+			git diff -p $* HEAD^
+		) >actual &&
 		test_cmp expected actual
 	"
 }
@@ -38,7 +41,10 @@ check_numstat () {
 	EOF
 	test_expect_success "--numstat $*" "
 		echo '1	0	$expect' >expected &&
-		git diff --numstat $* HEAD^ >actual &&
+		(
+			test -z "$in_there" || cd "$in_there"
+			git diff --numstat $* HEAD^
+		) >actual &&
 		test_cmp expected actual
 	"
 }
@@ -51,7 +57,10 @@ check_stat () {
 	 1 file changed, 1 insertion(+)
 	EOF
 	test_expect_success "--stat $*" "
-		git diff --stat $* HEAD^ >actual &&
+		(
+			test -z "$in_there" || cd "$in_there"
+			git diff --stat $* HEAD^
+		) >actual &&
 		test_i18ncmp expected actual
 	"
 }
@@ -63,15 +72,22 @@ check_raw () {
 	:000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
 	EOF
 	test_expect_success "--raw $*" "
-		git diff --no-abbrev --raw $* HEAD^ >actual &&
+		(
+			test -z "$in_there" || cd "$in_there"
+			git diff --no-abbrev --raw $* HEAD^ >actual
+		) &&
 		test_cmp expected actual
 	"
 }
 
 for type in diff numstat stat raw
 do
+	in_there=
 	check_$type file2 --relative=subdir/
 	check_$type file2 --relative=subdir
+	in_there=subdir
+	check_$type file2 --relative
+	in_there=
 	check_$type dir/file2 --relative=sub
 done
 
-- 
2.15.1-480-gbc5668f98a

