From: Junio C Hamano <junkio@cox.net>
Subject: Re: updated design for the diff-raw format.
Date: Sat, 21 May 2005 16:19:30 -0700
Message-ID: <7vd5rkdv5p.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 01:18:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZdEo-0004Ca-Sl
	for gcvg-git@gmane.org; Sun, 22 May 2005 01:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVEUXTq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 19:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVEUXTq
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 19:19:46 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37254 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261662AbVEUXTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 19:19:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521231931.IBDB1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 19:19:31 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 16:12:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(fourth of the replayed messages)

Date: Sat, 21 May 2005 15:03:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half of copy detection.
Message-ID: <Pine.LNX.4.58.0505211452180.2206@ppc970.osdl.org>

On Sat, 21 May 2005, Junio C Hamano wrote:
> 
>      - omit the inter_name_termination and second path if both
>        paths are the same, only when doing human-readable
>        (i.e. inter_name_termination != line_termination).

Hmm. I guess that's fair enough, since it's still easily parseable even if
you don't want to use the -z version in scripts (as many tools are better
at handling line-terminated stuff than handling zero-terminations).

It might become another flag too, if somebody ends up caring.

> Somehow I failed to CC the GIT list the message you are
> responding to.  Discussing a change with an impact of this scale
> needs to be taken public before going further, so with your
> permission I would like to repost both my original ("Once we
> start to think of it this way...")  and your response to the GIT
> list first.  At least I feel that Petr needs to be in the loop
> about this one.

Sure. Although I doube people use the raw diff output except to (a) feed 
to diff-helper or (b) check that it's non-empty.

But absolutely, post the previous (and this) one.

> Another reason is that, as I said, I still have problems about the
> diffcore interface, namely the lack of interface for the applications to
> ask diffcore what the final outcome is.  The "diff-tree not being to
> omit its header output when pickaxe says the result is empty" problem is
> primarily what bothers me, but I think we want a more generic interface
> for the application to inspect the result (not just emptiness check),
> probably before starting to feed the resulting diff list to the external
> diff.

Why not just have a "is there anything pending" query before doing the 
flush? And always put _everything_ in the pending category, regardless of 
whether detect_rename/copy is in effect (but if it's not in effect, then 
flushing the pending queue is obviously just a "go through it and flush 
it" without any other complexity).

In other words, there would be four clear stages to this:

 1) diff_setup()
	remove "detect_rename" and "diff_score_opt" and "reverse_diff" 
	from this, since they are irrelevant until you _show_ the diffs

 2) diff_queue() *n
	tell diff-core about the files we are going to diff

 3) diff_detect_rename()
	this is what takes the "detect_rename" flag and "diff_score_opt", 
	and walks the list of diffs and potentially changes them into 
	"rename" and "copy" diffs.

 4) diff_flush()
	this just prints out the result (either as a raw diff or as 
	patches). This takes the "reverse_diff" flag that was removed from 
	diff_setup().

and then you can always query the state of the diff tree before stage 3 or 
before stage 4.

In fact, there's no reason not to even _change_ the diff-queue in magic 
ways before (3) or (4) depending on what you want to do. For example, your 
"-S" thing might want to do it's thing between stages (3) and (4).

		Linus




