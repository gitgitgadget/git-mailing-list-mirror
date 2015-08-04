From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 38/45] builtin-am: rerere support
Date: Tue,  4 Aug 2015 21:51:59 +0800
Message-ID: <1438696326-19590-39-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcgB-0002yt-GT
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbbHDNyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:44 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36103 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964958AbbHDNyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:39 -0400
Received: by pacgq8 with SMTP id gq8so9189798pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJ2sqg54Ut2alvYCY9idyX3dHCeXqJ3fQsoNLCondWE=;
        b=C2ka8aSXs8iGkm8VjHxu4ly9MHGsch+mY6dt55uKYCBiSwUbG9cj22NViJlDYjCINB
         H8RlWAzH1FjlGgZ88qVwB+tKsJqWiTOVyz8pewdUvvv5J9uBHPZzb4R4qUf/2CqruTQD
         Ldf3nhKN1/6YruP0gtZtLG7qxdMr4xqaw45pz/TVfFaFs+9FM+JVeiLV9HZkiCcOAGPG
         4eEMj501qcMRvNaojP9UY/CbgrDNl1ryYaiYcFYhkj9K0Ck3qnLzVJdoD6W6FM0i3qPy
         OqUvC9j18ExsBHuDTDUfyj46coQeRakfmnfxDc8tpykb8O4bBvt5pc8BNPFsIs2HZuZZ
         PAlw==
X-Received: by 10.68.109.97 with SMTP id hr1mr8057741pbb.110.1438696479269;
        Tue, 04 Aug 2015 06:54:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275308>

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
index c313e58..33d1f24 100644
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
@@ -1312,6 +1314,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result)) {
+		rerere(state->allow_rerere_autoupdate);
 		free(his_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
@@ -1531,6 +1534,8 @@ static void am_resolve(struct am_state *state)
 		die_user_resolve(state);
 	}
 
+	rerere(0);
+
 	do_commit(state);
 
 	am_next(state);
@@ -1631,12 +1636,29 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
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
 
@@ -1694,6 +1716,8 @@ static void am_abort(struct am_state *state)
 		return;
 	}
 
+	am_rerere_clear();
+
 	curr_branch = resolve_refdup("HEAD", 0, curr_head, NULL);
 	has_curr_head = !is_null_sha1(curr_head);
 	if (!has_curr_head)
@@ -1823,6 +1847,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("lie about committer date")),
 		OPT_BOOL(0, "ignore-date", &state.ignore_date,
 			N_("use current timestamp for author date")),
+		OPT_RERERE_AUTOUPDATE(&state.allow_rerere_autoupdate),
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-- 
2.5.0.280.gd88bd6e
