Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD641FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933875AbdCJS7l (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:59:41 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33050 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933093AbdCJS7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:59:33 -0500
Received: by mail-pg0-f47.google.com with SMTP id 25so41960048pgy.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FeAKBPK3mxE/xQppHsIHRP/ckJjZUbFMSQZIngbQGlY=;
        b=K5i+egPBjxitpieHt/xYgcKBrR01XUICFl7ggx69YMAM7m7bjR8sLAO2mHlnQj7CpZ
         YolFRTSYZmuy49BvgtKdl1v1nxwX49JcAuShXmNC8aaJVYkk8rj3vS4uWISIXcuKxoki
         aJPLNE9uO8p1gRku7Yr0+KK0GimU1KO63ikOth6aZOEV4vhTle2imuSzbaMvay4M/kG2
         h6sc9Pst2UCS2mh/zcgHG+u42kF/hjZq6P71bGgId9vhxdl15X1a38dsV7j7L8sd4Ug+
         3P+plImGWsPpBbD+h1v7lF6ALwqDKLS7IeGRGhnmbtD1p3ozPagFUJ1ldk5jBE0WBLGX
         7pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FeAKBPK3mxE/xQppHsIHRP/ckJjZUbFMSQZIngbQGlY=;
        b=YrZm4b2pus1BauQGDmjawHjbZ+F6a55GK3h0fyo+2P68JlfdGfJsknb0e2Mqh5cISx
         azq5UNXwJcORd0nN+Qh7gx1aZ7jghWSe20RyTemSXv9SmMeFNBIgcrv0NHcRB10YLbFG
         Or6L60jSKcvkHTl/9Ru+vaY5Fcv3baMFMKm/5ttFLwQoY8BYv83SVxwicPXSOP3oLatM
         tnTOBB4CRhvdqc45VzQlMWAv3PWfKqeZVY9ZIUALSVjpuyp9bbdxRvapdI4iXMt2a2d5
         H4rhiDgmbV9a9z6mvF6PxC2MPBJmf7sLZOalyEnW6SE5NF+kAIP+xwxdpTPi2SIJyuwZ
         bKMA==
X-Gm-Message-State: AMke39ne17cK/u1myV7ggK4dcPTWO8O5HtIqBC+HUvPzIsZ+F+x25P4aX4Vl73Lj/xjyO7ZW
X-Received: by 10.99.7.206 with SMTP id 197mr21901074pgh.95.1489172357238;
        Fri, 10 Mar 2017 10:59:17 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id h3sm20023941pfc.82.2017.03.10.10.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 10:59:16 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, jonathantanmy@google.com
Subject: [PATCH v2 2/2] pathspec: allow escaped query values
Date:   Fri, 10 Mar 2017 10:59:08 -0800
Message-Id: <20170310185908.171589-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170310185908.171589-1-bmwill@google.com>
References: <20170309210756.105566-1-bmwill@google.com>
 <20170310185908.171589-1-bmwill@google.com>
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
 t/t6135-pathspec-with-attrs.sh | 19 +++++++++++++++
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 7cd5f6e3d..d7956f6bf 100644
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
@@ -241,7 +285,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 	const char *nextat;
 
 	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
-		size_t len = strcspn(pos, ",)");
+		size_t len = strcspn_escaped(pos, ",)");
 		int i;
 
 		if (pos[len] == ',')
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index b5e5a0607..f60af29a9 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -178,4 +178,23 @@ test_expect_success 'abort on asking for wrong magic' '
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
+test_expect_success 'backslash cannot be the last character' '
+	test_must_fail git ls-files ":(attr:label=foo\\ labelA=bar)" 2>actual &&
+	test_i18ngrep "not allowed as last character in attr value" actual
+'
+
+test_expect_success 'backslash cannot be used as a value' '
+	test_must_fail git ls-files ":(attr:label=f\\\oo)" 2>actual &&
+	test_i18ngrep "for value matching" actual
+'
+
 test_done
-- 
2.12.0.246.ga2ecc84866-goog

