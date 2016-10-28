Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA600203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034387AbcJ1S4p (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:45 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33523 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034309AbcJ1S40 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:26 -0400
Received: by mail-pf0-f177.google.com with SMTP id 197so41764089pfu.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q5F9EHHFZovxXnLhZs74I04QRRNMEbTy8PscUfdR64w=;
        b=Po/vdOynh96J8dqT7O2x/2srNHdjiMbHL99mLXn8jmD/k8HFUI/qDDdOC44j9DJE+g
         IF0q6P5aPXCA3VN/tSUjDSHqcipIqm2mFFocDCnJIUFNp/HKXPuNGPXWkMLdA93DBU+B
         APGDcuKHiQblIZg5r1ghsRNQ16phMom4XOlsxTcKkAlDIy8BNuK7g4QrZvv+wOIOXEw2
         2XKH8HBLDSgEdxiVPZ57VdV13csj8v4wGXexU7sY3vSrfD/nGQVvElpV2JNPmhghlcDN
         y8WmEZfYsdL6nOREQKtYIkJZltl6nWiVcMFGNNB/7xCcSPXQSk0yDKJFzDNkOBRLQXP0
         pCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q5F9EHHFZovxXnLhZs74I04QRRNMEbTy8PscUfdR64w=;
        b=aQA77kG5SA856lJJhxB80DLtiJs5tErhZlgoMQblEsbgBqzxTwAUYDR5mxuOXivAvI
         ZotoFMOGnMoQQFror3YqWQ9oKGjRduHn7b9Bq/0rJJAe7HYDimiv50q0SIeT6q6jeUrm
         IhhMhx7ONBYZEzVE9K92gJdpBrbLFubOEgX1CZw6nBiO3UACbJCVktHvOlRtiUhFFsuJ
         4WkFA1rqr/R2ZJOUtjTCBFnWtzdhT0YSak3Y2iN074NVk12DnBtQBXRKc3JUdRiYtEq8
         /c/P4ahxd9E9nXDETSH2llw8mBKem6QX8MEnR9DCBOjv2jRyZMBVBXpoCt04iPb1psDw
         t0Rg==
X-Gm-Message-State: ABUngvfehg3dr3JZZxBlqLY84Nxxw7IJV1f12Z1YAIVHxDvHpHPccWhxOHcqyrmESRiWaP+h
X-Received: by 10.98.131.197 with SMTP id h188mr3241669pfe.86.1477680985867;
        Fri, 28 Oct 2016 11:56:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id ah5sm20588489pad.30.2016.10.28.11.56.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 33/36] pathspec: allow escaped query values
Date:   Fri, 28 Oct 2016 11:54:59 -0700
Message-Id: <20161028185502.8789-34-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
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
index 478449eec5..e8d20a0962 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -90,13 +90,57 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
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
 	struct argv_array attrs = ARGV_ARRAY_INIT;
 
-
 	if (!value || !strlen(value))
 		die(_("attr spec must not be empty"));
 
@@ -128,10 +172,9 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
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
@@ -168,7 +211,7 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 	for (copyfrom = elt + 2;
 	     *copyfrom && *copyfrom != ')';
 	     copyfrom = nextat) {
-		size_t len = strcspn(copyfrom, ",)");
+		size_t len = strcspn_escaped(copyfrom, ",)");
 		if (copyfrom[len] == ',')
 			nextat = copyfrom + len + 1;
 		else
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
index 643e8ac35a..3d03e0a6e0 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -172,4 +172,14 @@ test_expect_success 'abort on asking for wrong magic' '
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
2.10.1.714.ge3da0db

