Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB2A1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 20:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbcKUUm7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:42:59 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34914 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753962AbcKUUm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:42:57 -0500
Received: by mail-pg0-f48.google.com with SMTP id p66so133878857pga.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 12:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bw5tzcZYUnFH4xDFeRz4XJBvHpMNSA8pgfZsbtpIMIg=;
        b=DO3Pw3MYAT0Kdgr8zw/MThWQ4Hq9F26EZszzV7qaWxIbBCMGOQrjmL0okhgD0kO7sg
         +3yq0JMLx6MCEpPjUnv2uadKSC9ZEUxOZpCUVfbUO7Bhtxm/pZ0ntoJwE83scAdPCNMr
         FFYgwgFHp1Wgk8USegQUD8mMH+oWBPwcATY23YT9ZIJw/jLlNqaK7iB6pLs49rvMEohI
         DnCvwjftrrIsPACqA+MZAGRUnCqOPoMu5qdjC12mt1ByJseIeVH95UeY6yGQh2t2g85i
         IQ9ar8X8eb+er9fhInkyzyanfRIdo8jbmLHreafwfHXCE2CdR+ayzz+KqpbA+BDN2fZS
         HxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bw5tzcZYUnFH4xDFeRz4XJBvHpMNSA8pgfZsbtpIMIg=;
        b=L4MIWYwpCPclpZz8m3azICzRnjWlAqQdpSxT15pCcMpHDOKm3f23wkn1pzu4Gwzbih
         co8hjhywPIi+t9q1hc2HwCNjf4uKPsvNPo/FDSNPhNWql0IkBsAKTQy/Ss0EwG0Sg6i3
         95R551GO0qu5RxYOcI/V9Nl5uJXY1KN+VSyR38a49eRInNVFR2E4dRXwSFGaPM24+Ofc
         OMt51FMwhDJsDrEShAXmEI7btJ1lksUSoignucT+t3nsxF/Wfkm++EBRrr5jgKpcZt5O
         Ay2rKv01v+htIOpTf0s2Oii2yBRVhjv1TV/leMyScJkKxxFQVqIyKw1779om3WSAxKsf
         PWHw==
X-Gm-Message-State: AKaTC01yi4fvvtHZl26AIC8ziWobx1A8O+Rt8g5nUDcsvY33uS3vF1thEJrYRmDF3rDIPDMr
X-Received: by 10.99.126.6 with SMTP id z6mr35677284pgc.182.1479760918870;
        Mon, 21 Nov 2016 12:41:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id o26sm39497298pfk.91.2016.11.21.12.41.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 12:41:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule: use absolute path for computing relative path connecting
Date:   Mon, 21 Nov 2016 12:41:44 -0800
Message-Id: <20161121204146.13665-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
In-Reply-To: <20161121204146.13665-1-sbeller@google.com>
References: <20161121204146.13665-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This addresses a similar concern as in f8eaa0ba98b (submodule--helper,
module_clone: always operate on absolute paths, 2016-03-31)

When computing the relative path from one to another location, we
need to provide both locations as absolute paths to make sure the
computation of the relative path is correct.

While at it, change `real_work_tree` to be non const as we own
the memory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883de9..66c5ce5a24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1227,23 +1227,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *real_git_dir = xstrdup(real_path(git_dir));
+	char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(real_git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
+			       relative_path(real_work_tree, real_git_dir,
 					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(real_work_tree);
+	free(real_git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.11.0.rc2.18.g0126045.dirty

