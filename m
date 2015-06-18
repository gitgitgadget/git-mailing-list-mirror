From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 14/31] am: implement --abort
Date: Thu, 18 Jun 2015 19:25:26 +0800
Message-ID: <1434626743-8552-15-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XyQ-00055J-FV
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbbFRL1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:02 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:32970 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448AbbFRL0u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:50 -0400
Received: by pdjn11 with SMTP id n11so64833716pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=72PMY7Yvdpzsbb/IhqwhHgHTXqZ8d59hRkMUhSWX/Wc=;
        b=gQnwJOSmvqU0UquzyWNQHnaXLtfJ3lCuYlO5PK9flqxiWo0/aQsSzfHiTIYlq++wb9
         COP94hnwtK8YmcO2Ao6to/Amx1KDcYw6tH370CTFJ0f3PYQpIZ12UgG/69R5j0rsOTIl
         zOSSR3f8xLS+jhieQE+jeEGkeo13Uym98fRsvYbx2uRGVLvNqWSJ5CEG8xB4tO8r6KLG
         OcMD24XatqE+4x3xTaceFtKwz1yVE/sVxvjePTZQa20Xe63Vj2v0tIHjj/iMXeat/EAM
         lencopBUFn/NE4mGPVxn2FFWsyUG8DiaLhsZxEsI+tcxViJpXvRSsmsymvo8gl4+E4Rx
         cPsQ==
X-Received: by 10.70.133.170 with SMTP id pd10mr20329195pdb.127.1434626809848;
        Thu, 18 Jun 2015 04:26:49 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:49 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271978>

Since 3e5057a (git am --abort, 2008-07-16), git-am supported the --abort
option that will rewind HEAD back to the original commit. Re-implement
this feature through am_abort().

Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
and warn, 2010-12-21), to prevent commits made since the last failure
from being lost, git-am will not rewind HEAD back to the original
commit if HEAD moved since the last failure. Re-implement this through
safe_to_abort().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0d7af19..7053b8f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -423,6 +423,8 @@ static int split_patches(struct am_state *state, enum patch_format patch_format,
 static void am_setup(struct am_state *state, enum patch_format patch_format,
 		struct string_list *paths)
 {
+	unsigned char curr_head[GIT_SHA1_RAWSZ];
+
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
 
@@ -442,6 +444,14 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
+
+	if (!get_sha1("HEAD", curr_head)) {
+		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr_head));
+		update_ref("am", "ORIG_HEAD", curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	} else {
+		write_file(am_path(state, "abort-safety"), 1, "%s", "");
+		delete_ref("ORIG_HEAD", NULL, 0);
+	}
 }
 
 /**
@@ -450,6 +460,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
  */
 static void am_next(struct am_state *state)
 {
+	unsigned char head[GIT_SHA1_RAWSZ];
+
 	state->cur++;
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 
@@ -460,6 +472,11 @@ static void am_next(struct am_state *state)
 
 	strbuf_reset(&state->msg);
 	unlink(am_path(state, "final-commit"));
+
+	if (!get_sha1("HEAD", head))
+		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(head));
+	else
+		write_file(am_path(state, "abort-safety"), 1, "%s", "");
 }
 
 /**
@@ -665,10 +682,14 @@ static void am_run(struct am_state *state)
 {
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
 
@@ -844,6 +865,67 @@ static void am_skip(struct am_state *state)
 	am_run(state);
 }
 
+static int safe_to_abort(const struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+	unsigned char abort_safety[GIT_SHA1_RAWSZ], head[GIT_SHA1_RAWSZ];
+
+	if (file_exists(am_path(state, "dirtyindex")))
+		return 0;
+
+	if (read_state_file(&sb, am_path(state, "abort-safety"), 40, 1) > 0) {
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
 /**
  * parse_options() callback that validates and sets opt->value to the
  * PATCH_FORMAT_* enum value corresponding to `arg`.
@@ -862,7 +944,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 enum resume_mode {
 	RESUME_FALSE = 0,
 	RESUME_RESOLVED,
-	RESUME_SKIP
+	RESUME_SKIP,
+	RESUME_ABORT
 };
 
 static struct am_state state;
@@ -871,7 +954,7 @@ static enum resume_mode opt_resume;
 
 static const char * const am_usage[] = {
 	N_("git am [options] [(<mbox>|<Maildir>)...]"),
-	N_("git am [options] (--continue | --skip)"),
+	N_("git am [options] (--continue | --skip | --abort)"),
 	NULL
 };
 
@@ -887,6 +970,9 @@ static struct option am_options[] = {
 	OPT_CMDMODE(0, "skip", &opt_resume,
 		N_("skip the current patch"),
 		RESUME_SKIP),
+	OPT_CMDMODE(0, "abort", &opt_resume,
+		N_("restore the original branch and abort the patching operation."),
+		RESUME_ABORT),
 	OPT_END()
 };
 
@@ -948,6 +1034,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.1.4
