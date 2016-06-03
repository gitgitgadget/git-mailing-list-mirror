From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4] pathspec: allow escaped query values
Date: Fri,  3 Jun 2016 12:19:30 -0700
Message-ID: <20160603191930.16973-1-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 03 21:22:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8udG-0004Nn-H4
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 21:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbcFCTTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 15:19:37 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35553 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbcFCTTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 15:19:36 -0400
Received: by mail-pf0-f182.google.com with SMTP id g64so46479978pfb.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=a4oKtTlPt9kmtYxVGJYg36uSfqNJ8vWSLioYXfUCzjo=;
        b=nsu7vbEAN7mkWzeUMeXIGuEn5prltY9DJkvDq5/sJ7IqFmDPki1iasuxwuy1tGF6xR
         upFVypjhfjqqOU25QnSGnCh5GUUIFfWIlwnmvrih9SQRIp7tHLyfSrNMZWUDEZhqLy84
         YSvQ/5CPlM3o5ynwST/mEEnH5Qi+Xn5BTyt7cvKWArYhjz2X1qYzZYARgMbJ7mF5+G6O
         FCfph2DN6zPuld0Vyc72zRE7rfoBEXHl7RW6nA5TFpQ/7xW0a3a6SX7pXinVCiZan1w6
         w9XZXpg78LMxtnTxafdAO21vwCwQxIuHXd6vEa1ea74PW5XIaChVBqbKoMk3mvY4nKz0
         Ikrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a4oKtTlPt9kmtYxVGJYg36uSfqNJ8vWSLioYXfUCzjo=;
        b=FfFTZaXNnFhsuAMOyT6wRamAPp7dGuLbR12/Hi2Sr+btp36f5j03sRO5tOo/NGzAGu
         03fgNbyjFE5HICqzLBfxn+T5XQeVcjZEOo1EehkoCzhHBui+svHVWxfwyBK5YgP4La9M
         guzSC9xz/wyv2XKn8OrgU/k4gb8H03lm50WN7rzMyt8fTUi9+sy/ykkI49wh8eB4w9gv
         k55+QTIEJmlxgu6ZMxqrjxLDfHgJOreUhLT9js39+qUbZVlpuyDEsmbMqbJRq4ZOAEvo
         x//6bvxKqkXMwSScyahM3DC3jly1q4cxlin6JvKBaZ6pHdBRFFtMWkSFFo5rEpKyX2IN
         R0OA==
X-Gm-Message-State: ALyK8tKzxFowMfD4VpMxqNIoynPZRczwxWpZ531FRWM/W2Le0gZioOvA0I4jG4JqwlA70pOn
X-Received: by 10.98.93.93 with SMTP id r90mr7762646pfb.65.1464981575231;
        Fri, 03 Jun 2016 12:19:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:642c:ea7c:525:3838])
        by smtp.gmail.com with ESMTPSA id 132sm10150569pfc.52.2016.06.03.12.19.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 12:19:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.126.g9068a9d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296367>

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
---

differences to v3 (http://thread.gmane.org/gmane.comp.version-control.git/296259):
* lose the *src check before invalid_value_char
* remove a stray new line in parse_pathspec_attr_match

Thanks,
Stefan

 pathspec.c                      | 53 +++++++++++++++++++++++++++++++++++++----
 t/t6134-pathspec-with-labels.sh | 10 ++++++++
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 326863a..a32e379 100644
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
index a5c9632..f1e355f 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -163,4 +163,14 @@ test_expect_success 'abort on asking for wrong magic' '
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
2.8.2.126.g9068a9d.dirty
