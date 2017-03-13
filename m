Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC021FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbdCMSXg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:23:36 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35372 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751703AbdCMSXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:23:31 -0400
Received: by mail-pg0-f45.google.com with SMTP id b129so66925333pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7Ej8dznBekfaF0ePsn0XNgA9A01qUfRFsT/38vwkUM=;
        b=KOkWiqK7XlAtPYRb7mBBgos97VNjXhWGbHbGf/rkV3C3f5ciw3KVXzqG3Af/oy/42+
         St+P45rE9n8ZjLSyafcTEG1bnKiN6teaXtl4JDR8DQ9uTRTOlhHeCegUSyYXMMM3wknX
         O05JJ8A3ICj3whGlEatgA79hytk6bbA+3kQ3IDmBbKDMz+hrn89r0FgszUHu+A/xAjJL
         G3BQuapMh06XdFxP7LcBLLRYZjWt/b2jcr16E4o2uuqwRkXMsgkHZahpFqbExZoT+XQ8
         Spb29X53ordM3AGERSb/yCkt02AqRCi3QBzL2RxA6E/bVpDh5R3GiD5KoKbvwzY4Bq2f
         0iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7Ej8dznBekfaF0ePsn0XNgA9A01qUfRFsT/38vwkUM=;
        b=NZiNTjtxEk/2DhJycfUu/SKfXzZQOdnUtRLLw1HPUPQWSYZV18Ux2AHjfY+r6IujZ9
         kHwRk3rIkyXyVd2AREO0DxATlXAJIMbphZp+nqDOsZoDw6bCkaNzKwuKvOe0MYef69x/
         AqW1TBwEJX6SBZv7fuN/r672nLCWD8HX88OGX549YRR391tgzuk5L3GYkHmd0CGcz+3o
         aYX8Jyg5UvAKWakd6ei83IxjIBZ8ROIktIi1kAVfn6tKia2XZVbCoB+vECSLl0WRjMpu
         oFTmdScxcHR2lxR+1ULTrZ3LU+C0yY2DbRECJuXEP7KbyfTCw933E70ob5QX/rqKf6qm
         W0og==
X-Gm-Message-State: AMke39mdXk55eRZ7PxotvIzcRp2YOA11rlpFLTfHDxkwENtzcBb6JFSXPS0joCIgHxjUhOFj
X-Received: by 10.84.136.34 with SMTP id 31mr49229687plk.52.1489429410125;
        Mon, 13 Mar 2017 11:23:30 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z4sm22875320pge.49.2017.03.13.11.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 11:23:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, jonathantanmy@google.com
Subject: [PATCH v3 2/2] pathspec: allow escaped query values
Date:   Mon, 13 Mar 2017 11:23:22 -0700
Message-Id: <20170313182322.27539-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313182322.27539-1-bmwill@google.com>
References: <20170310185908.171589-1-bmwill@google.com>
 <20170313182322.27539-1-bmwill@google.com>
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
index 608511c52..303efda83 100644
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
@@ -131,10 +176,9 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
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
index 3f06fcf8d..77b8cef66 100755
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

