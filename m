From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: cg-log "fatal: bad revision ''"
Date: Tue, 24 Apr 2007 00:05:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704232357120.29477@castor.milkiway.cos>
References: <1Hergt-0EBwVE0@fwd29.aul.t-online.de> <20070420135816.GO4489@pasky.or.cz>
 <Pine.LNX.4.64.0704201900430.4275@castor.milkiway.cos>
 <alpine.LFD.0.98.0704201554550.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 00:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg6fK-0006UI-DL
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 00:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbXDWWFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 18:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbXDWWFn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 18:05:43 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:56727 "EHLO
	mailout04.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754323AbXDWWFm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 18:05:42 -0400
Received: from fwd34.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1Hg6fF-0002Kj-00; Tue, 24 Apr 2007 00:05:41 +0200
Received: from [192.168.2.100] (b7BZ-iZlgetrABvqbeuhCXLpN-SlvHFtijOBW5YbzAwbrNePLffSZY@[84.163.240.198]) by fwd34.sul.t-online.de
	with esmtp id 1Hg6f4-0uIcpU0; Tue, 24 Apr 2007 00:05:30 +0200
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <alpine.LFD.0.98.0704201554550.9964@woody.linux-foundation.org>
X-ID: b7BZ-iZlgetrABvqbeuhCXLpN-SlvHFtijOBW5YbzAwbrNePLffSZY
X-TOI-MSGID: 98620c86-84f9-4bbe-9e91-fbb8d3a8246c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45369>

On Fri, 20 Apr 2007, Linus Torvalds wrote:
> 
> 
> On Fri, 20 Apr 2007, Michael Dressel wrote:
> > 
> > Thanx for the reply. Is there a way to follow renaming at all, either 
> > with cogito or git?
> 
> "git blame" will follow renames, but doesn't really show things as a log, 
> more just as a "these commits mattered" thing.
> 
> You can use something like this patch to then make it *look* like a "log" 
> function.
> 
> Junio - I really think that something along these lines is worth doing, 
> but I wonder what the right semantics are. This patch is stupid, and just 
> keeps the "blame" semantics, just showing it in a "log format". It does 
> mean that when I do
> 
> 	git blame -C --log block/ll_rw_block.c
> 
> it will show entries for the old drivers/block/ll_rw_blk.c location.
> 
> HOWEVER, it's still broken, because when you do logging, you don't 
> actually care about the diffs at all, so *any* difference from the 
> previous version should show up, even if the lines don't show up in the 
> end result. So this doesn't really do what people actually *want* to do, 
> it does somethign much more complicated ;)
> 
> 		Linus
> 
> ---
>  builtin-blame.c |   21 +++++++++++++++++----
>  1 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin-blame.c b/builtin-blame.c
> index 8919b02..ee98753 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -16,6 +16,7 @@
>  #include "quote.h"
>  #include "xdiff-interface.h"
>  #include "cache-tree.h"
> +#include "log-tree.h"
>  
>  static char blame_usage[] =
>  "git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
> @@ -30,6 +31,7 @@ static char blame_usage[] =
>  "  -L n,m              Process only line range n,m, counting from 1\n"
>  "  -M, -C              Find line movements within and across files\n"
>  "  --incremental       Show blame entries as we find them, incrementally\n"
> +"  --log               Show blame entries as a log\n"
>  "  --contents file     Use <file>'s contents as the final image\n"
>  "  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
>  
> @@ -42,6 +44,7 @@ static int show_root;
>  static int blank_boundary;
>  static int incremental;
>  static int cmd_is_annotate;
> +static int log;
>  
>  #ifndef DEBUG
>  #define DEBUG 0
> @@ -1370,11 +1373,15 @@ static void write_filename_info(const char *path)
>   * The blame_entry is found to be guilty for the range.  Mark it
>   * as such, and show it in incremental output.
>   */
> -static void found_guilty_entry(struct blame_entry *ent)
> +static void found_guilty_entry(struct rev_info *revs, struct blame_entry *ent)
>  {
>  	if (ent->guilty)
>  		return;
>  	ent->guilty = 1;
> +	if (log) {
> +		log_tree_commit(revs, ent->suspect->commit);
> +		return;
> +	}
>  	if (incremental) {
>  		struct origin *suspect = ent->suspect;
>  
> @@ -1443,7 +1450,7 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
>  		/* Take responsibility for the remaining entries */
>  		for (ent = sb->ent; ent; ent = ent->next)
>  			if (same_suspect(ent->suspect, suspect))
> -				found_guilty_entry(ent);
> +				found_guilty_entry(revs, ent);
>  		origin_decref(suspect);
>  
>  		if (DEBUG) /* sanity */
> @@ -2072,7 +2079,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	cmd_is_annotate = !strcmp(argv[0], "annotate");
>  
>  	git_config(git_blame_config);
> -	save_commit_buffer = 0;
>  
>  	opt = 0;
>  	seen_dashdash = 0;
> @@ -2123,6 +2129,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  		}
>  		else if (!strcmp("--incremental", arg))
>  			incremental = 1;
> +		else if (!strcmp("--log", arg))
> +			log = 1;
>  		else if (!strcmp("--score-debug", arg))
>  			output_option |= OUTPUT_SHOW_SCORE;
>  		else if (!strcmp("-f", arg) ||
> @@ -2244,6 +2252,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  
>  	init_revisions(&revs, NULL);
>  	setup_revisions(unk, argv, &revs, NULL);
> +	revs.abbrev = DEFAULT_ABBREV;
> +	revs.commit_format = CMIT_FMT_DEFAULT;
> +	revs.verbose_header = 1;
> +	revs.always_show_header = 1;
> +
>  	memset(&sb, 0, sizeof(sb));
>  
>  	/*
> @@ -2335,7 +2348,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  
>  	assign_blame(&sb, &revs, opt);
>  
> -	if (incremental)
> +	if (incremental || log)
>  		return 0;
>  
>  	coalesce(&sb);
> 

Thanx for your help.

I have a version 1.5.2.rc0.2.g8ec0-dirty now with your changes patched in. 

The command git blame -C --log myfile produces some alternative  
information to git log. 
I thought it would be a "simple" bug in cg-Xfollowrenames. As I learned 
from the follow-up postings it's more involved.

Cheers,
Michael
