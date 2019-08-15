Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3361F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbfHOVll (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39918 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732930AbfHOVlg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so1870401pgi.6
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4clCW1IUqf/qSh0tNxdObRwnRJXlHkc1vF241W4z6s=;
        b=moLjW8avimGgQHCUzeKGwysii6+0TG4CyqziWR9Qbdw/lj6TNW2VKHxm0da4i4ak/i
         oCXD6xoMpE1pR9f5kQDrzNVIfsqrY/VV/FXy9aoTI4w2SzkfHwrwnRn87FT1BAro6LDg
         s64m+rCzzkzqSMP3jga+XZqJbGHV7u9JxoeruIsKmbM2bVBsvUmS8yuJ5DlDw/aznQRM
         bMZIBOWv+l7tQzvxSEgLNajf2ySkBapXGatP3MDRHkfgfzSKLAxBklE22GOQejw5F58i
         5wkHAe8An6ET61ZVd0PSXFRC8SaEL9B+1YZUjvbw4R7y/311CTz9kJ3bvDgOsRBO078B
         5/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4clCW1IUqf/qSh0tNxdObRwnRJXlHkc1vF241W4z6s=;
        b=oT8t60iKrFSoxiQpnVkt136IKy3bZ1Qtq4dIJ+R2Nr2ScsuzbdWkTFKbQhFm708YKG
         bvj7VKhP67r59nBCZRV+V0kUUDp/2/WP2PL+nUK6mk4hwmdnH4Z7po1Uytym8IcpC/vk
         lO/7J5jTlNwkvxS8ZSgZNV8H9Pp0juTlkKN3UDVyHFo3kP5dDI5vIGjsPPb8ztTPynrV
         WuYXdTYXa49wezWkYJmu0TuvsQp4pob2ji8q8lZq1gAjAzM6fdRYHAI8WL/H3MXATh10
         CmoN2oudewArUParPkfrKxL/NSCpwZ6RI0v3D+ndyFE0ZmXssomDfuPUwQy6dd2e0hQ0
         Yz5g==
X-Gm-Message-State: APjAAAX3/ISHzZ+JPSC9kigSwLKZ+tVMsUUWsnAU6hT4QrZS04JqS/8d
        9ePkszN2M00WWcttTIUIkB6yXAHf
X-Google-Smtp-Source: APXvYqwFpMpolG5RNqua1enKkP7sanx2OPTgeGhaVIXuXTk4AnQRvCRX5ea8Dpu066t/wkN6B1urmA==
X-Received: by 2002:a17:90a:1ae1:: with SMTP id p88mr3947992pjp.26.1565905295120;
        Thu, 15 Aug 2019 14:41:35 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 20/24] merge-recursive: avoid losing output and leaking memory holding that output
Date:   Thu, 15 Aug 2019 14:40:49 -0700
Message-Id: <20190815214053.16594-21-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If opt->buffer_output is less than 2, then merge_trees(),
merge_recursive(), and merge_recursive_generic() are all supposed to
flush the opt->obuf output buffer to stdout and release any memory it
holds.  merge_trees() did not do this.  Move the logic that handles this
for merge_recursive_internal() to merge_finalize() so that all three
methods handle this requirement.

Note that this bug didn't cause any problems currently, because there
are only two callers of merge_trees() right now (a git grep for
'merge_trees(' is misleading because builtin/merge-tree.c also defines a
'merge_tree' function that is unrelated), and only one of those is
called with buffer_output less than 2 (builtin/checkout.c), but it set
opt->verbosity to 0, for which there is only currently one non-error
message that would be shown: "Already up to date!".  However, that one
message can only occur when the merge is utterly trivial (the merge base
tree exactly matches the merge tree), and builtin/checkout.c already
attempts a trivial merge via unpack_trees() before falling back to
merge_trees().

Also, if opt->buffer_output is 2, then the caller is responsible to
handle showing any output in opt->obuf and for free'ing it.  This
requirement might be easy to overlook, so add a comment to
merge-recursive.h pointing it out.  (There are currently two callers
that set buffer_output to 2, both in sequencer.c, and both of which
handle this correctly.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 6 +++---
 merge-recursive.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index db2c544d0b..b4334d0506 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3603,9 +3603,6 @@ static int merge_recursive_internal(struct merge_options *opt,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output(opt);
-	if (!opt->call_depth && opt->buffer_output < 2)
-		strbuf_release(&opt->obuf);
 	return clean;
 }
 
@@ -3625,6 +3622,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 static void merge_finalize(struct merge_options *opt)
 {
+	flush_output(opt);
+	if (!opt->call_depth && opt->buffer_output < 2)
+		strbuf_release(&opt->obuf);
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       opt->needed_rename_limit, 0);
diff --git a/merge-recursive.h b/merge-recursive.h
index 9e040608fe..933d6e7642 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -38,7 +38,8 @@ struct merge_options {
 	/* console output related options */
 	int verbosity;
 	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
-	struct strbuf obuf;     /* output buffer */
+	struct strbuf obuf;     /* output buffer; if buffer_output == 2, caller
+				 * must handle and call strbuf_release */
 
 	/* miscellaneous control options */
 	const char *subtree_shift;
-- 
2.23.0.rc2.32.g2123e9e4e4

