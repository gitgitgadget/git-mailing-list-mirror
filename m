Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D319A20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966131AbcKJUff (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:35 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34078 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965625AbcKJUfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:19 -0500
Received: by mail-pf0-f178.google.com with SMTP id n85so151869504pfi.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2KSoMdzsdUEmnCUk2sySCOvP2d36weorz+jjtdPlZ04=;
        b=AyHrFh/i1nI5JuMLsH12XRYFznNqKiuBKxWkqAlyOVio7uJR1tLoC2Od+YsnkJ3yaz
         6uFVHzcCrO/RP+JtutUFAERTVGP3CwEtiaILu7ISvX9JT+QcqRZoVDOeZODtNFzrpgsf
         SUEXzxIawcCNkUUvdLZ5ENnhDM9oifkXWXG0q04JKfjoPBXNP/CY6nLRmAUFrpTxyOL6
         +k3VquL9iTYN2K7V685KlOzB80wnbyBr0s926vYLaY3yW9i8wFbDG7GT3UGy4YPjy6e9
         XJg+8HQqz82qSOdOdsxvMVjqNvMjxac4m/0so57Vb2aSEf8BQf5/1fe4mULM4ya3b04S
         d9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2KSoMdzsdUEmnCUk2sySCOvP2d36weorz+jjtdPlZ04=;
        b=bE6k5ddUHXpxZ32mnlzrCJaL29ciSEB17qJfdSWWow1ctKpHqAvxn3MiTOsHhaA7qG
         FaBm4FIsoCpbZ1IqA/D7l5yjU3YS9WeO5fg7nasD+cQ3YcluafuxedvaJnZL9GaFufIJ
         iSjo+DyfWBoxveHplNFiXfGRWQ9eKKOV7OKPc7VUqQ0TcYcN6zA5qBot4ypr5iwwocdJ
         NP+QolPWfeGiuthAkIuMdx4V2eWSjieUrwvOmY4M6HGP9h+IBZ7PSvqjmUMW1NRpbWa9
         2A3uAlKfH7boa1qTp4pFx1dXhgcQEkWhxnu+RiXZth5E75ReYZU5tdTqCfcbIY1Qm4K4
         CHVg==
X-Gm-Message-State: ABUngvcZSLWABmwwCqFoRTZ4rftUHRFdQnmlCpYBuzo0aOxZOsA0GtiWCUIQwQkyoPJbxf6P
X-Received: by 10.99.171.67 with SMTP id k3mr24863928pgp.2.1478810118094;
        Thu, 10 Nov 2016 12:35:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id w24sm7160387pfa.9.2016.11.10.12.35.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 32/35] pathspec: allow escaped query values
Date:   Thu, 10 Nov 2016 12:34:25 -0800
Message-Id: <20161110203428.30512-33-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
index 4aa7ea5..d702803 100644
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
index e276811..5aafc0c 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -188,4 +188,14 @@ test_expect_success 'abort on asking for wrong magic' '
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
2.10.1.469.g00a8914

