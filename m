Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89ACB20281
	for <e@80x24.org>; Tue,  7 Nov 2017 06:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754809AbdKGGkS (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 01:40:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50638 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754796AbdKGGkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 01:40:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BCBDA91DD;
        Tue,  7 Nov 2017 01:40:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=gaLe
        y96Kjyde2IyjFNC6KKiv6DE=; b=SywljefC7VFMSbCntP7mArdrw5Wr6cIH0VC+
        wZMG77ZhaGu5iqzGAyHr4RXTHWvY94OVctSBeqZUa6aHEA4m/yyXPErX/lRf02zl
        s6/7tV9bXpsQxmqKn0XBieeT/50G6rnG6VUmZ+MvaLW7iqJLxTelMhGoZzN8xyr0
        qzXVH38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=BmyHG3
        cwSmqe/JjWmzAmYxNeaa7nNJw/cVD4Arfr3jh+yp3J+frDurrPWGhqeSQtJWwdm9
        OVofGMmCkhwFtDyiEJL6atJWwvW8a521G8kN3OUBy6b0O3oqbyHQbHV/z0u5gG1e
        NOcoqWAf7qryQU6pEXGPxlslnJxc5DfdjjBbk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 331E9A91DC;
        Tue,  7 Nov 2017 01:40:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9047DA91DB;
        Tue,  7 Nov 2017 01:40:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/2] diff: --ignore-cr-at-eol
Date:   Tue,  7 Nov 2017 15:40:11 +0900
Message-Id: <20171107064011.18399-3-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-263-g47cc852023
In-Reply-To: <20171107064011.18399-1-gitster@pobox.com>
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
 <20171107064011.18399-1-gitster@pobox.com>
X-Pobox-Relay-ID: 836CF582-C386-11E7-BA8D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new option --ignore-cr-at-eol tells the diff machinery to treat a
carriage-return at the end of a (complete) line as if it does not
exist.

This would make it easier to review a change whose only effect is to
turn line endings from CRLF to LF or the other way around.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt     |  3 +++
 Documentation/merge-strategies.txt |  5 +++--
 diff.c                             |  2 ++
 merge-recursive.c                  |  2 ++
 t/t4015-diff-whitespace.sh         | 28 ++++++++++++++++++++++++++++
 xdiff/xdiff.h                      |  4 +++-
 xdiff/xutils.c                     | 38 ++++++++++++++++++++++++++++++++++++--
 7 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48de..aa2c0ff74d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -519,6 +519,9 @@ endif::git-format-patch[]
 --text::
 	Treat all files as text.
 
+--ignore-cr-at-eol::
+	Ignore carrige-return at the end of line when doing a comparison.
+
 --ignore-space-at-eol::
 	Ignore changes in whitespace at EOL.
 
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2eb92b9327..030744910e 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -57,11 +57,12 @@ diff-algorithm=[patience|minimal|histogram|myers];;
 ignore-space-change;;
 ignore-all-space;;
 ignore-space-at-eol;;
+ignore-cr-at-eol;;
 	Treats lines with the indicated type of whitespace change as
 	unchanged for the sake of a three-way merge.  Whitespace
 	changes mixed with other changes to a line are not ignored.
-	See also linkgit:git-diff[1] `-b`, `-w`, and
-	`--ignore-space-at-eol`.
+	See also linkgit:git-diff[1] `-b`, `-w`,
+	`--ignore-space-at-eol`, and `--ignore-cr-at-eol`.
 +
 * If 'their' version only introduces whitespace changes to a line,
   'our' version is used;
diff --git a/diff.c b/diff.c
index 790250fe86..dd14e4190c 100644
--- a/diff.c
+++ b/diff.c
@@ -3888,6 +3888,8 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
+	else if (!strcmp(arg, "--ignore-cr-at-eol"))
+		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
 	else if (!strcmp(arg, "--indent-heuristic"))
diff --git a/merge-recursive.c b/merge-recursive.c
index 7a7d55aabe..006b94baf2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2214,6 +2214,8 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		DIFF_XDL_SET(o, IGNORE_WHITESPACE);
 	else if (!strcmp(s, "ignore-space-at-eol"))
 		DIFF_XDL_SET(o, IGNORE_WHITESPACE_AT_EOL);
+	else if (!strcmp(s, "ignore-cr-at-eol"))
+		DIFF_XDL_SET(o, IGNORE_CR_AT_EOL);
 	else if (!strcmp(s, "renormalize"))
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 289806d0c7..32dd54c21d 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -106,6 +106,8 @@ test_expect_success 'another test, without options' '
 	git diff -w -b --ignore-space-at-eol >out &&
 	test_cmp expect out &&
 
+	git diff -w --ignore-cr-at-eol >out &&
+	test_cmp expect out &&
 
 	tr "Q_" "\015 " <<-\EOF >expect &&
 	diff --git a/x b/x
@@ -128,6 +130,9 @@ test_expect_success 'another test, without options' '
 	git diff -b --ignore-space-at-eol >out &&
 	test_cmp expect out &&
 
+	git diff -b --ignore-cr-at-eol >out &&
+	test_cmp expect out &&
+
 	tr "Q_" "\015 " <<-\EOF >expect &&
 	diff --git a/x b/x
 	index d99af23..22d9f73 100644
@@ -145,6 +150,29 @@ test_expect_success 'another test, without options' '
 	 CR at end
 	EOF
 	git diff --ignore-space-at-eol >out &&
+	test_cmp expect out &&
+
+	git diff --ignore-space-at-eol --ignore-cr-at-eol >out &&
+	test_cmp expect out &&
+
+	tr "Q_" "\015 " <<-\EOF >expect &&
+	diff --git a/x b/x
+	index_d99af23..22d9f73 100644
+	--- a/x
+	+++ b/x
+	@@ -1,6 +1,6 @@
+	-whitespace at beginning
+	-whitespace change
+	-whitespace in the middle
+	-whitespace at end
+	+_	whitespace at beginning
+	+whitespace_	_change
+	+white space in the middle
+	+whitespace at end__
+	 unchanged line
+	 CR at end
+	EOF
+	git diff --ignore-cr-at-eol >out &&
 	test_cmp expect out
 '
 
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index cbf5d8e166..51f8926215 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -33,9 +33,11 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE (1 << 1)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 3)
+#define XDF_IGNORE_CR_AT_EOL (1 << 4)
 #define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | \
 			      XDF_IGNORE_WHITESPACE_CHANGE | \
-			      XDF_IGNORE_WHITESPACE_AT_EOL)
+			      XDF_IGNORE_WHITESPACE_AT_EOL | \
+			      XDF_IGNORE_CR_AT_EOL)
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 04d7b32e4e..b2cbcc818f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -156,6 +156,24 @@ int xdl_blankline(const char *line, long size, long flags)
 	return (i == size);
 }
 
+/*
+ * Have we eaten everything on the line, except for an optional
+ * CR at the very end?
+ */
+static int ends_with_optional_cr(const char *l, long s, long i)
+{
+	int complete = s && l[s-1] == '\n';
+
+	if (complete)
+		s--;
+	if (s == i)
+		return 1;
+	/* do not ignore CR at the end of an incomplete line */
+	if (complete && s == i + 1 && l[i] == '\r')
+		return 1;
+	return 0;
+}
+
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
 	int i1, i2;
@@ -170,7 +188,8 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 
 	/*
 	 * -w matches everything that matches with -b, and -b in turn
-	 * matches everything that matches with --ignore-space-at-eol.
+	 * matches everything that matches with --ignore-space-at-eol,
+	 * which in turn matches everything that matches with --ignore-cr-at-eol.
 	 *
 	 * Each flavor of ignoring needs different logic to skip whitespaces
 	 * while we have both sides to compare.
@@ -204,6 +223,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 			i1++;
 			i2++;
 		}
+	} else if (flags & XDF_IGNORE_CR_AT_EOL) {
+		/* Find the first difference and see how the line ends */
+		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
+			i1++;
+			i2++;
+		}
+		return (ends_with_optional_cr(l1, s1, i1) &&
+			ends_with_optional_cr(l2, s2, i2));
 	}
 
 	/*
@@ -230,9 +257,16 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 		char const *top, long flags) {
 	unsigned long ha = 5381;
 	char const *ptr = *data;
+	int cr_at_eol_only = (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL;
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
-		if (XDL_ISSPACE(*ptr)) {
+		if (cr_at_eol_only) {
+			/* do not ignore CR at the end of an incomplete line */
+			if (*ptr == '\r' &&
+			    (ptr + 1 < top && ptr[1] == '\n'))
+				continue;
+		}
+		else if (XDL_ISSPACE(*ptr)) {
 			const char *ptr2 = ptr;
 			int at_eol;
 			while (ptr + 1 < top && XDL_ISSPACE(ptr[1])
-- 
2.15.0-263-g47cc852023

