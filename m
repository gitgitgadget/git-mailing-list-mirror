Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D32201A7
	for <e@80x24.org>; Sun, 14 May 2017 08:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdENIeG (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 04:34:06 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34179 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdENIeE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 04:34:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so11993900pfk.1
        for <git@vger.kernel.org>; Sun, 14 May 2017 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1tXSfOXJXBzrmT8mhuUpsFRk81vEY5itnJqbRuCkCnA=;
        b=hndXg9LOjB+uLcGCdTZnVdcTj6u16d/UYDfVTkJ+gUDeGt9fdjzRH4WI92v6VJuuaM
         wl3dXwIHcDY4xIFPCO/y3Ox8IUp5q1FasOP0V6cshbwOcS4KDA2g8IxJzrH2uOxUyZ4Y
         gw1qj6EjBjJQB2kO4S/CDsvwxZ+YngSAgeqhZxFihlhaHKxKk65qIk+CcWooCrejpSdg
         wZtVpJexThW2P6JxFTSrUS3175/ERD4LvcG8zXEvdY/Au8h1dbaxKVJpG1NQ7VcYmt+S
         we8p99thx3zPwxRdn8TIm/aGpdTRb7WEEjXgscbMHrsRRX41fvbxSTWkjaw3M+uYxPYd
         eliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1tXSfOXJXBzrmT8mhuUpsFRk81vEY5itnJqbRuCkCnA=;
        b=L7Mi/LUlldt3ibsrrVasHPkMen0sb7yzykaQtbqDCEbjtBjQcWGyufK8gunXy+duIY
         17D+91orTTv4wnh+NWCak0IZZNueZu9DEnarHbMxbteMHlNR6/Vhnb4gG56IaB7jJZRa
         UC5W8+1kLy9SzTRq6t5Jy4nnedSrI40OcPQ+bAjNxJkFlbz9jifiN84nDX9VGlc7ET8n
         4ucK48ymHxp7eGd5CtMCsrkxZfBMU3uRKvesrMNv26vtuJ8ticiCE5YVGJSvvk+vMsA8
         h48iXcYrdOeyufz07d69d4Lv8MAhLP6P/hMjwVbfYq6Jhp1E4GseyDJR2YHiVB5XWte8
         yiEg==
X-Gm-Message-State: AODbwcCzUgWCCoUe9P00rB3VktZwrsF2lFicjtGO3SGjwojPUieaLkyO
        UaX0FqRUbImtiw==
X-Received: by 10.98.192.143 with SMTP id g15mr419836pfk.219.1494750843352;
        Sun, 14 May 2017 01:34:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:54fd:6c32:8438:4e94])
        by smtp.gmail.com with ESMTPSA id q27sm13290057pfk.4.2017.05.14.01.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 May 2017 01:34:02 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     peff@peff.net
Cc:     bmalehorn@gmail.com, git@vger.kernel.org
Subject: [PATCH] interpret-trailers: obey scissors lines
Date:   Sun, 14 May 2017 01:33:49 -0700
Message-Id: <20170514083349.24979-2-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.9.g050893b
In-Reply-To: <20170514083349.24979-1-bmalehorn@gmail.com>
References: <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
 <20170514083349.24979-1-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit message is being edited as "verbose", it will contain a
scissors string ("-- >8 --") and a diff:

    my subject

    # ------------------------ >8 ------------------------
    # Do not touch the line above.
    # Everything below will be removed.
    diff --git a/foo.txt b/foo.txt
    index 5716ca5..7601807 100644
    --- a/foo.txt
    +++ b/foo.txt
    @@ -1 +1 @@
    -bar
    +baz

interpret-trailers doesn't interpret the scissors and therefore places
trailer information after the diff. A simple reproduction is:

    git config commit.verbose true
    GIT_EDITOR='git interpret-trailers --in-place --trailer Acked-by:me' \
        git commit --amend

This commit resolves the issue by teaching "git interpret-trailers" to
obey scissors the same way "git commit" does.
---
 builtin/commit.c              |  3 ++-
 commit.c                      | 13 +++++++------
 t/t7513-interpret-trailers.sh | 17 +++++++++++++++++
 wt-status.c                   | 11 ++++++-----
 wt-status.h                   |  2 +-
 5 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2de5f6cc6..d223cf3ea 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1735,7 +1735,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (verbose || /* Truncate the message just before the diff, if any. */
 	    cleanup_mode == CLEANUP_SCISSORS)
-		wt_status_truncate_message_at_cut_line(&sb);
+		strbuf_setlen(&sb,
+			      wt_status_strip_scissors(sb.buf, sb.len));
 
 	if (cleanup_mode != CLEANUP_NONE)
 		strbuf_stripspace(&sb, cleanup_mode == CLEANUP_ALL);
diff --git a/commit.c b/commit.c
index fab826973..6c26ac9b9 100644
--- a/commit.c
+++ b/commit.c
@@ -11,6 +11,7 @@
 #include "commit-slab.h"
 #include "prio-queue.h"
 #include "sha1-lookup.h"
+#include "wt-status.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1649,10 +1650,9 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 /*
  * Inspect the given string and determine the true "end" of the log message, in
  * order to find where to put a new Signed-off-by: line.  Ignored are
- * trailing comment lines and blank lines, and also the traditional
- * "Conflicts:" block that is not commented out, so that we can use
- * "git commit -s --amend" on an existing commit that forgot to remove
- * it.
+ * trailing comment lines and blank lines.  To support "git commit -s
+ * --amend" on an existing commit, we also ignore "Conflicts:".  To
+ * support "git commit -v", we truncate at scissor lines.
  *
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
@@ -1662,8 +1662,9 @@ int ignore_non_trailer(const char *buf, size_t len)
 	int boc = 0;
 	int bol = 0;
 	int in_old_conflicts_block = 0;
+	size_t cutoff = wt_status_strip_scissors(buf, len);
 
-	while (bol < len) {
+	while (bol < cutoff) {
 		const char *next_line = memchr(buf + bol, '\n', len - bol);
 
 		if (!next_line)
@@ -1689,5 +1690,5 @@ int ignore_non_trailer(const char *buf, size_t len)
 		}
 		bol = next_line - buf;
 	}
-	return boc ? len - boc : 0;
+	return boc ? len - boc : len - cutoff;
 }
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 4dd1d7c52..b16d8c5d9 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1258,4 +1258,21 @@ test_expect_success 'with no command and no key' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with scissors' '
+	cat >expected <<-\EOF &&
+	my subject
+
+	review: Brian
+	sign: A U Thor <author@example.com>
+	# ------------------------ >8 ------------------------
+	ignore this
+	EOF
+	git interpret-trailers --trailer review:Brian >actual <<-\EOF &&
+	my subject
+	# ------------------------ >8 ------------------------
+	ignore this
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 4bb46781c..2a6bba205 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -883,17 +883,18 @@ static void wt_longstatus_print_other(struct wt_status *s,
 	status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 }
 
-void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
+size_t wt_status_strip_scissors(const char *s, size_t len)
 {
 	const char *p;
 	struct strbuf pattern = STRBUF_INIT;
 
 	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
-	if (starts_with(buf->buf, pattern.buf + 1))
-		strbuf_setlen(buf, 0);
-	else if ((p = strstr(buf->buf, pattern.buf)))
-		strbuf_setlen(buf, p - buf->buf + 1);
+	if (starts_with(s, pattern.buf + 1))
+		len = 0;
+	else if ((p = strstr(s, pattern.buf)))
+		len = p - s + 1;
 	strbuf_release(&pattern);
+	return len;
 }
 
 void wt_status_add_cut_line(FILE *fp)
diff --git a/wt-status.h b/wt-status.h
index 54fec7703..52a05fd51 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -112,7 +112,7 @@ struct wt_status_state {
 	unsigned char cherry_pick_head_sha1[20];
 };
 
-void wt_status_truncate_message_at_cut_line(struct strbuf *);
+size_t wt_status_strip_scissors(const char *s, size_t len);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
-- 
2.12.3.9.g050893b

