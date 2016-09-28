Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A3E20987
	for <e@80x24.org>; Wed, 28 Sep 2016 23:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbcI1XfE (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 19:35:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51187 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932826AbcI1Xa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 19:30:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2B5941BFD;
        Wed, 28 Sep 2016 19:30:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=XWJ5
        lnjSqfxPRWfzjxhm6yP2SdQ=; b=t8D2sFfb4EWp0uDClRNAqyULTz7KKEqmDhmJ
        lMnBF7S7+PaXQMvXBkF7QYSFoh3ka6ze35m1WV76gOmwc1V7nMYHijiGbggCSCaH
        cucKAGCweTJGgDx9Ri9EdGiiQofUDeCYCwfwkpZP0+Y8AdGJCwzeGyhZI6iff98/
        +vDNX1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        T1XP7tC9tZ6trLFvA005RFKmAvLHf/w2ECI5f+c1rAyJd9QMIVNblpiYcZQYEGTR
        7Uk1vjrimkt4oCdLphcny+AIExkeLpEHQul6vlZMQK7U6hpV3N6/e9XSC2TCg24i
        ADSvsmf1ROiSkEb6W/Wo+3CEua8lqRBlr30lmwmn4pc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA6F841BFC;
        Wed, 28 Sep 2016 19:30:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D19A41BFB;
        Wed, 28 Sep 2016 19:30:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, torvalds@linux-foundation.org
Subject: [PATCH 2/4] t13xx: do not assume system config is empty
Date:   Wed, 28 Sep 2016 16:30:45 -0700
Message-Id: <20160928233047.14313-3-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-584-gc9e068c
In-Reply-To: <20160928233047.14313-1-gitster@pobox.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
X-Pobox-Relay-ID: 9980B936-85D3-11E6-B55C-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most parts of these two tests want to read from the local
configuration file they prepare and make sure expected names and
values appear with "git config --list".

Once we add custom configuration items that we want to affect the
tests with globally to t/gitconfig-for-test file, these will start
seeing the contents from there and break.  Clarify with --local that
they only care about the contents from their local configuration.

The tests for show-origin codepath in "git config" however cannot be
tweaked with "--local" etc., because they wants to read also from
$HOME/.gitconfig and make sure what comes from where.  Disable
reading from the system-wide config with GIT_CONFIG_NOSYSTEM=1 for
these tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-repo-config.sh | 24 +++++++++++++-----------
 t/t1308-config-set.sh  |  1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 1184f43..b998568 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -341,13 +341,11 @@ version.1.2.3eX.alpha=beta
 EOF
 
 test_expect_success 'working --list' '
-	git config --list > output &&
+	git config --local --list > output &&
 	test_cmp expect output
 '
-cat > expect << EOF
-EOF
-
-test_expect_success '--list without repo produces empty output' '
+test_expect_success '--list without repo shows only from the global' '
+	git config --system --list >expect &&
 	git --git-dir=nonexistent config --list >output &&
 	test_cmp expect output
 '
@@ -360,7 +358,7 @@ version.1.2.3eX.alpha
 EOF
 
 test_expect_success '--name-only --list' '
-	git config --name-only --list >output &&
+	git config --local --name-only --list >output &&
 	test_cmp expect output
 '
 
@@ -370,7 +368,7 @@ nextsection.nonewline wow2 for me
 EOF
 
 test_expect_success '--get-regexp' '
-	git config --get-regexp in >output &&
+	git config --local --get-regexp in >output &&
 	test_cmp expect output
 '
 
@@ -380,7 +378,7 @@ nextsection.nonewline
 EOF
 
 test_expect_success '--name-only --get-regexp' '
-	git config --name-only --get-regexp in >output &&
+	git config --local --name-only --get-regexp in >output &&
 	test_cmp expect output
 '
 
@@ -391,7 +389,7 @@ EOF
 
 test_expect_success '--add' '
 	git config --add nextsection.nonewline "wow4 for you" &&
-	git config --get-all nextsection.nonewline > output &&
+	git config --local --get-all nextsection.nonewline > output &&
 	test_cmp expect output
 '
 
@@ -935,7 +933,7 @@ section.quotecont=cont;inued
 EOF
 
 test_expect_success 'value continued on next line' '
-	git config --list > result &&
+	git config --local --list > result &&
 	test_cmp result expect
 '
 
@@ -959,7 +957,7 @@ Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF
 test_expect_success '--null --list' '
-	git config --null --list >result.raw &&
+	git config --null --local --list >result.raw &&
 	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
@@ -1264,6 +1262,7 @@ test_expect_success '--show-origin with --list' '
 		file:.git/../include/relative.include	user.relative=include
 		command line:	user.cmdline=true
 	EOF
+	GIT_CONFIG_NOSYSTEM=1 \
 	git -c user.cmdline=true config --list --show-origin >output &&
 	test_cmp expect output
 '
@@ -1281,6 +1280,7 @@ test_expect_success '--show-origin with --list --null' '
 		includeQcommand line:Quser.cmdline
 		trueQ
 	EOF
+	GIT_CONFIG_NOSYSTEM=1 \
 	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
 	nul_to_q <output.raw >output &&
 	# The here-doc above adds a newline that the --null output would not
@@ -1304,6 +1304,7 @@ test_expect_success '--show-origin with --get-regexp' '
 		file:$HOME/.gitconfig	user.global true
 		file:.git/config	user.local true
 	EOF
+	GIT_CONFIG_NOSYSTEM=1 \
 	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
 	test_cmp expect output
 '
@@ -1312,6 +1313,7 @@ test_expect_success '--show-origin getting a single key' '
 	cat >expect <<-\EOF &&
 		file:.git/config	local
 	EOF
+	GIT_CONFIG_NOSYSTEM=1 \
 	git config --show-origin user.override >output &&
 	test_cmp expect output
 '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7655c94..5d5adb1 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -260,6 +260,7 @@ test_expect_success 'iteration shows correct origins' '
 	name=
 	scope=cmdline
 	EOF
+	GIT_CONFIG_NOSYSTEM=1 \
 	GIT_CONFIG_PARAMETERS=$cmdline_config test-config iterate >actual &&
 	test_cmp expect actual
 '
-- 
2.10.0-584-gc9e068c

