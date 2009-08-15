From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] git stat: pathspec limits, unlike traditional "git
 status"
Date: Sat, 15 Aug 2009 15:39:54 -0700
Message-ID: <1250375997-10657-7-git-send-email-gitster@pobox.com>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com>
 <1250375997-10657-2-git-send-email-gitster@pobox.com>
 <1250375997-10657-3-git-send-email-gitster@pobox.com>
 <1250375997-10657-4-git-send-email-gitster@pobox.com>
 <1250375997-10657-5-git-send-email-gitster@pobox.com>
 <1250375997-10657-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRvd-0003is-AK
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbZHOWkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZHOWkO
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZHOWkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:11 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F8EC4FC
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83E57C4FB for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:12 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
In-Reply-To: <1250375997-10657-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 98689784-89EC-11DE-8879-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126039>

The "git stat" command is not "preview of commit with the same arguments";
the path parameters are not paths to be added to the pristine index (aka
"--only" option), but are taken as pathspecs to limit the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Fix-up to 3/9; will be squashed in the final round.

 builtin-commit.c |    3 +++
 wt-status.c      |    6 ++++++
 wt-status.h      |    1 +
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 8db0365..5e23ef1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -922,6 +922,9 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 			     builtin_stat_usage, 0);
 	handle_untracked_files_arg(&s);
 
+	if (*argv)
+		s.pathspec = get_pathspec(prefix, argv);
+
 	read_cache();
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
diff --git a/wt-status.c b/wt-status.c
index c55be53..249227c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -269,6 +269,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
+	rev.prune_data = s->pathspec;
 	run_diff_files(&rev, 0);
 }
 
@@ -285,6 +286,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 200;
 	rev.diffopt.break_opt = 0;
+	rev.prune_data = s->pathspec;
 	run_diff_index(&rev, 1);
 }
 
@@ -297,6 +299,8 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 		struct wt_status_change_data *d;
 		struct cache_entry *ce = active_cache[i];
 
+		if (!ce_path_match(ce, s->pathspec))
+			continue;
 		it = string_list_insert(ce->name, &s->change);
 		d = it->util;
 		if (!d) {
@@ -330,6 +334,8 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		struct dir_entry *ent = dir.entries[i];
 		if (!cache_name_is_other(ent->name, ent->len))
 			continue;
+		if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+			continue;
 		s->workdir_untracked = 1;
 		string_list_insert(ent->name, &s->untracked);
 	}
diff --git a/wt-status.h b/wt-status.h
index a0e7517..09fd9f1 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -31,6 +31,7 @@ struct wt_status {
 	int is_initial;
 	char *branch;
 	const char *reference;
+	const char **pathspec;
 	int verbose;
 	int amend;
 	int nowarn;
-- 
1.6.4.224.g3be84
