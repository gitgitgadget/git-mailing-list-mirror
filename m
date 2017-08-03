Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC831F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdHCUhV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:37:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62648 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751656AbdHCUhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:37:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8BC0A7ABB;
        Thu,  3 Aug 2017 16:37:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sWJmxiqt70g2BzNjkfMYKSWbNwA=; b=UisdXk
        lYTvCaqoLsCDhCZ/cjVQI03dWniGJdRUHh+LqUPZgScI05/DYJgY1pEBayg5mQNa
        +cqvNMjK9iQg5Ygwsxi6z/vitWd1FJV6/zu2NwYJqjYjUMKBeZHaDaQkRKHk0Rez
        n6BKfs7YuRFtiCtf5FFpgJGGeix3aULYwPEbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vSE8YIdoDeR95klabZzyC1kvYPiYlzFK
        y88lLqXbZB97Lhjfi2a/YWYO3kFeC/rVUoE+crKYyvPWq+REaWYuLhnJVtoTJzz/
        cClxMqdNEdfxb/8uFbW8XtPM3qEzeptQj393lpC18CgVx6wOXYFijWLkZSt7pq3o
        3OM0sv/CyJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1818A7ABA;
        Thu,  3 Aug 2017 16:37:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21729A7AB9;
        Thu,  3 Aug 2017 16:37:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de
Subject: Re: [PATCH v2 08/15] unpack-trees: don't respect submodule.update
References: <20170725213928.125998-1-bmwill@google.com>
        <20170803182000.179328-1-bmwill@google.com>
        <20170803182000.179328-9-bmwill@google.com>
Date:   Thu, 03 Aug 2017 13:37:10 -0700
In-Reply-To: <20170803182000.179328-9-bmwill@google.com> (Brandon Williams's
        message of "Thu, 3 Aug 2017 11:19:53 -0700")
Message-ID: <xmqqpoccwfpl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8733E7CA-788B-11E7-9D23-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> The 'submodule.update' config was historically used and respected by the
> 'submodule update' command because update handled a variety of different
> ways it updated a submodule.  As we begin teaching other commands about
> submodules it makes more sense for the different settings of
> 'submodule.update' to be handled by the individual commands themselves
> (checkout, rebase, merge, etc) so it shouldn't be respected by the
> native checkout command.

Soooo... what's the externally observable effect of this change?  Is
it something that can be illustrated in a set of new tests?

IOW does this commit by itself want to change the behaviour of
"submodule update" and existing (indirect) users of unpack-trees?
Or does it want to keep the documented behaviour of "submodule
update" while correcting unintended triggering in other (indirect)
users of unpack-trees of the same machinery that is being removed in
this patch?

> -	switch (sub->update_strategy.type) {
> -	case SM_UPDATE_UNSPECIFIED:
> -	case SM_UPDATE_CHECKOUT:
> -		if (submodule_move_head(ce->name, old_id, new_id, flags))
> -			return o->gently ? -1 :
> -				add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
> -		return 0;
> -	case SM_UPDATE_NONE:
> -		return 0;
> -	case SM_UPDATE_REBASE:
> -	case SM_UPDATE_MERGE:
> -	case SM_UPDATE_COMMAND:
> -	default:
> -		warning(_("submodule update strategy not supported for submodule '%s'"), ce->name);
> -		return -1;
> -	}
> +	if (submodule_move_head(ce->name, old_id, new_id, flags))
> +		return o->gently ? -1 :
> +				   add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
> +	return 0;

With this update, we always behave as if update_strategy.type were
either left unspecified or explicitly set to checkout.  Other arms
in this switch (and the other switch too), especially "none", were
not expecting a call to submodule_move_head() to be made, but now
the call is unconditional.



>  }
>  
>  static void reload_gitmodules_file(struct index_state *index,
> @@ -293,7 +282,6 @@ static void reload_gitmodules_file(struct index_state *index,
>  				submodule_free();
>  				checkout_entry(ce, state, NULL);
>  				gitmodules_config();
> -				git_config(submodule_config, NULL);
>  			} else
>  				break;
>  		}
> @@ -308,19 +296,9 @@ static void unlink_entry(const struct cache_entry *ce)
>  {
>  	const struct submodule *sub = submodule_from_ce(ce);
>  	if (sub) {
> -		switch (sub->update_strategy.type) {
> -		case SM_UPDATE_UNSPECIFIED:
> -		case SM_UPDATE_CHECKOUT:
> -		case SM_UPDATE_REBASE:
> -		case SM_UPDATE_MERGE:
> -			/* state.force is set at the caller. */
> -			submodule_move_head(ce->name, "HEAD", NULL,
> -					    SUBMODULE_MOVE_HEAD_FORCE);
> -			break;
> -		case SM_UPDATE_NONE:
> -		case SM_UPDATE_COMMAND:
> -			return; /* Do not touch the submodule. */
> -		}
> +		/* state.force is set at the caller. */
> +		submodule_move_head(ce->name, "HEAD", NULL,
> +				    SUBMODULE_MOVE_HEAD_FORCE);
>  	}
>  	if (!check_leading_path(ce->name, ce_namelen(ce)))
>  		return;
