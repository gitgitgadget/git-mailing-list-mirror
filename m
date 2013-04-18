From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 18:39:06 -0700
Message-ID: <7va9owd3d1.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
	<7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
	<87wqs1xi9h.fsf@hexa.v.cablecom.net>
	<7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
	<7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
	<20130417201056.GA2914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 03:39:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USdoh-0002lN-RK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 03:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038Ab3DRBjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 21:39:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab3DRBjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 21:39:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26D05EBC7;
	Thu, 18 Apr 2013 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yafJeoD2ZTVjNJ79dpzRmkLJUwc=; b=EEBGfV
	98N6YWqphW1EZwbeLgrJfkEr9mGv+Dpxly8MI5MvEJ6ek5/wXViKwXjcW9hUbhaM
	mvaJYzSr9y/CS2qN9fxwmXUL3U9ZrirVv/3fxouPFf8Gw1B+S97tIDngywFBe7Au
	H7YvJ68zsy8SJoVYLKHPmVKPFtrOHQ8l7acDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NacQQy1qvp792pO22Bcgi35vwE1d1Kl7
	vF81g1Lvk9VR8bverPeuX5rh7J4zfQiCuLItxu17G8QIYSEs+UF5ZU1cFLIm056N
	y3aufffCgqYsrGw6LtAIQa4SUUi4Mm4pWD9vZOBeJ/uMJ4IwcjzV7pnyZ5jFjQ9E
	FsUZpMXMPIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D644EBC6;
	Thu, 18 Apr 2013 01:39:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28E32EBC4;
	Thu, 18 Apr 2013 01:39:08 +0000 (UTC)
In-Reply-To: <20130417201056.GA2914@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 17 Apr 2013 16:10:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C305FEE8-A7C8-11E2-88E2-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221597>

Jeff King <peff@peff.net> writes:

> Yeah, I had the same thought, as this warning has been bugging me for
> the last day or two. The worst part about it is that I finally trained
> myself to type "git add ." to silence the _other_ warning, and now it
> triggers this one. :)

So here is the "reworked" one on top of what is in 'next'.

It introduces a bit of conflict with the "add -u/-A" topic, so I am
not ready to push out the integration result yet.

-- >8 --
Subject: [PATCH] git add: rework the logic to warn "git add <pathspec>..." default change

The earlier logic to warn against "git add subdir" that is run
without "-A" or "--no-all" was only to check any <pathspec> given
exactly spells a directory name that (still) exists on the
filesystem.  This had number of problems:

 * "git add '*dir'" (note that the wildcard is hidden from the
   shell) would not trigger the warning.

 * "git add '*.py'" would behave differently between the current
   version of Git and Git 2.0 for the same reason as "subdir", but
   would not trigger the warning.

 * "git add dir" for a submodule "dir" would just update the index
   entry for the submodule "dir" without ever recursing into it, and
   use of "-A" or "--no-all" would matter.  But the logic only
   checks the directory-ness of "dir" and gives an unnecessary
   warning.

Rework the logic to detect the case where the behaviour will be
different in Git 2.0, and issue a warning only when it matters.
Even with the code before this warning, "git add subdir" will have
to traverse the directory in order to find _new_ files the index
does not know about _anyway_, so we can do this check without adding
an extra pass to find if <pathspec> matches any removed file.

This essentially updates the "add_files_to_cache()" public API to
"update_files_in_cache()" API that is internal to "git add", because
with the "--all" option, the function is no longer about "adding"
paths to the cache, but is also used to remove them.

There are other callers of the former from "checkout" (used when
"checkout -m" prepares the temporary tree that represents the local
modifications to be merged) and "commit" ("commit --include" that
picks up local changes in addition to what is in the index).  Since
ADD_CACHE_IGNORE_ERRORS (aka "--no-all") is not used by either of
them, once dust settles after Git 2.0 and the warning becomes
unnecessary, we may want to unify these two functions again.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c | 64 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f8f6c9e..4242bce 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,6 +26,9 @@ static int take_worktree_changes;
 struct update_callback_data {
 	int flags;
 	int add_errors;
+
+	/* only needed for 2.0 transition preparation */
+	int warn_add_would_remove;
 };
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -49,6 +52,17 @@ static int fix_unmerged_status(struct diff_filepair *p,
 		return DIFF_STATUS_MODIFIED;
 }
 
+static void warn_add_would_remove(const char *path)
+{
+	warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
+		  "index for paths removed from the working tree that match\n"
+		  "the given pathspec. If you want to 'add' only changed\n"
+		  "or newly created paths, say 'git add --no-all <pathspec>...'"
+		  " instead.\n\n"
+		  "'%s' would be removed from the index without --no-all."),
+		path);
+}
+
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt, void *cbdata)
 {
@@ -70,6 +84,10 @@ static void update_callback(struct diff_queue_struct *q,
 			}
 			break;
 		case DIFF_STATUS_DELETED:
+			if (data->warn_add_would_remove) {
+				warn_add_would_remove(path);
+				data->warn_add_would_remove = 0;
+			}
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
 			if (!(data->flags & ADD_CACHE_PRETEND))
@@ -81,20 +99,27 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
+static void update_files_in_cache(const char *prefix, const char **pathspec,
+				  struct update_callback_data *data)
 {
-	struct update_callback_data data;
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	init_pathspec(&rev.prune_data, pathspec);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
-	data.flags = flags;
-	data.add_errors = 0;
-	rev.diffopt.format_callback_data = &data;
+	rev.diffopt.format_callback_data = data;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+}
+
+int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
+{
+	struct update_callback_data data;
+
+	memset(&data, 0, sizeof(data));
+	data.flags = flags;
+	update_files_in_cache(prefix, pathspec, &data);
 	return !!data.add_errors;
 }
 
@@ -354,18 +379,6 @@ static void warn_pathless_add(const char *option_name, const char *short_name) {
 		option_name, short_name);
 }
 
-static int directory_given(int argc, const char **argv)
-{
-	struct stat st;
-
-	while (argc--) {
-		if (!lstat(*argv, &st) && S_ISDIR(st.st_mode))
-			return 1;
-		argv++;
-	}
-	return 0;
-}
-
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -378,6 +391,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	char *seen = NULL;
 	const char *option_with_implicit_dot = NULL;
 	const char *short_option_with_implicit_dot = NULL;
+	struct update_callback_data update_data;
 
 	git_config(add_config, NULL);
 
@@ -403,15 +417,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Warn when "git add pathspec..." was given without "-u" or "-A"
-	 * and pathspec... contains a directory name.
+	 * and pathspec... covers a removed path.
 	 */
-	if (!take_worktree_changes && addremove_explicit < 0 &&
-	    directory_given(argc, argv))
-		warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
-			  "index for paths removed from the working tree that match\n"
-			  "the given pathspec. If you want to 'add' only changed\n"
-			  "or newly created paths, say 'git add --no-all <pathspec>...'"
-			  " instead."));
+	memset(&update_data, 0, sizeof(update_data));
+	if (!take_worktree_changes && addremove_explicit < 0)
+		update_data.warn_add_would_remove = 1;
 
 	if (!take_worktree_changes && addremove_explicit < 0 && argc)
 		/*
@@ -508,8 +518,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
-	exit_status |= add_files_to_cache(prefix, pathspec, flags);
+	update_data.flags = flags;
+	update_files_in_cache(prefix, pathspec, &update_data);
 
+	exit_status |= !!update_data.add_errors;
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
 
-- 
1.8.2.1-552-g964983e
