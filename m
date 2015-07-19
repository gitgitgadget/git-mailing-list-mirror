From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 38/45] builtin-am: rerere support
Date: Mon, 20 Jul 2015 00:10:30 +0800
Message-ID: <1437322237-29863-39-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCj-0006ms-JN
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbbGSQMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:32 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35442 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbbGSQM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:26 -0400
Received: by pdrg1 with SMTP id g1so89735209pdr.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wPlTqotVWD5SOwxg832fZoE2dsurdqyLpcBOPqyZpdg=;
        b=RBpPuRTV7rpQ4skM8UEaaw/u5Ec6fvTK5uvRD6Bqkh9pld1ITrh9sNZHz8qmkWspk3
         +K/tz5gsWU7INrLV58Bq7zr3VW4nqxqQqJjvtwH2fUHoZV74qdTvxZ+gGCmNoSHtkfyn
         g2laNDY4S3iHEVgsAfKQIJo22hOYOJ0Dug7Ymqao0o9TESKBz7nlqi9fjNPq6vC3XRxp
         yJipJasKqkE+OY5uXCL/oj27ojDlEOLmJGdcYB6rYaxDO9tyHfULbwvS9r2IpGF9VFua
         3u3tjR+NKPcXxcJMoZmZ/ptzQaV0OYjeP58ue1Q+i5+NJxG1vxfJ/gEJklxcjyIrFBjK
         SYzw==
X-Received: by 10.66.116.81 with SMTP id ju17mr49759043pab.35.1437322345808;
        Sun, 19 Jul 2015 09:12:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274257>

git-am.sh will call git-rerere at the following events:

* "git rerere" when a three-way merge fails to record the conflicted
  automerge results. Since 8389b52 (git-rerere: reuse recorded resolve.,
  2006-01-28)

  * Since cb6020b (Teach --[no-]rerere-autoupdate option to merge,
    revert and friends, 2009-12-04), git-am.sh supports the
    --[no-]rerere-autoupdate option as well, and would pass it to
    git-rerere.

* "git rerere" when --resolved, to record the hand resolution. Since
  f131dd4 (rerere: record (or avoid misrecording) resolved, skipped or
  aborted rebase/am, 2006-12-08)

* "git rerere clear" when --skip-ing. Since f131dd4 (rerere: record (or
  avoid misrecording) resolved, skipped or aborted rebase/am,
  2006-12-08)

* "git rerere clear" when --abort-ing. Since 3e5057a (git am --abort,
  2008-07-16)

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 638b6d3..89613e0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -24,6 +24,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "notes-utils.h"
+#include "rerere.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -114,6 +115,7 @@ struct am_state {
 	const char *resolvemsg;
 	int committer_date_is_author_date;
 	int ignore_date;
+	int allow_rerere_autoupdate;
 	const char *sign_commit;
 	int rebasing;
 };
@@ -1314,6 +1316,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result)) {
+		rerere(state->allow_rerere_autoupdate);
 		free(his_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
@@ -1533,6 +1536,8 @@ static void am_resolve(struct am_state *state)
 		die_user_resolve(state);
 	}
 
+	rerere(0);
+
 	do_commit(state);
 
 	am_next(state);
@@ -1633,12 +1638,29 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
 }
 
 /**
+ * Resets rerere's merge resolution metadata.
+ */
+static void am_rerere_clear(void)
+{
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	int fd = setup_rerere(&merge_rr, 0);
+
+	if (fd < 0)
+		return;
+
+	rerere_clear(&merge_rr);
+	string_list_clear(&merge_rr, 1);
+}
+
+/**
  * Resume the current am session by skipping the current patch.
  */
 static void am_skip(struct am_state *state)
 {
 	unsigned char head[GIT_SHA1_RAWSZ];
 
+	am_rerere_clear();
+
 	if (get_sha1("HEAD", head))
 		hashcpy(head, EMPTY_TREE_SHA1_BIN);
 
@@ -1696,6 +1718,8 @@ static void am_abort(struct am_state *state)
 		return;
 	}
 
+	am_rerere_clear();
+
 	curr_branch = resolve_refdup("HEAD", 0, curr_head, NULL);
 	has_curr_head = !is_null_sha1(curr_head);
 	if (!has_curr_head)
@@ -1824,6 +1848,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("lie about committer date")),
 		OPT_BOOL(0, "ignore-date", &state.ignore_date,
 			N_("use current timestamp for author date")),
+		OPT_RERERE_AUTOUPDATE(&state.allow_rerere_autoupdate),
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-- 
2.5.0.rc2.110.gb39b692
