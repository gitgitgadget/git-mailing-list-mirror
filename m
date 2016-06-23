Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00822018A
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbcFWQ3p (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36478 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbcFWQ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id a2so18848246lfe.3
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohUNHCHWTkZ7J2kIbFUGt2GvHVGuj0wS5tBVjNfH8Cg=;
        b=s8LNheSZFWdOdULTILabdDT+E377J6trZLt8VTxbBRSw+Y/eihJXXxitJFvBGHOWDd
         Ls9GEWndwhM5i69r5eTQZbRPrmEB8lCPMfHj7ojUeAEpSThLafkHozn2E8e22K5/ieeN
         Kxg9fYOZ0Zp0P8Uj0i3cZ5Ox223yJEX9cf1175s5ewRL5DlCrIbMJY4J2bpGrWGsY1lp
         dg2MQZcRMRB4NW8FpiMwkmubSAnvTX2RPJME82isShdufrnuMSyKGqqg5d/JTogLctgD
         yP8/mPsHN2d7iymYpR2EBo2Qzf9j8VkmUdKhu/nN81w4qtPGajOo97saw+kQYm5XyiNB
         E+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohUNHCHWTkZ7J2kIbFUGt2GvHVGuj0wS5tBVjNfH8Cg=;
        b=lJ9x9ZWjg8Yd+JPHhJ8/DyNegeAW4MvAbhbjMsK01aeBBjbx9C7W3Kv3zJEeQVDB0K
         ogm8zl4x1gDvaiOFsNJF85DrL3aTgYrIQyFYG/OafSNc4B2s4kj5kwktW7GVUli6n29+
         Z/dVdZTFO+NgPDfMJK2MjfYdDeJ3wQQeQdzgs55LXyr2ptFYlJNTT6t9K5mX+2FgjBkL
         0QWwvLqbe/p0r/I/B+ifsB1mT3HDsDCS+CjCnJk3vJYmq8yZSKsiob7b1I4iyKIQ6O3z
         GwFAGS0dNw0SPOadHOfjWippFE4BarvXNuZhQnv7lohwjOm3g/eVw3ksLBA6bY8AglQb
         NQjQ==
X-Gm-Message-State: ALyK8tIGGKgaoKGGrGKt6vDZd+BJK5BE7KrKWwPaY2qTKQ/3jBXSWTz1wezX1wrQRr70zw==
X-Received: by 10.25.87.83 with SMTP id l80mr13178121lfb.159.1466699377769;
        Thu, 23 Jun 2016 09:29:37 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:37 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/11] grep/pcre: support utf-8
Date:	Thu, 23 Jun 2016 18:29:04 +0200
Message-Id: <20160623162907.23295-9-pclouds@gmail.com>
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

In the previous change in this function, we add locale support for
single-byte encodings only. It looks like pcre only supports utf-* as
multibyte encodings, the others are left in the cold (which is
fine).

We need to enable PCRE_UTF8 so pcre can find character boundary
correctly. It's needed for case folding (when --ignore-case is used)
or '*', '+' or similar syntax is used.

The "has_non_ascii()" check is to be on the conservative side. If
there's non-ascii in the pattern, the searched content could still be
in utf-8, but we can treat it just like a byte stream and everything
should work. If we force utf-8 based on locale only and pcre validates
utf-8 and the file content is in non-utf8 encoding, things break.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c                          |  2 ++
 t/t7812-grep-icase-non-ascii.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/grep.c b/grep.c
index 22f4d99..6e99b01 100644
--- a/grep.c
+++ b/grep.c
@@ -329,6 +329,8 @@ static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 			p->pcre_tables = pcre_maketables();
 		options |= PCRE_CASELESS;
 	}
+	if (is_utf8_locale() && has_non_ascii(p->pattern))
+		options |= PCRE_UTF8;
 
 	p->pcre_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
 				      p->pcre_tables);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 1929809..08ae4c9 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -20,6 +20,21 @@ test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
 	git grep -i "TILRAUN: HALLÓ HEIMUR!"
 '
 
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 icase' '
+	git grep --perl-regexp    "TILRAUN: H.lló Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.lló Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LLÓ HEIMUR!"
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 string with "+"' '
+	test_write_lines "TILRAUN: Hallóó Heimur!" >file2 &&
+	git add file2 &&
+	git grep -l --perl-regexp "TILRAUN: H.lló+ Heimur!" >actual &&
+	echo file >expected &&
+	echo file2 >>expected &&
+	test_cmp expected actual
+'
+
 test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Halló Heimur!"  2>&1 >/dev/null |
 		 grep fixed >debug1 &&
-- 
2.8.2.526.g02eed6d

