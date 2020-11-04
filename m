Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE6BC388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935DB20759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J/cHc/bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgKDUfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:35:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57624 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgKDUfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:35:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C549F84C0;
        Wed,  4 Nov 2020 15:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HMl79bi+vkr3+Q3ns3qlGVp0/iQ=; b=J/cHc/
        bnfU4JW3YvuRMCGALqKEwQO9Zln2n80faVnRzPOcpb3MceURDZauEEYptRvG7esI
        YNpmGNto9MJcDB6QhGvT6yka0qGq5WgfdqFJcxtbVpkGV1/CE8lg76Kh1phYHRLh
        9QmZ+9XmTL/3muOhuPO0B2yIQ7U7aP0A1T5T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WU5PY9T6Y0kGLZ7pD+QXby+VMTR8dbGF
        bDp5leRlpHia10Z2cfjQNq6upQ0XUyhWt0uRiYhm83EeLNTKcWTdqxqSiK14wmH0
        Vsuc57XkqFoYtl9ggwn9WvQ7l+tNvFX5lwiNjb+3AE+GTh0JrNTTfQ/PmhWI7Yfs
        DfE1NkhbRXA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 844C3F84BF;
        Wed,  4 Nov 2020 15:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA4D3F84BC;
        Wed,  4 Nov 2020 15:35:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: [PATCH] log: diagnose -L used with pathspec as an error
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
        <20201102144321.GA3962443@coredump.intra.peff.net>
        <20201103101553.GH24813@szeder.dev>
        <20201103182102.GA459792@coredump.intra.peff.net>
        <xmqq361qs31a.fsf@gitster.c.googlers.com>
        <20201103185711.GA461461@coredump.intra.peff.net>
        <xmqqimamqjhl.fsf@gitster.c.googlers.com>
        <xmqq7dr1nh3a.fsf_-_@gitster.c.googlers.com>
        <20201104194155.GA3060815@coredump.intra.peff.net>
        <xmqq361onahn.fsf@gitster.c.googlers.com>
Date:   Wed, 04 Nov 2020 12:35:10 -0800
In-Reply-To: <xmqq361onahn.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 04 Nov 2020 12:16:36 -0800")
Message-ID: <xmqqy2jglv29.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C9CA430-1EDD-11EB-8F7D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -L option is documented to accept no pathspec, but the
command line option parser has allowed the combination without
checking so far.  Ensure that there is no pathspec when the -L
option is in effect to fix this.

Incidentally, this change fixes another bug in the command line
option parser, which has allowed the -L option used together
with the --follow option.  Because the latter requires exactly
one path given, but the former takes no pathspec, they become
mutually incompatible automatically.  Because the -L option
follows renames on its own, there is no reason to give --follow
at the same time.

The new tests say they may fail with "-L and --follow being
incompatible" instead of "-L and pathspec being imcompatible".
Currently the expected failure can come only from the latter, but
this is to futureproof them, in case we decide to add code to
explicititly die on -L and --follow used together.

Heled-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c       |  3 +++
 t/t4211-line-log.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

 * This time, as a standalone patch, instead of a comment in a
   discussion thread.

diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef9..9d70f3e60b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -206,6 +206,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
 
+	if (rev->line_level_traverse && rev->prune_data.nr)
+		die(_("-L<range>:<file> cannot be used with pathspec"));
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 2d1d7b5d19..b85c4a8a04 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -8,6 +8,32 @@ test_expect_success 'setup (import history)' '
 	git reset --hard
 '
 
+test_expect_success 'basic command line parsing' '
+	# This may fail due to "no such path a.c in commit", or
+	# "-L is incompatible with pathspec", depending on the
+	# order the error is checked.  Either is acceptable.
+	test_must_fail git log -L1,1:a.c -- a.c &&
+
+	# This must fail due to "-L is incompatible with pathspec".
+	test_must_fail git log -L1,1:b.c -- b.c 2>error &&
+	test_i18ngrep "cannot be used with pathspec" error &&
+
+	# Note that incompatibility between -L/--follow is not
+	# explicitly checked to avoid redundant code and the comments
+	# on the following tests are merely for future-proofing.
+
+	# These must fail due to "follow requires one pathspec", or
+	# "-L is incompatible with --follow", depending on the
+	# order the error is checked.  Either is acceptable.
+	test_must_fail git log -L1,1:b.c --follow &&
+	test_must_fail git log --follow -L1,1:b.c &&
+
+	# This may fail due to "-L is incompatible with pathspec", or
+	# "-L is incompatible with --follow", depending on the
+	# order the error is checked.  Either is acceptable.
+	test_must_fail git log --follow -L1,1:b.c -- b.c
+'
+
 canned_test_1 () {
 	test_expect_$1 "$2" "
 		git log $2 >actual &&
-- 
2.29.2-287-gba574db674

