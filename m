From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 14/45] builtin-am: implement --abort
Date: Tue,  4 Aug 2015 21:51:35 +0800
Message-ID: <1438696326-19590-15-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:54:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcfI-0002W9-EW
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbbHDNxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:37 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32973 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807AbbHDNxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:33 -0400
Received: by padck2 with SMTP id ck2so9382525pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Jk31DCqps2kyjrgjgklkDoUQ3F+x8Voae8RumZiG48=;
        b=yVVsYppAhq1X1KoqouOKQ6l0F5sX8vdOQVmq2ZFc6VAHMz85mTIOhw9PD7m1/UFdcZ
         8vcsj0plMw7PMNDOQu/WMo6MTvVDo15mYspGmTyxORS4PbNM5fQWwHjhAfwz7PlMpZJJ
         NKFJSk6xCCUAkY/kVpmxGovXLJKDpbxUBLyEIPZCiw4cfqnHpSCTAK486mUKjwmKI803
         ChJ5y/obY3c6sSIlGzKnIQnmV78Kd9YUZbXRSa4+wAHFNoIBijydkPU3zmhBN7ycTYJ5
         YtNgQclga1yW4S+r4eKx0/R/V72IOkEzm1VxiHAFZBDxQAun42m5UJlHcwRVod2+KjEJ
         L3/Q==
X-Received: by 10.68.200.162 with SMTP id jt2mr8112318pbc.29.1438696413043;
        Tue, 04 Aug 2015 06:53:33 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275285>

Since 3e5057a (git am --abort, 2008-07-16), git-am supported the --abort
option that will rewind HEAD back to the original commit. Re-implement
this through am_abort().

Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
and warn, 2010-12-21), to prevent commits made since the last failure
from being lost, git-am will not rewind HEAD back to the original
commit if HEAD moved since the last failure. Re-implement this through
safe_to_abort().

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v7
    
    * Add a free(curr_branch) so we don't leak memory.

 builtin/am.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 765844b..6c24d07 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -490,6 +490,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 static void am_setup(struct am_state *state, enum patch_format patch_format,
 			const char **paths)
 {
+	unsigned char curr_head[GIT_SHA1_RAWSZ];
+
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
 
@@ -506,6 +508,14 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
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
@@ -522,6 +532,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
  */
 static void am_next(struct am_state *state)
 {
+	unsigned char head[GIT_SHA1_RAWSZ];
+
 	free(state->author_name);
 	state->author_name = NULL;
 
@@ -538,6 +550,11 @@ static void am_next(struct am_state *state)
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
@@ -788,10 +805,14 @@ static void am_run(struct am_state *state, int resume)
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
 
@@ -980,6 +1001,75 @@ static void am_skip(struct am_state *state)
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
+	char *curr_branch;
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
+	free(curr_branch);
+	am_destroy(state);
+}
+
+/**
  * parse_options() callback that validates and sets opt->value to the
  * PATCH_FORMAT_* enum value corresponding to `arg`.
  */
@@ -998,7 +1088,8 @@ enum resume_mode {
 	RESUME_FALSE = 0,
 	RESUME_APPLY,
 	RESUME_RESOLVED,
-	RESUME_SKIP
+	RESUME_SKIP,
+	RESUME_ABORT
 };
 
 int cmd_am(int argc, const char **argv, const char *prefix)
@@ -1009,7 +1100,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	const char * const usage[] = {
 		N_("git am [options] [(<mbox>|<Maildir>)...]"),
-		N_("git am [options] (--continue | --skip)"),
+		N_("git am [options] (--continue | --skip | --abort)"),
 		NULL
 	};
 
@@ -1026,6 +1117,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "skip", &resume,
 			N_("skip the current patch"),
 			RESUME_SKIP),
+		OPT_CMDMODE(0, "abort", &resume,
+			N_("restore the original branch and abort the patching operation."),
+			RESUME_ABORT),
 		OPT_END()
 	};
 
@@ -1090,6 +1184,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.280.gd88bd6e
