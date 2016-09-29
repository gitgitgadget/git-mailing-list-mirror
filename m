Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED6320987
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934220AbcI2VA3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55948 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934182AbcI2VA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C16642998;
        Thu, 29 Sep 2016 17:00:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=PiZB
        bD0JNaxRraoGdbWFMg3cArs=; b=nBBzTb81Q/Kge+ddP243yNOefJjRhvcmRzrO
        LHNZRkB/+Mdb5MuxfA80zKVoDpXTFbwK1vJ6BTjteOiXb3+iqP9wZZObPzI/zgR3
        uLOjSpn9HDKnGojWdHHlsS1aD5HDERkwuCd+WBcZLjzxQAfzuwwNx4DPrn5P9nR4
        Xd+j1hY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        E7+NGaO7cdA8xSr2U320bmIZfn2jICwm8QhiJHZLpuipswoV4gGx8h7d5PyScyxr
        +oZZUF+nAHoJ9IyfQLUwtxqdCTAHsxO7noCxd+n3oH2b742hUUqwy0S75rXtWZAL
        Mc6eNmL0Cuw1UwAuKAfqQyU+DlElzneU6V+ER7xM7Yc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 043F142997;
        Thu, 29 Sep 2016 17:00:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72E5942996;
        Thu, 29 Sep 2016 17:00:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 4/9] t1300: check also system-wide configuration file in --show-origin tests
Date:   Thu, 29 Sep 2016 14:00:09 -0700
Message-Id: <20160929210014.3874-5-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: BE6C253C-8687-11E6-8022-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Because we used to run our tests with GIT_CONFIG_NOSYSTEM, these did
not test that the system-wide configuration file is also read and
shown as one of the origins.  Create a custom/fake system-wide
configuration file and make sure it appears in the output, using the
newly introduced GIT_CONFIG_SYSTEM_PATH mechanism.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-repo-config.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 1b3f6f4854f9..940469339bd2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1236,6 +1236,11 @@ test_expect_success 'set up --show-origin tests' '
 		[user]
 			relative = include
 	EOF
+	cat >"$HOME"/etc-gitconfig <<-\EOF &&
+		[user]
+			system = true
+			override = system
+	EOF
 	cat >"$HOME"/.gitconfig <<-EOF &&
 		[user]
 			global = true
@@ -1254,6 +1259,8 @@ test_expect_success 'set up --show-origin tests' '
 
 test_expect_success '--show-origin with --list' '
 	cat >expect <<-EOF &&
+		file:$HOME/etc-gitconfig	user.system=true
+		file:$HOME/etc-gitconfig	user.override=system
 		file:$HOME/.gitconfig	user.global=true
 		file:$HOME/.gitconfig	user.override=global
 		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
@@ -1264,13 +1271,16 @@ test_expect_success '--show-origin with --list' '
 		file:.git/../include/relative.include	user.relative=include
 		command line:	user.cmdline=true
 	EOF
+	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
 	git -c user.cmdline=true config --list --show-origin >output &&
 	test_cmp expect output
 '
 
 test_expect_success '--show-origin with --list --null' '
 	cat >expect <<-EOF &&
-		file:$HOME/.gitconfigQuser.global
+		file:$HOME/etc-gitconfigQuser.system
+		trueQfile:$HOME/etc-gitconfigQuser.override
+		systemQfile:$HOME/.gitconfigQuser.global
 		trueQfile:$HOME/.gitconfigQuser.override
 		globalQfile:$HOME/.gitconfigQinclude.path
 		$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
@@ -1281,6 +1291,7 @@ test_expect_success '--show-origin with --list --null' '
 		includeQcommand line:Quser.cmdline
 		trueQ
 	EOF
+	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
 	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
 	nul_to_q <output.raw >output &&
 	# The here-doc above adds a newline that the --null output would not
@@ -1304,6 +1315,7 @@ test_expect_success '--show-origin with --get-regexp' '
 		file:$HOME/.gitconfig	user.global true
 		file:.git/config	user.local true
 	EOF
+	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
 	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
 	test_cmp expect output
 '
@@ -1312,6 +1324,7 @@ test_expect_success '--show-origin getting a single key' '
 	cat >expect <<-\EOF &&
 		file:.git/config	local
 	EOF
+	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
 	git config --show-origin user.override >output &&
 	test_cmp expect output
 '
-- 
2.10.0-589-g5adf4e1

