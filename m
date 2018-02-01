Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08B71F404
	for <e@80x24.org>; Thu,  1 Feb 2018 20:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBAU5W (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 15:57:22 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45643 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeBAU5V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 15:57:21 -0500
Received: by mail-wr0-f196.google.com with SMTP id h9so7467636wre.12
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 12:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R9Ao/ukF38mnmHx8UfYjxVmTJOU4DM3apWAKZClQgGU=;
        b=TtD5jkH04V99zG/k/09AagfqiitiobNmyGaT3fujn4gYEMZ2C744K8FMAFy3EngebR
         Df8xpJaEczMdbKBA2QkqLb9vhhilqgNv/KF4Sk8xwH6Pf9cj+eEY93fW2idwaRSY8Bn0
         J9eikos7O4z8Xk4RvrC1yQdN5jkrjfp/VjqaERGHGLzNXVqWCa80l52lwhaezGsKTE1k
         Ea0qqshDst1xTdth1fEid2UeNLqWFqKmLjpJIjQ0q95YjN8miJwO8TI7PQ1L3oPY5nvp
         wVJytz4hWn9APuQm4jU5bfasj00tRvtKZX0dQotPoYDD8TUlqzD/jkDnypNOuW/VKc8n
         JH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R9Ao/ukF38mnmHx8UfYjxVmTJOU4DM3apWAKZClQgGU=;
        b=ZM9ItYPh1NtGFWcV7IDBp63IS5Fw8E73ukO1jzAPU1bPpgv1vvO/VKxELY7//wzwTo
         ATZaFUOt0ZF8X24+Vnsp/xfaIYbvUK6W4eQxj2MhzUBzYKd+B0tSzGbqusUjC155GD4z
         sk33zu0an33H1EsBLFC/CcjuAFZKgn5Serf99Mm2zOPRWwkuI76m6aATIt43vy9At+Y5
         mFe8y0K1n1Uf5jmuM2FAaQlL+AcQ3bKLB5iY7hs3YubfBNz+6xbUvwc9Nh/OEnE6T0Iv
         il2SrCiZmB+gmXebh0YCarxtu7ZCNwRLI9+7crUGskySHDF3JrQkpLqIknh8zEmLNg73
         MHOQ==
X-Gm-Message-State: AKwxytc8ARGYesKbt3ScoC59H+DfJUEsja+EBjEk/XLxMnVz8TWdX6dE
        +7ZzPny7rGjZn2WO1UM6BJkKqdbi
X-Google-Smtp-Source: AH8x227Gfc5LenAsjsZAl1PdsqUlMxTwcJjadvDN8WY1zR1zxdAkIEUJR767ANmKgpEh3NDtngS+ZA==
X-Received: by 10.223.156.207 with SMTP id h15mr28401097wre.281.1517518639706;
        Thu, 01 Feb 2018 12:57:19 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id g8sm629587wrb.88.2018.02.01.12.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 12:57:18 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/PATCH] reset --hard: make use of the pretty machinery
Date:   Thu,  1 Feb 2018 20:57:21 +0000
Message-Id: <20180201205721.30087-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.101.gde0f0111ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

reset --hard currently uses its own logic for printing the first line of
the commit message in its output.  Instead of just using the first line,
use the pretty machinery to create the output.

In addition to the easier to follow code, this makes the output more
consistent with other commands that print the title of the commit, such
as 'git commit --oneline' or 'git checkout', which both use
'pp_commit_easy()' with the CMIT_FMT_ONELINE modifier.

It is a slight change of the output if the second line of the commit
message is not a blank line, i.e. if the commit message is

    foo
    bar

previously we would print "HEAD is now at 000000 foo", while after
this change we print "HEAD is now at 000000 foo bar", same as 'git log
--oneline' shows "000000 foo bar".

So this does make the output more consistent with other commands, and
'reset' is a porcelain command, so nobody should be parsing the output
in scripts.

The current behaviour dates back to 0e5a7faa3a ("Make "git reset" a
builtin.", 2007-09-11), so I assume (without digging into the old
codebase too much) that the logic was implemented because there was
no convenience function such as 'pp_commit_easy' that would do this
already.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Sending this as RFC/PATCH, as I'm not 100% sure this change in
behaviour is acceptable, and that I'm not missing some other edge
case, but I noticed this while trying to find out how this message
gets constructed, and just using the pretty machinery seems much
simpler, and more consisent

 builtin/reset.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index e15f595799..5da0f75de9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -106,24 +106,16 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 
 static void print_new_head_line(struct commit *commit)
 {
-	const char *hex, *body;
-	const char *msg;
-
-	hex = find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
-	printf(_("HEAD is now at %s"), hex);
-	msg = logmsg_reencode(commit, NULL, get_log_output_encoding());
-	body = strstr(msg, "\n\n");
-	if (body) {
-		const char *eol;
-		size_t len;
-		body = skip_blank_lines(body + 2);
-		eol = strchr(body, '\n');
-		len = eol ? eol - body : strlen(body);
-		printf(" %.*s\n", (int) len, body);
-	}
-	else
-		printf("\n");
-	unuse_commit_buffer(commit, msg);
+	struct strbuf buf = STRBUF_INIT;
+
+	printf(_("HEAD is now at %s"),
+		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+
+	pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
+	if (buf.len > 0)
+		printf(" %s", buf.buf);
+	putchar('\n');
+	strbuf_release(&buf);
 }
 
 static void update_index_from_diff(struct diff_queue_struct *q,
-- 
2.16.1.101.gde0f0111ea

