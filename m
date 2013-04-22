From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/2] git add <pathspec>... defaults to "-A"
Date: Mon, 22 Apr 2013 15:41:48 -0700
Message-ID: <7vr4i2mbmb.fsf_-_@alter.siamese.dyndns.org>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
	<1366663435-13598-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 00:42:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPQt-000729-Vc
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab3DVWly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:41:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500Ab3DVWlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:41:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CD26188A0;
	Mon, 22 Apr 2013 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5f+OhWD3anvhmY890t84tQFxdOg=; b=kbrDb6
	eaPDjbk4ZTtLfxGWKBU4rW7afNVVT0VX3Zmdd9wFm59x8N+gejN+I4tr+Ip1RFdN
	c9O3ztd0QhfM5cRjwu1ZFcGxSVjvplDDmhOYvTluZ3prM1qM6QMsCNUis6Hs6Qyo
	/TY6t3b5pZC9s5cE0d8vpO1JEx2xFccC3FEQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b/GOupJLNrIMlWCXjvytRl9txwgoTt60
	tNikULS+WErzSRGNMY/r4vKpcSRA1owVn268QJotrFk9exid9SEt/f10kvu46492
	HhSeAI+VnAYFLsQXWcrvgEHPri3FjAOTYiLWmdqBVwIBSzhE6Yn3A89shu20cY3o
	KjZdR5jRDH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EED81889F;
	Mon, 22 Apr 2013 22:41:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 544D21889D;
	Mon, 22 Apr 2013 22:41:50 +0000 (UTC)
In-Reply-To: <1366663435-13598-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 22 Apr 2013 13:43:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D273CFD0-AB9D-11E2-A90E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222125>

Make "git add <pathspec>..." notice paths that have been removed
from the working tree, i.e. a synonym to "git add -A <pathspec>...".

Given that "git add <pathspec>" is to update the index with the
state of the named part of the working tree as a whole, it makes it
more intuitive, and also makes it possible to simplify the advice we
give while marking the paths the user finished resolving conflicts
with.  We used to say "to record removal as a resolution, remove the
path from the working tree and say 'git rm'; for all other cases,
edit the path in the working tree and say 'git add'", but we can now
say "update the path in the working tree and say 'git add'" instead.

As promised, this merges the temporary update_files_in_cache() helper
function back to add_files_to_cache() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This comes on top of the previous two meant for 1.8.3, but should
   wait until Git 2.0.  You can see that it still has conflicts with
   Jonathan's jn/add-2.0-u-A-sans-pathspec topic, but there is a
   resolution already prepared on 'pu'.

 Documentation/git-add.txt | 18 +++++++++++-------
 builtin/add.c             | 43 ++++---------------------------------------
 2 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 48754cb..77ad391 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -53,8 +53,14 @@ OPTIONS
 	Files to add content from.  Fileglobs (e.g. `*.c`) can
 	be given to add all matching files.  Also a
 	leading directory name (e.g. `dir` to add `dir/file1`
-	and `dir/file2`) can be given to add all files in the
-	directory, recursively.
+	and `dir/file2`) can be given to update the index to
+	match the current state of the directory as a whole (e.g.
+	specifying `dir` will record not just a file `dir/file1`
+	modified in the working tree, a file `dir/file2` added to
+	the working tree, but also a file `dir/file3` removed from
+	the working tree.  Note that older versions of 	Git used
+	to ignore removed files; use `--no-all` option if you want
+	to add modified or new files but ignore removed	ones.
 
 -n::
 --dry-run::
@@ -129,11 +135,9 @@ of Git, hence the form without <pathspec> should not be used.
 	files that have been removed from the working tree.  This
 	option is a no-op when no <pathspec> is used.
 +
-This option is primarily to help the current users of Git, whose
-"git add <pathspec>..." ignores removed files.  In future versions
-of Git, "git add <pathspec>..." will be a synonym to "git add -A
-<pathspec>..." and "git add --ignore-removal <pathspec>..." will behave like
-today's "git add <pathspec>...", ignoring removed files.
+This option is primarily to help users who are used to older
+versions of Git, whose "git add <pathspec>..." was a synonym
+to "git add --no-all <pathspec>...", i.e. ignored removed files.
 
 -N::
 --intent-to-add::
diff --git a/builtin/add.c b/builtin/add.c
index c55615b..22c5ff5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -28,9 +28,6 @@ struct update_callback_data {
 	int add_errors;
 	const char *implicit_dot;
 	size_t implicit_dot_len;
-
-	/* only needed for 2.0 transition preparation */
-	int warn_add_would_remove;
 };
 
 static const char *option_with_implicit_dot;
@@ -96,24 +93,6 @@ static int fix_unmerged_status(struct diff_filepair *p,
 		return DIFF_STATUS_MODIFIED;
 }
 
-static const char *add_would_remove_warning = N_(
-	"You ran 'git add' with neither '-A (--all)' or '--ignore-removal',\n"
-"whose behaviour will change in Git 2.0 with respect to paths you removed.\n"
-"Paths like '%s' that are\n"
-"removed from your working tree are ignored with this version of Git.\n"
-"\n"
-"* 'git add --ignore-removal <pathspec>', which is the current default,\n"
-"  ignores paths you removed from your working tree.\n"
-"\n"
-"* 'git add --all <pathspec>' will let you also record the removals.\n"
-"\n"
-"Run 'git status' to check the paths you removed from your working tree.\n");
-
-static void warn_add_would_remove(const char *path)
-{
-	warning(_(add_would_remove_warning), path);
-}
-
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt, void *cbdata)
 {
@@ -151,10 +130,6 @@ static void update_callback(struct diff_queue_struct *q,
 			}
 			break;
 		case DIFF_STATUS_DELETED:
-			if (data->warn_add_would_remove) {
-				warn_add_would_remove(path);
-				data->warn_add_would_remove = 0;
-			}
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
 			if (!(data->flags & ADD_CACHE_PRETEND))
@@ -378,7 +353,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
 static int verbose, show_only, ignored_too, refresh_only;
 static int ignore_add_errors, intent_to_add, ignore_missing;
 
-#define ADDREMOVE_DEFAULT 0 /* Change to 1 in Git 2.0 */
+#define ADDREMOVE_DEFAULT 1
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */
 
@@ -476,20 +451,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
 
-	/*
-	 * Warn when "git add pathspec..." was given without "-u" or "-A"
-	 * and pathspec... covers a removed path.
-	 */
-	memset(&update_data, 0, sizeof(update_data));
-	if (!take_worktree_changes && addremove_explicit < 0)
-		update_data.warn_add_would_remove = 1;
-
 	if (!take_worktree_changes && addremove_explicit < 0 && argc)
-		/*
-		 * Turn "git add pathspec..." to "git add -A pathspec..."
-		 * in Git 2.0 but not yet
-		 */
-		; /* addremove = 1; */
+		/* Turn "git add pathspec..." to "git add -A pathspec..." */
+		addremove = 1;
 
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
@@ -579,6 +543,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
+	memset(&update_data, 0, sizeof(update_data));
 	if ((flags & ADD_CACHE_IMPLICIT_DOT) && prefix) {
 		/*
 		 * Check for modified files throughout the worktree so
-- 
1.8.2.1-740-ga5571a3
