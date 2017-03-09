Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6BA202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 21:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdCIVIN (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 16:08:13 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34344 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdCIVIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 16:08:12 -0500
Received: by mail-pf0-f174.google.com with SMTP id v190so33127720pfb.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 13:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPY5sRoEz3UzFG9nY2on1NSDmOoNIoGARRUyWXuKur0=;
        b=Xd+rQm/iDdTYUfnRL9v0a35GVMp/dUR6lx6ptwVQnXBsJx2Kyfa8gr7vXLsfk30hCd
         YSDeNjuWirSGOJnF3K4rWWcau0vBWSK4NArsi6mO06Ak1zbIz+WNO1KpBc03byNt+X8z
         Y0D6Z2P8iEv1uw29FoQYe7S/5IvFhh4Ijp7LyQRlYGtHd9nzfCDVMuOh3CtswAU5+gu6
         d8vdvlt/Z6HgNmO2QnQUHpFizga5EpljaLJUxyOERtPRCu2CrdoaAhSIx9YhhVpt0FBd
         HkkhVURDjuLNFpCmODGdZa+GtRXm/uklEQIiT/t9q2PhMiqICS5KflyzwoPe5+dKWGd8
         bAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OPY5sRoEz3UzFG9nY2on1NSDmOoNIoGARRUyWXuKur0=;
        b=h7tY26dWXli2O/O2dey/OhGNqbBzqTkyo/dyecZKpWjhzskHzFe8ZClm6KlNKe0kdi
         wZg219qIPS6LH/QzoQ+UqeQTvOlD728z23B6hTYnjT6nyQ7H4mA0YGjsRQSDfcNoLVF/
         lcq8u2cHzdaK5e0pV/CXb4HYB0/GxgSPH67yZItKKvHbIszV0NJQhyc4xvafPkJQEGvi
         QiPLHIBX+cNIqLGCUqOYzZGmCHJjOmX/o1n7/tzUMOSGKzY8hCBtEIDyKvV7e42UCqNP
         pStFtt9wOXitnmW31+ihLXQDaM9leUtDYJ+ba4iLkGD6W73TBcTAIWkgNBd4mqnYy3S7
         iRzg==
X-Gm-Message-State: AMke39kWzuiLmD69SPfG5t+PMUfMKobJYY1nzTDD+rLM8dsNVqdPbPIXLMEc4eMMJF9JeKTM
X-Received: by 10.99.65.67 with SMTP id o64mr16083231pga.119.1489093690330;
        Thu, 09 Mar 2017 13:08:10 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id s21sm14270000pgg.65.2017.03.09.13.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 13:08:09 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com
Subject: [PATCH 2/2] pathspec: allow escaped query values
Date:   Thu,  9 Mar 2017 13:07:56 -0800
Message-Id: <20170309210756.105566-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309210756.105566-1-bmwill@google.com>
References: <20170309210756.105566-1-bmwill@google.com>
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
First `parse_long_magic` needs to not stop early upon seeing a comma or
closing paren that is escaped. As a second step we need to remove any
escaping from the attr value.

Based on a patch by Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c                     | 52 ++++++++++++++++++++++++++++++++++++++----
 t/t6135-pathspec-with-attrs.sh |  9 ++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 583ed5208..f89f84a83 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -89,6 +89,51 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
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
@@ -133,10 +178,9 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
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
@@ -239,7 +283,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 	const char *nextat;
 
 	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
-		size_t len = strcspn(pos, ",)");
+		size_t len = strcspn_escaped(pos, ",)");
 		int i;
 
 		if (pos[len] == ',')
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index b5e5a0607..585d17bad 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -178,4 +178,13 @@ test_expect_success 'abort on asking for wrong magic' '
 	test_must_fail git ls-files . ":(attr:!label=foo)"
 '
 
+test_expect_success 'check attribute list' '
+	cat <<-EOF >>.gitattributes &&
+	* whitespace=indent,trail,space
+	EOF
+	git ls-files ":(attr:whitespace=indent\,trail\,space)" >actual &&
+	git ls-files >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.246.ga2ecc84866-goog

