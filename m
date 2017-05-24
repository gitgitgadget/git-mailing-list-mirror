Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9606E20281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969143AbdEXFQh (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33592 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969121AbdEXFQa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:30 -0400
Received: by mail-oi0-f67.google.com with SMTP id h4so31066335oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k+sMqhNszT7VEdYTPKdLNSMIm3zeTPrAk43vfxEhmO0=;
        b=o4IAzLaM5bthh8Sk9IGsnQeSiMApsKOBc7rLmQ0QHnaYtdWyr4nIb+AB77uwAxi/Wx
         UZm3txh5C/wIEC6cokp6JqlXe1QKv7OzFZSZIGUtYJOsRrLK4ilHJM/0XLg7Gi85f4mM
         fO2lGjpjGz2hyr09abWhz5wPgh7fyWszt78hpyZHqyB92kUK4Kn0qCxEe4KPbsyVX6dw
         ZMmJyeV+udE+X8Mu6NQ+iASYmSarBUvNwcQKOpsZDojPuK6JDZQT3cHd3rI8ei9l28rV
         H95yt7EyZRhNpiayo44zt/cVjXoGQGUBegFq09pWxx6PwtCk9by+cl3M5+NZGY3tA5em
         7llQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k+sMqhNszT7VEdYTPKdLNSMIm3zeTPrAk43vfxEhmO0=;
        b=kx/bu0jBeK2gyYLbx4HvQANryZLAgwIWiHFGD6y1eE7JsaaniIaFZB1xETeN4wcI4C
         5oyXWVVQUtVvOqTaftvVKmcdbbrVdWW+H+y7Du1fVl4C4DuyUZfGYUFJbzJXLY7WhbZu
         GpgKvk23Y+HT4QQlsai883fUVY/Jz3P4L1RZMRILaQFN7uMg8Oavmm4eeIPgNjUGMIPW
         GcicBWxhGKi0S3u+6DVmnyxFGX02tdmkUXoofrYVgE4GPhz/k+x9PWPCr3Av306fG9FO
         YbYwwp0JEUtDBjMR2QJYtw45M+r8K0ACTm/Q1LWenjxtKuPNAdudV/L6jWodkdoGFQsB
         68tA==
X-Gm-Message-State: AODbwcA7cdQ1HrFi0VFPZ64m7G0h3CpmotO0tzhYqC0ftU1wanYWBxdf
        A82kR5CuJmo1Yw==
X-Received: by 10.157.17.217 with SMTP id y25mr3911953oty.137.1495602989312;
        Tue, 23 May 2017 22:16:29 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:28 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 10/29] blame: move stat counters to scoreboard
Date:   Wed, 24 May 2017 00:15:18 -0500
Message-Id: <20170524051537.29978-11-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Statistic counters are used in parts of blame that are being moved to
libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5082543..f0c9ab8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -61,11 +61,6 @@ static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 #define DEBUG 0
 #endif
 
-/* stats */
-static int num_read_blob;
-static int num_get_patch;
-static int num_commits;
-
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
 #define PICKAXE_BLAME_COPY_HARDER	04
@@ -151,13 +146,13 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct blame_origin *o, mmfile_t *file)
+			     struct blame_origin *o, mmfile_t *file, int *num_read_blob)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
 		unsigned long file_size;
 
-		num_read_blob++;
+		(*num_read_blob)++;
 		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
 		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
 			;
@@ -375,6 +370,11 @@ struct blame_scoreboard {
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
+
+	/* stats */
+	int num_read_blob;
+	int num_get_patch;
+	int num_commits;
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -934,9 +934,9 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	d.offset = 0;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
-	num_get_patch++;
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	sb->num_get_patch++;
 
 	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d))
 		die("unable to generate diff (%s -> %s)",
@@ -1140,7 +1140,7 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
 	if (!file_p.ptr)
 		return;
 
@@ -1269,7 +1269,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
 			if (!file_p.ptr)
 				continue;
 
@@ -1434,7 +1434,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 		}
 	}
 
-	num_commits++;
+	sb->num_commits++;
 	for (i = 0, sg = first_scapegoat(revs, commit);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
@@ -2818,7 +2818,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&o->blob_oid),
 			    path);
 	}
-	num_read_blob++;
+	sb.num_read_blob++;
 	lno = prepare_lines(&sb);
 
 	if (lno && !range_list.nr)
@@ -2899,9 +2899,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_stats) {
-		printf("num read blob: %d\n", num_read_blob);
-		printf("num get patch: %d\n", num_get_patch);
-		printf("num commits: %d\n", num_commits);
+		printf("num read blob: %d\n", sb.num_read_blob);
+		printf("num get patch: %d\n", sb.num_get_patch);
+		printf("num commits: %d\n", sb.num_commits);
 	}
 	return 0;
 }
-- 
2.9.3

