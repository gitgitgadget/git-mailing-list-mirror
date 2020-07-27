Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90461C433E1
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 17:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DE620729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 17:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgG0RDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:03:44 -0400
Received: from 0x63.nu ([109.74.10.199]:48160 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbgG0RDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 13:03:44 -0400
X-Greylist: delayed 1089 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 13:03:43 EDT
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1k06Fo-0007KE-7r
        for git@vger.kernel.org; Mon, 27 Jul 2020 18:45:32 +0200
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Subject: Questions about trailer configuration semantics
Date:   Mon, 27 Jul 2020 18:45:24 +0200
Message-ID: <87blk0rjob.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I noticed some undocumented and (at least to me) surprising behavior in
trailers.c.

When configuring a value in trailer.<token>.key it causes the trailer to
be normalized to that in "git interpret-trailers --parse".
E.g:
 $ printf '\naCKed: Zz\n' | \
   git -c 'trailer.Acked.key=Acked' interpret-trailers --parse
 will emit: "Acked: Zz"

but only if "key" is used, other config options doesn't cause it to be
normalized.
E.g:
 $ printf '\naCKed: Zz\n' | \
   git -c 'trailer.Acked.ifmissing=doNothing' interpret-trailers --parse
 will emit: "aCKed: Zz" (still lowercase a and uppercase CK)


Then there is the replacement by config "trailer.fix.key=Fixes" which
expands "fix" to "Fixes". This happens when using "--trailer 'fix = 123'"
which seems to be expected and useful behavior (albeit a bit unclear in
documentation). But it also happens when parsing incoming trailers, e.g
with that config
 $ printf "\nFix: 1\n" | git interpret-trailers --parse
 will emit: "Fixes: 1"

(token_from_item prefers order .key, incoming token, .name)


The most surprising thing is that it uses prefix matching when finding
they key in configuration. If I have "trailer.reviewed.key=Reviewed-By"
it is possible to just '--trailer r=XYZ' and it will find the
reviewed-by trailer as "r" is a prefix of reviewedby. This also applies
to the "--parse". This in makes it impossible to have trailer keys that
are prefix of each other (e.g: "Acked", "Acked-Tests", "Acked-Docs") if
there is multiple matching in configuration it will just pick the one
that happens to come first.

(token_matches_item uses strncasecmp with token length)


I guess these are the questions for the above observations:

* Should normalization of spelling happen at all?

* If so should it only happen when there is a .key config?

* Should replacement to what is in .key happen also in --parse mode, or
  only for "--trailer"

* The prefix matching gotta be a bug, right?



Here is a patch to the tests showing these things.



From 49a4bb64a7ebf1f2d50897a024deb86b4f8056b1 Mon Sep 17 00:00:00 2001
From: Anders Waldenborg <anders@0x63.nu>
Date: Mon, 27 Jul 2020 18:34:37 +0200
Subject: [PATCH] trailers: add tests for unclear/undocumented behavior

---
 t/t7513-interpret-trailers.sh | 70 +++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 2e6d406edf..d5d19cf89b 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -99,6 +99,64 @@ test_expect_success 'with config option on the command line' '
 	test_cmp expected actual
 '

+test_expect_success 'parse normalizes spelling and separators from configs with key' '
+	cat >patch <<-\EOF &&
+		non-trailer-line
+
+		ReviEweD-bY :abc
+		ReviEwEd-bY) rst
+		ReviEweD-BY ; xyz
+		aCked-bY: not normalized
+	EOF
+	cat >expected <<-\EOF &&
+		Reviewed-By: abc
+		Reviewed-By: rst
+		Reviewed-By: xyz
+		aCked-bY: not normalized
+	EOF
+	git \
+		-c "trailer.separators=:);" \
+		-c "trailer.rb.key=Reviewed-By" \
+		-c "trailer.Acked-By.ifmissing=doNothing" \
+		interpret-trailers --parse patch >actual &&
+	test_cmp expected actual
+'
+
+# Matching currently is prefix matching, causing "This-trailer" to be normalized too
+test_expect_failure 'config option matches exact only' '
+	cat >patch <<-\EOF &&
+
+		This-trailer: a
+		 b
+		This-trailer-exact: b
+		 c
+		This-trailer-exact-plus-some: c
+		 d
+	EOF
+	cat >expected <<-\EOF &&
+		This-trailer: a b
+		THIS-TRAILER-EXACT: b c
+		This-trailer-exact-plus-some: c d
+	EOF
+	git -c "trailer.tte.key=THIS-TRAILER-EXACT" interpret-trailers --parse patch >actual &&
+	test_cmp expected actual
+'
+
+# Matching currently uses the config key even if key value is different
+test_expect_failure 'config option matches exact only' '
+	cat >patch <<-\EOF &&
+
+		Ticket: 1234
+		Reference-ticket: 99
+	EOF
+	cat >expected <<-\EOF &&
+		Ticket: 1234
+		Reference-Ticket: 99
+	EOF
+	git -c "trailer.ticket.key=Reference-Ticket" interpret-trailers --parse patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with only a title in the message' '
 	cat >expected <<-\EOF &&
 		area: change
@@ -473,6 +531,18 @@ test_expect_success 'with config setup' '
 	test_cmp expected actual
 '

+# currently this matches the "Acked-by: " value in ack key set by previous test
+test_expect_failure 'with config setup matches key exactly' '
+	cat >expected <<-\EOF &&
+
+		A: B
+	EOF
+	git interpret-trailers --trailer "A=10" empty >actual &&
+	test_cmp expected actual
+'
+
+
+
 test_expect_success 'with config setup and ":=" as separators' '
 	git config trailer.separators ":=" &&
 	git config trailer.ack.key "Acked-by= " &&
--
2.25.1
