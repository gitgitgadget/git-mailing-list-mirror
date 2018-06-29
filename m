Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A28B1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030293AbeF2AUb (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:31 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:36874 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2AU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:28 -0400
Received: by mail-it0-f73.google.com with SMTP id 129-v6so339625itb.2
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/HRm1Umg+RVGwog3pOObLfz5iN27C3CF0K9k4zXSNpU=;
        b=dhSQ0gEI8JBLnbGHMa1aulmeTrXP0facRdy33HYQeHlevsfpREHGIhlDtF8B1q89Bi
         v+hYpodAIVExZvWiADX07INBq9ww0ittRVb+erj0WlIVEu5qVtIrAOdtl7Rn4nMjDMzY
         N3p+fJlswqdG4GEpsOO5+GdkpWOft91z1Zbqqo747JFCpmNUTm7Rii5uW+ilpeP/ZAG0
         Aqa5uIESmEeXmsAGG1unJg1uviOExnUJV//jM+XMW1ad7zQEz5DxoyGMcIIgJ4twLj/r
         WU442JEgGIar5/yVurw2EhlBG/f8zLsxne2M1Q7dRjUbCLNrIztaf/inwl7dE9pfvedw
         g91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/HRm1Umg+RVGwog3pOObLfz5iN27C3CF0K9k4zXSNpU=;
        b=ajju9EOuuBi7jKGZHyGtueMStq3XHHQpAt089MydTJSNZghB2f6Yry2eWIbzon/gYB
         9tiIRJx4j8UTV4Y08nvvd2WkUw4sqy9wORW5ZqkldU+/xvFY0utyjZQ/PZgBv4du/CSa
         SMElnaRyCukFwKkjBWw9hC0HxIt2qy0GuqLD7YpWJqbKHdn4SYy7cDpzrjRMJIKpUNQD
         iCkpJjMKO3SMwhtgT/Z4q2mU6h5H5LsuW8zql1sTIn1oSyVmRCuMnewqHz6TL82R9Ydx
         y+M0Jg7pUixMzFt9TY4itPW6I9mV3V2mF8AE+DS4fLj68iyAluxWdWOqXKibXUkYLrR9
         cYUg==
X-Gm-Message-State: APt69E0+ff53rpdWRRDXLnHx1H/WC17T++X2+Odis0mD+k/FFNsCjRG7
        RAb9H0czT/vW3tNgl+Zpcc50zViJW2WB
X-Google-Smtp-Source: AAOMgpcrOL886z6NZGGcyy8n1YBCKZHhEXOzaPADWMBu9EvfvA5Bk0oy/xGvW6FQQcHmu+Zj81MN2U4oxsET
MIME-Version: 1.0
X-Received: by 2002:a24:5e11:: with SMTP id h17-v6mr39785itb.2.1530231627960;
 Thu, 28 Jun 2018 17:20:27 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:56 -0700
In-Reply-To: <20180629001958.85143-1-sbeller@google.com>
Message-Id: <20180629001958.85143-8-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 7/9] diff.c: decouple white space treatment from move
 detection algorithm
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original implementation of the move detection logic the choice for
ignoring white space changes is the same for the move detection as it is
for the regular diff.  Some cases came up where different treatment would
have been nice.

Allow the user to specify that white space should be ignored differently
during detection of moved lines than during generation of added and removed
lines. This is done by providing analogs to the --ignore-space-at-eol,
-b, and -w options by introducing the option --color-moved-ws=<modes>
with the modes named "ignore-space-at-eol", "ignore-space-change" and
"ignore-all-space", which is used only during the move detection phase.

As we change the default, we'll adjust the tests.

For now we do not infer any options to treat white spaces in the move
detection from the generic white space options given to diff.
This can be tuned later to reasonable default.

As we plan on adding more white space related options in a later patch,
that interferes with the current white space options, use a flag field
and clamp it down to  XDF_WHITESPACE_FLAGS, as that (a) allows to easily
check at parse time if we give invalid combinations and (b) can reuse
parts of this patch.

By having the white space treatment in its own option, we'll also
make it easier for a later patch to have an config option for
spaces in the move detection.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 17 +++++++++
 diff.c                         | 39 +++++++++++++++++++--
 diff.h                         |  1 +
 t/t4015-diff-whitespace.sh     | 64 +++++++++++++++++++++++++++++++---
 4 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ba56169de31..80e29e39854 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -292,6 +292,23 @@ dimmed_zebra::
 	blocks are considered interesting, the rest is uninteresting.
 --
 
+--color-moved-ws=<modes>::
+	This configures how white spaces are ignored when performing the
+	move detection for `--color-moved`. These modes can be given
+	as a comma separated list:
++
+--
+ignore-space-at-eol::
+	Ignore changes in whitespace at EOL.
+ignore-space-change::
+	Ignore changes in amount of whitespace.  This ignores whitespace
+	at line end, and considers all other sequences of one or
+	more whitespace characters to be equivalent.
+ignore-all-space::
+	Ignore whitespace when comparing lines. This ignores differences
+	even if one line has whitespace where the other line has none.
+--
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
diff --git a/diff.c b/diff.c
index 95c51c0b7df..70eeb40c5fd 100644
--- a/diff.c
+++ b/diff.c
@@ -283,6 +283,36 @@ static int parse_color_moved(const char *arg)
 		return error(_("color moved setting must be one of 'no', 'default', 'blocks', 'zebra', 'dimmed_zebra', 'plain'"));
 }
 
+static int parse_color_moved_ws(const char *arg)
+{
+	int ret = 0;
+	struct string_list l = STRING_LIST_INIT_DUP;
+	struct string_list_item *i;
+
+	string_list_split(&l, arg, ',', -1);
+
+	for_each_string_list_item(i, &l) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, i->string);
+		strbuf_trim(&sb);
+
+		if (!strcmp(sb.buf, "ignore-space-change"))
+			ret |= XDF_IGNORE_WHITESPACE_CHANGE;
+		else if (!strcmp(sb.buf, "ignore-space-at-eol"))
+			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
+		else if (!strcmp(sb.buf, "ignore-all-space"))
+			ret |= XDF_IGNORE_WHITESPACE;
+		else
+			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
+
+		strbuf_release(&sb);
+	}
+
+	string_list_clear(&l, 0);
+
+	return ret;
+}
+
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
@@ -717,10 +747,12 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
 	const struct moved_entry *a = entry;
 	const struct moved_entry *b = entry_or_key;
+	unsigned flags = diffopt->color_moved_ws_handling
+			 & XDF_WHITESPACE_FLAGS;
 
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
-				    diffopt->xdl_opts);
+				    flags);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -728,8 +760,9 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 {
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
+	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
-	ret->ent.hash = xdiff_hash_string(l->line, l->len, o->xdl_opts);
+	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
 	ret->es = l;
 	ret->next_line = NULL;
 
@@ -4710,6 +4743,8 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm < 0)
 			die("bad --color-moved argument: %s", arg);
 		options->color_moved = cm;
+	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
+		options->color_moved_ws_handling = parse_color_moved_ws(arg);
 	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
diff --git a/diff.h b/diff.h
index 7bd4f182c33..de5dc680051 100644
--- a/diff.h
+++ b/diff.h
@@ -214,6 +214,7 @@ struct diff_options {
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
+	int color_moved_ws_handling;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index e54529f026d..0c737a47cf8 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1460,7 +1460,8 @@ test_expect_success 'move detection ignoring whitespace ' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -w --color-moved --color >actual.raw &&
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-ws=ignore-all-space >actual.raw &&
 	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
@@ -1522,7 +1523,8 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -b --color-moved --color >actual.raw &&
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-ws=ignore-space-change >actual.raw &&
 	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
@@ -1587,7 +1589,8 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color >actual.raw &&
+	git diff HEAD --no-renames --color-moved --color \
+		--color-moved-ws=ignore-space-at-eol >actual.raw &&
 	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
@@ -1757,7 +1760,60 @@ test_expect_success 'move detection with submodules' '
 
 	# nor did we mess with it another way
 	git diff --submodule=diff --color | test_decode_color >expect &&
-	test_cmp expect decoded_actual
+	test_cmp expect decoded_actual &&
+	rm -rf bananas &&
+	git submodule deinit bananas
+'
+
+test_expect_success 'only move detection ignores white spaces' '
+	git reset --hard &&
+	q_to_tab <<-\EOF >text.txt &&
+		a long line to exceed per-line minimum
+		another long line to exceed per-line minimum
+		original file
+	EOF
+	git add text.txt &&
+	git commit -m "add text" &&
+	q_to_tab <<-\EOF >text.txt &&
+		Qa long line to exceed per-line minimum
+		Qanother long line to exceed per-line minimum
+		new file
+	EOF
+
+	# Make sure we get a different diff using -w
+	git diff --color --color-moved -w |
+		grep -v "index" |
+		test_decode_color >actual &&
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/text.txt b/text.txt<RESET>
+	<BOLD>--- a/text.txt<RESET>
+	<BOLD>+++ b/text.txt<RESET>
+	<CYAN>@@ -1,3 +1,3 @@<RESET>
+	 Qa long line to exceed per-line minimum<RESET>
+	 Qanother long line to exceed per-line minimum<RESET>
+	<RED>-original file<RESET>
+	<GREEN>+<RESET><GREEN>new file<RESET>
+	EOF
+	test_cmp expected actual &&
+
+	# And now ignoring white space only in the move detection
+	git diff --color --color-moved \
+		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol |
+		grep -v "index" |
+		test_decode_color >actual &&
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/text.txt b/text.txt<RESET>
+	<BOLD>--- a/text.txt<RESET>
+	<BOLD>+++ b/text.txt<RESET>
+	<CYAN>@@ -1,3 +1,3 @@<RESET>
+	<BOLD;MAGENTA>-a long line to exceed per-line minimum<RESET>
+	<BOLD;MAGENTA>-another long line to exceed per-line minimum<RESET>
+	<RED>-original file<RESET>
+	<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>a long line to exceed per-line minimum<RESET>
+	<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>another long line to exceed per-line minimum<RESET>
+	<GREEN>+<RESET><GREEN>new file<RESET>
+	EOF
+	test_cmp expected actual
 '
 
 test_done
-- 
2.18.0.399.gad0ab374a1-goog

