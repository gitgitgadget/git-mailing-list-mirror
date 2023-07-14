Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF676EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 16:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjGNQ3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNQ3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 12:29:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488C2722
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 09:29:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0A9B19A17D;
        Fri, 14 Jul 2023 12:29:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5ZuuSrPSVsb4mNjeayovpkLiKeq6wfGtecTxlL
        rn3Wg=; b=K7W3vz65zL4b+3gQuU67DEAm4z3rHGljKSnVqTo1easxvjPGRdMAdl
        EuJhHLuoJ8e6IYjHhn7X+LaPuQ1OHa96lxqeK4LefMN+fzeHM5kqxbS47enI3sgh
        D/xdlKfV6BzTOl3TNmCdexvkrxyEjHaVwrmM9h5shlwJ2PKVUAqu8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D964D19A17C;
        Fri, 14 Jul 2023 12:29:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C16419A17B;
        Fri, 14 Jul 2023 12:29:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/20] packfile.c: prevent overflow in `load_idx()`
References: <cover.1689205042.git.me@ttaylorr.com>
        <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
        <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
        <ZLAJNbIBFUPHYhlt@nand.local> <ZLCc3mRbdXPllpAp@nand.local>
Date:   Fri, 14 Jul 2023 09:29:42 -0700
In-Reply-To: <ZLCc3mRbdXPllpAp@nand.local> (Taylor Blau's message of "Thu, 13
        Jul 2023 20:54:54 -0400")
Message-ID: <xmqqfs5qqww9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A361C4C0-2263-11EE-8899-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jul 13, 2023 at 10:24:53AM -0400, Taylor Blau wrote:
>> On Thu, Jul 13, 2023 at 09:21:55AM +0100, Phillip Wood wrote:
>> > p->crc_offset is a uint32_t so we're still prone to truncation here unless
>> > we change the crc_offset member of struct packed_git to be a size_t. I
>> > haven't checked if the other users of crc_offset would need adjusting if we
>> > change its type.
>>
>> Thanks for spotting. Luckily, this should be a straightforward change:
>
> Here's a replacement patch which changes the type of `crc_offset`. If
> there end up being other review comments, I'll fold this into the next
> round.

The code change to use st_add() and st_mult() is the same as before,
and the type of .crc_offset member changes, both of which is not
unexpected.

In the meantime I will replace the copy of [2/20] I have with this
one.

Thanks, both.

> --- 8< ---
> Subject: [PATCH] packfile.c: prevent overflow in `load_idx()`
>
> Prevent an overflow when locating a pack's CRC offset when the number
> of packed items is greater than 2^32-1/hashsz by guarding the
> computation with an `st_mult()`.
>
> Note that to avoid truncating the result, the `crc_offset` member must
> itself become a `size_t`. The only usage of this variable (besides the
> assignment in `load_idx()`) is in `read_v2_anomalous_offsets()` in the
> index-pack code. There we use the `crc_offset` as a pointer offset, so
> we are already equipped to handle the type change.
>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  object-store-ll.h | 2 +-
>  packfile.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/object-store-ll.h b/object-store-ll.h
> index e8f22cdb1b..26a3895c82 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -106,7 +106,7 @@ struct packed_git {
>  	const void *index_data;
>  	size_t index_size;
>  	uint32_t num_objects;
> -	uint32_t crc_offset;
> +	size_t crc_offset;
>  	struct oidset bad_objects;
>  	int index_version;
>  	time_t mtime;
> diff --git a/packfile.c b/packfile.c
> index 89220f0e03..70acf1694b 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -186,7 +186,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
>  		     */
>  		    (sizeof(off_t) <= 4))
>  			return error("pack too large for current definition of off_t in %s", path);
> -		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
> +		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
>  	}
>
>  	p->index_version = version;
> --
> 2.41.0.329.g0a1adfae833
> --- >8 ---
>
> Thanks,
> Taylor
