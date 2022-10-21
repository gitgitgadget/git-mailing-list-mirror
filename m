Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB94C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJUDMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJUDLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:11:46 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E5AD8F55
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 187so1247430iov.10
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zd9zUDRv2jDdpAqGYBb5Eyl0Xx2VQTYfwws6RV7WY28=;
        b=bDMAqOwVfsjj1fcBhx9I6zyq639JeSEvVtrFUAKb3KZ81V3itFmyNquDO2W7/PCINS
         AaPsphdbhGx0VI6HC3k6tRZIFQsvxcJba6gruu2UscHP+NMEExKejBsms6Ss9HtRK/+t
         2obxFwwPxNI7dxUBnoww42OAJ833SjhyU4MH1S4uw265B1qMdB3Qo1kHkCa5EdbX2NN5
         xAnjITZV6+4+mjBnPtRqzzyZtxcsXYYfONPYxASyfaJ5/eee6ml9x4OGiukHTWevaIHz
         4m6hEBjDScq13B+i9/FWKlRGPUPancD1peCITkYdIY3Up4XSUr3Nhyt+gifJq75V08pz
         nzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd9zUDRv2jDdpAqGYBb5Eyl0Xx2VQTYfwws6RV7WY28=;
        b=Ixrh45HNl8oUFbznfUtFcvcgUvlSa2zab+3RuaeZDUcRq0spVAErAhr4ViGFoNJHlD
         zTOnODmijv7BFJjWf1amyX3cMyQY2JiwBmmVnZ5kuL5fqkLXymLGpLSRIHY5GOk+GSmK
         23ylUEUGugH3laNZmi76ip884u/ODuf/DZ8AyYQ4TNao2FfkBDigTQWe2W79yhIIh+iM
         F+iU9jzurYVTATIDQ0wjTPza2thAHZhAOU+jrNNd2ghYkRMp/P20Beyo+cdcuEvx6OrD
         3rv8VzXZGRLEgca2bKcuGSTwG3qBx+v7mxmUa2eGVxRj2rHwwtMGWxAi3ehBiB5I3Pl+
         3Qng==
X-Gm-Message-State: ACrzQf15chyLHMeSF2jsosLQSJK1/RBT2r8P8qSmlYkCJRL2jE3doAC+
        7YPna1E4d145oCK95sWBpONwrWyx3A0WTji3
X-Google-Smtp-Source: AMsMyM70BiXdccCONT1oA2eEBceKNcrbQWFMWosXBYzLG/XJIAV8muHj2m3R7g7Dqq5zMNEmL8keUA==
X-Received: by 2002:a6b:6f02:0:b0:6bc:15d8:3446 with SMTP id k2-20020a6b6f02000000b006bc15d83446mr11819778ioc.108.1666321902513;
        Thu, 20 Oct 2022 20:11:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z25-20020a05663822b900b0034a6d12aa25sm3890951jas.4.2022.10.20.20.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:11:42 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:11:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v2 5/6] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <f0044682be70f876f6f92455f1fa46dd2e8aa09f.1666320509.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of handling SHORTLOG_GROUP_AUTHOR separately, reimplement it as
a special case of the new `--group=<format>` mode, where the author mode
is a shorthand for `--group='%aN <%aE>'.

Note that we still need to keep the SHORTLOG_GROUP_AUTHOR enum since it
has a different meaning in `read_from_stdin()`, where it is still used
for a different purpose.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/log.c      |  1 +
 builtin/shortlog.c | 20 ++++++++++----------
 shortlog.h         |  1 +
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ee19dc5d45..b4d5420217 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1334,6 +1334,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	log.in2 = 4;
 	log.file = rev->diffopt.file;
 	log.groups = SHORTLOG_GROUP_AUTHOR;
+	shortlog_finish_setup(&log);
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 0358397a7b..fceb84f12f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -249,15 +249,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
-		strbuf_reset(&ident);
-		format_commit_message(commit,
-				      log->email ? "%aN <%aE>" : "%aN",
-				      &ident, &ctx);
-		if (!HAS_MULTI_BITS(log->groups) ||
-		    strset_add(&dups, ident.buf))
-			insert_one_record(log, ident.buf, oneline_str);
-	}
 	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
 		strbuf_reset(&ident);
 		format_commit_message(commit,
@@ -377,6 +368,15 @@ void shortlog_init(struct shortlog *log)
 	log->format.strdup_strings = 1;
 }
 
+void shortlog_finish_setup(struct shortlog *log)
+{
+	if (log->groups & SHORTLOG_GROUP_AUTHOR)
+		string_list_append(&log->format,
+				   log->email ? "%aN <%aE>" : "%aN");
+
+	string_list_sort(&log->trailers);
+}
+
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
 	struct shortlog log = { STRING_LIST_INIT_NODUP };
@@ -446,7 +446,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	if (!log.groups)
 		log.groups = SHORTLOG_GROUP_AUTHOR;
-	string_list_sort(&log.trailers);
+	shortlog_finish_setup(&log);
 
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
diff --git a/shortlog.h b/shortlog.h
index 4850a8c30f..28d04f951a 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -33,6 +33,7 @@ struct shortlog {
 };
 
 void shortlog_init(struct shortlog *log);
+void shortlog_finish_setup(struct shortlog *log);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
 
-- 
2.38.0.16.g393fd4c6db

