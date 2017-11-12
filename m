Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5183201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdKLPAr (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:00:47 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:47272
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751306AbdKLPAn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 10:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1510498841;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=z9Ey0k21FG+bjeWVTXpwDZSE8tn7IR2aAegcTMTne8k=;
        b=U5Vo1EwGEz2pHqbBAd492WvzDK3u1UttKDBesXZxaYdx0UeHOM7SDAUwytT4b2T3
        y49fH5Xn5MACjWQLXC5DCBKDCauuEjjr7YizKGkjp37kSRdpcfM8U5G7OLuBKItB3xM
        +PTTX8oMlCcFvaV2N0Uz66Iq0AKDypieY0PaYE1c=
From:   Soukaina NAIT HMID <nhsoukaina@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015fb0bf3103-7448dcb3-ec22-4e67-8995-5cbea349263f-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
Subject: [add-default-config 5/5] fix return code on default + add tests
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Nov 2017 15:00:40 +0000
X-SES-Outgoing: 2017.11.12-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Soukaina NAIT HMID <snaithmid@bloomberg.net>

Signed-off-by: Soukaina NAIT HMID <snaithmid@bloomberg.net>
---
 builtin/config.c   |   9 ++-
 t/t9904-default.sh | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+), 3 deletions(-)
 create mode 100755 t/t9904-default.sh

diff --git a/builtin/config.c b/builtin/config.c
index eab81c5627091..29c5f55f27a57 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -261,9 +261,12 @@ static int get_value(const char *key_, const char *regex_)
 
 	if (values.nr == 0 && default_value) {
 		if(types == TYPE_INT || types == TYPE_BOOL || types == TYPE_BOOL_OR_INT || types == TYPE_PATH ) {
-			char* xstr = normalize_value(key, default_value);
-			fwrite(xstr, 1, strlen(xstr), stdout);
-			fwrite("\n", 1, 1, stdout);
+			if(strlen(default_value)) {
+				char* xstr = normalize_value(key, default_value);
+				fwrite(xstr, 1, strlen(xstr), stdout);
+				fwrite("\n", 1, 1, stdout);
+				ret = 0;
+			}
 		}
 	}
 	free(values.items);
diff --git a/t/t9904-default.sh b/t/t9904-default.sh
new file mode 100755
index 0000000000000..8e838f512298b
--- /dev/null
+++ b/t/t9904-default.sh
@@ -0,0 +1,232 @@
+#!/bin/sh
+
+test_description='Test default color/boolean/int/path'
+. ./test-lib.sh
+
+boolean()
+{
+	slot=$([ "$#" == 3 ] && echo $3 || echo "no.such.slot") &&
+	actual=$(git config --default "$1" --bool "$slot") &&
+	test "$actual" = "$2"
+}
+
+invalid_boolean()
+{
+	slot=$([ "$#" == 2 ] && echo $2 || echo "no.such.slot") &&
+	test_must_fail git config --default "$1" --bool "$slot"
+}
+
+test_expect_success 'empty value for boolean' '
+	invalid_boolean ""
+'
+
+test_expect_success 'true' '
+	boolean "true" "true"
+'
+
+test_expect_success '1 is true' '
+	boolean "1" "true"
+'
+
+test_expect_success 'non-zero is true' '
+	boolean "5312" "true"
+'
+
+test_expect_success 'false' '
+	boolean "false" "false"
+'
+
+test_expect_success '0 is false' '
+	boolean "0" "false"
+'
+
+test_expect_success 'invalid value' '
+	invalid_boolean "ab"
+'
+
+test_expect_success 'existing slot has priority = true' '
+	git config bool.value true &&
+	boolean "false" "true" "bool.value"
+'
+
+test_expect_success 'existing slot has priority = false' '
+	git config bool.value false &&
+	boolean "true" "false" "bool.value"
+'
+
+int()
+{
+	slot=$([ "$#" == 3 ] && echo $3 || echo "no.such.slot") &&
+	actual=$(git config --default "$1" --int "$slot") &&
+	test "$actual" = "$2"
+}
+
+invalid_int()
+{
+	slot=$([ "$#" == 2 ] && echo $2 || echo "no.such.slot") &&
+	test_must_fail git config "$1" --int "$slot"
+}
+
+test_expect_success 'empty value for int' '
+	invalid_int "" ""
+'
+
+test_expect_success 'positive' '
+	int "12345" "12345"
+'
+
+test_expect_success 'negative' '
+	int "-679032" "-679032"
+'
+
+test_expect_success 'invalid value' '
+	invalid_int "abc"
+'
+test_expect_success 'existing slot has priority = 123' '
+	git config int.value 123 &&
+	int "666" "123" "int.value"
+'
+
+test_expect_success 'existing slot with bad value' '
+	git config int.value abc &&
+	invalid_int "123" "int.value"
+'
+
+path()
+{
+	slot=$([ "$#" == 3 ] && echo $3 || echo "no.such.slot") &&
+	actual=$(git config --default "$1" --path "$slot") &&
+	test "$actual" = "$2"
+}
+
+invalid_path()
+{
+	slot=$([ "$#" == 2 ] && echo $2 || echo "no.such.slot") &&
+	test_must_fail git config "$1" --path "$slot"
+}
+
+test_expect_success 'empty path is invalid' '
+	invalid_path "" ""
+'
+
+test_expect_success 'valid path' '
+	path "/aa/bb/cc" "/aa/bb/cc"
+'
+
+test_expect_success 'existing slot has priority = /to/the/moon' '
+	git config path.value /to/the/moon &&
+	path "/to/the/sun" "/to/the/moon" "path.value"
+'
+ESC=$(printf '\033')
+
+color()
+{
+	slot=$([ "$#" == 3 ] && echo $3 || echo "no.such.slot") &&
+	actual=$(git config --default "$1" --color "$slot" ) &&
+	test "$actual" = "${2:+$ESC}$2"
+}
+
+invalid_color()
+{
+	slot=$([ "$#" == 2 ] && echo $2 || echo "no.such.slot") &&
+	test_must_fail git config --default "$1" --color "$slot"
+}
+
+test_expect_success 'reset' '
+	color "reset" "[m"
+'
+
+test_expect_success 'empty color is empty' '
+	color "" ""
+'
+
+test_expect_success 'attribute before color name' '
+	color "bold red" "[1;31m"
+'
+
+test_expect_success 'color name before attribute' '
+	color "red bold" "[1;31m"
+'
+
+test_expect_success 'attr fg bg' '
+	color "ul blue red" "[4;34;41m"
+'
+
+test_expect_success 'fg attr bg' '
+	color "blue ul red" "[4;34;41m"
+'
+
+test_expect_success 'fg bg attr' '
+	color "blue red ul" "[4;34;41m"
+'
+
+test_expect_success 'fg bg attr...' '
+	color "blue bold dim ul blink reverse" "[1;2;4;5;7;34m"
+'
+
+# note that nobold and nodim are the same code (22)
+test_expect_success 'attr negation' '
+	color "nobold nodim noul noblink noreverse" "[22;24;25;27m"
+'
+
+test_expect_success '"no-" variant of negation' '
+	color "no-bold no-blink" "[22;25m"
+'
+
+test_expect_success 'long color specification' '
+	color "254 255 bold dim ul blink reverse" "[1;2;4;5;7;38;5;254;48;5;255m"
+'
+
+test_expect_success 'absurdly long color specification' '
+	color \
+	  "#ffffff #ffffff bold nobold dim nodim italic noitalic
+	   ul noul blink noblink reverse noreverse strike nostrike" \
+	  "[1;2;3;4;5;7;9;22;23;24;25;27;29;38;2;255;255;255;48;2;255;255;255m"
+'
+
+test_expect_success '0-7 are aliases for basic ANSI color names' '
+	color "0 7" "[30;47m"
+'
+
+test_expect_success '256 colors' '
+	color "254 bold 255" "[1;38;5;254;48;5;255m"
+'
+
+test_expect_success '24-bit colors' '
+	color "#ff00ff black" "[38;2;255;0;255;40m"
+'
+
+test_expect_success '"normal" yields no color at all"' '
+	color "normal black" "[40m"
+'
+
+test_expect_success '-1 is a synonym for "normal"' '
+	color "-1 black" "[40m"
+'
+
+test_expect_success 'color too small' '
+	invalid_color "-2"
+'
+
+test_expect_success 'color too big' '
+	invalid_color "256"
+'
+
+test_expect_success 'extra character after color number' '
+	invalid_color "3X"
+'
+
+test_expect_success 'extra character after color name' '
+	invalid_color "redX"
+'
+
+test_expect_success 'extra character after attribute' '
+	invalid_color "dimX"
+'
+
+test_expect_success 'existing slot has priority = red' '
+	git config color.value red &&
+	path "blue" "red" "color.value"
+'
+
+test_done

--
https://github.com/git/git/pull/431
