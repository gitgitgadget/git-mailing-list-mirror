Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3776DC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5260F22
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbhJGUdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:33:51 -0400
Received: from mta-07-4.privateemail.com ([68.65.122.27]:61913 "EHLO
        MTA-07-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbhJGUds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:33:48 -0400
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id 558C618000A6;
        Thu,  7 Oct 2021 16:31:54 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.224])
        by mta-07.privateemail.com (Postfix) with ESMTPA id C553E18000A0;
        Thu,  7 Oct 2021 16:31:53 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH v11 3/3] grep: fix an edge case concerning ascii patterns and UTF-8 data
Date:   Thu,  7 Oct 2021 16:31:48 -0400
Message-Id: <20211007203148.23888-3-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007203148.23888-1-someguy@effective-light.com>
References: <20211007203148.23888-1-someguy@effective-light.com>
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

So, to fix this teach the grep code to mark the pattern as UTF-8 (even if
the pattern is composed of only ascii characters), so long as the log
output is encoded using UTF-8.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 grep.c                          |  6 +++--
 grep.h                          |  1 +
 revision.c                      |  2 ++
 t/t7812-grep-icase-non-ascii.sh | 48 +++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index fe847a0111..978d30f053 100644
--- a/grep.c
+++ b/grep.c
@@ -382,8 +382,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
-	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
+	if ((opt->utf8_all_the_things && !has_non_ascii(p->pattern)) ||
+	    (!opt->ignore_locale && is_utf8_locale() &&
+	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
+					    (p->fixed || p->is_fixed))))
 		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
 
 #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
diff --git a/grep.h b/grep.h
index 808ad76f0c..c9ddd637d1 100644
--- a/grep.h
+++ b/grep.h
@@ -167,6 +167,7 @@ struct grep_opt {
 	int extended_regexp_option;
 	int pattern_type_option;
 	int ignore_locale;
+	int utf8_all_the_things;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
 	unsigned post_context;
diff --git a/revision.c b/revision.c
index 0dabb5a0bc..0d751dceb7 100644
--- a/revision.c
+++ b/revision.c
@@ -2874,6 +2874,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				 &revs->grep_filter);
 	if (!is_encoding_utf8(get_log_output_encoding()))
 		revs->grep_filter.ignore_locale = 1;
+	else
+		revs->grep_filter.utf8_all_the_things = 1;
 	compile_grep_patterns(&revs->grep_filter);
 
 	if (revs->reverse && revs->reflog_info)
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index e5d1e4ea68..42323b31c0 100755
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
+	export GIT_COMMITTER_NAME="Ç O Mîtter" &&
+	export GIT_COMMITTER_EMAIL="committer@example.com" &&
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

