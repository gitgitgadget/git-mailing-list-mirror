Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694CDC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 08:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4593461AA9
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 08:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244825AbhKRIrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:47:19 -0500
Received: from MTA-15-4.privateemail.com ([198.54.127.111]:54935 "EHLO
        MTA-15-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244897AbhKRIpT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 03:45:19 -0500
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id 23EE21800189;
        Thu, 18 Nov 2021 03:42:13 -0500 (EST)
Received: from hal-station.. (unknown [10.20.151.201])
        by mta-15.privateemail.com (Postfix) with ESMTPA id 42F5818000BD;
        Thu, 18 Nov 2021 03:42:11 -0500 (EST)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] grep/pcre2: limit the instances in which UTF mode is enabled
Date:   Thu, 18 Nov 2021 03:41:42 -0500
Message-Id: <20211118084143.279174-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UTF mode is enabled for cases that cause older versions of PCRE to break.
This is primarily due to the fact that we can't make as many assumptions on
the kind of data that is fed to "git grep." So, limit when UTF mode can be
enabled by introducing "is_log" to struct grep_opt, checking to see if it's
a non-zero value in compile_pcre2_pattern() and only mutating it in
cmd_log() so that we know "git log" was invoked if it's set to a non-zero
value.

Fixes: ae39ba431a (grep/pcre2: fix an edge case concerning ascii patterns
and UTF-8 data, 2021-10-15)
Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 builtin/log.c                   | 1 +
 grep.c                          | 2 +-
 grep.h                          | 1 +
 t/t7812-grep-icase-non-ascii.sh | 2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7..040b0b533f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -751,6 +751,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	git_config(git_log_config, NULL);
 
 	repo_init_revisions(the_repository, &rev, prefix);
+	rev.grep_filter.is_log = 1;
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
diff --git a/grep.c b/grep.c
index f6e113e9f0..665d86f007 100644
--- a/grep.c
+++ b/grep.c
@@ -382,7 +382,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
+	if ((opt->is_log && !opt->ignore_locale && !has_non_ascii(p->pattern)) ||
 	    (!opt->ignore_locale && is_utf8_locale() &&
 	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
 					    (p->fixed || p->is_fixed))))
diff --git a/grep.h b/grep.h
index 3e8815c347..64634c6a3f 100644
--- a/grep.h
+++ b/grep.h
@@ -167,6 +167,7 @@ struct grep_opt {
 	int extended_regexp_option;
 	int pattern_type_option;
 	int ignore_locale;
+	int is_log;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
 	unsigned post_context;
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 22487d90fd..1da6b07a57 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -60,7 +60,7 @@ test_expect_success GETTEXT_LOCALE,PCRE 'log --author with an ascii pattern on U
 	test_write_lines "forth" >file4 &&
 	git add file4 &&
 	git commit --author="À Ú Thor <author@example.com>" -m sécond &&
-	git log -1 --color=always --perl-regexp --author=".*Thor" >log &&
+	git log -1 --color=always --perl-regexp --author=". . Thor" >log &&
 	grep Author log >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expected actual
-- 
2.34.0

