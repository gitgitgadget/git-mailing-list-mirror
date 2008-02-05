From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 9/9] Build in checkout
Date: Tue, 5 Feb 2008 22:11:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052205210.8543@racer.site>
References: <alpine.LNX.1.00.0802041336060.13593@iabervon.org> <alpine.LSU.1.00.0802050143050.8543@racer.site> <alpine.LNX.1.00.0802042201060.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:13:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMW2H-0005JR-Ay
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762266AbYBEWM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762238AbYBEWM1
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:12:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:37921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762200AbYBEWMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:12:25 -0500
Received: (qmail invoked by alias); 05 Feb 2008 22:12:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 05 Feb 2008 23:12:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+P7iJRXWyPWksC2AzujZwg9rvnvL39JcnYDpdlO0
	TjkRwJ1OwRfzdp
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802042201060.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72708>

Hi,

On Tue, 5 Feb 2008, Daniel Barkalow wrote:

> On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> 
> So, as an introductory comment, I was working quite strictly from 
> git-checkout.sh, using the implementations of the operations as given 
> there, and not looking at what other code has the same goal and may be 
> doing it differently, so I've almost certainly missed a number of 
> chances for sharing code (beyond calling functions directly instead of 
> putting together command lines and having them parsed). In particular, I 
> hadn't looked at all at builtin-reset, which obviously does a bunch of 
> the same things.

Well, it seems like I won't be able to review any more til this weekend.  
Sorry.

> > On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> > 
> > > diff --git a/builtin-checkout.c b/builtin-checkout.c
> > > new file mode 100644
> > > index 0000000..2950d5c
> > > --- /dev/null
> > > +++ b/builtin-checkout.c
> > > @@ -0,0 +1,478 @@
> > > +#include "cache.h"
> > > +#include "builtin.h"
> > > +#include "parse-options.h"
> > > +#include "refs.h"
> > > +#include "commit.h"
> > > +#include "tree.h"
> > > +#include "tree-walk.h"
> > > +#include "unpack-trees.h"
> > > +#include "dir.h"
> > > +#include "run-command.h"
> > > +#include "merge-recursive.h"
> > > +#include "diff.h"
> > > +#include "revision.h"
> > > +
> > > +static const char * const checkout_usage[] = {
> > > +	"git checkout [options] <branch>",
> > > +	"git checkout [options] [<branch>] -- <file>...",
> > > +	NULL,
> > > +};
> > > +
> > > +static int post_checkout_hook(struct commit *old, struct commit *new,
> > > +			      int changed)
> > > +{
> > > +	struct child_process proc;
> > > +	const char *name = git_path("hooks/post-checkout");
> > > +	const char *argv[5];
> > > +
> > > +	if (access(name, X_OK) < 0)
> > > +		return 0;
> > > +
> > > +	memset(&proc, 0, sizeof(proc));
> > > +	argv[0] = name;
> > > +	argv[1] = xstrdup(sha1_to_hex(old->object.sha1));
> > > +	argv[2] = xstrdup(sha1_to_hex(new->object.sha1));
> > > +	argv[3] = changed ? "1" : "0";
> > > +	argv[4] = NULL;
> > > +	proc.argv = argv;
> > > +	proc.no_stdin = 1;
> > > +	proc.stdout_to_stderr = 1;
> > > +	return run_command(&proc);
> > > +}
> > 
> > Would this not be helped by the patch of Paolo in 
> > http://article.gmane.org/gmane.comp.version-control.git/72495?
> > 
> > We would only need to move the function into run-command.[ch]...
> 
> Probably, but that hasn't been merged yet as of origin/next, which is 
> what I'm working from. Good candidate for a follow-up when both series 
> are in, or if I do a revision of this series after that one is in.

Concur.  I briefly looked at moving run_hook(), and it is not as nice as I 
thought: builtin-commit's version of run_hook() wants to set the 
environment variable GIT_INDEX_FILE, and therefore it has a parameter 
index_file which most other hooks probably do not need.

> > > +	hashcpy(ce->sha1, sha1);
> > > +	memcpy(ce->name, base, baselen);
> > > +	memcpy(ce->name + baselen, pathname, len - baselen);
> > > +	ce->ce_flags = create_ce_flags(len, 0);
> > > +	ce->ce_mode = create_ce_mode(mode);
> > > +	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
> > > +	return 0;
> > > +}
> > > +
> > > +static int read_tree_some(struct tree *tree, const char **pathspec)
> > 
> > I have a hunch that you could share code with builtin-reset.c, namely 
> > call function read_from_tree() here.
> 
> This version matches the "ls-tree | update-index" implementation in 
> git-checkout.sh; I'm not terribly fond of the diff-index-based version, 
> since it messed up the index, rereads it from disk, and then applies 
> changes. On the other hand, it would probably be good to update the 
> cache entries with a function that would keep the stat info if nothing 
> else changed.

Exactly.  In fact, that is the only reason I suggested that: to prevent 
the index from needing an update.

This is quite important if you have a large working tree, and switch 
branches from A to B.  For example, "make" will punish you where it hurts.

> > > +static int remove_merge_head(void)
> > > +{
> > > +	unlink(git_path("MERGE_HEAD"));
> > > +	return 0;
> > > +}
> > 
> > Please make this either void, or return what the unlink() returns.
> 
> I think, actually, that I should steal the end of "builtin-reset", which 
> discards a few other files as well that won't be appropriate after the 
> switch.

Good.

> > > +static void show_local_changes(struct object *head)
> > > +{
> > > +	struct rev_info rev;
> > > +	// I think we want full paths, even if we're in a subdirectory.
> > 
> > Please avoid C++-style comments.
> 
> Yup. Can we make git build by default with --std=c89, so I get errors for 
> this sort of thing? *sigh*

Heh.  You can do that in config.mak.  For the Makefile, I am afraid this 
is no option, as we try to support other compilers than gcc, too.

> > > +static int reset_to_new(struct tree *tree, int quiet)
> > 
> > Again, I think that this would benefit from code sharing with 
> > builtin-reset.  It can be a bit tricky to avoid writing files when they 
> > are already up-to-date...
> 
> Reset actually execs "read-tree", which does a bunch of parsing to set up 
> the arguments like this function does (except that it doesn't keep the 
> stat info, I think), and then uses the same actual code that this function 
> calls directly (which has done the only-write-changes thing correctly 
> since June 2005 or before).

Okay, I'll just wait and see (as I do not have the time to dive into the 
code).

Thanks,
Dscho
