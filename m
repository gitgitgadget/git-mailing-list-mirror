From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH v2] status: display "doing what" information in git status
Date: Fri,  6 May 2011 09:38:55 +0200
Message-ID: <1304667535-4787-1-git-send-email-madcoder@debian.org>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 09:39:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIFd4-0000ls-Rm
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 09:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab1EFHjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 03:39:02 -0400
Received: from pan.madism.org ([88.191.52.104]:40045 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab1EFHjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 03:39:00 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7B9C44EE72;
	Fri,  6 May 2011 09:38:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7972313EC; Fri,  6 May 2011 09:38:57 +0200 (CEST)
X-Mailer: git-send-email 1.7.5.1.290.gfe86e2.dirty
In-Reply-To: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172951>

This provides the same information as the git bash prompt about the
current operation that is going on: rebase, merge, am, cherry-pick or
bisect.

This is very useful for "beginners" who don't have their shell prompt set
up for git.

The logic has been largely borrowed from
contrib/completion/git-completion.bash

when hints are enabled, it also gives hints on how to abort or resolve
that pending situation. For example, with this patch and hints activated,
being in the middle of a `git rebase -i` looks like:

	$ git status
	# in the middle of a git rebase -i of master (detached head)
	#   (use "git rebase --abort" to abort current rebase or proceed)
	# Changes not staged for commit:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working directory)
	#
	#       modified:   lib-common (new commits)
	#
	# Submodules changed but not updated:
	#
	# * lib-common 0b07a6b...11cdf27 (1):
	#   > Add t_sb_init().
	#
	# Untracked files:
	#   (use "git add <file>..." to include in what will be committed)
	#
	#       qdb/a/
	#       qkv/A/
	no changes added to commit (use "git add" and/or "git commit -a")

If we have an ongoing operation then:
- if we are on a branch it displays:
  # On branch $branch ($what_is_ongoing)
  #   ($ongoing_hint)
- if we are on a detached head it displays:
  # $what_is_ongoing (detached head)
  #   ($ongoing_hint)

If we have no ongoing operation the git status does as before:
- if we are on a branch it displays:
  # On branch $branch
- if we are on a detached head it displays:
  # Not currently on any branch.

Since the ongoing operation is usually something to be done with before
continuing with further git operations, the hint and ongoing operations
are displayed with the "WT_STATUS_NOBRANCH" color to be easy to spot.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 wt-status.c |  138 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 123 insertions(+), 15 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f4e0ba..91f6c7c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -527,6 +527,128 @@ static void wt_status_print_unmerged(struct wt_status *s)
 
 }
 
+static int wt_has_file(const char *what)
+{
+	char path[PATH_MAX];
+
+	return access(git_snpath(path, sizeof(path), "%s", what), F_OK) == 0;
+}
+
+static void wt_status_print_doingwhat(struct wt_status *s)
+{
+	const char *status_nobranch = color(WT_STATUS_NOBRANCH, s);
+	const char *branch_name = s->branch;
+	const char *advice = NULL;
+
+	const char * const rebase_advice =
+		_("use \"git rebase --abort\" to abort current rebase or proceed");
+	const char * const am_advice =
+		_("use \"git am --abort\" to abort current mailbox apply or proceed");
+	const char * const merge_advice =
+		_("use \"git reset --hard\" to abort, or resolve conflicts and commit");
+
+	struct strbuf sb = STRBUF_INIT;
+	char path[PATH_MAX];
+
+	if (!prefixcmp(branch_name, "refs/heads/"))
+		branch_name += 11;
+	else if (!strcmp(branch_name, "HEAD")) {
+		branch_name = NULL;
+	}
+
+	status_printf(s, color(WT_STATUS_HEADER, s), "");
+	if (branch_name) {
+		const char *status_onbranch = color(WT_STATUS_ONBRANCH, s);
+
+		status_printf_more(s, status_onbranch, _("On branch "));
+		status_printf_more(s, status_onbranch, "%s", branch_name);
+	}
+	if (wt_has_file("rebase-merge")) {
+		git_snpath(path, sizeof(path), "%s", "rebase-merge/head-name");
+		strbuf_read_file(&sb, path, 0);
+		strbuf_rtrim(&sb);
+
+		if (branch_name)
+			status_printf_more(s, status_nobranch, " (");
+		status_printf_more(s, status_nobranch,
+				   _("in the middle of a git rebase -%c of %s"),
+				   wt_has_file("rebase-merge/interactive") ? 'i' : 'm',
+				   prefixcmp(sb.buf, "refs/heads/") == 0 ?
+				   sb.buf + 11 : sb.buf);
+		advice = rebase_advice;
+	} else if (wt_has_file("rebase-apply")) {
+		if (branch_name)
+			status_printf_more(s, status_nobranch, " (");
+		if (wt_has_file("rebase-apply/rebasing")) {
+			status_printf_more(s, status_nobranch,
+					   _("in the middle of a git rebase"));
+			advice = rebase_advice;
+		} else if (wt_has_file("rebase-apply/applying")) {
+			status_printf_more(s, status_nobranch,
+					   _("in the middle of a git am"));
+			advice = am_advice;
+		} else {
+			status_printf_more(s, status_nobranch,
+					   _("in the middle of a git rebase/am"));
+			advice = am_advice;
+		}
+	} else if (wt_has_file("MERGE_HEAD")) {
+		git_snpath(path, sizeof(path), "%s", "MERGE_HEAD");
+		strbuf_read_file(&sb, path, 0);
+		strbuf_rtrim(&sb);
+
+		if (branch_name)
+			status_printf_more(s, status_nobranch, " (");
+		status_printf_more(s, status_nobranch,
+				   _("resolving merge with %s"),
+				   prefixcmp(sb.buf, "refs/heads/") == 0 ?
+				   sb.buf + 11 : sb.buf);
+		advice = merge_advice;
+	} else if (wt_has_file("CHERRY_PICK_HEAD")) {
+		unsigned char sha1buf[20];
+
+		git_snpath(path, sizeof(path), "%s", "CHERRY_PICK_HEAD");
+		strbuf_read_file(&sb, path, 0);
+		strbuf_rtrim(&sb);
+
+		if (branch_name)
+			status_printf_more(s, status_nobranch, " (");
+		if (sb.len == 40 && get_sha1_hex(sb.buf, sha1buf) == 0) {
+			status_printf_more(s, status_nobranch,
+					   _("resolving cherry-pick of %s"),
+					   find_unique_abbrev(sha1buf, DEFAULT_ABBREV));
+		} else {
+			status_printf_more(s, status_nobranch,
+					   _("resolving cherry-pick of %s"),
+					   sb.buf);
+		}
+		advice = merge_advice;
+	} else if (wt_has_file("BISECT_LOG")) {
+		if (branch_name)
+			status_printf_more(s, status_nobranch, " (");
+		status_printf_more(s, status_nobranch,
+					   _("in the middle of a git bisect"));
+	} else {
+		if (!branch_name) {
+			status_printf_more(s, status_nobranch,
+					   _("Not currently on any branch."));
+		}
+		status_printf_more(s, "", "\n");
+		return;
+	}
+
+	if (branch_name) {
+		status_printf_more(s, status_nobranch, ")\n");
+	} else {
+		status_printf_more(s, status_nobranch, _(" (detached head)\n"));
+	}
+	if (advice && advice_status_hints) {
+		status_printf(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_more(s, status_nobranch, "  (%s)\n", advice);
+	}
+	strbuf_release(&sb);
+}
+
 static void wt_status_print_updated(struct wt_status *s)
 {
 	int shown_header = 0;
@@ -706,22 +828,8 @@ static void wt_status_print_tracking(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
-	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
-	const char *branch_status_color = color(WT_STATUS_HEADER, s);
-
 	if (s->branch) {
-		const char *on_what = _("On branch ");
-		const char *branch_name = s->branch;
-		if (!prefixcmp(branch_name, "refs/heads/"))
-			branch_name += 11;
-		else if (!strcmp(branch_name, "HEAD")) {
-			branch_name = "";
-			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			on_what = _("Not currently on any branch.");
-		}
-		status_printf(s, color(WT_STATUS_HEADER, s), "");
-		status_printf_more(s, branch_status_color, "%s", on_what);
-		status_printf_more(s, branch_color, "%s\n", branch_name);
+		wt_status_print_doingwhat(s);
 		if (!s->is_initial)
 			wt_status_print_tracking(s);
 	}
-- 
1.7.5.1.290.gfe86e2.dirty
