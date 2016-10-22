Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D066320986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965136AbcJVXeA (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:34:00 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37536 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965071AbcJVXdg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:36 -0400
Received: by mail-it0-f44.google.com with SMTP id m138so74605407itm.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tYewk5TW8kaUI69BjX6JuKWIjXSHc9wrc0FSyk4e8B4=;
        b=YJCI04IMjH2wk0G/U7FR5dZRyeongzBi0263zUpQeUM9SEr7yKbRAhbht18EIJpuSK
         RMe7Zn3KLxoXyHXnd7EXb1Iyi/2MP/YS/8P24q7NCk2krjnQ2jBNvjCUjFepO6XKCYM8
         tlbyH0W7mwFXcT3WKesGJwbFEJJwPJuFRmbN+mgVsKBhYAoiL7nEaXHPQXW2Na/e9/n8
         4cW7AK3ajMFlwH/GAlYrcuu7pGf3uD+ELirqxz55kArWU5cqOqUflS8zuPVTLDb1wAFR
         3LhEPOZzBbnBaXfqor5t0GGt8pvvA3VpIkwAHLD2qr20TxmNXDcqQ5HngU94s6/HIFDt
         l+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tYewk5TW8kaUI69BjX6JuKWIjXSHc9wrc0FSyk4e8B4=;
        b=T7WpinOECj8Av90hSq7SPmH3Q9dc2oNFYYZMbT+5JLAaJQSULvAomh9yKoEsfT2TK1
         cOtTwMH645fo+Y0IRXqA2KBuLofBhqjeJu2OmsomU2zEZuK1sDRHUxmDpNs0pVgIyVgn
         /0G6NDZpyBAOkC3CrxiNeNOHupruYcDeXgMbxIlOMuGipilRLZxsu5Hu7NmPWWrgiuWi
         WJt9W2YjyUQCx079kZItFVWbUcRcvXN/dulSMbWwV4L0VAInKibG1MvTrdV48XoeHzMm
         iYYudcBUi+AecLXVVW44zHTb2VOm5WtK2Zf/uA+7I56+yEdrvd2+t3GJW1nXojkLScaG
         nOew==
X-Gm-Message-State: ABUngvf+rTgANq83c5MjnR05E1RPGOwQB8JXuOzeifNRWqotCpYpkj3Q7Mf+KNyYyxy7bsEv
X-Received: by 10.107.158.85 with SMTP id h82mr8679847ioe.152.1477179215873;
        Sat, 22 Oct 2016 16:33:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id 80sm4550174iot.36.2016.10.22.16.33.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 33/36] pathspec: allow escaped query values
Date:   Sat, 22 Oct 2016 16:32:22 -0700
Message-Id: <20161022233225.8883-34-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our own .gitattributes file we have attributes such as:

    *.[ch] whitespace=indent,trail,space

When querying for attributes we want to be able to ask for the exact
value, i.e.

    git ls-files :(attr:whitespace=indent,trail,space)

should work, but the commas are used in the attr magic to introduce
the next attr, such that this query currently fails with

fatal: Invalid pathspec magic 'trail' in ':(attr:whitespace=indent,trail,space)'

This change allows escaping characters by a backslash, such that the query

    git ls-files :(attr:whitespace=indent\,trail\,space)

will match all path that have the value "indent,trail,space" for the
whitespace attribute. To accomplish this, we need to modify two places.
First `eat_long_magic` needs to not stop early upon seeing a comma or
closing paren that is escaped. As a second step we need to remove any
escaping from the attr value.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pathspec.c                      | 53 +++++++++++++++++++++++++++++++++++++----
 t/t6134-pathspec-with-labels.sh | 10 ++++++++
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 0eee177..3832e03 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -89,12 +89,56 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static size_t strcspn_escaped(const char *s, const char *stop)
+{
+	const char *i;
+
+	for (i = s; *i; i++) {
+		/* skip the escaped character */
+		if (i[0] == '\\' && i[1]) {
+			i++;
+			continue;
+		}
+
+		if (strchr(stop, *i))
+			break;
+	}
+	return i - s;
+}
+
+static inline int invalid_value_char(const char ch)
+{
+	if (isalnum(ch) || strchr(",-_", ch))
+		return 0;
+	return -1;
+}
+
+static char *attr_value_unescape(const char *value)
+{
+	const char *src;
+	char *dst, *ret;
+
+	ret = xmallocz(strlen(value));
+	for (src = value, dst = ret; *src; src++, dst++) {
+		if (*src == '\\') {
+			if (!src[1])
+				die(_("Escape character '\\' not allowed as "
+				      "last character in attr value"));
+			src++;
+		}
+		if (invalid_value_char(*src))
+			die("cannot use '%c' for value matching", *src);
+		*dst = *src;
+	}
+	*dst = '\0';
+	return ret;
+}
+
 static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
 {
 	struct string_list_item *si;
 	struct string_list list = STRING_LIST_INIT_DUP;
 
-
 	if (!value || !strlen(value))
 		die(_("attr spec must not be empty"));
 
@@ -131,10 +175,9 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 			if (attr[attr_len] != '=')
 				am->match_mode = MATCH_SET;
 			else {
+				const char *v = &attr[attr_len + 1];
 				am->match_mode = MATCH_VALUE;
-				am->value = xstrdup(&attr[attr_len + 1]);
-				if (strchr(am->value, '\\'))
-					die(_("attr spec values must not contain backslashes"));
+				am->value = attr_value_unescape(v);
 			}
 			break;
 		}
@@ -166,7 +209,7 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 	for (copyfrom = elt + 2;
 	     *copyfrom && *copyfrom != ')';
 	     copyfrom = nextat) {
-		size_t len = strcspn(copyfrom, ",)");
+		size_t len = strcspn_escaped(copyfrom, ",)");
 		if (copyfrom[len] == ',')
 			nextat = copyfrom + len + 1;
 		else
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
index 1c9323c..f5f8413 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -167,4 +167,14 @@ test_expect_success 'abort on asking for wrong magic' '
 	test_must_fail git ls-files . ":(attr:!label=foo)"
 '
 
+test_expect_success 'check attribute list' '
+	cat <<-EOF >>.gitattributes &&
+	* whitespace=indent,trail,space
+	EOF
+	cat .gitattributes &&
+	git ls-files ":(attr:whitespace=indent\,trail\,space)" >actual &&
+	git ls-files >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.1.508.g6572022

