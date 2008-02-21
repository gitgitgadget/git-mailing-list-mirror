From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Built-in checkout: wrong behaviour in subdirectories
Date: Thu, 21 Feb 2008 10:50:42 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802211041190.19024@iabervon.org>
References: <20080220223520.GA23642@localhost> <alpine.LNX.1.00.0802201740050.19024@iabervon.org> <7vhcg32p0i.fsf@gitster.siamese.dyndns.org> <7vd4qr2o03.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 16:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSDiQ-0004Yt-Oe
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 16:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYBUPvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 10:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764565AbYBUPux
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 10:50:53 -0500
Received: from iabervon.org ([66.92.72.58]:55612 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760361AbYBUPur (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 10:50:47 -0500
Received: (qmail 16618 invoked by uid 1000); 21 Feb 2008 15:50:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Feb 2008 15:50:42 -0000
In-Reply-To: <7vd4qr2o03.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74623>

On Wed, 20 Feb 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> >
> >> Junio: it looks like something used to cause read-tree to be run with 
> >> pwd being the working tree root in git-checkout.sh.
> >
> > "Something"?  I think we explicitly cdup when switching
> > branches, and we should do the same in C rewrite.
> >
> >         # We are switching branches and checking out trees, so
> >         # we *NEED* to be at the toplevel.
> >         cd_to_toplevel
> 
> Isn't it just the matter of not passing prefix to topts in
> merge_working_tree()?  Your other calls to unpack_trees() do not
> seem to pass bogus prefix to it.

You're absolutely right; I think I initially misunderstood the way the 
wrapper sets things up beforehand, and did the later parts of the 
conversion correctly. But we should also drop the bunch of 
now-unused arguments, too:

--------------
commit 267d68e24111bc9054d1f3356842f58106c76f49
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Thu Feb 21 10:48:46 2008 -0500

    Remove unused prefix arguments in switch_branches path
    
    This path doesn't actually care where in the tree you started out,
    since it must change the whole thing anyway. With the gratuitous bug
    removed, the argument is unused.
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-checkout.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index cddd3a9..46cb362 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -205,8 +205,7 @@ static void setup_branch_path(struct branch_info *branch)
 }
 
 static int merge_working_tree(struct checkout_opts *opts,
-			      struct branch_info *old, struct branch_info *new,
-			      const char *prefix)
+			      struct branch_info *old, struct branch_info *new)
 {
 	int ret;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
@@ -429,8 +428,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		adjust_to_tracking(new, opts);
 }
 
-static int switch_branches(struct checkout_opts *opts,
-			   struct branch_info *new, const char *prefix)
+static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 {
 	int ret = 0;
 	struct branch_info old;
@@ -471,7 +469,7 @@ static int switch_branches(struct checkout_opts *opts,
 		opts->force = 1;
 	}
 
-	ret = merge_working_tree(opts, &old, new, prefix);
+	ret = merge_working_tree(opts, &old, new);
 	if (ret)
 		return ret;
 
@@ -565,5 +563,5 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		die("Cannot switch branch to a non-commit.");
 	}
 
-	return switch_branches(&opts, &new, prefix);
+	return switch_branches(&opts, &new);
 }
