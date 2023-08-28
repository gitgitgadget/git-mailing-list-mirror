Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE7EC83F11
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjH1WVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjH1WVR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:21:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A3A139
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:21:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D26C1A778F;
        Mon, 28 Aug 2023 18:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RDwbfGeMSqm1DFJCqx60M2vsWIoUJ1oAN/y1xo
        yJNJ4=; b=V7eht84itT9tNJgE91wBoT0AwWhpP2BnkjWec1k/6h47pU+KbsI+xC
        mt2fy251LjsurjJvcoCaZBEbBKUCpq2UdLX4JEMOrXAUxO0s+aSLhosFoYd4pt+Q
        yaN87o7gV1H6xH0+YqRXDBlwaBd5Xw6NU+g78DOWsLTQlRrc+MHfs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 361111A778E;
        Mon, 28 Aug 2023 18:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94D501A778D;
        Mon, 28 Aug 2023 18:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/22] sequencer: use repository parameter in
 short_commit_name()
References: <20230828214604.GA3830831@coredump.intra.peff.net>
        <20230828214629.GA3831137@coredump.intra.peff.net>
Date:   Mon, 28 Aug 2023 15:21:11 -0700
In-Reply-To: <20230828214629.GA3831137@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 28 Aug 2023 17:46:29 -0400")
Message-ID: <xmqqsf82g65k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 322CD9BE-45F1-11EE-A63F-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> -static const char *short_commit_name(struct commit *commit)
> +static const char *short_commit_name(struct repository *r, struct commit *commit)
>  {
> -	return repo_find_unique_abbrev(the_repository, &commit->object.oid,
> -				       DEFAULT_ABBREV);
> +	return repo_find_unique_abbrev(r, &commit->object.oid, DEFAULT_ABBREV);
>  }

Theoretically this is the right thing to do, and ...

>  static int get_message(struct commit *commit, struct commit_message *out)
> @@ -446,7 +445,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
>  
>  	out->message = repo_logmsg_reencode(the_repository, commit, NULL,
>  					    get_commit_output_encoding());
> -	abbrev = short_commit_name(commit);
> +	abbrev = short_commit_name(the_repository, commit);

... this is a no-op.

> @@ -2383,7 +2382,7 @@ static int do_pick_commit(struct repository *r,
>  		error(command == TODO_REVERT
>  		      ? _("could not revert %s... %s")
>  		      : _("could not apply %s... %s"),
> -		      short_commit_name(commit), msg.subject);
> +		      short_commit_name(r, commit), msg.subject);

And this is a logical consequence for a function that is told by the
caller in which repository to work in via its parameter.

> @@ -3172,7 +3171,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>  		item->offset_in_buf = todo_list->buf.len;
>  		subject_len = find_commit_subject(commit_buffer, &subject);
>  		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
> -			short_commit_name(commit), subject_len, subject);
> +			short_commit_name(opts->revs->repo, commit),
> +			subject_len, subject);
>  		repo_unuse_commit_buffer(the_repository, commit,
>  					 commit_buffer);

But how do we ascertain that opts->revs->repo is always safe to use
(iow initialized to a sensible value)?  repo_init_revisions() takes
a repository as its parameter and the first thing it does is to set
it to the revs->repo, so it is safe for any "struct rev_info" that
came from there, but REV_INFO_INIT omits initializer for the .repo
member.

The other two calls in this loop refer to the_repository so the
current code would be safe even if opts->revs->repo is set or NULL,
but that will no longer be true with the updated code.  I'd feel
safer if at the beginning of the function we create a local variable
"struct rev_info *repo" that is initialized to opts->revs->repo and
use it throughout the function instead of the_repository.


> @@ -5564,7 +5564,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  		if (!is_empty && (commit->object.flags & PATCHSAME)) {
>  			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
>  				warning(_("skipped previously applied commit %s"),
> -					short_commit_name(commit));
> +					short_commit_name(revs->repo, commit));
>  			skipped_commit = 1;
>  			continue;
>  		}

This one I am fairly certain is a safe and correct conversion; the
function would be segfaulting in its call to get_revision() if
revs->repo were set to a bogus value.

Thanks.
