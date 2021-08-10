Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F45C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C48760EBD
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 22:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhHJWeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 18:34:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50707 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHJWeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 18:34:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78BB5DC237;
        Tue, 10 Aug 2021 18:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ep/uG0u6GlpVe38Pz4eIoBtPi684XTuWIdW32Z
        Ryra4=; b=hK33gwsg2wNfTGyRB++trofFmkqIPia6gANPJtIC86HVrsT2/BTSUC
        uBXes5LOp3v9p7yiVUW6NiXcJzb4Id0ot678XTRXNiSfz/Jmf0TadUcM8K9Z2Yzt
        Eur1TimlTy0cDZVwdu8LOXoKItBC/zcKb82g6g+TVrD8F6z1gNjds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EA27DC235;
        Tue, 10 Aug 2021 18:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1AAFDC234;
        Tue, 10 Aug 2021 18:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
        <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
Date:   Tue, 10 Aug 2021 15:33:53 -0700
In-Reply-To: <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 10 Aug 2021 12:20:38 -0700")
Message-ID: <xmqqwnotaq0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AF6D746-FA2B-11EB-9CA9-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +	skippedCherryPicks::
> +		Shown when linkgit:git-rebase[1] skips a commit that has already
> +		been cherry-picked onto the upstream branch.

Makes sense.

> +	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1},

No need to resend to only fix this, but I'll add SP after "1" to
match surrounding lines while queuing the patch.

> @@ -5149,8 +5150,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  		oidset_insert(&interesting, &commit->object.oid);
>  
>  		is_empty = is_original_commit_empty(commit);
> -		if (!is_empty && (commit->object.flags & PATCHSAME))
> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +					_("skipped previously applied commit %s"),
> +					short_commit_name(commit));
> +			skipped_commit = 1;
>  			continue;
> +		}
>  		if (is_empty && !keep_empty)
>  			continue;
>  
> @@ -5214,6 +5220,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  		oidcpy(&entry->entry.oid, &commit->object.oid);
>  		oidmap_put(&commit2todo, entry);
>  	}
> +	if (skipped_commit)
> +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +				  _("use --reapply-cherry-picks to include skipped commits"));

I agree with the change in this hunk that advanced users may want to
squelch this "what to do" hint.

I am not sure about the earlier hunk that reports when some commits
have actually been skipped.  When --no-reapply-cherry-picks is in
effect, the user is expecting that some commits are cherry-picks
among other (hopefully the majority of) commits, and even those
users who do not want to be taught how to use the command would want
to learn the fact that some commits were skipped (and which ones).

Using two separate advice configuration variables feel way overkill
for this.  I wonder if the previous hunk should use warning(), i.e.

> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> +			warning(_("skipped previously applied commit %s"),
> +				short_commit_name(commit));
> +			skipped_commit = 1;
>  			continue;
> +		}

possibly squelched by "git rebase --quiet".

> @@ -5369,8 +5379,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>  	while ((commit = get_revision(&revs))) {
>  		int is_empty = is_original_commit_empty(commit);
>  
> -		if (!is_empty && (commit->object.flags & PATCHSAME))
> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +					  _("skipped previously applied commit %s"),
> +					  short_commit_name(commit));
> +			skipped_commit = 1;
>  			continue;
> +		}

Likewise.  I wonder why we have two so-much-similar codepaths that
we need to touch, though.

>  		if (is_empty && !keep_empty)
>  			continue;
>  		strbuf_addf(out, "%s %s ", insn,
> @@ -5380,6 +5395,9 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>  			strbuf_addf(out, " %c empty", comment_line_char);
>  		strbuf_addch(out, '\n');
>  	}
> +	if (skipped_commit)
> +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +				  _("use --reapply-cherry-picks to include skipped commits"));
>  	return 0;
>  }
