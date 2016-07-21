Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8101E203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbcGUTAy (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 15:00:54 -0400
Received: from siwi.pair.com ([209.68.5.199]:46962 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbcGUTAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 15:00:52 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id CC9E8845CE;
	Thu, 21 Jul 2016 15:00:50 -0400 (EDT)
Subject: Re: [PATCH v1 3/6] Per-file output for Porcelain Status V2
To:	Junio C Hamano <gitster@pobox.com>,
	Jeff Hostetler <jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-4-git-send-email-jeffhost@microsoft.com>
 <xmqqh9bkc7xx.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, peff@peff.net
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57911B5B.9090604@jeffhostetler.com>
Date:	Thu, 21 Jul 2016 14:58:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqh9bkc7xx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 05:31 PM, Junio C Hamano wrote:

> The code seems to assume that d->porcelain_v2.* fields are
> initialized earlier in the callchain to reasonable values
> (e.g. STATUS_ADDED case does not clear .mode_head to "missing"); I
> am not sure if that is easier to read or fill in all the values
> explicitly in this function.

The structure is initially zeroed when it allocated.
I'm only setting values for the side the we know are
actually defined (such as in an ADD we know there is
no head values). I'll look at making this more clear.

>> +}
>> +
>> +/* Copy info for both sides of an index-vs-worktree change
>> + * into the very verbose porcelain data.
>> + */
>> +static void porcelain_v2_changed_entry(
>> +	struct wt_status_change_data *d,
>> +	const struct diff_filepair *p)
>> +{
>> +	switch (p->status) {
>> +	case DIFF_STATUS_ADDED:
>> +		d->porcelain_v2.mode_worktree = p->two->mode;
>> +		/* don't bother with worktree sha, since it is almost always zero. */
>> +		break;
>> +
>> +	case DIFF_STATUS_DELETED:
>> +		d->porcelain_v2.mode_index = p->one->mode;
>> +		hashcpy(d->porcelain_v2.sha1_index, p->one->sha1);
>> +		break;
>> +
>> +	case DIFF_STATUS_COPIED:
>> +	case DIFF_STATUS_MODIFIED:
>> +	case DIFF_STATUS_RENAMED:
>
> Can RENAMED or COPIED happen here?

If we don't report renamed or copied for unstaged changes, then no.


> The code would be simpler and we'll catch bugs more uniformly if
> "collect" phase is made oblivious to s->status_format, I would
> suspect, by making unconditional call to porcelain_v2_*_entry()
> functions from all of these "collect" functions.

ok. will do.

>
>> +/* Convert various submodule status values into a
>> + * string of characters in the buffer provided.
>> + */
>> +static void wt_porcelain_v2_submodule_state(
>> +	struct wt_status_change_data *d,
>> +	char sub[5])
>> +{
>> +	int k = 0;
>> +
>> +	if (S_ISGITLINK(d->porcelain_v2.mode_head) ||
>> +		S_ISGITLINK(d->porcelain_v2.mode_index) ||
>> +		S_ISGITLINK(d->porcelain_v2.mode_worktree)) {
>> +		/* We have a submodule */
>> +		sub[k++] = 'S';
>> +
>> +		/* Sub-flags for each type of dirt */
>> +		if (d->new_submodule_commits)
>> +			sub[k++] = 'C';
>> +		if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
>> +			sub[k++] = 'M';
>> +		if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
>> +			sub[k++] = 'U';
>> +	} else {
>> +		/* Not a submodule */
>> +		sub[k++] = 'N';
>> +	}
>> +
>> +	sub[k] = 0;
>> +}
>
> The above seems to do "up to 5"; if these come early in the output,
> it may instead be easier to read if "fixed 5 columns, many of them
> may be SP, and some may be C or M or U", which would align on fixed
> column terminal people use for coding.

I debated fixed 4 columns vs a variable width token.
The latter seemed easier to parse, but does look more ugly
on the terminal.  I'll revisit this.  Perhaps make it fixed
4 columns with a '.' instead of SPACE, so both parsing
techniques work.

>
>> +/* Various fix-up steps before we start printing an item.
>> + */
>> +static void wt_porcelain_v2_fix_up_status(
>> +	struct string_list_item *it,
>> +	struct wt_status *s)
>> +{
>> +	struct wt_status_change_data *d = it->util;
>> +
>> +	if (!d->index_status) {
>> +		if (d->worktree_status == DIFF_STATUS_MODIFIED ||
>> +			d->worktree_status == DIFF_STATUS_DELETED) {
>> +			/* X=' ' Y=[MD]
>> +			 * The item did not change in head-vs-index scan so the head
>> +			 * column was never set. (The index column was set during the
>> +			 * index-vs-worktree scan.)
>> +			 * Force set the head column to make the output complete.
>> +			 */
>> +			d->porcelain_v2.mode_head = d->porcelain_v2.mode_index;
>> +			hashcpy(d->porcelain_v2.sha1_head, d->porcelain_v2.sha1_index);
>> +		}
>
> Can there be "else" clause for this inner "if"?  When
> d->index_status is not set, but worktree_status is not one of these
> two, what does it indicate?  The same for the next one.

For a normal entry (not unmerged) when X is ' ', Y can only
be 'M' or 'D'.  The only other value for Y is ' ', but then if
both were ' ' the entry would not be in the list.  So I think
we're OK, but I'll document that here.  And below.


>> +/*
>> + * Define a single format for tracked entries. This includes:
>> + * normal changes, rename changes, and unmerged changes.
>> + *
>> + * The meanings of modes_[abcd] and sha_[abc] depends on the
>> + * change type, but are always present.
>> + *
>> + * Path(s) are C-Quoted if necessary. Current path is ALWAYS
>> + * first. The rename source path is only present when necessary.
>> + * A single TAB separates them (because paths can contain spaces
>> + * and C-Quoting converts actual tabs in pathnames to a C escape
>> + * sequence).
>> + */
>> +static void wt_porcelain_v2_print_tracked_entry(
>> +	FILE *fp,
>> +	char x_staged,
>> +	char y_unstaged,
>> +	const char *submodule,
>> +	int mode_a,
>> +	int mode_b,
>> +	int mode_c,
>> +	int mode_d,
>> +	const unsigned char sha_a[GIT_SHA1_RAWSZ],
>> +	const unsigned char sha_b[GIT_SHA1_RAWSZ],
>> +	const unsigned char sha_c[GIT_SHA1_RAWSZ],
>
> x, y, a, b, c, d are all mystery.  When we see a/b/c, they typically
> mean stage#1, stage#2 and stage#3, but that does not seem to be it.
> When we see a/b, they typically mean old and new, but that does not
> seem to be the case here, either.

I took X and Y from the man-page as the names of first 2 columns
of the existing format.
>
> If you are saying in the above comment, which curiously is formatted
> correctly unlike many other multi-line comments we see in this patch
> ;-),

I read Linus' recent post on the subject mid-way thru this effort. :-)

 >      that the meaning of these are not fixed but the function is to
> always show 2 things, then four things in the fixed order without
> knowing what they mean, it would be easier to understand if you made
> them into an array, i.e.e.g. instead of having x_staged and
> y_unstaged, have "char prefix[2]" or something that tells the reader
> that whatever meaning these have, these come early in the output.

I'll revisit this.  For normal entries (modified and/or renamed) I
show the head, index, worktree modes and the head and index SHAs
and the last mode and SHA fields are zero.  For unmerged entries,
I show the stage 1, 2, 3 and worktree modes and the stage 1,2,3
SHAs.  This gives us the same number of fields for parsing.  An
earlier version had 2 different line formats. Would it be better to
have a different initial character/token (like the ":" vs "::" prefix
in diff-index) ?


>> +	x_staged = d->index_status ? d->index_status : '.';
>> +	y_unstaged = d->worktree_status ? d->worktree_status : '.';
>
> I see a curious and misleading use of the word "staged" around
> here.  If these two are index-status and worktree-status (with
> stand-in letter '.' when they are not available), why not call them
> index-status and worktree-status instead?
> ...
>> +	char x_us = 'U', y_them = 'U';
>
> I really do not want to see these X_ and Y_ prefixes; they do not
> convey any meaning; if X always corresponds to ours while Y always
> corresponds to theirs, then they are even redundant.

I was trying to preserve the X and Y link back to the man-page, but
also give meaning to the fields.  I'll revisit.

>> +	memset(stages, 0, sizeof(stages));
>> +	pos = cache_name_pos(it->string, strlen(it->string));
>> +	assert(pos < 0);
>> +	pos = -pos-1;
>> +	while (pos < active_nr) {
>> +		ce = active_cache[pos++];
>> +		stage = ce_stage(ce);
>> +		if (strcmp(ce->name, it->string) || !stage)
>> +			break;
>> +		stages[stage - 1].mode = ce->ce_mode;
>> +		hashcpy(stages[stage - 1].sha1, ce->sha1);
>> +	}
>
> You did assert(pos < 0) to make sure that the path the caller told
> you is unmerged indeed is unmerged, which is a very good check.  In
> the same spirit, you would want to make sure that you got at least
> one result from the above loop, to diagnose a bug where the path did
> not even exist at all in the index.

Would that be possible for a conflict/unmerged entry?
I can add an assert for that just to be safe.

> Also, it is possible to have more than one stage#1 entries in the
> index (stage#2 can only be one; I think stage#3 can theoretically
> have more than one, but in practice, even merge-octopus does not do
> that).  The above loop gives us the "last one wins" semantics to
> make sure what you grab from the index always fit in stages[] array,
> which is not wrong per-se, but that design decision may want to be
> documented in a comment nearby for people to work on enhancing it in
> the future.

Interesting, more than 1 entry in a single stage. I hadn't considered
that.  I think I pretty much stole the essence of this loop from
elsewhere in the file, so yes I should be consistent with elsewhere
in the code. I'll update the comments.  Good catch!

Thanks for all your time on this!
Jeff

