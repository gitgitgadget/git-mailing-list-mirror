Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A479B1F4DD
	for <e@80x24.org>; Sat, 26 Aug 2017 16:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdHZQiw (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 12:38:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59773 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751061AbdHZQiv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 12:38:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FBCE90D88;
        Sat, 26 Aug 2017 12:38:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gSGhIBMa1EFVnza09pI8NjQSSxM=; b=Y4Hvb7
        COTwu77Ayq7MEoKwBdSRs2519Ms5ge/LvIQLSj/GNoSQLvCmoWvMbQOaYEA4lA1z
        bn9pqKsozh5kz+xuP2SYhwD4TQpL8yqROO8lDMBfchY+x3qKxgh+TKcHX3xuwgOu
        2xNF1YVJLYlkfIgN/ie2SjyG7xA8R5wGsM+lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S5TGgfuMpcuBqocliwkjrFjhyWZsUcKr
        MTJBX2eRnYcBx+MUTWM0/7YJGRk7b/Qxj9jVcRDKL5iHCIe2S6pQ29I8zYHfgyPH
        r0gHKS+wyRn5/cyR3mp0mnRreqI6qypDfay6hKWqPLUF6KWkg7H4Z2GzgyqdfgvU
        q75x0vn8TKI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2784090D87;
        Sat, 26 Aug 2017 12:38:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8021390D86;
        Sat, 26 Aug 2017 12:38:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 02/12] load_subtree(): remove unnecessary conditional
References: <cover.1503734566.git.mhagger@alum.mit.edu>
        <c21bedbee9487792f4a336a417aa9874578aaac2.1503734566.git.mhagger@alum.mit.edu>
Date:   Sat, 26 Aug 2017 09:38:49 -0700
In-Reply-To: <c21bedbee9487792f4a336a417aa9874578aaac2.1503734566.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Sat, 26 Aug 2017 10:28:02 +0200")
Message-ID: <xmqqh8wuqo6e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A3D2C82-8A7D-11E7-A660-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> At this point in the code, len is *always* <= 20.

This is the kind of log message that makes me unconfortable, as it
lacks "because", and the readers would need to find out themselves
by following the same codepath the patch author already followed.

There is an assert earlier before the control gets in this loop

	prefix_len = subtree->key_oid.hash[KEY_INDEX];
	assert(prefix_len * 2 >= n);
	memcpy(object_oid.hash, subtree->key_oid.hash, prefix_len);

that tries to ensure there is sufficient number of prefix defined in
that key, and the codeflow may ensure that prefix_len is both an
even number and shorter than 20 (the correctness of the code depends
on these, it seems, and if for some reason prefix_len is much
larger, calls to get_oid_hex_segment() will overflow the oid.hash[]
array without checking).  I'd at least feel safer to have an assert
next to the existing one that catches a bug to throw a randomly
large value into subtree->key_oid.hash[KEY_INDEX].  Then we can
safely say "at this point in the code, len is always <= 20", as that
assert will makes it obvious without looking at anything other than
this code and get_oid_hex_segment() implementaiton (combined with
the fact that this function is the only one that coerces len and
puts it into ->key_oid.hash[KEY_INDEX], but that is a weak assurance
as we cannot tell where "subtree" came from---it may have full
20-byte oid in its key_oid field---without following the callchain a
lot more widely).

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  notes.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/notes.c b/notes.c
> index 00630a9396..f7ce64ff48 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -446,25 +446,24 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
>  		 * If object SHA1 is incomplete (len < 20), and current
>  		 * component consists of 2 hex chars, assume note subtree
>  		 */
> -		if (len <= GIT_SHA1_RAWSZ) {
> -			type = PTR_TYPE_NOTE;
> -			l = (struct leaf_node *)
> -				xcalloc(1, sizeof(struct leaf_node));
> -			oidcpy(&l->key_oid, &object_oid);
> -			oidcpy(&l->val_oid, entry.oid);
> -			if (len < GIT_SHA1_RAWSZ) {
> -				if (!S_ISDIR(entry.mode) || path_len != 2)
> -					goto handle_non_note; /* not subtree */
> -				l->key_oid.hash[KEY_INDEX] = (unsigned char) len;
> -				type = PTR_TYPE_SUBTREE;
> -			}
> -			if (note_tree_insert(t, node, n, l, type,
> -					     combine_notes_concatenate))
> -				die("Failed to load %s %s into notes tree "
> -				    "from %s",
> -				    type == PTR_TYPE_NOTE ? "note" : "subtree",
> -				    oid_to_hex(&l->key_oid), t->ref);
> +		type = PTR_TYPE_NOTE;
> +		l = (struct leaf_node *)
> +			xcalloc(1, sizeof(struct leaf_node));
> +		oidcpy(&l->key_oid, &object_oid);
> +		oidcpy(&l->val_oid, entry.oid);
> +		if (len < GIT_SHA1_RAWSZ) {
> +			if (!S_ISDIR(entry.mode) || path_len != 2)
> +				goto handle_non_note; /* not subtree */
> +			l->key_oid.hash[KEY_INDEX] = (unsigned char) len;
> +			type = PTR_TYPE_SUBTREE;
>  		}
> +		if (note_tree_insert(t, node, n, l, type,
> +				     combine_notes_concatenate))
> +			die("Failed to load %s %s into notes tree "
> +			    "from %s",
> +			    type == PTR_TYPE_NOTE ? "note" : "subtree",
> +			    oid_to_hex(&l->key_oid), t->ref);
> +
>  		continue;
>  
>  handle_non_note:
