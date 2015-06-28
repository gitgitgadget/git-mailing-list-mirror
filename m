From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 13/44] builtin-am: implement --abort
Date: Sun, 28 Jun 2015 22:05:35 +0800
Message-ID: <1435500366-31700-14-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFV-0002AY-8s
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbF1OHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:52 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34159 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbF1OHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:30 -0400
Received: by pdbep18 with SMTP id ep18so79680594pdb.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=499JubJ6PO+LO70w07Pr4AUlGCeGOZJY9BjNGE8qEMo=;
        b=0S1VDFW2d3i9jMTOPF5TodiHMekH9+pmMRTh1MERILwF84uaG1INrtL0VyoGi1gwX+
         s8acwht7NkXMI8arvRRBS+MXCwhfrd1iZN1C/66XfQBVyULK/DhZsSfff7BA8WXpduiw
         DWpnnLfL4h76POOQ3KOqrUIZ30cOXCgbHqhVEVXksmNrSdHBqB1R6ILKxFtiocRrCTzY
         hip9DbPLJyXJSFu69pK32/D/yDUrD4LoJUsjIURDAqPVzeDflKQgJB7zZkYZPd9Wl/qD
         C5U/8gMFfcuGKgKswf1UUMrT6PWIny7tNXOKBuW3LWPStDRG8XaBIX8fUjqfn7ZRKA0f
         JqrA==
X-Received: by 10.68.194.104 with SMTP id hv8mr22378773pbc.151.1435500450201;
        Sun, 28 Jun 2015 07:07:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272888>

Since 3e5057a (git am --abort, 2008-07-16), git-am supported the --abort
option that will rewind HEAD back to the original commit. Re-implement
this through am_abort().

Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
and warn, 2010-12-21), to prevent commits made since the last failure
from being lost, git-am will not rewind HEAD back to the original
commit if HEAD moved since the last failure. Re-implement this through
safe_to_abort().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5087094..1db95f2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -507,6 +507,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 static void am_setup(struct am_state *state, enum patch_format patch_format,
 			const char **paths)
 {
+	unsigned char curr_head[GIT_SHA1_RAWSZ];
+
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
 
@@ -523,6 +525,14 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		die(_("Failed to split patches."));
 	}
 
+	if (!get_sha1("HEAD", curr_head)) {
+		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
+		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	} else {
+		write_file(am_path(state, "abort-safety"), 1, "%s", "");
+		delete_ref("ORIG_HEAD", NULL, 0);
+	}
+
 	/*
 	 * NOTE: Since the "next" and "last" files determine if an am_state
 	 * session is in progress, they should be written last.
@@ -539,6 +549,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
  */
 static void am_next(struct am_state *state)
 {
+	unsigned char head[GIT_SHA1_RAWSZ];
+
 	if (state->author_name)
 		free(state->author_name);
 	state->author_name = NULL;
@@ -559,6 +571,11 @@ static void am_next(struct am_state *state)
 	unlink(am_path(state, "author-script"));
 	unlink(am_path(state, "final-commit"));
 
+	if (!get_sha1("HEAD", head))
+		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(head));
+	else
+		write_file(am_path(state, "abort-safety"), 1, "%s", "");
+
 	state->cur++;
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 }
@@ -791,10 +808,14 @@ static void am_run(struct am_state *state)
 	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 	struct strbuf sb = STRBUF_INIT;
 
+	unlink(am_path(state, "dirtyindex"));
+
 	refresh_and_write_cache();
 
-	if (index_has_changes(&sb))
+	if (index_has_changes(&sb)) {
+		write_file(am_path(state, "dirtyindex"), 1, "t");
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
+	}
 
 	strbuf_release(&sb);
 
@@ -982,6 +1003,74 @@ static void am_skip(struct am_state *state)
 }
 
 /**
+ * Returns true if it is safe to reset HEAD to the ORIG_HEAD, false otherwise.
+ *
+ * It is not safe to reset HEAD when:
+ * 1. git-am previously failed because the index was dirty.
+ * 2. HEAD has moved since git-am previously failed.
+ */
+static int safe_to_abort(const struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+	unsigned char abort_safety[GIT_SHA1_RAWSZ], head[GIT_SHA1_RAWSZ];
+
+	if (file_exists(am_path(state, "dirtyindex")))
+		return 0;
+
+	if (read_state_file(&sb, state, "abort-safety", 1) > 0) {
+		if (get_sha1_hex(sb.buf, abort_safety))
+			die(_("could not parse %s"), am_path(state, "abort_safety"));
+	} else
+		hashclr(abort_safety);
+
+	if (get_sha1("HEAD", head))
+		hashclr(head);
+
+	if (!hashcmp(head, abort_safety))
+		return 1;
+
+	error(_("You seem to have moved HEAD since the last 'am' failure.\n"
+		"Not rewinding to ORIG_HEAD"));
+
+	return 0;
+}
+
+/**
+ * Aborts the current am session if it is safe to do so.
+ */
+static void am_abort(struct am_state *state)
+{
+	unsigned char curr_head[GIT_SHA1_RAWSZ], orig_head[GIT_SHA1_RAWSZ];
+	int has_curr_head, has_orig_head;
+	const char *curr_branch;
+
+	if (!safe_to_abort(state)) {
+		am_destroy(state);
+		return;
+	}
+
+	curr_branch = resolve_refdup("HEAD", 0, curr_head, NULL);
+	has_curr_head = !is_null_sha1(curr_head);
+	if (!has_curr_head)
+		hashcpy(curr_head, EMPTY_TREE_SHA1_BIN);
+
+	has_orig_head = !get_sha1("ORIG_HEAD", orig_head);
+	if (!has_orig_head)
+		hashcpy(orig_head, EMPTY_TREE_SHA1_BIN);
+
+	clean_index(curr_head, orig_head);
+
+	if (has_orig_head)
+		update_ref("am --abort", "HEAD", orig_head,
+				has_curr_head ? curr_head : NULL, 0,
+				UPDATE_REFS_DIE_ON_ERR);
+	else if (curr_branch)
+		delete_ref(curr_branch, NULL, REF_NODEREF);
+
+	am_destroy(state);
+}
+
+/**
  * parse_options() callback that validates and sets opt->value to the
  * PATCH_FORMAT_* enum value corresponding to `arg`.
  */
@@ -999,7 +1088,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 enum resume_mode {
 	RESUME_FALSE = 0,
 	RESUME_RESOLVED,
-	RESUME_SKIP
+	RESUME_SKIP,
+	RESUME_ABORT
 };
 
 int cmd_am(int argc, const char **argv, const char *prefix)
@@ -1010,7 +1100,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	const char * const usage[] = {
 		N_("git am [options] [(<mbox>|<Maildir>)...]"),
-		N_("git am [options] (--continue | --skip)"),
+		N_("git am [options] (--continue | --skip | --abort)"),
 		NULL
 	};
 
@@ -1027,6 +1117,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "skip", &resume,
 			N_("skip the current patch"),
 			RESUME_SKIP),
+		OPT_CMDMODE(0, "abort", &resume,
+			N_("restore the original branch and abort the patching operation."),
+			RESUME_ABORT),
 		OPT_END()
 	};
 
@@ -1085,6 +1178,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	case RESUME_SKIP:
 		am_skip(&state);
 		break;
+	case RESUME_ABORT:
+		am_abort(&state);
+		break;
 	default:
 		die("BUG: invalid resume value");
 	}
-- 
2.5.0.rc0.76.gb2c6e93
