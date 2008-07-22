From: Jeff King <peff@peff.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 00:41:57 -0400
Message-ID: <20080722044157.GA20787@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Bremner <bremner@unb.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 06:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL9iF-0003pf-Qk
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 06:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbYGVEl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 00:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbYGVEl7
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 00:41:59 -0400
Received: from peff.net ([208.65.91.99]:4956 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbYGVEl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 00:41:58 -0400
Received: (qmail 2375 invoked by uid 111); 22 Jul 2008 04:41:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 00:41:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 00:41:57 -0400
Content-Disposition: inline
In-Reply-To: <7vtzeir68z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89432>

On Mon, Jul 21, 2008 at 07:40:28PM -0700, Junio C Hamano wrote:

> Actually, the situation is now even worse than I originally thought
> especially with Jeff's pager.<cmd> patch on 'master' recently.  For
> example, you can screw yourself quite badly by forcing diff-files used in
> the scripts you run to page, defeating --exit-code option.  Which means

Actually, you could _always_ do that with "git -p diff-files". Which is
obviously stupid, just as setting pager.diff-files is. In the reported
case, though, "status" is broken, which we now do by default. So no
stupidity required.

>  (2) Then why are we even allowing to configure the plumbing to page?

  1. Laziness. We just never marked which shouldn't be allowed to page.
     But again, in this case, we have explicitly marked status as "this
     should page" so I don't think this is a plumbing / porcelain thing.
     Status fulfills both roles here (some people want it paged, because
     they use it as porcelain, and some people want the exit code).

  2. We don't always know all git commands. We execute user scripts as
     "git foo", but we don't know what they do. Worse than that, we have
     to commit our pager choice early because we might be exec'ing (but
     this is somewhat of an artifact of the way the code is structured,
     and not necessarily an impossible obstacle).

> Should we maintain a table of commands that we allow paging to be
> customized, and ignore pager.<cmd> for commands that are not in the list?

The patch below sets up the infrastructure, which is trivial. Note that
this _doesn't_ handle the case of "git -p status", because we have to
commit that choice at a different time (again, we might be able to
overcome that with a little code restructuring).

This marks diff-files as FORBID_PAGER; I will leave it to others to
fight about which commands should have it. But it doesn't make sense to
mark "status" since some people obviously _want_ the paging there.

> Which codepath should issue error messages when the user tries to break
> the system by saying "pager.diff-files = true"?

No error, but it is silently ignored. :)

---
diff --git a/git.c b/git.c
index 74ea0e6..72cadb5 100644
--- a/git.c
+++ b/git.c
@@ -210,6 +210,7 @@ const char git_version_string[] = GIT_VERSION;
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE	(1<<2)
+#define FORBID_PAGER	(1<<3)
 
 struct cmd_struct {
 	const char *cmd;
@@ -231,6 +232,8 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 		use_pager = check_pager_config(p->cmd);
 	if (use_pager == -1 && p->option & USE_PAGER)
 		use_pager = 1;
+	if (use_pager ==  1 && p->option & FORBID_PAGER)
+		use_pager = 0;
 	commit_pager_choice();
 
 	if (p->option & NEED_WORK_TREE)
@@ -286,7 +289,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
-		{ "diff-files", cmd_diff_files, RUN_SETUP },
+		{ "diff-files", cmd_diff_files, RUN_SETUP | FORBID_PAGER },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
