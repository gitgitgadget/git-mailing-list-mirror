From: Jeff King <peff@peff.net>
Subject: Re: Excluding files from git-diff
Date: Sat, 18 Oct 2008 12:58:34 -0400
Message-ID: <20081018165834.GA28364@coredump.intra.peff.net>
References: <20081017145313.GA23471@eriks> <48F8ACC2.1010903@drmicha.warpmail.net> <48F8BDA7.50901@pflanze.mine.nu> <20081018155912.GA20387@coredump.intra.peff.net> <48FA0A17.9050506@pflanze.mine.nu> <20081018161424.GC20185@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Erik Hahn <erik_hahn@gmx.de>, git@vger.kernel.org
To: Christian Jaeger <christian@pflanze.mine.nu>
X-From: git-owner@vger.kernel.org Sat Oct 18 18:59:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrF9a-0000mN-Gi
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 18:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbYJRQ6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbYJRQ6i
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 12:58:38 -0400
Received: from peff.net ([208.65.91.99]:4382 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYJRQ6h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 12:58:37 -0400
Received: (qmail 2554 invoked by uid 111); 18 Oct 2008 16:58:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 18 Oct 2008 12:58:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Oct 2008 12:58:34 -0400
Content-Disposition: inline
In-Reply-To: <20081018161424.GC20185@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98560>

On Sat, Oct 18, 2008 at 12:14:24PM -0400, Jeff King wrote:

> The most flexible thing would be the ability to say "I want these paths
> (or all paths), and exclude these paths" (sort of like we already do for
> commits). But defining a good command-line syntax for that would
> probably be painful, and I really think the only sane use case is "I
> want all paths except for these". In which case your "--invert-match"
> seems like a good route.

I looked at this a little, so here's as far as I got, in case it helps
you in writing a patch.

There are actually two ways the limiter is used:

 1. diff will show only a subset of the paths, as contained in a
    diff_options.paths variable

 2. the revision walker will prune based based on changes in particular
    paths (e.g., "git log --invert-path -- .gitignore" should show only
    commits that touch something besides .gitignore)

The code to handle '1' might look something like the patch below, but
this doesn't deal at all with revision pruning.

---
diff --git a/diff.c b/diff.c
index 1c6be89..a72f593 100644
--- a/diff.c
+++ b/diff.c
@@ -2646,6 +2646,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--ignore-submodules"))
 		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
+	else if (!strcmp(arg, "--invert-path"))
+		DIFF_OPT_SET(options, INVERT_PATH);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index a49d865..43f3bff 100644
--- a/diff.h
+++ b/diff.h
@@ -65,6 +65,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
+#define DIFF_OPT_INVERT_PATH         (1 << 21)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
diff --git a/tree-diff.c b/tree-diff.c
index 9f67af6..ef78d91 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -91,7 +91,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
  *  - zero for no
  *  - negative for "no, and no subsequent entries will be either"
  */
-static int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
+static int tree_entry_interesting_internal(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
 {
 	const char *path;
 	const unsigned char *sha1;
@@ -190,6 +190,17 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 	return never_interesting; /* No matches */
 }
 
+static int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen, struct diff_options *opt)
+{
+	int r = tree_entry_interesting_internal(desc, base, baselen, opt);
+	if (!DIFF_OPT_TST(opt, INVERT_PATH))
+		return r;
+	return r  < 0 ?     2 :
+	       r == 0 ?     1 :
+	       r == 1 ?     0 :
+	       /* r > 1 */ -1;
+}
+
 /* A whole sub-tree went away or appeared */
 static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base, int baselen)
 {
