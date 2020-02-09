Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72583C352A4
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5421A20820
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBINcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:32:21 -0500
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:55332 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727654AbgBINcV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Feb 2020 08:32:21 -0500
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com [198.54.127.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 812B7800D5
        for <git@vger.kernel.org>; Sun,  9 Feb 2020 08:19:26 -0500 (EST)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
        by MTA-07.privateemail.com (Postfix) with ESMTP id 76E7C60034;
        Sun,  9 Feb 2020 08:19:25 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.209])
        by MTA-07.privateemail.com (Postfix) with ESMTPA id 949B160043;
        Sun,  9 Feb 2020 13:19:24 +0000 (UTC)
From:   "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
To:     git@vger.kernel.org
Cc:     "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Subject: [RFC PATCH 2/3] Add merge commit message type autoselect logic
Date:   Sun,  9 Feb 2020 16:16:22 +0300
Message-Id: <20200209131623.5827-3-darktemplar@dark-templar-archives.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200209131623.5827-1-darktemplar@dark-templar-archives.net>
References: <20200209131623.5827-1-darktemplar@dark-templar-archives.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: i.Dark_Templar <darktemplar@dark-templar-archives.net>
---
 Documentation/config/fmt-merge-msg.txt | 17 ++++--
 builtin/fmt-merge-msg.c                | 71 ++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/fmt-merge-msg.txt b/Documentation/config/fmt-merge-msg.txt
index 8c12540fa7..3829095222 100644
--- a/Documentation/config/fmt-merge-msg.txt
+++ b/Documentation/config/fmt-merge-msg.txt
@@ -9,8 +9,15 @@ merge.log::
 	actual commits that are being merged.  Defaults to false, and
 	true is a synonym for 20.
 
-merge.multilineMessage::
-	Make default merge commit message multiline. Every merged object
-	will be written using new line. This should ensure that
-	commit message wouldn't become one very long line when
-	there are a lot of merged objects.
+merge.messageType::
+	Configure default merge commit message type. `original` is used
+	if no value or an invalid value is set.
+	+
+	* `original` keeps old merge commit message format which takes only one line.
+	* `multiline` switches merge commit message to multiline mode. Every merged object
+	will be written using new line. This should ensure that commit message
+	wouldn't become one very long line when there are a lot of merged objects.
+	* `autoselect`, as it's name implies, selects one of following types
+	using arbitrary logic. Currently it selects `original` mode for merge
+	with only one additional object, otherwise switching to `multiline` mode,
+	but this behaviour may be changed in future without any notice.
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 93d44b59d9..0bc6ce5b05 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -14,13 +14,20 @@
 #include "repository.h"
 #include "commit-reach.h"
 
+enum message_format {
+	MESSAGE_FORMAT_ORIGINAL = 0,
+	MESSAGE_FORMAT_MULTILINE = 1,
+	MESSAGE_FORMAT_AUTOSELECT = 2,
+	MESSAGE_FORMAT_DEFAULT = MESSAGE_FORMAT_ORIGINAL
+};
+
 static const char * const fmt_merge_msg_usage[] = {
 	N_("git fmt-merge-msg [-m <message>] [--log[=<n>] | --no-log] [--file <file>]"),
 	NULL
 };
 
 static int use_branch_desc;
-static int use_multiline_default_message = 0;
+static enum message_format default_message_format = MESSAGE_FORMAT_DEFAULT;
 
 int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
@@ -33,8 +40,16 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			merge_log_config = DEFAULT_MERGE_LOG_LEN;
 	} else if (!strcmp(key, "merge.branchdesc")) {
 		use_branch_desc = git_config_bool(key, value);
-	} else if (!strcmp(key, "merge.multilinemessage")) {
-		use_multiline_default_message = git_config_bool(key, value);
+	} else if (!strcmp(key, "merge.messagetype")) {
+		if (!value)
+			return config_error_nonbool(key);
+
+		if (!strcmp(value, "autoselect"))
+			default_message_format = MESSAGE_FORMAT_AUTOSELECT;
+		else if (!strcmp(value, "original"))
+			default_message_format = MESSAGE_FORMAT_ORIGINAL;
+		else if (!strcmp(value, "multiline"))
+			default_message_format = MESSAGE_FORMAT_MULTILINE;
 	} else {
 		return git_default_config(key, value, cb);
 	}
@@ -525,6 +540,43 @@ static void fmt_merge_msg_title_multiline(struct strbuf *out,
 	}
 }
 
+static void fmt_merge_msg_title_autoselect(struct strbuf *out,
+				const char *current_branch)
+{
+	int i = 0;
+	int j = 0;
+	int objects_count = 0;
+
+	for (i = 0; i < srcs.nr; i++) {
+		struct src_data *src_data = srcs.items[i].util;
+
+		if (src_data->head_status == 1) {
+			++objects_count;
+			continue;
+		}
+		if (src_data->head_status == 3) {
+			++objects_count;
+		}
+		for (j = 0; j < src_data->branch.nr; j++) {
+			++objects_count;
+		}
+		for (j = 0; j < src_data->r_branch.nr; j++) {
+			++objects_count;
+		}
+		for (j = 0; j < src_data->tag.nr; j++) {
+			++objects_count;
+		}
+		for (j = 0; j < src_data->generic.nr; j++) {
+			++objects_count;
+		}
+	}
+
+	if (objects_count > 1)
+		fmt_merge_msg_title_multiline(out, current_branch);
+	else
+		fmt_merge_msg_title(out, current_branch);
+}
+
 static void fmt_tag_signature(struct strbuf *tagbuf,
 			      struct strbuf *sig,
 			      const char *buf,
@@ -693,10 +745,19 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 	}
 
 	if (opts->add_title && srcs.nr) {
-		if (!use_multiline_default_message)
+		switch (default_message_format) {
+		case MESSAGE_FORMAT_ORIGINAL:
 			fmt_merge_msg_title(out, current_branch);
-		else
+			break;
+		case MESSAGE_FORMAT_MULTILINE:
 			fmt_merge_msg_title_multiline(out, current_branch);
+			break;
+		case MESSAGE_FORMAT_AUTOSELECT:
+			fmt_merge_msg_title_autoselect(out, current_branch);
+			break;
+		default:
+			BUG("merge.messagetype value is not properly processed: %d", (int) default_message_format);
+		}
 	}
 
 	if (origins.nr)
-- 
2.24.1

