From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] show git tag output in pager
Date: Fri, 30 Sep 2011 06:42:41 -0400
Message-ID: <20110930104241.GB24507@sigill.intra.peff.net>
References: <20110927134235.GA27478@zelva.suse.cz>
 <vpqehz2cbk4.fsf@bauges.imag.fr>
 <20110929093749.GB27152@zelva.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Michal Vyskocil <mvyskocil@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 30 12:42:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9aYL-0004Rg-JG
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 12:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172Ab1I3Kmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 06:42:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50223
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab1I3Kmo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 06:42:44 -0400
Received: (qmail 420 invoked by uid 107); 30 Sep 2011 10:47:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Sep 2011 06:47:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2011 06:42:41 -0400
Content-Disposition: inline
In-Reply-To: <20110929093749.GB27152@zelva.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182475>

On Thu, Sep 29, 2011 at 11:37:49AM +0200, Michal Vyskocil wrote:

> On Tue, Sep 27, 2011 at 04:19:39PM +0200, Matthieu Moy wrote:
> > The commit message should explain why this is needed, and in particular
> > why you prefer this to setting pager.tag in your ~/.gitconfig.
> 
> Opps! I read a documentation, but I did not realize this works for all
> commands and not only for them calling setup_pager(). Then sorry, no
> change is needed.

I don't think you want to set pager.tag. It will invoke the pager for
all tag subcommands, including tag creation and deletion. It's not a
huge deal if your pager exits immediately when the input is less than a
page (which I think our default LESS settings will do). But I wouldn't
be surprised if it ends up confusing some program at some point.

I think instead, you want some way for commands to say "OK, I'm in a
subcommand that might or might not want a pager now".

Something like the (thoroughly not tested) patch below, which you can
use like:

  git config pager.tag.list

diff --git a/builtin.h b/builtin.h
index 0e9da90..d0fe971 100644
--- a/builtin.h
+++ b/builtin.h
@@ -35,6 +35,7 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
 
 extern int check_pager_config(const char *cmd);
+extern void try_subcommand_pager(const char *subcommand);
 
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, char **buf, unsigned long *buf_size);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 667515e..bc45fe6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -152,6 +152,7 @@ static int list_tags(const char **patterns, int lines,
 	filter.lines = lines;
 	filter.with_commit = with_commit;
 
+	try_subcommand_pager("tag.list");
 	for_each_tag_ref(show_reference, (void *) &filter);
 
 	return 0;
diff --git a/git.c b/git.c
index 8e34903..60fbf1e 100644
--- a/git.c
+++ b/git.c
@@ -64,6 +64,16 @@ static void commit_pager_choice(void) {
 	}
 }
 
+void try_subcommand_pager(const char *subcommand)
+{
+	/* it's too late to turn off a running pager */
+	if (pager_in_use())
+		return;
+
+	use_pager = check_pager_config(subcommand);
+	commit_pager_choice();
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;

Other programs like "git branch list" would probably want similar hooks.

For commands like "tag" and "branch" where there's really only one
operation that you would want to be paged (i.e., "list"), it's tempting
to also (or instead) make "pager.tag" only affect the useful command.

That's not too hard for internal commands like "tag" (patch below). But
I'm not sure how you would do it for something external like "stash";
from git.c's perspective, we don't know anything about stash or whether
it would want to respect pager config or not.

diff --git a/builtin/tag.c b/builtin/tag.c
index bc45fe6..bbdb135 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -152,7 +152,7 @@ static int list_tags(const char **patterns, int lines,
 	filter.lines = lines;
 	filter.with_commit = with_commit;
 
-	try_subcommand_pager("tag.list");
+	try_subcommand_pager("tag");
 	for_each_tag_ref(show_reference, (void *) &filter);
 
 	return 0;
diff --git a/git.c b/git.c
index 60fbf1e..64a078d 100644
--- a/git.c
+++ b/git.c
@@ -276,6 +276,7 @@ static int handle_alias(int *argcp, const char ***argv)
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
+#define NO_PAGER_CONFIG		(1<<4)
 
 struct cmd_struct {
 	const char *cmd;
@@ -299,7 +300,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
 
-		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
+		if (use_pager == -1 &&
+		    p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
+		    !(p->option & NO_PAGER_CONFIG))
 			use_pager = check_pager_config(p->cmd);
 		if (use_pager == -1 && p->option & USE_PAGER)
 			use_pager = 1;
@@ -436,7 +439,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-		{ "tag", cmd_tag, RUN_SETUP },
+		{ "tag", cmd_tag, RUN_SETUP | NO_PAGER_CONFIG },
 		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-file", cmd_unpack_file, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },

-Peff
