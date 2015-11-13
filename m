From: Andreas Krey <a.krey@gmx.de>
Subject: [RFC] rename detection: allow more renames
Date: Fri, 13 Nov 2015 17:35:06 +0100
Message-ID: <20151113163506.GD16219@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 13 17:35:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxHJk-0003oF-4p
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 17:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053AbbKMQfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 11:35:10 -0500
Received: from continuum.iocl.org ([217.140.74.2]:38832 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbbKMQfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 11:35:09 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tADGZ6R00557;
	Fri, 13 Nov 2015 17:35:06 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281255>

Hi all,

we also ran into the maximum rename limit
in the rename detection. (Yes, we get a lot
of rename candidates when cherry-picking
between two specific releases.)

The code talks about limiting the size
of the rename matrix, but as far as I
can see, the matrix itself never exists
as such, and the only thing that could
actually overflow is the computation
for the progress indication. This
can be fixed by reporting just the
destinations checked instead of the
combinations, since we only update
the progress once per destination
anyway.

If the direction is good, I will
shape it up (and obtain the
proper signoffs).


diff --git a/diffcore-rename.c b/diffcore-rename.c
index 749a35d..279f24e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -368,7 +368,7 @@ static int too_many_rename_candidates(int num_create,
 	int rename_limit = options->rename_limit;
 	int num_src = rename_src_nr;
 	int i;
-
+	static int max_rename_limit = 100000;
 	options->needed_rename_limit = 0;
 
 	/*
@@ -380,8 +380,8 @@ static int too_many_rename_candidates(int num_create,
 	 * but handles the potential overflow case specially (and we
 	 * assume at least 32-bit integers)
 	 */
-	if (rename_limit <= 0 || rename_limit > 32767)
-		rename_limit = 32767;
+	if (rename_limit <= 0 || rename_limit > max_rename_limit)
+		rename_limit = max_rename_limit;
 	if ((num_create <= rename_limit || num_src <= rename_limit) &&
 	    (num_create * num_src <= rename_limit * rename_limit))
 		return 0;
@@ -515,7 +515,7 @@ void diffcore_rename(struct diff_options *options)
 	if (options->show_rename_progress) {
 		progress = start_progress_delay(
 				_("Performing inexact rename detection"),
-				rename_dst_nr * rename_src_nr, 50, 1);
+				rename_dst_nr, 50, 1);
 	}
 
 	mx = xcalloc(num_create * NUM_CANDIDATE_PER_DST, sizeof(*mx));
@@ -552,7 +552,7 @@ void diffcore_rename(struct diff_options *options)
 			diff_free_filespec_blob(two);
 		}
 		dst_cnt++;
-		display_progress(progress, (i+1)*rename_src_nr);
+		display_progress(progress, (i+1));
 	}
 	stop_progress(&progress);


And we would also like to see progress when doing
a cherry pick - in our case this takes a few minutes:

 
diff --git a/sequencer.c b/sequencer.c
index 3c060e0..8fce028 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -282,6 +282,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
 		parse_merge_opt(&o, *xopt);
+	o.show_rename_progress = isatty(2);
 
 	clean = merge_trees(&o,
 			    head_tree,


Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
