From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 37/44] builtin-am: rerere support
Date: Sun, 28 Jun 2015 22:05:59 +0800
Message-ID: <1435500366-31700-38-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGq-00036x-O1
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbbF1OJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:15 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35321 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbbF1OIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:38 -0400
Received: by pactm7 with SMTP id tm7so91499089pac.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=otBI16pjMVNwV/vLoFPShBmY43py+5N0ibXzc6avGEI=;
        b=KxF9H1tV9/KE4USedPwGWmuX2u/JHvC6S013KR/SAI+8Wq32M5ck4gYT30Iud8Ivc8
         9LwC270rP+oGdDRv2GecTmX3NkV+IaILJWFo3qH6rf+JM+ZxXTyBp0HZcSHzM0tOEP8L
         wx4voplrhy3eDSOQxkZw9LYBPSIEtPRq1P/ok4xXg9Pg4hIsCAg1MuX4yb+zWvdIMoTv
         YXOYWQjfIBjUlKEbBthd01oDZEOh5XI6NKE9007P/BC6DuIKyiyVTlyhAg2IQkBr0Pe9
         WEIsNQZXGA2EAjN0ImeoZOXYCcdCYdrvYuxfvSv7vDzCeIBzwxt7UjZPt8B4dtA91cUB
         I7dw==
X-Received: by 10.66.120.161 with SMTP id ld1mr22073827pab.73.1435500517423;
        Sun, 28 Jun 2015 07:08:37 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272914>

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

Notes:
    No tests in master.

 builtin/am.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index be85b97..b54fdbd 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -24,6 +24,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "notes-utils.h"
+#include "rerere.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -128,6 +129,8 @@ struct am_state {
 
 	int ignore_date;
 
+	int allow_rerere_autoupdate;
+
 	const char *sign_commit;
 
 	int rebasing;
@@ -1357,6 +1360,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result)) {
+		rerere(state->allow_rerere_autoupdate);
 		free(his_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
@@ -1556,6 +1560,8 @@ static void am_resolve(struct am_state *state)
 		die_user_resolve(state);
 	}
 
+	rerere(0);
+
 	do_commit(state);
 
 	am_next(state);
@@ -1654,12 +1660,29 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
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
 
@@ -1717,6 +1740,8 @@ static void am_abort(struct am_state *state)
 		return;
 	}
 
+	am_rerere_clear();
+
 	curr_branch = resolve_refdup("HEAD", 0, curr_head, NULL);
 	has_curr_head = !is_null_sha1(curr_head);
 	if (!has_curr_head)
@@ -1844,6 +1869,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("lie about committer date")),
 		OPT_BOOL(0, "ignore-date", &state.ignore_date,
 			N_("use current timestamp for author date")),
+		OPT_RERERE_AUTOUPDATE(&state.allow_rerere_autoupdate),
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-- 
2.5.0.rc0.76.gb2c6e93
