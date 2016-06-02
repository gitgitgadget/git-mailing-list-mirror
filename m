From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] pathspec: allow escaped query values
Date: Thu,  2 Jun 2016 16:14:13 -0700
Message-ID: <20160602231413.9028-1-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 03 01:14:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bop-0008Rg-8O
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbcFBXOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:14:23 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34357 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbcFBXOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:14:23 -0400
Received: by mail-pa0-f41.google.com with SMTP id bz2so8880643pad.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3KnnTmxa+IeTShsuav/yVoDNmldKu2sti9szfyWOT3U=;
        b=Ae2ds06pU+pB2mnsROlRJeEsFBkgtpGDLxxWafV27+YLJg638kKfjiC4uru+1ywp5d
         FqaOVgOuQ8yXDWX3Y0VRTYqsqBiqmp8Q10ymLGGZ+Cr7/Zy5jfekoSIHeOBk2J19Ap+W
         M01KlPnFGKP51TV8F/Yq4VS3BMJw/dMV+1f3Q4LmSyYZK3YpJoDDotYtkpwnI80ll96F
         xYcSuhDPI86eym2FijWW6iv4G2+mT6PoK+0ESVHiHzAvZlSPW/9VS+GOKk9FGQmMVyj6
         u7SizC1mKFPktxgDWx/JXrjWZTs2FQdoRxBcmtdZXKUeFmhIW/3TuTNptHGIqJZwl9YA
         95bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3KnnTmxa+IeTShsuav/yVoDNmldKu2sti9szfyWOT3U=;
        b=Kejm0ZSeP8fgs0Zq0jBm1a8gf0qUxHfeF2R0AUpIQ36lFWdNgiKbs3ZG4Vp0GrKE6B
         oLbSrSiK/HzUmPHygwzMA0hAmyWIlwnjwDadyEn1PrpyDy2imSYyTtbaXYW/B9Zv7Yyf
         ZhQ9V/ZKzfI1MLRSYdmbyIeEQuw7XH8Ql1E5lL3O/xTb32gZYygeL8MO3HzFc9mtSPVb
         x9mKd2G9VoNes4kVII3MALPNZU6eOV7vkGS3xOwVB6oVzFhrB2m9fWzoPEC4rJVLJlXD
         vZPp0pnj/O9/WxX4IICbOjsIucZJFgK1LwZEP9nrnAci3FJGjA+peXbrTtp+Eti9coT6
         U+vA==
X-Gm-Message-State: ALyK8tLnszo2PZVeGe6I1fb90nisVk3Zd7xxuug8LSLzjTq18t01DA1zf5h1e1hVpIydB01J
X-Received: by 10.66.249.161 with SMTP id yv1mr686237pac.39.1464909256842;
        Thu, 02 Jun 2016 16:14:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69fd:2c70:2aa5:9d28])
        by smtp.gmail.com with ESMTPSA id vy8sm789589pab.22.2016.06.02.16.14.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Jun 2016 16:14:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.126.g9068a9d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296259>

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


> That would be true _only_ when "find next escape and copy up to that
> byte" aka "scanning once with optimized strchr(), and copying once
> with optimized memmove()" is faster than "scanning once and copying"
> loop.

Oh right. that would work for larger strings that don't fit into a cache
very well, but in our expected case this will do.

> I was merely reacting to your use of memmove() in a very different
> loop, where if you unescape "a\b\c\defghijk", your memmove() would
> move "efghijk" many times.

Right, at the time of writing I didn't like it, but was ok with it as
we only have a few escapes.

> Also the handling of the terminating NUL may need to be
> updated.

I don't think so.

> That is why I did not say "replace yours with this", but
> merely "along the lines of this" ;-)

This is pretty much your code modulo nits (xmalloz, semicolons) now,
and I am convinced it works by the test.

However if we add a value restriction here, we need to be as strict in the
.gitattributes parsing as well and put a warning there (similar to
invalid_attr_name_message) I would think.

Thanks,
Stefan

 pathspec.c                      | 52 +++++++++++++++++++++++++++++++++++++----
 t/t6134-pathspec-with-labels.sh | 10 ++++++++
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 326863a..fe53ddf 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -89,6 +89,51 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
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
+		if (*src && invalid_value_char(*src))
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
@@ -166,7 +210,7 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
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
