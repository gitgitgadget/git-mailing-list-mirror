Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D2DC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 21:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347701AbiFOVpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiFOVpE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 17:45:04 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FFB33883
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 14:45:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7400E12607C;
        Wed, 15 Jun 2022 17:45:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9KJDyWKXp0nq81wIJA79ZaCFcktcNoFSAZ9wC8
        0X/fI=; b=EtL3a1ufXVjTSsK2DOTX5F2LM9hG3qp7/IkW1x/6C6KKIZ/kH9jJ/E
        iehgBaSSRYVOOsXeXPP6ATaCPmjjVn2rrrWTkIPZBZYLV7OwOCWkCf/YicB1h4dQ
        cZs4d41dHkhc6Itba493WBYJfxxaMZUk0GGEP1dWOFCijn2Ws7dqc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E99512607A;
        Wed, 15 Jun 2022 17:45:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15EC0126079;
        Wed, 15 Jun 2022 17:45:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
References: <20220614003251.16765-1-jacob.e.keller@intel.com>
Date:   Wed, 15 Jun 2022 14:44:59 -0700
In-Reply-To: <20220614003251.16765-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Mon, 13 Jun 2022 17:32:51 -0700")
Message-ID: <xmqqzgidy52c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67E84D10-ECF4-11EC-9626-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Fix this by checking negative refspecs inside of get_ref_states. For
> each ref which matches a negative refspec, copy it into a "skipped" list
> and remove it from the fetch map. This allows us to show the following
> output instead:
>
>   * remote jdk19
>     Fetch URL: git@github.com:openjdk/jdk19.git
>     Push  URL: git@github.com:openjdk/jdk19.git
>     HEAD branch: master
>     Remote branches:
>       master tracked
>       pr/1   skipped
>       pr/2   skipped
>       pr/3   skipped
>     Local ref configured for 'git push':
>       master pushes to master (fast-forwardable)
>
> By showing the refs as skipped, it helps clarify that these references
> won't actually be fetched. Alternatively, we could simply remove them
> entirely.

Very sensible.

> @@ -367,6 +368,24 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
>  			die(_("Could not get fetch map for refspec %s"),
>  				states->remote->fetch.raw[i]);
>  
> +	/* handle negative refspecs first */
> +	for (tail = &fetch_map; *tail; ) {
> +		ref = *tail;
> +
> +		if (omit_name_by_refspec(ref->name, &states->remote->fetch)) {
> +			string_list_append(&states->skipped, abbrev_branch(ref->name));
> +
> +			/* Matched a negative refspec, so remove this ref from
> +			 * consideration for being a new or tracked ref.
> +			 */
> +			*tail = ref->next;
> +			free(ref->peer_ref);
> +			free(ref);
> +		} else {
> +			tail = &ref->next;
> +		}
> +	}


This is somewhat curious.  Do we really need to destroy the
fetch_map like the above?  I know by removing skipped items from the
list, the existing loop (below) can stop having to worry about them,
but the caller of get_ref_states() may later want to iterate over
the full fetch_map for other reasons (even if the current one does
not, a future version of the caller may have a reason to do so that
we do not know right now yet).

> +
>  	for (ref = fetch_map; ref; ref = ref->next) {
>  		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
>  			string_list_append(&states->new_refs, abbrev_branch(ref->name));

IOW, is adding a new condition to this existing loop insufficient?

	for (ref = fetch_map; ref; ref = ref->next) {
-		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
+		if (omit_name_by_refspec(ref->name, &states->remote->fetch))
+			string_list_append(&states->skipped, abbrev_branch(ref->name));
+		else if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
			string_list_append(&states->new_refs, abbrev_branch(ref->name));
		else
			string_list_append(&states->tracked, abbrev_branch(ref->name));
	}


Thanks.
