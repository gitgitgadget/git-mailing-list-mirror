X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: an option to make "git-diff Z A" prints Z's diff before A's
Date: Wed, 25 Oct 2006 12:16:07 -0700
Message-ID: <7vd58g9pfs.fsf@assigned-by-dhcp.cox.net>
References: <871wowzx15.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 19:16:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <871wowzx15.fsf@rho.meyering.net> (Jim Meyering's message of
	"Wed, 25 Oct 2006 09:15:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30094>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcoEb-0004Xk-5I for gcvg-git@gmane.org; Wed, 25 Oct
 2006 21:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964798AbWJYTQN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 15:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWJYTQN
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 15:16:13 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:32165 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S964798AbWJYTQL
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 15:16:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025191610.NONL2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 15:16:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ejFt1V00b1kojtg0000000 Wed, 25 Oct 2006
 15:15:54 -0400
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

Jim Meyering <jim@meyering.net> writes:

> In a recent patch set I prepared, I placed the names of the
> more relevant files at the front of the list given to "git-diff".
>...
> I know about the -O<orderfile> option, and it can make git-diff do
> what I want, but only if I first create a separate file containing
> the names that I'm already providing to git-diff in the very same order.
>
> Is there an easier way?

No, not right now.

> If not, would you be amenable to a new option enabling this behavior
> without requiring a temporary file?

The thing is, "git diff -- Z A" does *not* mean:

	I know I have a file called Z and a file called A;
	please give diff for these files.

What it means is:

	Please give me the diff as usual, but I care about paths
	that match these patterns, Z or A.

So "git diff -- Documentation" names all changed files in that
directory; you could also spell it "Documentation/" for clarity.

git-diff traverses two tree-like things (either tree-vs-tree,
tree-vs-index, or tree-vs-working tree) in parallel in the
canonical order, but skips comparing paths that do not match the
list of patterns you gave on the command line.  While it does
so, we do not record which pattern caused the path to be
included in the output anywhere, so there currently is no way to
tell which ones matched an earlier pattern and which ones
matched a later one.

If somebody wants to do this, the place to modify would be the
following:

 - add a new parameter, "int match_number", to change_fn_t and
   add_remove_fn_t functions, and add a new member to struct
   diff_filepair to record it.

 - update all callers of diff_addremove, diff_change, and
   diff_unmerge to pass which pathspec the user gave on the
   command line matched the path to be included (in your example
   if both Z and A were directory, file Z/foo gets number 1 and
   file A/bar gets number 2).

 - update diff_addremove, diff_change and diff_unmerge to pass
   that match_number to diff_queue(), and make diff_queue()
   record the number in the new diff_filepair it creates.

 - in places where an existing filepair is split into two and
   two existing filepairs are merged into one (e.g. "break" and
   "rename"), make sure match_number is propagated sensibly from
   the original filepairs to the modified ones.

 - in diffcore_std(), if orderfile is not in use, use the
   match_number to sort the queued filepairs.

