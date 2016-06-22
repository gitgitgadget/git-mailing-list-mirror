Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774742018B
	for <e@80x24.org>; Wed, 22 Jun 2016 23:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbcFVXAj (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 19:00:39 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33769 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbcFVXAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 19:00:37 -0400
Received: by mail-qk0-f195.google.com with SMTP id a186so12916705qkf.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 16:00:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pKwvILvinc/+lyksJxFb5+TDpGxAH4g0HR3fKe/O8NA=;
        b=I71F8QQwW1KZ+tR4eN/7isFshRtxSaxmJ2J0uNlSO8kbAuG3Ler0GJIVRdyDnGIlqc
         TBh1KU2j+K7iVlMrJI4BDYDvFIrpCp+HdCRXrm25d6jjxRUJPbivkilM1P+mzQnGB42C
         GDRv002zE2PgUwiJWVYzTlE2zz7brYAVngVsOR9PEEsWwNI7e3q4C1OogXCh7q7nFEMC
         8Fs8ANLbcLPoDeaJnvwCvu94QjwACWilS1xSyjHqWEZISkVZ75HnOR2iMQux/H2696s1
         zbGwyTdApKqhLfxYlqjbIWpdI+c1AEnt2bdenFOkRUCnaB9KLsu7sdI2SwIb3h/yh3nQ
         v5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pKwvILvinc/+lyksJxFb5+TDpGxAH4g0HR3fKe/O8NA=;
        b=JvJMjF2S4/JFqCno6lflfgpZyfz+W9v3XRnw2CorT+gM2aApad848Gr1RlHXkRI61Y
         5C7psKnFSTkAXF37Ozy5Fvfh0IGD4u12+q50RBx4AIArlDfaAHvK/J3UlZNELoZYPaWT
         jrxCFt6FlrseItGK78jQqZ1Xb0lZvXvOl4uD/aJuQTiYjGq2b/pDi4j3UiYrX+2k8/eY
         tzw7sHiHP/WNT5Lb7uLrk1LwPqB99R0C4RZk/0HwZniGEmuRJp8ktUr9xzwJYHhoRY43
         LqY9z3YgUg9hHyjR8fjXhgMrH5evf64hE6tXaA+bUqeE0GX4Md6kNeduE9NZR0iUEpxZ
         8q2A==
X-Gm-Message-State: ALyK8tKs/PTTxn/koAzkziSx3VTlBjjZbTcC1gpSELaFAjLjuzB9mtH/r/pr49KI8cIhbg==
X-Received: by 10.55.198.196 with SMTP id s65mr39337172qkl.119.1466636436576;
        Wed, 22 Jun 2016 16:00:36 -0700 (PDT)
Received: from Emily-Xies-MacBook-Pro-2.local.com ([207.251.103.46])
        by smtp.gmail.com with ESMTPSA id 143sm1020341qkk.39.2016.06.22.16.00.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 22 Jun 2016 16:00:35 -0700 (PDT)
From:	Emily Xie <emilyxxie@gmail.com>
To:	git@vger.kernel.org
Cc:	novalis@novalis.org, gitster@pobox.com,
	Emily Xie <emilyxxie@gmail.com>
Subject: [PATCH] pathspec: warn on empty strings as pathspec
Date:	Wed, 22 Jun 2016 19:00:24 -0400
Message-Id: <20160622230024.24034-1-emilyxxie@gmail.com>
X-Mailer: git-send-email 2.8.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Currently, passing an empty string as a pathspec results in
a match on all paths. This is because a pathspec match is a
leading substring match that honors directory boundaries.
So, just as pathspec "dir/" (or "dir") matches "dir/file",
"" matches "file".

However, this causes problems. Namely, a user's
carelessly-written script could accidentally assign an
empty string to a variable that then gets passed to a Git
command invocation, e.g.:

        git rm -r "$path"
        git add "$path"

which would unintentionally affect all paths in the current
directory.

The fix for this issue requires a two-step approach. As
there may be existing scripts that knowingly use empty
strings in this manner, the first step simply invokes a
warning that (1) declares using empty strings to
match all paths will become invalid and (2) asks the user
to use "." if their intent was to match all.

For step two, a follow-up patch several release cycles
later will remove the warnings and throw an error instead.

This patch is the first step.

Signed-off-by: Emily Xie <emilyxxie@gmail.com>
Reported-by: David Turner <novalis@novalis.org>
Mentored-by: Michail Denchev <mdenchev@gmail.com>
Thanks-to: Sarah Sharp <sarah@thesharps.us> and James Sharp <jamey@minilop.net>
---
 pathspec.c     | 11 +++++++++--
 t/t3600-rm.sh  |  5 +++++
 t/t3700-add.sh |  5 +++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index c9e9b6c..02aa691 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -364,7 +364,7 @@ void parse_pathspec(struct pathspec *pathspec,
 {
 	struct pathspec_item *item;
 	const char *entry = argv ? *argv : NULL;
-	int i, n, prefixlen, nr_exclude = 0;
+	int i, n, prefixlen, warn_empty_string, nr_exclude = 0;
 
 	memset(pathspec, 0, sizeof(*pathspec));
 
@@ -402,8 +402,15 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 
 	n = 0;
-	while (argv[n])
+	warn_empty_string = 1;
+	while (argv[n]) {
+		if (*argv[n] == '\0' && warn_empty_string) {
+			warning(_("empty strings as pathspecs will be made invalid in upcoming releases. "
+			          "please use . instead if you meant to match all paths"));
+			warn_empty_string = 0;
+		}
 		n++;
+	}
 
 	pathspec->nr = n;
 	ALLOC_ARRAY(pathspec->items, n);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index d046d98..14f0edc 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -881,4 +881,9 @@ test_expect_success 'rm files with two different errors' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'rm empty string should invoke warning' '
+	git rm -rf "" 2>output &&
+	test_i18ngrep "warning: empty strings" output
+'
+
 test_done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f14a665..05379d0 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -332,4 +332,9 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success 'git add empty string should invoke warning' '
+	git add "" 2>output &&
+	test_i18ngrep "warning: empty strings" output
+'
+
 test_done
-- 
2.8.4

