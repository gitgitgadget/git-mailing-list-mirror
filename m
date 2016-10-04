Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BC020986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbcJDWzE (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:55:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59506 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751602AbcJDWzD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:55:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C393F44C00;
        Tue,  4 Oct 2016 18:55:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=XUKQ
        tWCJDmQHK5j2tDFkOp+35Fg=; b=SybW8UxXy39GMkk1PzMAx7TOq3FLxFou6XRw
        AGSZBVo/96+3OwQlTArivEk3KDawzVb26GYA0Tsg9RXFZmc1JJ6PBDdR2gQl5jDI
        E92+D1dBvSaQMZ7iMgjjwfZPlpBSLkfVLg2umT9m1PoL8TLmWby9FbxPBBvI8RFE
        LUke1DA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        cy0pOFv2jUUKg0x0V3fBifFZJbWRlfttCQhULY0o6QaCzYeSY1Ui3tdEqLXZkd9e
        /jFR9IiRzuBmN1DQmfZ5UkH8nbQAo08aXj1rUqhNOXFCT3KTTPhWtMmSSPGwrbIa
        k0f4UX1myPR2IyqiXgrpu+kqHdvOjB3cpZyR+wJydCc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA88F44BFD;
        Tue,  4 Oct 2016 18:55:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D95244BF9;
        Tue,  4 Oct 2016 18:55:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, strk@kbt.io
Subject: [PATCH 4/4] diff: introduce diff.wsErrorHighlight option
Date:   Tue,  4 Oct 2016 15:54:49 -0700
Message-Id: <20161004225449.6759-5-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-510-g1ef781f2c1
In-Reply-To: <20161004225449.6759-1-gitster@pobox.com>
References: <xmqqk2douhe0.fsf@gitster.mtv.corp.google.com>
 <20161004225449.6759-1-gitster@pobox.com>
X-Pobox-Relay-ID: 94E54764-8A85-11E6-80D8-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the preparatory steps, it has become trivial to teach the
system a new diff.wsErrorHighlight configuration that gives the
default value for --ws-error-highlight command line option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-config.txt  |  6 ++++++
 Documentation/diff-options.txt |  2 ++
 diff.c                         | 11 ++++++++++-
 t/t4015-diff-whitespace.sh     | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6eaa45271c..c0396e66a5 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -182,3 +182,9 @@ diff.algorithm::
 	low-occurrence common elements".
 --
 +
+
+diff.wsErrorHighlight::
+	A comma separated list of `old`, `new`, `context`, that
+	specifies how whitespace errors on lines are highlighted
+	with `color.diff.whitespace`.  Can be overridden by the
+	command line option `--ws-error-highlight=<kind>`
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 306b7e3604..dfd6bc99c6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -303,6 +303,8 @@ ifndef::git-format-patch[]
 	lines are highlighted.  E.g. `--ws-error-highlight=new,old`
 	highlights whitespace errors on both deleted and added lines.
 	`all` can be used as a short-hand for `old,new,context`.
+	The `diff.wsErrorHighlight` configuration variable can be
+	used to specify the default behaviour.
 
 endif::git-format-patch[]
 
diff --git a/diff.c b/diff.c
index bd625cf3f7..9acf04f5b0 100644
--- a/diff.c
+++ b/diff.c
@@ -41,6 +41,7 @@ static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 static long diff_algorithm;
+static unsigned ws_error_highlight_default = WSEH_NEW;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -262,6 +263,14 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.wserrorhighlight")) {
+		int val = parse_ws_error_highlight(value);
+		if (val < 0)
+			return -1;
+		ws_error_highlight_default = val;
+		return 0;
+	}
+
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -3306,7 +3315,7 @@ void diff_setup(struct diff_options *options)
 	options->rename_limit = -1;
 	options->dirstat_permille = diff_dirstat_permille_default;
 	options->context = diff_context_default;
-	options->ws_error_highlight = WSEH_NEW;
+	options->ws_error_highlight = ws_error_highlight_default;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
 
 	/* pathchange left =NULL by default */
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 4a4f374824..289806d0c7 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -937,4 +937,39 @@ test_expect_success 'test --ws-error-highlight option' '
 
 '
 
+test_expect_success 'test diff.wsErrorHighlight config' '
+
+	git -c color.diff=always -c diff.wsErrorHighlight=default,old diff |
+	test_decode_color >current &&
+	test_cmp expect.default-old current &&
+
+	git -c color.diff=always -c diff.wsErrorHighlight=all diff |
+	test_decode_color >current &&
+	test_cmp expect.all current &&
+
+	git -c color.diff=always -c diff.wsErrorHighlight=none diff |
+	test_decode_color >current &&
+	test_cmp expect.none current
+
+'
+
+test_expect_success 'option overrides diff.wsErrorHighlight' '
+
+	git -c color.diff=always -c diff.wsErrorHighlight=none \
+		diff --ws-error-highlight=default,old |
+	test_decode_color >current &&
+	test_cmp expect.default-old current &&
+
+	git -c color.diff=always -c diff.wsErrorHighlight=default \
+		diff --ws-error-highlight=all |
+	test_decode_color >current &&
+	test_cmp expect.all current &&
+
+	git -c color.diff=always -c diff.wsErrorHighlight=all \
+		diff --ws-error-highlight=none |
+	test_decode_color >current &&
+	test_cmp expect.none current
+
+'
+
 test_done
-- 
2.10.1-510-g1ef781f2c1

