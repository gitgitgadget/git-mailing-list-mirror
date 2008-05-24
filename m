From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff -- file1 file2: do not default to --no-index inside
 a git repository
Date: Fri, 23 May 2008 17:00:17 -0700
Message-ID: <7v8wy0r2pa.fsf@gitster.siamese.dyndns.org>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
 <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org>
 <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805232309350.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 24 02:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhCM-0000qL-8J
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbYEXAA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbYEXAA3
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:00:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYEXAA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:00:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 12E6C3CB3;
	Fri, 23 May 2008 20:00:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 727CC3CAF; Fri, 23 May 2008 20:00:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A574298-2924-11DD-9209-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82773>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	On Fri, 23 May 2008, Junio C Hamano wrote:
>
> 	> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 	> 
> 	> > ... So I would suggest that we make it *much* harder to 
> 	> > trigger the "make it act like a traditional 'diff'" thing.
> 	> >
> 	> > I would suggest that we *not* invoce the traditional 'diff' 
> 	> > behaviour when:
> 	> >
> 	> >  - we're called as "git-diff-files". That's clearly a git 
> 	> >    thing. Don't try to make it act like an external non-git diff. 
> 	> >    Only do the special case for plain "git diff" itself.
>
> 	I am not so sure about that.

Unsure that "git-diff-files" is clearly a git thing?

> 	> >  - even for plain "git diff", make it much harder to trigger 
> 	> >    non-git behaviour. Don't do it if the files don't exist.
> 	> >    Don't do it if there is '--' there.
> 	> >
> 	> > In fact, maybe we should remove that thing entirely, or 
> 	> > *require* a flag to enable it (at least if we're in a git
> 	> > directory).  It's a cute hack, but when the cute hack actually 
> 	> > makes it impossible to do certain real git operations, it's a 
> 	> > cute hack that is detrimental.
> 	> 
> 	> Very well said.  I've always wanted to rip that hack out of the 
> 	> normal "git diff with two pathspec parameters" codepath.
>
> 	Yes, I see how that cute hack does the wrong thing here.
>
> 	However, it is pretty convenient to be able to say "git diff a b" 
> 	and have it fall back to --no-index if either a or b is not in the 
> 	index.  Most of the time, I would actually expect it to be the 
> 	right thing, too.

"Most-of-the-time" may be a good thing in Porcelains, but is clearly a
wrong thing for plumbing.

I think ripping out --no-index from git-diff-files is probably the first
step.  "git diff" also needs to fixed as Linus outlined, but that is a
separate topic.

How about doing something like this as a start?  At least that would get
well behaved Porcelains like stg unstuck?

---

 builtin-diff-files.c |   38 +++++++++++++++++++++++++++++++-------
 git.c                |    2 +-
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index e2306c1..6898e3e 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -10,26 +10,50 @@
 #include "builtin.h"
 
 static const char diff_files_usage[] =
-"git-diff-files [-q] [-0/-1/2/3 |-c|--cc|--no-index] [<common diff options>] [<path>...]"
+"git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	int nongit;
 	int result;
+	unsigned options;
 
-	prefix = setup_git_directory_gently(&nongit);
 	init_revisions(&rev, prefix);
 	git_config(git_diff_basic_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
-	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
-		argc = 0;
-	else
-		argc = setup_revisions(argc, argv, &rev, NULL);
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	while (1 < argc && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "--base"))
+			rev.max_count = 1;
+		else if (!strcmp(argv[1], "--ours"))
+			rev.max_count = 2;
+		else if (!strcmp(argv[1], "--theirs"))
+			rev.max_count = 3;
+		else if (!strcmp(argv[1], "-q"))
+			options |= DIFF_SILENT_ON_REMOVED;
+		else
+			usage(diff_files_usage);
+		argv++; argc--;
+	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
+
+	/*
+	 * Make sure there are NO revision (i.e. pending object) parameter,
+	 * rev.max_count is reasonable (0 <= n <= 3), and
+	 * there is no other revision filtering parameters.
+	 */
+	if (rev.pending.nr ||
+	    rev.min_age != -1 || rev.max_age != -1 ||
+	    3 < rev.max_count)
+		usage(diff_files_usage);
+
+	if (rev.max_count == -1 &&
+	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
+		rev.combine_merges = rev.dense_combined_merges = 1;
+
 	result = run_diff_files_cmd(&rev, argc, argv);
 	return diff_result_code(&rev.diffopt, result);
 }
diff --git a/git.c b/git.c
index 89b431f..4b79380 100644
--- a/git.c
+++ b/git.c
@@ -293,7 +293,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
-		{ "diff-files", cmd_diff_files },
+		{ "diff-files", cmd_diff_files, RUN_SETUP },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
