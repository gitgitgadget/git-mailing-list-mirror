From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Fri, 03 Aug 2007 13:33:31 -0700
Message-ID: <7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708031121000.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH3q5-0004D9-2C
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 22:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759633AbXHCUde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 16:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755340AbXHCUde
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 16:33:34 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34535 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbXHCUdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 16:33:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803203332.ZCJN26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 3 Aug 2007 16:33:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XYZX1X00K1kojtg0000000; Fri, 03 Aug 2007 16:33:32 -0400
In-Reply-To: <Pine.LNX.4.64.0708031121000.14781@racer.site> (Johannes
	Schindelin's message of "Fri, 3 Aug 2007 11:23:21 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54754>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But I'd really think that what should be done (if anything has to be done 
> at all) is to introduce a config variable which triggers the same logic in 
> git-diff as was introduced in 2b5f9a8c0cff511f2bb0833b1ee02645b79323f4.

Sorry, I don't follow at all.  The diff toolchain works all
inside core without having to write a temporary index out, which
was the issue the commit you are quoting was about.

In any case, enough discussion.  Here is an updated patch, which
I _could_ be pursuaded to consider for inclusion after v1.5.3
happens, if there are enough agreements and Acks.

-- >8 --
git-diff: --stat-unmatch

Traditionally, git-diff with the working tree files showed files
whose lstat(2) information did not match with what were recorded
in the index, even if the actual contents did not have any
differences.  This squelches such output from git-diff by
default.

A new option, --stat-unmatch, is introduced to restore the
traditional behaviour.  This is useful to see if you want to
know you have too many files you only touch(1)ed without
modifying.  Having many such paths hurts performance, and you
can run "git-update-index --refresh" to update the lstat(2)
information recorded in the index in such a case.

The low level git-diff-files command is not affected.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/git-diff.txt |   13 ++++++++++
 builtin-diff.c             |   13 ++++++++++
 diff.c                     |   54 ++++++++++++++++++++++++++++++++++++++++++++
 diff.h                     |    1 +
 4 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b36e705..efdc65b 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -59,6 +59,19 @@ OPTIONS
 -------
 include::diff-options.txt[]
 
+--stat-unmatch::
+	Traditionally, `git-diff` with the working tree files
+	showed files whose `lstat(2)` information did not match
+	with what were recorded in the index, even if the actual
+	contents did not have any differences, but recent git
+	squelches such output.  This option can be used to
+	restore the traditional behaviour.  This is useful to
+	see if you want to know you have too many files you only
+	`touch(1)`ed without modifying.  Having many such paths
+	hurts performance, and you can run `git-update-index
+	--refresh` to update the `lstat(2)` information recorded
+	in the index in such a case.
+
 <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
diff --git a/builtin-diff.c b/builtin-diff.c
index b48121e..c8e137d 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -222,6 +222,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
+	rev.diffopt.skip_stat_unmatch = 1;
 
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc = 0;
@@ -338,5 +339,17 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 					     ent, ents);
 	if (rev.diffopt.exit_with_status)
 		result = rev.diffopt.has_changes;
+
+	/*
+	 * We do not actually do this here because 99% of the time
+	 * the pager is in effect and this will not be shown, but
+	 * you could if you wanted to.
+	 *
+	 * if (1 < rev.diffopt.skip_stat_unmatch)
+	 *	fprintf(stderr,
+	 *		"Squelched %d stat-only differences.\n",
+	 *		rev.diffopt.skip_stat_unmatch - 1);
+	 *
+	 */
 	return result;
 }
diff --git a/diff.c b/diff.c
index a5fc56b..8c26e4d 100644
--- a/diff.c
+++ b/diff.c
@@ -2261,6 +2261,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--shortstat")) {
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
 	}
+	else if (!strcmp(arg, "--stat-unmatch"))
+		options->skip_stat_unmatch = 0;
 	else if (!prefixcmp(arg, "--stat")) {
 		char *end;
 		int width = options->stat_width;
@@ -3143,11 +3145,63 @@ static void diffcore_apply_filter(const char *filter)
 	*q = outq;
 }
 
+static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	outq.queue = NULL;
+	outq.nr = outq.alloc = 0;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+
+		/*
+		 * 1. Entries that come from stat info dirtyness
+		 *    always have both sides (iow, not create/delete),
+		 *    one side of the object name is unknown, with
+		 *    the same mode and size.  Keep the ones that
+		 *    do not match these criteria.  They have real
+		 *    differences.
+		 *
+		 * 2. At this point, the file is known to be modified,
+		 *    with the same mode and size, and the object
+		 *    name of one side is unknown.  Need to inspect
+		 *    the identical contents.
+		 */
+		if (!DIFF_FILE_VALID(p->one) || /* (1) */
+		    !DIFF_FILE_VALID(p->two) ||
+		    (p->one->sha1_valid && p->two->sha1_valid) ||
+		    (p->one->mode != p->two->mode) ||
+		    diff_populate_filespec(p->one, 1) ||
+		    diff_populate_filespec(p->two, 1) ||
+		    (p->one->size != p->two->size) ||
+
+		    diff_populate_filespec(p->one, 0) || /* (2) */
+		    diff_populate_filespec(p->two, 0) ||
+		    memcmp(p->one->data, p->two->data, p->one->size))
+			diff_q(&outq, p);
+		else {
+			/*
+			 * The caller can subtract 1 from skip_stat_unmatch
+			 * to determine how many paths were dirty only
+			 * due to stat info mismatch.
+			 */
+			diffopt->skip_stat_unmatch++;
+			diff_free_filepair(p);
+		}
+	}
+	free(q->queue);
+	*q = outq;
+}
+
 void diffcore_std(struct diff_options *options)
 {
 	if (options->quiet)
 		return;
 
+	if (options->skip_stat_unmatch && !options->find_copies_harder)
+		diffcore_skip_stat_unmatch(options);
 	if (options->break_opt != -1)
 		diffcore_break(options->break_opt);
 	if (options->detect_rename)
diff --git a/diff.h b/diff.h
index 9fd6d44..de21f8e 100644
--- a/diff.h
+++ b/diff.h
@@ -65,6 +65,7 @@ struct diff_options {
 	int context;
 	int break_opt;
 	int detect_rename;
+	int skip_stat_unmatch;
 	int line_termination;
 	int output_format;
 	int pickaxe_opts;
