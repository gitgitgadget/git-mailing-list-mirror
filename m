Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716192095B
	for <e@80x24.org>; Tue, 21 Mar 2017 00:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755240AbdCUA43 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:56:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61063 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754140AbdCUA42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:56:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ED2D7FDDA;
        Mon, 20 Mar 2017 20:56:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=LDxr
        pKa4M5wPiOp40+nXz3kZDPY=; b=IKEcmDR7j3v2n6TMhc4o+Le+uoiAirpo8UG+
        EkrkOzBpGQytlOFw8fAw3fQiblgh98OUNdSqyimocKbIFt5N8RJqY83U1DxUATAV
        AVDoh5zS7Srka7TKkHbhNmlOoM8LJj5MXVY9ABaJOjyRIUYUn6WwYDz+guK/lh3Q
        PO1dkJM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45CED7FDD9;
        Mon, 20 Mar 2017 20:56:27 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1641F7FDD5;
        Mon, 20 Mar 2017 20:56:25 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 2/5] t1400: set core.logAllRefUpdates in "logged by touch" tests
Date:   Mon, 20 Mar 2017 20:56:13 -0400
Message-Id: <20170321005616.31324-3-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170321005616.31324-1-kyle@kyleam.com>
References: <20170321005616.31324-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 35E896EC-0DD1-11E7-A5DE-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=LDxrpKa4M5wPiOp40+nXz3kZDPY=;
 b=O3Q0r0bP5HBYDad71QSuGs1JHxiGXOzXSvSgwY3bhYzSq2QHWKyIg96u/3GNBpJsocSPsxHivDREDtl4BnCw/uMPo3Kph9AVIgKKnQOKfPuXPICdnFrv9KmdwAScgWOzrdWtfOU4NOtgxDJg6dLweYYMIVYkYeaigbgXFoDAvic=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A group of update-ref tests verifies that logs are created when either
the log file for the ref already exists or core.logAllRefUpdates is
"true".  However, when the default for core.logAllRefUpdates was
changed in 0bee59186 (Enable reflogs by default in any repository with
a working directory., 2006-12-14), the setup for the tests was not
updated.  As a result, the "logged by touch" tests would pass even if
the log file did not exist (i.e., if "--create-reflog" was removed
from the first "git update-ref" call).

Update the "logged by touch" tests to disable core.logAllRefUpdates
explicitly so that the behavior does not depend on the default value.
While we're here, update the "logged by config" tests to use
test_config() rather than setting core.logAllRefUpdates to "true"
outside of the tests.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---

I'm confused about the setup for the "logged by touch" tests.
d0ab05849 (tests: remove some direct access to .git/logs, 2015-07-27)
changed the setup to delete the log file itself rather than its
contents.  The reflog was then recreated by using "--create-reflog" in
the "create $m (logged by touch)" test.  What I don't understand is
how this change fits with d0ab05849, which seems to be concerned with
loosening the assumption that the logs are stored in .git/logs.  For
these particular tests, we are still removing
.git/logs/refs/heads/master explictly, so why not leave the empty file
around so that the "create $m (logged by touch)" actually tests that
update-ref call is logged by the existence of the log rather than
using "--create-reflog", which overrides this?

 t/t1400-update-ref.sh | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index fde5b98af..be8b113b1 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -260,17 +260,20 @@ rm -f .git/$m
 rm -f .git/logs/refs/heads/master
 test_expect_success \
 	"create $m (logged by touch)" \
-	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	'test_config core.logAllRefUpdates false &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:30" \
 	 git update-ref --create-reflog HEAD '"$A"' -m "Initial Creation" &&
 	 test '"$A"' = $(cat .git/'"$m"')'
 test_expect_success \
 	"update $m (logged by touch)" \
-	'GIT_COMMITTER_DATE="2005-05-26 23:31" \
+	'test_config core.logAllRefUpdates false &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:31" \
 	 git update-ref HEAD'" $B $A "'-m "Switch" &&
 	 test '"$B"' = $(cat .git/'"$m"')'
 test_expect_success \
 	"set $m (logged by touch)" \
-	'GIT_COMMITTER_DATE="2005-05-26 23:41" \
+	'test_config core.logAllRefUpdates false &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:41" \
 	 git update-ref HEAD'" $A &&
 	 test $A"' = $(cat .git/'"$m"')'
 
@@ -312,23 +315,21 @@ test_expect_success \
 rm -rf .git/$m .git/logs expect
 
 test_expect_success \
-	'enable core.logAllRefUpdates' \
-	'git config core.logAllRefUpdates true &&
-	 test true = $(git config --bool --get core.logAllRefUpdates)'
-
-test_expect_success \
 	"create $m (logged by config)" \
-	'GIT_COMMITTER_DATE="2005-05-26 23:32" \
+	'test_config core.logAllRefUpdates true &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:32" \
 	 git update-ref HEAD'" $A "'-m "Initial Creation" &&
 	 test '"$A"' = $(cat .git/'"$m"')'
 test_expect_success \
 	"update $m (logged by config)" \
-	'GIT_COMMITTER_DATE="2005-05-26 23:33" \
+	'test_config core.logAllRefUpdates true &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:33" \
 	 git update-ref HEAD'" $B $A "'-m "Switch" &&
 	 test '"$B"' = $(cat .git/'"$m"')'
 test_expect_success \
 	"set $m (logged by config)" \
-	'GIT_COMMITTER_DATE="2005-05-26 23:43" \
+	'test_config core.logAllRefUpdates true &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:43" \
 	 git update-ref HEAD '"$A &&
 	 test $A"' = $(cat .git/'"$m"')'
 
-- 
2.12.0

