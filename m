Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA138C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94F661090
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbhJOQQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:16:15 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:33662 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236325AbhJOQQL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Oct 2021 12:16:11 -0400
Received: from MTA-11-4.privateemail.com (mta-11-1.privateemail.com [198.54.118.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 1C985803DE
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:14:04 -0400 (EDT)
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
        by mta-11.privateemail.com (Postfix) with ESMTP id 077B418000B1;
        Fri, 15 Oct 2021 12:14:03 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.246])
        by mta-11.privateemail.com (Postfix) with ESMTPA id 64D3E18000A2;
        Fri, 15 Oct 2021 12:14:02 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii patterns and UTF-8 data
Date:   Fri, 15 Oct 2021 12:13:56 -0400
Message-Id: <20211015161356.3372-3-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015161356.3372-1-someguy@effective-light.com>
References: <20211015161356.3372-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we attempt to grep non-ascii log message text with an ascii pattern, we
run into the following issue:

    $ git log --color --author='.var.*Bjar' -1 origin/master | grep ^Author
    grep: (standard input): binary file matches

So, to fix this teach the grep code to use PCRE2_UTF, as long as the log
output is encoded in UTF-8.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
v12: get rid of utf8_all_the_things and fix an issue with one of the unit
     tests.

v13: make some clarifications in the commit message.
---
 grep.c                          |  6 +++--
 t/t7812-grep-icase-non-ascii.sh | 48 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index fe847a0111..f6e113e9f0 100644
--- a/grep.c
+++ b/grep.c
@@ -382,8 +382,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
-	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
+	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
+	    (!opt->ignore_locale && is_utf8_locale() &&
+	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
+					    (p->fixed || p->is_fixed))))
 		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
 
 #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index e5d1e4ea68..22487d90fd 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -53,6 +53,54 @@ test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
 	test_cmp expected actual
 '
 
+test_expect_success GETTEXT_LOCALE,PCRE 'log --author with an ascii pattern on UTF-8 data' '
+	cat >expected <<-\EOF &&
+	Author: <BOLD;RED>À Ú Thor<RESET> <author@example.com>
+	EOF
+	test_write_lines "forth" >file4 &&
+	git add file4 &&
+	git commit --author="À Ú Thor <author@example.com>" -m sécond &&
+	git log -1 --color=always --perl-regexp --author=".*Thor" >log &&
+	grep Author log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success GETTEXT_LOCALE,PCRE 'log --committer with an ascii pattern on ISO-8859-1 data' '
+	cat >expected <<-\EOF &&
+	Commit:     Ç<BOLD;RED> O Mîtter <committer@example.com><RESET>
+	EOF
+	test_write_lines "fifth" >file5 &&
+	git add file5 &&
+	GIT_COMMITTER_NAME="Ç O Mîtter" &&
+	GIT_COMMITTER_EMAIL="committer@example.com" &&
+	git -c i18n.commitEncoding=latin1 commit -m thïrd &&
+	git -c i18n.logOutputEncoding=latin1 log -1 --pretty=fuller --color=always --perl-regexp --committer=" O.*" >log &&
+	grep Commit: log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success GETTEXT_LOCALE,PCRE 'log --grep with an ascii pattern on UTF-8 data' '
+	cat >expected <<-\EOF &&
+	    sé<BOLD;RED>con<RESET>d
+	EOF
+	git log -1 --color=always --perl-regexp --grep="con" >log &&
+	grep con log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success GETTEXT_LOCALE,PCRE 'log --grep with an ascii pattern on ISO-8859-1 data' '
+	cat >expected <<-\EOF &&
+	    <BOLD;RED>thïrd<RESET>
+	EOF
+	git -c i18n.logOutputEncoding=latin1 log -1 --color=always --perl-regexp --grep="th.*rd" >log &&
+	grep "th.*rd" log >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: setup invalid UTF-8 data' '
 	printf "\\200\\n" >invalid-0x80 &&
 	echo "ævar" >expected &&
-- 
2.33.0

