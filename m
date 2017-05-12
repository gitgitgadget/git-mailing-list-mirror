Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15D9201A4
	for <e@80x24.org>; Fri, 12 May 2017 05:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756087AbdELFEL (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 01:04:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34823 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755468AbdELFEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 01:04:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so5677947pfd.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 22:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pd09kpm0J3VDAAXlYobC+mxIo/ABHnUSmybh3Fhd25s=;
        b=dJfJdprD5zlxH5MQkX3F4MD6FXETU5IPY5Zd0o3S+5ljSNH2abIQxAOUp0324NYThI
         zvhheXqdE9IGR3mAqHHrep2Yb1tCEAc7d+ZqQQpjAWF8RenKWMjYlI9Zq4YpXdGjWQRv
         OBOnikdS88wat5nbPjxSqC0/OrmLqX30WF/g60Q6QGGxr04/46yOnLcRYOFHYi7sgRep
         +P+GU362W2FIZejJI/g5WlXmPZ7x40b1XMYC7ch6fIHQpUX6RxGWswWh72xLy9A2e3Vd
         FfPKCFfmQniC+64M5O2xokl5880LONrmSPghpv2r5fEiUQhJOsiBzYwSfq93llZTS6EA
         cHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pd09kpm0J3VDAAXlYobC+mxIo/ABHnUSmybh3Fhd25s=;
        b=OwSCMGnjNz85Csy4xwQZv4BG8/gkR4XXqPyiztvC1xUP5zRIiZ0GfSiOnLFGPUMSV8
         H2NLtyp2EuzQzv6b/6l4kx9Hc4PzSeaGbH03lndxJxuuqX8ef6S85z4epIzJvPTmgwhA
         qAdY9OBfMrQcrb47/md9EgJgJswRyKfcs6qJ2tIOvPMFYjb5/4XVskY3KsIYuavQAiYq
         p7jGCEaEkieab2E0zTjW5TDlRV5FZ6Ye2PFg2cwTkDKkXKivCnvFOt+UzukQ2PQRrDjW
         TfYuqTvwHiBKLq1lg2FtGOlQlM+Njy8rU1PEUu485x0N+HqmfUo1H5x6CtEy2EsEi/v1
         TKOQ==
X-Gm-Message-State: AODbwcChlAvsBQrG7nrXLa2nqcTD5rDctzOK6MnwH5yzD6lt+y1Kc5nl
        x22QbcTQ0Eg87ygjbgk=
X-Received: by 10.99.113.75 with SMTP id b11mr2323300pgn.173.1494565448326;
        Thu, 11 May 2017 22:04:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:ad55:5f17:47e6:6202])
        by smtp.gmail.com with ESMTPSA id p3sm2747654pgd.36.2017.05.11.22.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 22:04:07 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     git@vger.kernel.org
Cc:     Brian Malehorn <bmalehorn@gmail.com>
Subject: [PATCH 3/3] commit.c: skip scissors when computing trailers
Date:   Thu, 11 May 2017 22:03:47 -0700
Message-Id: <20170512050347.30765-4-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.3.g39c96af
In-Reply-To: <20170512050347.30765-1-bmalehorn@gmail.com>
References: <20170512050347.30765-1-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"scissors" ("----- >8 -----") can be automatically added to commit
messages by setting commit.verbose = true. Prevent this from interfering
with trailer calculations by automatically skipping over scissors,
instead of (usually) treating them as a comment.
---
 commit.c                      | 13 +++++++++----
 t/t7513-interpret-trailers.sh | 17 +++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 041cfa5a9..9a7b41d09 100644
--- a/commit.c
+++ b/commit.c
@@ -1701,10 +1701,10 @@ int is_scissors_line(const char *line)
 /*
  * Inspect the given string and determine the true "end" of the log message, in
  * order to find where to put a new Signed-off-by: line.  Ignored are
- * trailing comment lines and blank lines, and also the traditional
- * "Conflicts:" block that is not commented out, so that we can use
- * "git commit -s --amend" on an existing commit that forgot to remove
- * it.
+ * trailing comment lines and blank lines.  To support "git commit -s
+ * --amend" on an existing commit, we also ignore "Conflicts:".  To
+ * support "git commit -v", we truncate at "---- >8 ----" and similar
+ * scissors lines.
  *
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
@@ -1723,6 +1723,11 @@ int ignore_non_trailer(const char *buf, size_t len)
 		else
 			next_line++;
 
+		if (is_scissors_line(&buf[bol])) {
+			if (!boc)
+				boc = bol;
+			break;
+		}
 		if (buf[bol] == comment_line_char || buf[bol] == '\n') {
 			/* is this the first of the run of comments? */
 			if (!boc)
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 4dd1d7c52..d88d4a4ff 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1258,4 +1258,21 @@ test_expect_success 'with no command and no key' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with scissors' '
+	cat >expected <<-EOF &&
+		my subject
+
+		review: Brian
+		sign: A U Thor <author@example.com>
+		# ------------------------ >8 ------------------------
+		ignore this
+	EOF
+	git interpret-trailers --trailer review:Brian >actual <<-EOF &&
+		my subject
+		# ------------------------ >8 ------------------------
+		ignore this
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.12.3.3.g39c96af

