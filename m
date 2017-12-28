Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1215F1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbdL1EOk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:40 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:44653 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbdL1EOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:31 -0500
Received: by mail-io0-f194.google.com with SMTP id w127so37163820iow.11
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kh+9Cq68h238dy8d/4xV7eLPegbPx3XhmJtiloiTZ8s=;
        b=SeYbOM6TnOy5G0SVS9H8TMEXtiGpsI48ZbqFEtyD8mwYlRaaAdZwYfbQSJmgRKr+f0
         jClWw1ndngSYB+zF/1SF/6PzHbaGZuvQRGckfhLGNJF2QgQ8m35AIYxGxlSEodoRrpcY
         WUUV+xgnQbPh3IajF5T6/UXxDLhevHkVEXjGCT8L38yZgo1B92hkUj/wna36KIouVGmP
         /hN6JGRhsDMAM2GPCySyUsgtOSZISrNuEZV3ncyA0Ner4jIjqsWupSGpE9xy9JbCmFXj
         auidJmBZsZyjCqLnl7suSPYw8xQluPwCAdTOU4Zg2WogY53SQeCK9LGUcMhaDYZUG00S
         ykyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kh+9Cq68h238dy8d/4xV7eLPegbPx3XhmJtiloiTZ8s=;
        b=o8Cx0xjJ0BwdKdkrbAdKA1g8KWpH5E0EVfJVJVLNwXxyVhy2cmMEhKMWw3l6WMeHUk
         nHfpyluChz71+PUCSkvvfAdI8TaAhDTtDb5ikT0mZdqdZDB4CLmDgF7kk6MtlrNq/jc+
         jZigSsP0EEabWFVMV54/WJb3oiOP4gDZYYhEoqVUmB/LAb9SfCHcrAiuuJ3tR9c+PQs1
         XbMiifesusbeh0g3ZcMhDapURuHSiXfFzEX5ldhWRIy6rAQwfIe39aZIPqn4O2rCRLx7
         w6OjRjnwRT6zapiyOESMAxhMFmly2/PF9bmNZPNWrhJ7j/zfRso9txgEtpvJUrLyzUNC
         DxnQ==
X-Gm-Message-State: AKGB3mLIowueQ+ego9DjaqvwNRV77tA3JsUZLs6tg/RzUxE5cIJthFF/
        3LcARoQIcv0Xto/CgcLd8ZufEQ==
X-Google-Smtp-Source: ACJfBossHTQsJVNiyvroUyD2650X0SOyCWJdQIlHEEszrup7fdffVRRBPT+2Re0szhZwK9G6r35c4g==
X-Received: by 10.107.153.206 with SMTP id b197mr39533436ioe.264.1514434470875;
        Wed, 27 Dec 2017 20:14:30 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:30 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 29/34] merge-recursive: avoid clobbering untracked files with directory renames
Date:   Wed, 27 Dec 2017 20:13:47 -0800
Message-Id: <20171228041352.27880-30-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 42 +++++++++++++++++++++++++++++++++++--
 t/t6043-merge-rename-directories.sh |  6 +++---
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cdf8588c7..e77d2b043 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1138,6 +1138,26 @@ static int conflict_rename_dir(struct merge_options *o,
 {
 	const struct diff_filespec *dest = pair->two;
 
+	if (!o->call_depth && would_lose_untracked(dest->path)) {
+		char *alt_path = unique_path(o, dest->path, rename_branch);
+
+		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
+			       "writing to %s instead."),
+		       dest->path, alt_path);
+		/*
+		 * Write the file in worktree at alt_path, but not in the
+		 * index.  Instead, write to dest->path for the index but
+		 * only at the higher appropriate stage.
+		 */
+		if (update_file(o, 0, &dest->oid, dest->mode, alt_path))
+			return -1;
+		free(alt_path);
+		return update_stages(o, dest->path, NULL,
+				     rename_branch == o->branch1 ? dest : NULL,
+				     rename_branch == o->branch1 ? NULL : dest);
+	}
+
+	/* Update dest->path both in index and in worktree */
 	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
 		return -1;
 	return 0;
@@ -1156,7 +1176,8 @@ static int handle_change_delete(struct merge_options *o,
 	const char *update_path = path;
 	int ret = 0;
 
-	if (dir_in_way(path, !o->call_depth, 0)) {
+	if (dir_in_way(path, !o->call_depth, 0) ||
+	    (!o->call_depth && would_lose_untracked(path))) {
 		update_path = alt_path = unique_path(o, path, change_branch);
 	}
 
@@ -1282,6 +1303,12 @@ static int handle_file(struct merge_options *o,
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
+		} else if (!o->call_depth &&
+			   would_lose_untracked(rename->path)) {
+			dst_name = unique_path(o, rename->path, cur_branch);
+			output(o, 1, _("Refusing to lose untracked file at %s; "
+				       "adding as %s instead"),
+			       rename->path, dst_name);
 		}
 	}
 	if ((ret = update_file(o, 0, &rename->oid, rename->mode, dst_name)))
@@ -1407,7 +1434,18 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		remove_file(o, 0, path, 0);
+		if (would_lose_untracked(path))
+			/*
+			 * Only way we get here is if both renames were from
+			 * a directory rename AND user had an untracked file
+			 * at the location where both files end up after the
+			 * two directory renames.  See testcase 10d of t6043.
+			 */
+			output(o, 1, _("Refusing to lose untracked file at "
+				       "%s, even though it's in the way."),
+			       path);
+		else
+			remove_file(o, 0, path, 0);
 		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
 		if (!ret)
 			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index b12193e75..dd9b94266 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2873,7 +2873,7 @@ test_expect_success '10b-setup: Overwrite untracked with dir rename + delete' '
 	)
 '
 
-test_expect_failure '10b-check: Overwrite untracked with dir rename + delete' '
+test_expect_success '10b-check: Overwrite untracked with dir rename + delete' '
 	(
 		cd 10b &&
 
@@ -2944,7 +2944,7 @@ test_expect_success '10c-setup: Overwrite untracked with dir rename/rename(1to2)
 	)
 '
 
-test_expect_failure '10c-check: Overwrite untracked with dir rename/rename(1to2)' '
+test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)' '
 	(
 		cd 10c &&
 
@@ -3013,7 +3013,7 @@ test_expect_success '10d-setup: Delete untracked with dir rename/rename(2to1)' '
 	)
 '
 
-test_expect_failure '10d-check: Delete untracked with dir rename/rename(2to1)' '
+test_expect_success '10d-check: Delete untracked with dir rename/rename(2to1)' '
 	(
 		cd 10d &&
 
-- 
2.15.0.408.g8e199d483

