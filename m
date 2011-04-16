From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] combine-diff: use textconv for combined diff format
Date: Sat, 16 Apr 2011 10:19:48 -0700
Message-ID: <7vei52azbf.fsf@alter.siamese.dyndns.org>
References: <20110414213006.GA7709@sigill.intra.peff.net>
 <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net> <7voc47cqj0.fsf@alter.siamese.dyndns.org> <4DA96E48.3050008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 19:20:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB9AG-0006V5-H6
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 19:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab1DPRUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 13:20:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1DPRUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 13:20:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5AE4C5828;
	Sat, 16 Apr 2011 13:21:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EVCTx3xk9dfV2jfCk0ykUQGGojY=; b=xghtzD
	urxVNwHpo7GstQiXLiv4Dv4Uqwm/uXNOu19hZbe80qHITrScprmk4t7g6mf7f9Di
	YluYLPiOHx4cbrfJXx7TRWd8e5HSN/vSiVFUxZ1cyh41sk/uGWdSSStwQIJA/V6y
	PIjakKOEbdGh85HTEH+xUcuB37IN5vu2p7dMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orSz+Do9HzioIRORS6Ylim3qsa+s5tTE
	IuHs0h/qeUTM3tb6eF1EnRU5vIOQdiyJqhWh/K/xqAzZbNQ97TkQe68Lkz1xSZ1K
	dxFkOOKQGrvzj7ij2iIBufKn16Eh7x6pomfhCgQ9D1XeVY2lXKFP91YX6S/42c/F
	mWZBfLgQc24=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26DDB5827;
	Sat, 16 Apr 2011 13:21:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C8A7B5826; Sat, 16 Apr 2011
 13:21:50 -0400 (EDT)
In-Reply-To: <4DA96E48.3050008@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sat, 16 Apr 2011 12:24:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06BB064A-684E-11E0-B305-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171684>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 15.04.2011 20:34:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> git diff -m produces a combined diff!
>> 
>> Hmm, what is the rest of your command line?  I thought -m was a way to ask
>> pairwise diff with each parent.
>
> Sure, but it does not always work like that. Just look at the test from
> my patch, or do any "git merge --no-commit" and then "git diff -m". I
> would expect that to compare the worktree to each parent, but in fact it
> runs "diff --cc".

Thanks; it wasn't clear you are comparing stages with the working tree.
Asking for the rest of the command line paid off ;-)

And yes, comparing multiple entries with the worktree files is done in
run_diff_files() defined in diff-lib.c; it is unaware of the -m option
that was originally defined for diff-tree to show pairwise diff.  That
codepath never cared about -m before nor after -c/--cc was invented for
diff-tree, and it only learned about -c/--cc when it was introduced.  I
think diff-index is unaware of the -m option from the same historical
background (read: not "for the same reason or justification").

We may want to change that, but I am personally not very interested.  We
can ask to diff against a specific stage, I know that is what I do, and I
think that is what most people do [*1*].

> "diff -m --oneline" says something like
>
> aa01ae1 (from 64c0923) Merge branch 'master' into somebranch
> diff --git a/a b/a
> index 72594ed..d8323da 100644
> Binary files a/a and b/a differ
> aa01ae1 (from e85049e) Merge branch 'master' into somebranch
> diff --git a/a b/a
> index 86e041d..d8323da 100644
> Binary files a/a and b/a differ

Yes this is the case for diff-tree running pair-wise comparison.

> so I'm wondering whether we shouldn't stay closer to that with "--cc
> also", e.g.:
>
> aa01ae1 Merge branch 'master' into somebranch
> diff --cc a
> index 72594ed,86e041d..d8323da
> Binary files a/a and b/a differ

The -c/--cc options are about presenting the pairwise -m output in a
different way by combining and condensing.  So in that sense, if we really
want to combine and condense information, one possibility is to do:

 Binary files a/a and c/a differ, b/a and c/a differ.

naming each parent as 'a', 'b', ... and giving the highest letter (in the
two-parent merge case, 'c') to the final result.  By doing so, you can
express where in its tree each parent had the content when you are viewing
a renaming merge.

Bu that opens an old can of worms we should have opened and closed four
years ago.

The header shows "diff --cc a" followed by "--- a/a" followed by "+++ b/a"
before the hunk for a two-way merge.  But if we are to "combine and
condense", another possibility is to show:

    diff --cc a/a b/a c/a
    index bf7c788,fa9d23a,5d24d9f..cc69134
    --- a/a
    --- b/a
    +++ c/a
    @@@@ -74,26 -74,6 -74,29 +74,50 @@@@
    ...

to keep the paths information.  I do not think anybody cared so far, and
perhaps we should have done it when we introduced -c/--cc, but it is not
at all worth changing now.

That means that we are not all that worried about losing the rename
information when showing such a diff in --cc/-c form.  After all, the
"diff --cc a" header is not "diff --cc a/a b/a c/a" that mentions all
paths, and "--- a/a" lines are not repeated for each parent.  So while
showing the names like you suggested may be a possibility, I think an
approach that is more in line with the current output would be:

 "Binary files a in different versions differ"

or something without naming them with a/, b/, ...

In short, it all depends on how much we condense when running -c/--cc.  We
are inconsistent by showing both "--- a/a" and "+++ b/a" lines, but modulo
that we condense away the renamed path information in our current output.
And the final alternative in the previous paragraph would be more in line
with that design.


[Footnote]

*1* I also often use 

 diff HEAD...MERGE_HEAD $path
 diff HEAD $path
 diff MERGE_HEAD $path

during a conflicted merge when it is hard to read in the --cc form.
