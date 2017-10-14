Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02A320437
	for <e@80x24.org>; Sat, 14 Oct 2017 02:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbdJNCne (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 22:43:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54702 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751572AbdJNCnd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 22:43:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C703998E0;
        Fri, 13 Oct 2017 22:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FYVaQDiMiEGBMHF99gM0oB6BXsQ=; b=lmydYV
        d1bT7E/N2zSfn+bhZcVp4g8cyH1DCww772AN6SJeL3E277frM/nGAsLqPEkUhixm
        DVv0xTT73CLhMhld87juwSV7Fidr8gu9EfftCm4+c62FSyo2XCZsV2iWe44fHXE8
        Or61t/ED9oQ6H2K5h9T3J519wRv194FGEI/Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GS6XSqpSSP9N3z/a4NJdr2h4ATvyrrQl
        O4PRmZxqzXdOtI3dK5EmunKlHkVSwiWIRijOBlzWqUExscpolZ0azWG/0zhFft5g
        VD8QMhl6hgcps9C+kT2wFpxYZyc581V/vrrVWYIxEPw0tVXxB1ILB/vRfMMLCNU/
        I/dMgAKYk8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22BE1998DE;
        Fri, 13 Oct 2017 22:43:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69DE2998DD;
        Fri, 13 Oct 2017 22:43:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Constantine <hi-angel@yandex.ru>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
Subject: Re: [PATCH] revision: quit pruning diff more quickly when possible
References: <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
        <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
        <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
        <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
        <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
        <20171013135636.o2vhktt7aqx6luuy@sigill.intra.peff.net>
        <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
        <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
        <42cbcb4f-7f9d-df69-f55e-0ba42b931957@gmail.com>
        <20171013142646.evapso5uxzvh2r2p@sigill.intra.peff.net>
        <20171013152745.cgqt3qgvcngyr5ew@sigill.intra.peff.net>
Date:   Sat, 14 Oct 2017 11:43:30 +0900
In-Reply-To: <20171013152745.cgqt3qgvcngyr5ew@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 13 Oct 2017 11:27:45 -0400")
Message-ID: <xmqqy3oetpnx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 773648FA-B089-11E7-8658-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here it is cleaned up and with a commit message. There's another case
> that can be optimized, too: --remove-empty with an all-deletions commit.
> That's probably even more obscure and pathological, but it was easy to
> cover in the same breath.

This one looks good.  It appears that again you guys had all the fun
while I was offline ;-).  And I am happy to see that we didn't veer
in the direction to optimize for a wrong case by keeping track of
what trees we already saw and things like that, of course.

Thanks.

> Subject: revision: quit pruning diff more quickly when possible
>
> When the revision traversal machinery is given a pathspec,
> we must compute the parent-diff for each commit to determine
> which ones are TREESAME. We set the QUICK diff flag to avoid
> looking at more entries than we need; we really just care
> whether there are any changes at all.
>
> But there is one case where we want to know a bit more: if
> --remove-empty is set, we care about finding cases where the
> change consists only of added entries (in which case we may
> prune the parent in try_to_simplify_commit()). To cover that
> case, our file_add_remove() callback does not quit the diff
> upon seeing an added entry; it keeps looking for other types
> of entries.
>
> But this means when --remove-empty is not set (and it is not
> by default), we compute more of the diff than is necessary.
> You can see this in a pathological case where a commit adds
> a very large number of entries, and we limit based on a
> broad pathspec. E.g.:
>
>   perl -e '
>     chomp(my $blob = `git hash-object -w --stdin </dev/null`);
>     for my $a (1..1000) {
>       for my $b (1..1000) {
>         print "100644 $blob\t$a/$b\n";
>       }
>     }
>   ' | git update-index --index-info
>   git commit -qm add
>
>   git rev-list HEAD -- .
>
> This case takes about 100ms now, but after this patch only
> needs 6ms. That's not a huge improvement, but it's easy to
> get and it protects us against even more pathological cases
> (e.g., going from 1 million to 10 million files would take
> ten times as long with the current code, but not increase at
> all after this patch).
>
> This is reported to minorly speed-up pathspec limiting in
> real world repositories (like the 100-million-file Windows
> repository), but probably won't make a noticeable difference
> outside of pathological setups.
>
> This patch actually covers the case without --remove-empty,
> and the case where we see only deletions. See the in-code
> comment for details.
>
> Note that we have to add a new member to the diff_options
> struct so that our callback can see the value of
> revs->remove_empty_trees. This callback parameter could be
> passed to the "add_remove" and "change" callbacks, but
> there's not much point. They already receive the
> diff_options struct, and doing it this way avoids having to
> update the function signature of the other callbacks
> (arguably the format_callback and output_prefix functions
> could benefit from the same simplification).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diff.h     |  1 +
>  revision.c | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/diff.h b/diff.h
> index 7dcfcfbef7..4a34d256f1 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -180,6 +180,7 @@ struct diff_options {
>  	pathchange_fn_t pathchange;
>  	change_fn_t change;
>  	add_remove_fn_t add_remove;
> +	void *change_fn_data;
>  	diff_format_fn_t format_callback;
>  	void *format_callback_data;
>  	diff_prefix_fn_t output_prefix;
> diff --git a/revision.c b/revision.c
> index 8fd222f3bf..a3f245e2cc 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -399,8 +399,16 @@ static struct commit *one_relevant_parent(const struct rev_info *revs,
>   * if the whole diff is removal of old data, and otherwise
>   * REV_TREE_DIFFERENT (of course if the trees are the same we
>   * want REV_TREE_SAME).
> - * That means that once we get to REV_TREE_DIFFERENT, we do not
> - * have to look any further.
> + *
> + * The only time we care about the distinction is when
> + * remove_empty_trees is in effect, in which case we care only about
> + * whether the whole change is REV_TREE_NEW, or if there's another type
> + * of change. Which means we can stop the diff early in either of these
> + * cases:
> + *
> + *   1. We're not using remove_empty_trees at all.
> + *
> + *   2. We saw anything except REV_TREE_NEW.
>   */
>  static int tree_difference = REV_TREE_SAME;
>  
> @@ -411,9 +419,10 @@ static void file_add_remove(struct diff_options *options,
>  		    const char *fullpath, unsigned dirty_submodule)
>  {
>  	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
> +	struct rev_info *revs = options->change_fn_data;
>  
>  	tree_difference |= diff;
> -	if (tree_difference == REV_TREE_DIFFERENT)
> +	if (!revs->remove_empty_trees || tree_difference != REV_TREE_NEW)
>  		DIFF_OPT_SET(options, HAS_CHANGES);
>  }
>  
> @@ -1351,6 +1360,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
>  	DIFF_OPT_SET(&revs->pruning, QUICK);
>  	revs->pruning.add_remove = file_add_remove;
>  	revs->pruning.change = file_change;
> +	revs->pruning.change_fn_data = revs;
>  	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
>  	revs->dense = 1;
>  	revs->prefix = prefix;
