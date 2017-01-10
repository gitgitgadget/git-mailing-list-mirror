Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC7E20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965852AbdAJUFl (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:05:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61761 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965503AbdAJUFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:05:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6055F5F864;
        Tue, 10 Jan 2017 15:05:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D/14RI6abwwYno9MkS5+VzZjNRA=; b=uc+6/4
        Eg/elXDjMQdmLF89/UDbjYFxj2hnj5F+1ACPcoGQz2CBCrVcKG4CS277hHZCn0mz
        mq5BV7nmCUYsDTnjwpFLDm3703sHbJbjKBY+QzKmoAgyYWB0Oqba/VoUaK9p1SDA
        4fCU0JDOobI1Ze/hPLVVosNww4AIKpri5wQlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ALSOSDgfVjQNZeSPYpCNmTdwDXPvNpL2
        prGZZ5VRQllF4x46HgaemkN9ATWcWdkJDKHVQYskI/LVZNe6DQa0CdPFpMCd4YsF
        /r7atu88rIwN3T/uA8tpJb3OD+TXsC5I5p9pYFftToX/plCwYL7cHTWbAyj6Q4O7
        22VfvS1OG00=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58F6B5F863;
        Tue, 10 Jan 2017 15:05:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA6C95F862;
        Tue, 10 Jan 2017 15:05:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, l.s.r@web.de, git@vger.kernel.org
Subject: Re: [PATCHv2 4/5] unpack-trees: factor file removal out of check_updates
References: <20170109194621.17013-1-sbeller@google.com>
        <20170109194621.17013-5-sbeller@google.com>
Date:   Tue, 10 Jan 2017 12:05:37 -0800
In-Reply-To: <20170109194621.17013-5-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Jan 2017 11:46:20 -0800")
Message-ID: <xmqqd1fusmsu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27F0F454-D770-11E6-A5ED-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This makes check_updates shorter and easier to understand.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

I agree that 3/5 made it easier to understand by ejecting a block
that is not essential to the functionality of the function out of
it, making the remainder of the fuction about "removing gone files
and then write out the modified files".  

The ejecting of the first half of these two operations, both are
what this function is about, done by this step feels backwards.  If
anything, the "only do the actual working tree manipulation when not
doing a dry-run and told to update" logic that must be in both are
spread in two helper functions after step 5/5, and with the added
boilerplate for these two helpers, the end result becomes _longer_
to understand what is really going on when check_updates() is
called.

Is the original after step 3/5 too long and hard to understand?

>  unpack-trees.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index b564024472..ac59510251 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -218,6 +218,26 @@ static void unlink_entry(const struct cache_entry *ce)
>  	schedule_dir_for_removal(ce->name, ce_namelen(ce));
>  }
>  
> +static unsigned remove_workingtree_files(struct unpack_trees_options *o,
> +					 struct progress *progress)
> +{
> +	int i;
> +	unsigned cnt = 0;
> +	struct index_state *index = &o->result;
> +
> +	for (i = 0; i < index->cache_nr; i++) {
> +		const struct cache_entry *ce = index->cache[i];
> +
> +		if (ce->ce_flags & CE_WT_REMOVE) {
> +			display_progress(progress, ++cnt);
> +			if (o->update && !o->dry_run)
> +				unlink_entry(ce);
> +		}
> +	}
> +
> +	return cnt;
> +}
> +
>  static struct progress *get_progress(struct unpack_trees_options *o)
>  {
>  	unsigned cnt = 0, total = 0;
> @@ -254,15 +274,8 @@ static int check_updates(struct unpack_trees_options *o)
>  
>  	if (o->update)
>  		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
> -	for (i = 0; i < index->cache_nr; i++) {
> -		const struct cache_entry *ce = index->cache[i];
>  
> -		if (ce->ce_flags & CE_WT_REMOVE) {
> -			display_progress(progress, ++cnt);
> -			if (o->update && !o->dry_run)
> -				unlink_entry(ce);
> -		}
> -	}
> +	cnt = remove_workingtree_files(o, progress);
>  	remove_marked_cache_entries(index);
>  	remove_scheduled_dirs();
