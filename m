Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F1E2018A
	for <e@80x24.org>; Thu, 23 Jun 2016 16:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbcFWQ3i (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33428 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcFWQ3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:35 -0400
Received: by mail-lf0-f67.google.com with SMTP id l188so18917159lfe.0
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rH2/5cwcdCc+P95WPzesckZFkSWX80xzfYap26XEKFE=;
        b=nhS3GDmxu/yy/HDvnqWSqV+XxDaRvMNCiObJq0TuxZbg1MHJ/7vjnSO10gCXkRK39u
         iJavGJrCGjqNB/iZy8yr9vAXtY/pN0q5w1UPc4eaSh+uk40Bol6fyMDv7Wmly5C0oaUd
         za8CMMeFOeoiezHE9n6MKuBsJd4LUWonfO1YJYi0uZo6SL4oggldEsKNsD3HEDOz4aQR
         yj5KpYArM+dF6oqFL23wrb0vXwiqFmo61nEIcX7mc8cY1q0NNamrtZBaEf6OzUFoxGX9
         E/NwCj46naf+oA4tQGvZLMT7gb4hNwPl0s5WT9FInJiyDIduV5Fq0Wk+xkWIKac8PXZc
         xGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rH2/5cwcdCc+P95WPzesckZFkSWX80xzfYap26XEKFE=;
        b=QZRakL35PrWELHvY+thuB9YQ6p/jZsf0hwKqfh+KKo669CJCuJ0E2iVdoES+kyCGlq
         OnVzCuWJxIUuxHKOyV0ZhH7iXTmPj0ZICUtLgpEDAMS92Wb36g9niYDvsn+VVgWyZQ3b
         v9Q5sCr8ZpAfIcag6iaO/8/eS/19fFs8FJjnOvXGrZQWQwJgGj/3P1qIfN/qgsaOvO9R
         tU9ZJlHRRRzcQNWeEx1vloWi07VhwQ/AyWP12ju3mVksOWCzlCe8u53h8pymhOzWER0w
         ndPkTW/Mu0amHauet5PwKNJVgph6HDXLrPkWPSK4mZuv9kuCdP7JvuiapPaM63u/qwHb
         Cb8w==
X-Gm-Message-State: ALyK8tJPgFxNFyQuUCBTmAyfsnzUxMZF1IrtJ5e2uw9GdDaH5MJkcKrBHYDkK2C5GXffsw==
X-Received: by 10.25.141.75 with SMTP id p72mr9763015lfd.86.1466699373332;
        Thu, 23 Jun 2016 09:29:33 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:32 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/11] grep/icase: avoid kwsset on literal non-ascii strings
Date:	Thu, 23 Jun 2016 18:29:00 +0200
Message-Id: <20160623162907.23295-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When we detect the pattern is just a literal string, we avoid heavy
regex engine and use fast substring search implemented in kwsset.c.
But kws uses git-ctype which is locale-independent so it does not know
how to fold case properly outside ascii range. Let regcomp or pcre
take care of this case instead. Slower, but accurate.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                                   |  7 ++++++-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh

diff --git a/grep.c b/grep.c
index 609f218..f192727 100644
--- a/grep.c
+++ b/grep.c
@@ -4,6 +4,7 @@
 #include "xdiff-interface.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "commit.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -398,14 +399,18 @@ static int is_fixed(const char *s, size_t len)
 
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
+	int icase, ascii_only;
 	int err;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
+	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
+	ascii_only     = !has_non_ascii(p->pattern);
 
 	if (opt->fixed) {
 		p->fixed = 1;
-	} else if (is_fixed(p->pattern, p->patternlen))
+	} else if ((!icase || ascii_only) &&
+		   is_fixed(p->pattern, p->patternlen))
 		p->fixed = 1;
 	else
 		p->fixed = 0;
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
new file mode 100755
index 0000000..b78a774
--- /dev/null
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='grep icase on non-English locales'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_LOCALE 'setup' '
+	test_write_lines "TILRAUN: Halló Heimur!" >file &&
+	git add file &&
+	LC_ALL="$is_IS_locale" &&
+	export LC_ALL
+'
+
+test_have_prereq GETTEXT_LOCALE &&
+test-regex "HALLÓ" "Halló" ICASE &&
+test_set_prereq REGEX_LOCALE
+
+test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
+	git grep -i "TILRAUN: Halló Heimur!" &&
+	git grep -i "TILRAUN: HALLÓ HEIMUR!"
+'
+
+test_done
-- 
2.8.2.526.g02eed6d

