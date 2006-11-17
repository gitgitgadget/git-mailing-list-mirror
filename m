X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Thu, 16 Nov 2006 21:55:45 -0800
Message-ID: <7vr6w2vcpq.fsf@assigned-by-dhcp.cox.net>
References: <7vac2q281q.fsf@assigned-by-dhcp.cox.net>
	<20061117031747.30672.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 05:55:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061117031747.30672.qmail@science.horizon.com>
	(linux@horizon.com's message of "16 Nov 2006 22:17:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31667>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkwha-0002M6-Sn for gcvg-git@gmane.org; Fri, 17 Nov
 2006 06:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754014AbWKQFzr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 00:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbWKQFzr
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 00:55:47 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:55737 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1754014AbWKQFzq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 00:55:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117055546.WYAI27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 00:55:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nhvs1V00Q1kojtg0000000; Fri, 17 Nov 2006
 00:55:53 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

>>> * When merging goes wrong
>
>> Another tool to help the user decide how the mess should be
>> sorted out is "git log --merge -- $path".  It gives the logs of
>> commits that touched the path while the two branches were forked.
>
> The things I never knew about...

Of course "git log -p --merge -- $path" would give the patch
text as well.

>> If you are using this particular commit as an example, you might
>> also want to tell your readers about:
>> 
>> 	git show -M 3f69d405
>> 
>> (-M is there to make the output more readable, because this
>> merge involved a few renames).
>
> I'm wondering what the heck that does!  I get a super-short diff with
> no mention of any renames at all.  Is this passed on to git-diff-tree?
> What does "detect renames" mean if it doesn't tell me about them?
> I'm actually confused.

"show $merge" is really "diff-tree --cc -p $merge".  So first I
should (not necessarily "you should to the readers of this
document") talk about three ways to describe a merge commit with
textual diffs.

(1) N independent diffs between each of the parents and the child.

    We could get this with

    	git diff-tree -m -p $merge

    but it is mostly useless, because very often many paths in a
    merge are truly trivial and the version from one of the
    parents is taken verbatim, whole file.  When looking at the
    development history, the real reason of the change is found
    in earlier log for that parent, and not in the merge in
    question.

    The diff between the child and its first parent is somewhat
    useful, because it represents the damage inflicted on his
    branch the person saw when he made the merge.  For this
    reason, "--stat" gives the graph for the first-parent diff
    for a merge.  But otherwise "diff-tree -p" by default stays
    silent about merges because it is not that useful, and that
    is why the above asks for the "useless output ;-)" with an
    explicit "-m".

(2) Uncompressed "combined diff" between all parents and the child.

    We can get this with:

	git diff-tree -c -p $merge

    This gives a combined diff that shows all the files parents
    and child disagreed (in other words, if the resulting file
    matches verbatim with one of the parents, it is not shown).
    This is already useful by reducing the clutter of truly
    trivial merges, compared to (1) above, but most clean merges
    take either first or second parent's version verbatim for
    each hunk (but not necessarily taking all hunks from the
    same parent) and these hunks are not very interesting.

    Because "-c" explicitly tells something special to be done
    for a merge, you do not need to say "-m" for the above
    command (giving -m does not hurt, but is not necessary).
    Uncompressed combined diff is a still per-file affair, so by
    default the above gives the output in the "raw" format, and
    that is why the above command still says "-p".

(3) Compressed "combined diff".  This is what "show" gives by
    default, and we can get this with:

	git diff-tree --cc $merge

    The difference from "-c -p" output is that this reduces the
    clutter further by dropping uninteresting hunks from the
    output.  If all the changes in a hunk is from only one
    parent, or the changes are the same from all but one parent,
    the hunk is dropped from the output (looking at dodecapus
    with --cc is interesting for this reason).

    Like "-c", this explicitly asks a magic to be done on a
    merge, so "-m" is implied.  Unlike "-c", this operation is
    per-hunk and "raw" format (which is inherently per file)
    does not make any sense.  Because "raw" is impossible, "-p"
    is also implied.

Both (2) and (3) are "combined".  It combines the diffs with
each parent; for N-parent merge, it combines N diffs into one.

What -M/-C does is to see which path in each parent is used to
diff against a path in the child.  For example, the stat part
of:

	git diff-tree --stat --cc -p -M 3f69d405

shows us that builtin-apply.c had a few insertion and deletion
(remember, this is the diff between the first parent and the
child -- "damage given to the first parent due to this merge").

If you run the above without -M, you will see a huge combined
diff for builtin-apply.c because the second parent (i.e. the
branch that was merged) did not have builtin-apply.c -- it still
had the file under its old name, apply.c.

So what ends up getting combined without -M is diff between
builtin-apply.c of the first parent and the child, and diff
between /dev/null and builtin-apply.c of the child.

But with -M, what it combines is diff between builtin-apply.c of
the first parent and the child, and diff between apply.c of the
second parent and builtin-apply.c of the child.  This obviously
produces a lot more reasonable output -- actually the merge for
this particular path is texually trivial that it does not even
show in the --cc output.  You can still view what it was by
looking at:

	git diff-tree -c -p -M 3f69d405

Side note: I am not sure if the --cc hunk droppage logic is
doing the right thing for the first hunk for builtin-apply.c
case.  I think it is an "interesting" hunk but somehow --cc
output does not show it.  The second and later hunks are
definitely uninteresting, though.

