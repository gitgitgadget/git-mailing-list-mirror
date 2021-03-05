Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA7C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB8165074
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhCETQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:16:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63625 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCETQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 14:16:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6A0412017B;
        Fri,  5 Mar 2021 14:16:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TLlr5c2KMCn38GL0xgrwLMR4N0E=; b=ecIU+B
        7l4reXYtXauad2b1oJTEBs2frENrkjbAGi/X8j3O+6Ztdd7eXpp55XtimOC4jZND
        nRXqDJ2N2rLKf7D1FRh0rVvAXXTK4VryRAv+nH5irIsPyYi7LG/NulkZZDXG5iZb
        uLjarq1gyxzpFlxLm3vzX0rtHKEUVwNuj1Lek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q4snBRUaoqG605RezVk6Igb+fw2PT29J
        Zujf6de0OAESJwHV0ZLsyxjY6a8Nk2KCFAGA1wPURYFMAauXsO1YZB3+XbBVJkRE
        UcqCxk/pyXpX1TZsNULiMq7rLhEpoVYnir6ba4LHnSsXcR+dKwBFuCaoUlpFZuAO
        Q6EpX5zHhnw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF0A0120179;
        Fri,  5 Mar 2021 14:16:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E78D1120174;
        Fri,  5 Mar 2021 14:15:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/5] builtin/repack.c: do not repack single packs with
 --geometric
References: <cover.1614957681.git.me@ttaylorr.com>
        <80bc7fa8397491d015b80a39168813d2019e262d.1614957681.git.me@ttaylorr.com>
Date:   Fri, 05 Mar 2021 11:15:58 -0800
In-Reply-To: <80bc7fa8397491d015b80a39168813d2019e262d.1614957681.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 5 Mar 2021 10:21:37 -0500")
Message-ID: <xmqqv9a59ztd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38414210-7DE7-11EB-BAF5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Loosen the guard to only stop when there aren't any packs, and let the
> rest of the code do the right thing. Add a test to ensure that this is
> the case.
>
> Noticed-by: Junio C Hamano <gitster@pobox.com>

I do not think I "noticed" anything, though.

> -	if (geometry->pack_nr <= 1) {
> +	if (!geometry->pack_nr) {
>  		geometry->split = geometry->pack_nr;
>  		return;
>  	}

When pack_nr is 0, split is set to 0.  Otherwise we compute the
split the usual way in the new code.  Let's see the post-context of
the above code and figure out what happens when pack_nr is 1.

	split = geometry->pack_nr - 1;

split set to 0 here.

	/*
	 * First, count the number of packs (in descending order of size) which
	 * already form a geometric progression.
	 */
	for (i = geometry->pack_nr - 1; i > 0; i--) {

Iterate from i = 0 while i is positive, which means this entire loop
is skipped.

		struct packed_git *ours = geometry->pack[i];
		struct packed_git *prev = geometry->pack[i - 1];
		if (geometry_pack_weight(ours) >= factor * geometry_pack_weight(prev))
			split--;
		else
			break;
	}

	if (split) {
		/*
		 * Move the split one to the right, since the top element in the
		 * last-compared pair can't be in the progression. Only do this
		 * when we split in the middle of the array (otherwise if we got
		 * to the end, then the split is in the right place).
		 */
		split++;
	}

And split is still 0.


	/*
	 * Then, anything to the left of 'split' must be in a new pack. But,
	 * creating that new pack may cause packs in the heavy half to no longer
	 * form a geometric progression.
	 *
	 * Compute an expected size of the new pack, and then determine how many
	 * packs in the heavy half need to be joined into it (if any) to restore
	 * the geometric progression.
	 */
	for (i = 0; i < split; i++)
		total_size += geometry_pack_weight(geometry->pack[i]);

The loop is skipped, as split is 0.

	for (i = split; i < geometry->pack_nr; i++) {

Iterate from i = 0 and for just once.

		struct packed_git *ours = geometry->pack[i];
		if (geometry_pack_weight(ours) < factor * total_size) {

But total_size is 0 so split is not incremented.

			split++;
			total_size += geometry_pack_weight(ours);
		} else
			break;
	}

	geometry->split = split;

Hence we assign 0 to .split member.

I however wonder if it expresses the intent more clearly if you did
this upfront, instead of forcing the readers to go through the code.

	if (geometry->pack_nr <= 1) {
-		geometry->split = geometry->pack_nr;
+		geometry->split = 0;
 		return;
 	}

That is, "when there is no existing packs, or just one pack, we
split at 0"

The code that gets affected by the setting of "split" is this piece
in the caller, cmd_repack():

	if (geometry) {
		FILE *in = xfdopen(cmd.in, "w");
		for (i = 0; i < geometry->split; i++)
			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
		for (i = geometry->split; i < geometry->pack_nr; i++)
			fprintf(in, "^%s\n", pack_basename(geometry->pack[i]));
		fclose(in);
	}

When split == 0, we end up feeding no positive packs and all
negative packs, which results in nothing to pack.  I wonder if we
can optimize out the spawning of the pack-object process, but that
is probalby optimizing for a wrong case.

> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 96917fc163..4a1952a054 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -20,6 +20,21 @@ test_expect_success '--geometric with no packs' '
>  	)
>  '
>  
> +test_expect_success '--geometric with one pack' '
> +	git init geometric &&
> +	test_when_finished "rm -fr geometric" &&
> +	(
> +		cd geometric &&
> +
> +		test_commit "base" &&
> +		git repack -d &&
> +
> +		git repack --geometric 2 >out &&
> +
> +		test_i18ngrep "Nothing new to pack" out
> +	)
> +'
> +
>  test_expect_success '--geometric with an intact progression' '
>  	git init geometric &&
>  	test_when_finished "rm -fr geometric" &&
