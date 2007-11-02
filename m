From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Support "history replay" for git log commands
Date: Fri, 02 Nov 2007 14:05:11 -0700
Message-ID: <7v4pg41hq0.fsf@gitster.siamese.dyndns.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021333050.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 22:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io3hy-0002Rg-42
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 22:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbXKBVFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbXKBVFU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 17:05:20 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:35178 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbXKBVFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 17:05:18 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 824E32EF;
	Fri,  2 Nov 2007 17:05:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C5C1691805;
	Fri,  2 Nov 2007 17:05:34 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0711021333050.3342@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 2 Nov 2007 13:35:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63175>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This notices if we aren't in topological order, and replays the history. 
> Thus avoiding the need to sort history up front.
>     
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> See the code and the more complete explanations in [PATCH 0/2]. In 
> particular, see the last section there about the downsides of this: the 
> 50x expansion of output on the kernel is unacceptable, but if somebody can 
> make a graphical viewer that can react correctly to the "Replay" thing, 
> I'm sure I can make the replays themselves happen much more rarely.
>
>  builtin-blame.c |    2 +-
>  builtin-log.c   |   35 +++++++++++++++++++++++++++++++++++
>  log-tree.c      |   10 +++++++---
>  revision.c      |   29 ++++++++++++++++++++++-------
>  revision.h      |    6 +++++-
>  5 files changed, 70 insertions(+), 12 deletions(-)
>
> diff --git a/builtin-blame.c b/builtin-blame.c
> index 8432b82..7b6af8c 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -1502,7 +1502,7 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
>  		else {
>  			commit->object.flags |= UNINTERESTING;
>  			if (commit->object.parsed)
> -				mark_parents_uninteresting(commit);
> +				mark_parents_uninteresting(revs, commit);
>  		}
>  		/* treat root commit as boundary */
>  		if (!commit->parents && !show_root)
> diff --git a/builtin-log.c b/builtin-log.c
> index e8b982d..10e0821 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -77,6 +77,35 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
>  	}
>  }
>  
> +static void replay_history(struct rev_info *revs)
> +{
> +	struct commit_list *entry;
> +
> +	revs->trigger_replay = 0;
> +	while ((entry = revs->shown) != NULL) {
> +		struct commit *commit = entry->item;
> +		unsigned flags = commit->object.flags;
> +
> +		/* Undo the SHOWN and FORCE_REPLAY bits */
> +		commit->object.flags = flags & ~(SHOWN | FORCE_REPLAY);
> +		commit->indegree = 0;
> +
> +		/* Remove it from the shown list, put it on the commit list */
> +		revs->shown = entry->next;
> +		entry->next = revs->commits;
> +		revs->commits = entry;
> +
> +		printf("Replay %s\n", sha1_to_hex(commit->object.sha1));
> +
> +		/* Was this the one that caused us to replay? */
> +		if (flags & FORCE_REPLAY)
> +			break;

Can one iteration of loop in log_tree_commit() smudge more
than one commits with FORCE_REPLAY?  Maybe make the
trigger_replay a counter and count down in this loop until we
find that many commits that have the FORCE_REPLAY flag?
