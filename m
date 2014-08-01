From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 03/19] rebase -i: reword executes pre-commit hook on
 interim commit
Date: Fri, 1 Aug 2014 19:47:09 -0400
Message-ID: <20140801234708.GA20040@peff.net>
References: <53A258D2.7080806@gmail.com>
 <cover.1406589435.git.bafain@gmail.com>
 <1bb7c0b9aed60f7c65bf812ac42b2f1ad8fd3f82.1406589435.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 01:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDMXg-0006xB-Q8
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 01:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaHAXrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 19:47:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:44540 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750997AbaHAXrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 19:47:16 -0400
Received: (qmail 17857 invoked by uid 102); 1 Aug 2014 23:47:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Aug 2014 18:47:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Aug 2014 19:47:09 -0400
Content-Disposition: inline
In-Reply-To: <1bb7c0b9aed60f7c65bf812ac42b2f1ad8fd3f82.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254684>

On Tue, Jul 29, 2014 at 01:18:03AM +0200, Fabian Ruch wrote:

> Specify the git-commit option `--no-verify` to disable the pre-commit
> hook when editing the log message. Because `--no-verify` also skips
> the commit-msg hook, execute the hook from within
> git-rebase--interactive after the commit is created. Fortunately, the
> commit message is still available in `$GIT_DIR/COMMIT_EDITMSG` after
> git-commit terminates. Caveat: In case the commit-msg hook finds the
> new log message ill-formatted, the user is only notified of the
> failed commit-msg hook but the log message is used for the commit
> anyway. git-commit ought to offer more fine-grained control over
> which hooks are executed.

Thanks for a nice explanation of the tradeoff. Have you looked at adding
an option to git-commit? We already have --no-post-rewrite. I think you
would just need:

diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..f7af220 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -102,6 +102,7 @@ static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
+static int no_pre_commit;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -661,7 +662,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (!no_verify && !no_pre_commit &&
+	    run_commit_hook(use_editor, index_file, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -1604,6 +1606,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			 N_("terminate entries with NUL")),
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
+		OPT_BOOL(0, "no-pre-commit", &no_pre_commit, N_("bypass pre-commit hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
 

though I would also not be opposed to some more uniform hook selection
mechanism (e.g., "--no-verify=pre-commit" or something).

-Peff
