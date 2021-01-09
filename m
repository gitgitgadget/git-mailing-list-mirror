Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F4C433E6
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 00:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCBF23AA7
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 00:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbhAIAGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 19:06:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54103 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbhAIAGl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 19:06:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C1C710CF60;
        Fri,  8 Jan 2021 19:05:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iVe4eP9yHrIiR3UIkJ1lvN1EPgw=; b=FC2wSq
        huJLayWmXi1LMh8wtbx/uOjl2/mfXeGb2xuhsgjI95I154LcP8fxgRaeI9dxmsZh
        9ki2cdXo0lff04snP6CuzLDd8LariJZEAYpb5WHRRx33ip7SH6CMkFdOiT26o1kX
        7p9pA+c9cCk3hX96Rh5bo4p30Vb6xAzrkME0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mCfJCBdX29fHDetl23ZbycSYXmLlHndw
        6Eu93BcXuvVNKHpxcRzDvY9VP+q9hX0090q4sHqN/yc1untMMDvgDo4P+Cl+JCwL
        UijOw1yLdWzzUZiqxjfkqxF81iAxRkR8GYcBP7DfmGUEbJ/K5VfHVBhdSePQxdrV
        sP8z4B465e0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65E3710CF5E;
        Fri,  8 Jan 2021 19:05:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0F6210CF5D;
        Fri,  8 Jan 2021 19:05:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 4/4] fetch: implement support for atomic reference
 updates
References: <cover.1610027375.git.ps@pks.im> <cover.1610107599.git.ps@pks.im>
        <53705281b60285837905137f45fc8607012d2f19.1610107599.git.ps@pks.im>
Date:   Fri, 08 Jan 2021 16:05:53 -0800
In-Reply-To: <53705281b60285837905137f45fc8607012d2f19.1610107599.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 8 Jan 2021 13:11:28 +0100")
Message-ID: <xmqq7dongeji.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 713751F4-520E-11EB-AC45-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +	/*
> +	 * When using an atomic fetch, we do not want to update FETCH_HEAD if
> +	 * any of the reference updates fails. We thus have to write all
> +	 * updates to a buffer first and only commit it as soon as all
> +	 * references have been successfully updated.
> +	 */
> +	if (atomic_fetch) {
> +		strbuf_addf(&fetch_head->buf, "%s\t%s\t%s",
> +			    old_oid, merge_status_marker, note);
> +		strbuf_add(&fetch_head->buf, url, url_len);
> +		strbuf_addch(&fetch_head->buf, '\n');
> +	} else {
> +		fprintf(fetch_head->fp, "%s\t%s\t%s",
> +			old_oid, merge_status_marker, note);
> +		for (i = 0; i < url_len; ++i)
> +			if ('\n' == url[i])
> +				fputs("\\n", fetch_head->fp);
> +			else
> +				fputc(url[i], fetch_head->fp);
> +		fputc('\n', fetch_head->fp);
> +	}

I do not want to see it done like this; formating what ought to come
out identical with two separate mechanisms will lead to bugs under
the road.

Also what is the deal about "\n" vs "\\n"?  Do we already have
behaviour differences between two codepaths from the get-go?

It would be much more preferrable to see this series go like so:

    [1/4] create append_fetch_head() that writes out to
          fetch_head->fp

    [1.5/4] convert append_fetch_head() to ALWAYS accumulate in
            fetch_head->buf, and ALWAYS flushes what is accumulated
            at the end.

After these two patches are applied, there shouldn't be any
behaviour change or change in the format in generated FETCH_HEAD.

    [2/4] and [3/4] stay the same

    [4/4] this step does not touch append_fetch_head() at all.  It
    just changes the way how fetch_head->buf is flushed at the end
    (namely, under atomic mode and after seeing any failure, the
    accumulated output gets discarded without being written).

I also thought briefly about an alternative approach to rewind and
truncate the output to its original length upon seeing a failure
under the atomic mode, but rejected it because the code gets hairy.
I think "accumulate until we know we want to actually write them out"
is a good approach to this issue.

Thanks.
