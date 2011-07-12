From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/17] revert: Introduce struct to keep command-line
 options
Date: Tue, 12 Jul 2011 13:05:49 -0500
Message-ID: <20110712180549.GC14120@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 20:06:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QghLR-0008Vq-RO
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 20:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab1GLSGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 14:06:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64355 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1GLSF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 14:05:59 -0400
Received: by vws1 with SMTP id 1so3647547vws.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T09EvarVtsI5/Wi9so1IUTa1wJZ/gssL1OJR7UTWb/k=;
        b=plFftf56gni97N8njvel227noQ+ng/HWh6M2XOJWpqdbFNDd5QQ4AGsTcNbI8Dyt4I
         BTU3cKWMzTRinNpo/XXebRYsWHLuGchhqV8r7ewJ1e22SrcORlKMtVcYekMR22lOoE7o
         UF5ZGXfU4dTCgrWlDZoFtAFR4hS34HrFtf0TA=
Received: by 10.52.94.46 with SMTP id cz14mr232748vdb.501.1310493958709;
        Tue, 12 Jul 2011 11:05:58 -0700 (PDT)
Received: from elie ([69.209.70.6])
        by mx.google.com with ESMTPS id e8sm5089907vdf.9.2011.07.12.11.05.56
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 11:05:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176960>

Ramkumar Ramachandra wrote:

> The variable "me" is left as a file-scope static variable because it
> is not an independent option.  "me" is simply a string that needs to
> be inferred from the "action" option, and is kept global to save each
> function the trouble of determining it independently.

Why not do something like this[1]?

[1] http://thread.gmane.org/gmane.comp.version-control.git/176647/focus=176730

diff --git i/builtin/revert.c w/builtin/revert.c
index 63baca85..3161e696 100644
--- i/builtin/revert.c
+++ w/builtin/revert.c
@@ -36,7 +36,6 @@ static const char * const cherry_pick_usage[] = {
 };
 
 static struct commit *commit;
-static const char *me;
 enum replay_action { REVERT, CHERRY_PICK };
 
 struct replay_opts {
@@ -69,6 +68,11 @@ static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 	return opts->action == REVERT ? revert_usage : cherry_pick_usage;
 }
 
+static const char *action_name(const struct replay_opts *opts)
+{
+	return opts->action == REVERT ? "revert" : "cherry-pick";
+}
+
 static int option_parse_x(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -280,20 +284,20 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static NORETURN void die_dirty_index(const char *me, enum replay_action action)
+static NORETURN void die_dirty_index(const struct replay_opts *opts)
 {
 	if (read_cache_unmerged()) {
-		die_resolve_conflict(me);
+		die_resolve_conflict(action_name(opts));
 	} else {
 		if (advice_commit_before_merge) {
-			if (action == REVERT)
+			if (opts->action == REVERT)
 				die(_("Your local changes would be overwritten by revert.\n"
 					  "Please, commit your changes or stash them to proceed."));
 			else
 				die(_("Your local changes would be overwritten by cherry-pick.\n"
 					  "Please, commit your changes or stash them to proceed."));
 		} else {
-			if (action == REVERT)
+			if (opts->action == REVERT)
 				die(_("Your local changes would be overwritten by revert.\n"));
 			else
 				die(_("Your local changes would be overwritten by cherry-pick.\n"));
@@ -347,7 +351,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), me);
+		die(_("%s: Unable to write new index file"),
+		    action_name(opts));
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
@@ -418,7 +423,7 @@ static int do_pick_commit(struct replay_opts *opts)
 		if (get_sha1("HEAD", head))
 			die (_("You do not have a valid HEAD"));
 		if (index_differs_from("HEAD", 0))
-			die_dirty_index(me, opts->action);
+			die_dirty_index(opts);
 	}
 	discard_cache();
 
@@ -455,7 +460,7 @@ static int do_pick_commit(struct replay_opts *opts)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		die(_("%s: cannot parse parent commit %s"),
-		    me, sha1_to_hex(parent->object.sha1));
+		    action_name(opts), sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit->buffer, &msg) != 0)
 		die(_("Cannot get commit message for %s"),
@@ -557,10 +562,15 @@ static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
 		die(_("empty commit set passed"));
 }
 
-static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
+static void read_and_refresh_cache(struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
-	int index_fd = hold_locked_index(&index_lock, 0);
+	int index_fd;
+	const char *me;
+
+	me = action_name(opts);
+
+	index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("git %s: failed to read the index"), me);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
@@ -578,8 +588,7 @@ static int revert_or_cherry_pick(int argc, const char **argv,
 	struct rev_info revs;
 
 	git_config(git_default_config, NULL);
-	me = opts->action == REVERT ? "revert" : "cherry-pick";
-	setenv(GIT_REFLOG_ACTION, me, 0);
+	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	parse_args(argc, argv, opts);
 
 	if (opts->allow_ff) {
@@ -593,7 +602,7 @@ static int revert_or_cherry_pick(int argc, const char **argv,
 			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
 
-	read_and_refresh_cache(me, opts);
+	read_and_refresh_cache(opts);
 
 	prepare_revs(&revs, opts);
 
