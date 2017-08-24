Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97FA520285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbdHXTk4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:40:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53768 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752751AbdHXTkz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:40:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3618AA10C;
        Thu, 24 Aug 2017 15:40:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9kmer8qt3M3ta6OzIlzRw5XveoU=; b=fhWpg5
        opAht7CqUQ0GsjMVyLxsT319m8qEYvn8rZ6qV3Hzq4Q+bImxdmUGhOpXO8S8owWv
        8WiQ/KI8g/DGwOKF6G7Y+koMiUSzYu+ab93VL3L04CpEc7o2Z2qNDZjS+kBsBb90
        fO33umrnTDw3dfcl4njeJqc5XQySxO+bURWk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D4NnNwgCX58JvT6AvVIP9Ji9kXXyh/zL
        J9hIyhCvA5V4dHR6H23TmyekcM7ZI6uEJH8eBfm7PhSMjmwm6mQBgNpFoTPafwBk
        6F0+WgS8e43JeRdw1GBoJ1lWrWiu0pDXcBilEQsItWtDFwBo1HCZ+PQrf3YVuPbE
        yTIflrVBjBg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4841AA10B;
        Thu, 24 Aug 2017 15:40:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 304E3AA10A;
        Thu, 24 Aug 2017 15:40:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v1] convert: display progress for filtered objects that have been delayed
References: <20170820154720.32259-1-larsxschneider@gmail.com>
Date:   Thu, 24 Aug 2017 12:40:53 -0700
In-Reply-To: <20170820154720.32259-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 20 Aug 2017 17:47:20 +0200")
Message-ID: <xmqqwp5svjne.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 246DEE90-8904-11E7-A85F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> In 2841e8f ("convert: add "status=delayed" to filter process protocol",
> 2017-06-30) we taught the filter process protocol to delayed responses.
> These responses are processed after the "Checking out files" phase.
> If the processing takes noticeable time, then the user might think Git
> is stuck.
>
> Display the progress of the delayed responses to let the user know that
> Git is still processing objects. This works very well for objects that
> can be filtered quickly. If filtering of an individual object takes
> noticeable time, then the user might still think that Git is stuck.
> However, in that case the user would at least know what Git is doing.
>
> It would be technical more correct to display "Checking out files whose
> content filtering has been delayed". For brevity we only print
> "Filtering content".
>
> The finish_delayed_checkout() call was moved below the stop_progress()
> call in unpack-trees.c to ensure that the "Checking out files" progress
> is properly stopped before the "Filtering content" progress starts in
> finish_delayed_checkout().
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Suggested-by: Taylor Blau <me@ttaylorr.com>
> ---

Makes sense.  The only thing that made me wonder was if we want the
change in unpack-trees.c in this patch.  After all, the procedure to
finish up the delayed checkout _is_ a part of the work need to be
done to populate the working tree files, so stopping the progress
before feels somewhat wrong at the phylosophical level.

I think our output cannot express nested progress bars, and I think
that is the reason why this patch tweaks unpack-trees.c; so I am
fine with the end result (and that is why I said "made me wonder
was", not "makes me wonder", the latter would imply "this we might
want fix before applying", but I do not think we want to change
anything this patch does to unpack-trees.c in this case).

The delayed progress API is being simplified so I'll probably do a
bit of evil merge while merging this to 'pu'.

Thanks.

>  entry.c        | 16 +++++++++++++++-
>  unpack-trees.c |  2 +-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index 65458f07a4..1d1a09f47e 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -3,6 +3,7 @@
>  #include "dir.h"
>  #include "streaming.h"
>  #include "submodule.h"
> +#include "progress.h"
>  
>  static void create_directories(const char *path, int path_len,
>  			       const struct checkout *state)
> @@ -161,16 +162,23 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
>  int finish_delayed_checkout(struct checkout *state)
>  {
>  	int errs = 0;
> +	unsigned delayed_object_count;
> +	off_t filtered_bytes = 0;
>  	struct string_list_item *filter, *path;
> +	struct progress *progress;
>  	struct delayed_checkout *dco = state->delayed_checkout;
>  
>  	if (!state->delayed_checkout)
>  		return errs;
>  
>  	dco->state = CE_RETRY;
> +	delayed_object_count = dco->paths.nr;
> +	progress = start_progress_delay(
> +		_("Filtering content"), delayed_object_count, 50, 1);
>  	while (dco->filters.nr > 0) {
>  		for_each_string_list_item(filter, &dco->filters) {
>  			struct string_list available_paths = STRING_LIST_INIT_NODUP;
> +			display_progress(progress, delayed_object_count - dco->paths.nr);
>  
>  			if (!async_query_available_blobs(filter->string, &available_paths)) {
>  				/* Filter reported an error */
> @@ -216,11 +224,17 @@ int finish_delayed_checkout(struct checkout *state)
>  				}
>  				ce = index_file_exists(state->istate, path->string,
>  						       strlen(path->string), 0);
> -				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
> +				if (ce) {
> +					errs |= checkout_entry(ce, state, NULL);
> +					filtered_bytes += ce->ce_stat_data.sd_size;
> +					display_throughput(progress, filtered_bytes);
> +				} else
> +					errs = 1;
>  			}
>  		}
>  		string_list_remove_empty_items(&dco->filters, 0);
>  	}
> +	stop_progress(&progress);
>  	string_list_clear(&dco->filters, 0);
>  
>  	/* At this point we should not have any delayed paths anymore. */
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 862cfce661..90fb270d77 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -395,8 +395,8 @@ static int check_updates(struct unpack_trees_options *o)
>  			}
>  		}
>  	}
> -	errs |= finish_delayed_checkout(&state);
>  	stop_progress(&progress);
> +	errs |= finish_delayed_checkout(&state);
>  	if (o->update)
>  		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
>  	return errs != 0;
>
> base-commit: b3622a4ee94e4916cd05e6d96e41eeb36b941182
