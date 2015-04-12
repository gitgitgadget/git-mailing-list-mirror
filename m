From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 1/4] t4059: test 'diff --cc' with a change from only
 few parents
Date: Sun, 12 Apr 2015 08:43:32 +0300
Message-ID: <20150412054332.GA28555@wheezy.local>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428076716-4449-1-git-send-email-max@max630.net>
 <1428076716-4449-2-git-send-email-max@max630.net>
 <xmqqa8ye5q7m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 07:43:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhAgA-0003PD-Gd
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 07:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbbDLFn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 01:43:26 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:51909
	"EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750724AbbDLFnZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2015 01:43:25 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-06.prod.phx3.secureserver.net with 
	id EtjH1q0085B68XE01tjPjh; Sat, 11 Apr 2015 22:43:24 -0700
Content-Disposition: inline
In-Reply-To: <xmqqa8ye5q7m.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267037>

On Sat, Apr 11, 2015 at 02:07:25PM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
> 
>> If `git diff --cc` is used with 2 or more parents, then it shows
>> all hunks which have changed compared to at least 2 parents.
>> Which is reasonable, because those places are likely places for
>> conflicts, and it should be displayed how they were resolved.
> 
> OK.
> 
>> But, preliminary path filtering passes a path only it was changed
>> compared to each parent.
> 
> That is true, but I am a bit confused by the above, especially the
> word "But" that begins the sentence.  Are you talking about this
> comment that describes what the caller wants to do?
> 
>     /* find set of paths that every parent touches */
>     static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
>             const struct sha1_array *parents, struct diff_options *opt)
> 
> When the result of a merge exactly matches one (or more) of the
> parent of the merge, we do not want to show it in the combined
> format, so intersect_paths() does want to find paths that are
> different from all parents.  Isn't that a good thing?

If it is a good thing, then probably for file which has not
been filtered out it is also a good thing, then diff --cc
should have been hiding hunks which fully preserve one of
the parent.

>> So, if a hunk which has not changed compared to some of parents is
>> shown if there are more changed hunks in the file, but not shown
>> if it is the only change.
>>
>> This looks inconsistent and for some scenarios it is desirable to show
>> such changes.
> 
> Hmm, that may be true.  So help me see if I understand your goal by
> checking if I rephrased you correctly below:
> 
>  - We want to show a combined hunk when the number of parent
>    variants for the hunk is more than 2 (i.e. interesting octopus)
>    or the result does not match any of the parents (i.e. conflict
>    resolution of a pairwise merge).  We want to drop a hunk whose
>    result came from only one set of parent and the other parents had
>    the same original that is different from the result.
> 
>  - The current code filters out a path that matches one of the
>    parents very early.  This is OK for a two-way merge.  If the
>    result matches one of the parent's, then any hunk we might
>    produce by not pre-filtering would have the result that came from
>    one parent (i.e. the one identical to the result) and there is
>    only one other parent, which cannot make it an interesting
>    octopus by definition.
> 
>    But an octopus may merge three variants and pick the result from
>    one of the parents as a whole.  With the pre-filtering, no hunk
>    from such a path is shown, even when the other two variants in
>    "discarded" parents are not identical.

Yes, I meant that.

> 
> The original to refer to are two commits bf1c32bd (combine-diff:
> update --cc "uninteresting hunks" logic., 2006-02-02) and fd4b1d21
> (combine-diff: add safety check to --cc., 2006-02-02).
> 
> Especially, we need to pay close attention to the discussion that
> germinated the current behaviour:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=15519
> 
> I recall that the "diff --cc" before that change was not discarding
> uninteresting merges sufficiently and the two commits were a
> deliberate attempt to reject what your series wants to show as
> uninteresting hunks.  
> 
> Two suggestions.
> 
>  - This is primarily for 2/4, but can we make it more clear in the
>    code that we do this "include more" change only on Octopus
>    merges?  This change should not make any difference for two-way
>    merges and I'd prefer to avoid extra processing of finding
>    matching hunks and combining, only to discard the result.
> 
>  - Can you run "diff --cc" with and without your patches to the
>    "merge from hell" commit mentioned in the original thread and see
>    if we show more hunks with your patches, and make sure what are
>    shown additionally looked really "interesting"?


The diffs:
older version (without my patch):
https://gist.githubusercontent.com/max630/70080d38e8e9951b58a4/raw/diffcc_old.txt
newer version:
https://gist.githubusercontent.com/max630/70080d38e8e9951b58a4/raw/diffcc_new.txt

The outcome is quite different, yes.

First, I can see that file removal/deletion are passed
without filtering, even if file was only added/deleted
compared to some parents and not changed compared to any, so
it's in some way "2 versions" diff which should not be
shown. This I think is something should be fixed in addition
to this series.

Other than that, all other changes look "interesting",
meaning they contain more than 2 versions. Sometimes it's not
easy to spot because a long hunk is almost inherited from
one parent with all others being the same, and only in
couple of lines there when they differ. But I always find
some difference.

It was also quite slow, 11 seconds compared to some 0.4.
But for 2-way merges speed did not change.



My exact case was that there was a change in one branch
which was overwritten during merge conflict resolution by
fully acepting the other branch - in a 2-parent merge. I
started looking for a way to visualize such cases. They
are not visible in usual diff, because they look same as
accepting change compared to the unchange branch. To
recognize them you should consider the mergebase. I googled
to your suggestion in [1], and prepared a trivial testcase
for such a merge - in contained a base commit, change in
both branches and children which fully repeat one of the
branches. But then I discovered that such merge is not shown
in "diff --cc" because of the path filtering. So here am I.

Actually I think this is the very true rule which I would
like to be used: if there is a parent which is changed
compared to the merge base and child commit differs from
that parent. Because this is where there had been a valuable
change, and it disappeared. Linus in [2] wrote that those
change was fixing the same problem and it's good that they
are not shown, by it my case there were fixing different
problems, they just happened to be in the same place, and
after merge the bug reappeared.

[1] http://thread.gmane.org/gmane.comp.version-control.git/191553/focus=191557
[2] http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=15519
