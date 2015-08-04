From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 00/45] Make git-am a builtin
Date: Tue,  4 Aug 2015 21:51:21 +0800
Message-ID: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:59:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMckh-0005J9-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934303AbbHDN7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:59:31 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32925 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933673AbbHDNw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:52:59 -0400
Received: by pdbnt7 with SMTP id nt7so4808540pdb.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=1mci/Nz52WuF4hFEgpvMYnmbp+AQOqFILIEh3V1ckwc=;
        b=JfVg1LsWMfzKSZ51LURDrsjBF8AoW4B3/AFE2dCGrAi9yaJ7Xur/9oJgc4aay3Ucff
         DHBprvpxNdrtHuD0hC8x37a+hLxfT7f5alK7CGKaU0MsJQtKuU9o7d+1JZOvnt3vInxN
         sXdwyvvyULOBqkOP7yuAOSteBkmpc/LFUJALEOssMyoMTg4XDM4cokZrBFCYngy81oQx
         LOE7INh+thQbtHZml/97FipNey1YZin81BAdC7X7Xp2hot8yA9wWqdoVBOqZ1oMpcipp
         5bvdJsltmlMqIHRsjC1QbqU8eqdLMBJnctrwd+/MwEqXcvzD0Fvqi6eZ7xkwL1iu3B43
         6rJw==
X-Received: by 10.70.108.137 with SMTP id hk9mr8053775pdb.105.1438696379012;
        Tue, 04 Aug 2015 06:52:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.52.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:52:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275320>

This is a re-roll of [v6]. The changes are as follows:

* removed am.threeWay config to match master

* renamed am_state's "append_signoff" field to the shorter "signoff" to
  preserve horizontal space.

* Fix memory leak in am_abort() (Noticed by Stefan, thanks!)

* Rebase onto master, and adjust to the changes introduced by
  a5481a6 (convert "enum date_mode" into a struct, 2015-06-25).

Interdiff below.

Previous versions:

[WIP v1] http://thread.gmane.org/gmane.comp.version-control.git/270048
[WIP v2] http://thread.gmane.org/gmane.comp.version-control.git/271381
[WIP v3] http://thread.gmane.org/gmane.comp.version-control.git/271967
[v4] http://thread.gmane.org/gmane.comp.version-control.git/272876
[v5] http://thread.gmane.org/gmane.comp.version-control.git/273520
[v6] http://thread.gmane.org/gmane.comp.version-control.git/274225

git-am is a commonly used command for applying a series of patches from a
mailbox to the current branch. Currently, it is implemented by the shell script
git-am.sh. However, compared to C, shell scripts have certain deficiencies:
they need to spawn a lot of processes, introduce a lot of dependencies and
cannot take advantage of git's internal caches.

This patch series rewrites git-am.sh into C builtin/am.c, and is part of my
GSoC project to rewrite git-pull and git-am into C builtins[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (45):
  wrapper: implement xopen()
  wrapper: implement xfopen()
  builtin-am: implement skeletal builtin am
  builtin-am: implement patch queue mechanism
  builtin-am: split out mbox/maildir patches with git-mailsplit
  builtin-am: auto-detect mbox patches
  builtin-am: extract patch and commit info with git-mailinfo
  builtin-am: apply patch with git-apply
  builtin-am: implement committing applied patch
  builtin-am: refuse to apply patches if index is dirty
  builtin-am: implement --resolved/--continue
  builtin-am: don't parse mail when resuming
  builtin-am: implement --skip
  builtin-am: implement --abort
  builtin-am: reject patches when there's a session in progress
  builtin-am: implement -q/--quiet
  builtin-am: exit with user friendly message on failure
  builtin-am: implement -s/--signoff
  cache-tree: introduce write_index_as_tree()
  builtin-am: implement --3way
  builtin-am: implement --rebasing mode
  builtin-am: bypass git-mailinfo when --rebasing
  builtin-am: handle stray state directory
  builtin-am: implement -u/--utf8
  builtin-am: implement -k/--keep, --keep-non-patch
  builtin-am: implement --[no-]message-id, am.messageid
  builtin-am: support --keep-cr, am.keepcr
  builtin-am: implement --[no-]scissors
  builtin-am: pass git-apply's options to git-apply
  builtin-am: implement --ignore-date
  builtin-am: implement --committer-date-is-author-date
  builtin-am: implement -S/--gpg-sign, commit.gpgsign
  builtin-am: invoke post-rewrite hook
  builtin-am: support automatic notes copying
  builtin-am: invoke applypatch-msg hook
  builtin-am: invoke pre-applypatch hook
  builtin-am: invoke post-applypatch hook
  builtin-am: rerere support
  builtin-am: support and auto-detect StGit patches
  builtin-am: support and auto-detect StGit series files
  builtin-am: support and auto-detect mercurial patches
  builtin-am: implement -i/--interactive
  builtin-am: implement legacy -b/--binary option
  builtin-am: check for valid committer ident
  builtin-am: remove redirection to git-am.sh

 Makefile                                |    2 +-
 builtin.h                               |    1 +
 builtin/am.c                            | 2319 +++++++++++++++++++++++++++++++
 cache-tree.c                            |   29 +-
 cache-tree.h                            |    1 +
 git-am.sh => contrib/examples/git-am.sh |    0
 git-compat-util.h                       |    2 +
 git.c                                   |    1 +
 wrapper.c                               |   56 +
 9 files changed, 2398 insertions(+), 13 deletions(-)
 create mode 100644 builtin/am.c
 rename git-am.sh => contrib/examples/git-am.sh (100%)

diff --git a/builtin/am.c b/builtin/am.c
index 1116304..84d57d4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -123,7 +123,7 @@ struct am_state {
 	int interactive;
 	int threeway;
 	int quiet;
-	int append_signoff;
+	int signoff;
 	int utf8;
 	int keep; /* enum keep_type */
 	int message_id;
@@ -152,8 +152,6 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	state->prec = 4;
 
-	git_config_get_bool("am.threeway", &state->threeway);
-
 	state->utf8 = 1;
 
 	git_config_get_bool("am.messageid", &state->message_id);
@@ -429,7 +427,7 @@ static void am_load(struct am_state *state)
 	state->quiet = !strcmp(sb.buf, "t");
 
 	read_state_file(&sb, state, "sign", 1);
-	state->append_signoff = !strcmp(sb.buf, "t");
+	state->signoff = !strcmp(sb.buf, "t");
 
 	read_state_file(&sb, state, "utf8", 1);
 	state->utf8 = !strcmp(sb.buf, "t");
@@ -906,7 +904,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 			if (tz > 0)
 				tz2 = -tz2;
 
-			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_RFC2822));
+			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_MODE(RFC2822)));
 		} else if (starts_with(sb.buf, "# ")) {
 			continue;
 		} else {
@@ -998,7 +996,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
 
-	write_file(am_path(state, "sign"), 1, state->append_signoff ? "t" : "f");
+	write_file(am_path(state, "sign"), 1, state->signoff ? "t" : "f");
 
 	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
 
@@ -1284,7 +1282,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die_errno(_("could not read '%s'"), am_path(state, "msg"));
 	stripspace(&msg, 0);
 
-	if (state->append_signoff)
+	if (state->signoff)
 		append_signoff(&msg, 0, 0);
 
 	assert(!state->author_name);
@@ -1368,7 +1366,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	} else
 		state->author_email = xstrdup("");
 
-	author_date = show_ident_date(&ident_split, DATE_NORMAL);
+	author_date = show_ident_date(&ident_split, DATE_MODE(NORMAL));
 	strbuf_addstr(&sb, author_date);
 	assert(!state->author_date);
 	state->author_date = strbuf_detach(&sb, NULL);
@@ -2065,7 +2063,7 @@ static void am_abort(struct am_state *state)
 {
 	unsigned char curr_head[GIT_SHA1_RAWSZ], orig_head[GIT_SHA1_RAWSZ];
 	int has_curr_head, has_orig_head;
-	const char *curr_branch;
+	char *curr_branch;
 
 	if (!safe_to_abort(state)) {
 		am_destroy(state);
@@ -2092,6 +2090,7 @@ static void am_abort(struct am_state *state)
 	else if (curr_branch)
 		delete_ref(curr_branch, NULL, REF_NODEREF);
 
+	free(curr_branch);
 	am_destroy(state);
 }
 
@@ -2146,7 +2145,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
-		OPT_BOOL('s', "signoff", &state.append_signoff,
+		OPT_BOOL('s', "signoff", &state.signoff,
 			N_("add a Signed-off-by line to the commit message")),
 		OPT_BOOL('u', "utf8", &state.utf8,
 			N_("recode into utf8 (default)")),

-- 
2.5.0.280.gd88bd6e
