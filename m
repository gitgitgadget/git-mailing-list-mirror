From: Jeff King <peff@peff.net>
Subject: Re: [tig PATCH] fix off-by-one on parent selection
Date: Sun, 23 May 2010 03:55:03 -0400
Message-ID: <20100523075503.GA24598@coredump.intra.peff.net>
References: <20100510085504.GA2283@coredump.intra.peff.net>
 <AANLkTim8cQ-1oBE-BOwbjTlyn2E2V64NvM_6Drs3kTAS@mail.gmail.com>
 <20100523074051.GA16730@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun May 23 09:55:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG61x-0008Fp-8X
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 09:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab0EWHzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 03:55:11 -0400
Received: from peff.net ([208.65.91.99]:52366 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab0EWHzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 03:55:10 -0400
Received: (qmail 20853 invoked by uid 107); 23 May 2010 07:55:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 03:55:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 03:55:03 -0400
Content-Disposition: inline
In-Reply-To: <20100523074051.GA16730@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147556>

On Sun, May 23, 2010 at 03:40:52AM -0400, Jeff King wrote:

> Now try "tig blame new". For all of the lines but the first, blaming the
> parent gets you the correct "The selected commit has no parents". But
> parent-blaming the first line will correctly re-blame using the filename
> "old".

By the way, there is one minor bug remaining after this patch:

>  	case REQ_PARENT:
>  		if (check_blame_commit(blame, TRUE) &&
> -		    select_commit_parent(blame->commit->id, opt_ref,
> -					 blame->commit->filename)) {
> -			string_copy(opt_file, blame->commit->filename);
> +		    select_commit_parent(blame->commit->id, opt_ref) &&
> +		    follow_parent_rename(blame->commit->id, opt_ref,
> +					 blame->commit->filename, opt_file)) {
>  			setup_blame_parent_line(view, blame);
>  			open_view(view, REQ_VIEW_BLAME, OPEN_REFRESH);
>  		}

We may write some new filename into opt_file in the follow_parent_rename
call, but setup_blame_parent_line always diffs the original file. Which
means we lose the line position when following a rename.

We need to do the equivalent of:

  git diff -U0 \
    opt_ref:opt_file \
    blame->commit->id:blame->commit->filename

IOW, to blame directly between the two blobs. Sadly, I don't think there
is a plumbing command to do this, so we are stuck using regular "git
diff", which may have surprises in the config.

The patch below works for my simple tests.  I think we probably want to
be doing this anyway for the multiple-parent case. I didn't test, but I
don't think that diff-tree invocation is going to produce any output for
a merge commit.

diff --git a/tig.c b/tig.c
index cfa26ce..4388c2f 100644
--- a/tig.c
+++ b/tig.c
@@ -5177,15 +5177,21 @@ check_blame_commit(struct blame *blame, bool check_null_id)
 static void
 setup_blame_parent_line(struct view *view, struct blame *blame)
 {
+	char from[SIZEOF_REF+SIZEOF_STR];
+	char to[SIZEOF_REF+SIZEOF_STR];
 	const char *diff_tree_argv[] = {
-		"git", "diff-tree", "-U0", blame->commit->id,
-			"--", blame->commit->filename, NULL
+		"git", "diff", "--no-textconv", "--no-extdiff", "--no-color",
+		"-U0", from, to, "--", NULL
 	};
 	struct io io = {};
 	int parent_lineno = -1;
 	int blamed_lineno = -1;
 	char *line;
 
+	snprintf(from, sizeof(from), "%s:%s", opt_ref, opt_file);
+	snprintf(to, sizeof(to), "%s:%s", blame->commit->id,
+		 blame->commit->filename);
+
 	if (!io_run(&io, diff_tree_argv, NULL, IO_RD))
 		return;
 
