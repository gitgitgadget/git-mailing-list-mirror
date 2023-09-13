Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B5EE3F3F
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 00:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbjIMAWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 20:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMAWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 20:22:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211B18D
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 17:22:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 886911B6B5A;
        Tue, 12 Sep 2023 20:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=o6s63RkSyh4iropNCyj1lMKGYtMHqUR+oX5RSE
        Gn3fM=; b=fiE7y9lE9RO80pF4pmEGmC9HOKkBRu4gz1+iy29Gp+EmQ2ymZMktpB
        ybqxEdp5BahN2EvsDE4pQMOD+lfDjORQMjnoA74fspA7LzlpLOPL7w6dNF5Y9MAn
        jr3m4gRaVcH1ULVlMVc2qjNt5uH12l2Gny5CqTy7gDUcr2wqs/ySI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F68E1B6B59;
        Tue, 12 Sep 2023 20:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E37341B6B58;
        Tue, 12 Sep 2023 20:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff-merges: improve --diff-merges documentation
In-Reply-To: <87ttrzhmfu.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        12 Sep 2023 10:37:09 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-2-sorganov@gmail.com>
        <xmqqfs3ktnvo.fsf@gitster.g> <87ttrzhmfu.fsf@osv.gnss.ru>
Date:   Tue, 12 Sep 2023 17:22:45 -0700
Message-ID: <xmqqcyymly5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA1FB7F8-51CB-11EE-8756-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> It is more like that `-p` does not imply `-m` (which used to mean
>> "consider showing the comparison between parent(s) and the child,
>> even for merge commits"), even though newer options like `-c`,
>> `--cc` and others do imply `-m` (simply because they do not make
>> much sense if they are not allowed to work on merges) that may make
>> new people confused.
>
> No, neither --cc nor -c imply -m.

I was only trying to help you polish the text you added to explain
what you called the "legacy feature" to reflect the reason behind
that legacy.  As you obviously were not there back then when I made
"--cc" imply "-m" while keeping "-p" not to imply "-m".

Our "git log [--diff-output-options]" logic was (and still is) not
to show the comparison between parents and the child by default for
merge commits even with -p/--raw/--stat (these were what existed and
were common back then) and "git log --raw/--stat/-p" showed the
raw/diffstat/patch after the log message for one-parent commits but
only the log message for merges.

The reason behind that design choice is that Linus (and I and
others) did not find that the patches for merges are as useful as
patches for regular commits.  We made "git log -p" to omit
patches for merges that tend to become large.

	Side note: the first-parent patch is sort of readable, but
	if you are not doing the "--first-parent" traversal (which
	is a much later invention, so it wasn't even an option), you
	are showing individual commits and their patches while
	traversing the side branch, then the first-parent patch of a
	merge amounts to the squash of individual changes on the
	side branch that got merged.  It was deemed redundant
	presentation that is just wasteful and harder to grok than
	reading individual commits.  Worse, the patch against second
	and later parent(s) have no real value (it shows how behind
	the fork point of the side branch was relative to the tip of
	the trunk, which is rarely useful).

But we also wanted to have a mode of "git log -p" that spews
everything to the output that could be used to reconstruct the
history, hence we added "-m" to tell "git log":

	By default, you are designed not to show comparison between
	parents and the child for merge commit.  But when "-m" is
	given, do show the comparison for merge commit in the format
	that other options given to you, like --raw, --patch,
	specifies.

We however didn't have a good idea how to represent such a
comparison between parents and the child, so we chose the most
redundant, verbose, and obvious, which is N pairwise patches with
each of N parents to the child (for a N-parent patch).

Later "--cc" and "-c" came as an alternative way to represent
comparison between parents and the child.

Given that I, together with Linus, invented "--cc" and "-c", taking
inspiration from how Paul Mackerras showed a merge in his 'gitk'
tool, and made the design decision not to require "-m" to get the
output in the format they specify when the "git log" traversal shows
merge commits, I do not know what to say when you repeat that "--cc"
does not imply "-m".  It simply is not true.

I think this is the second time you claimed the above after I
explained the same to you, if I am not mistaken.  If you do not want
to be corrected, that is fine, and I'll stop wasting my time trying
to correct you.

But I still have to make sure that you (or anybody else) do not
spread misinformation to other users by writing incorrect statements
in documentation patches.

