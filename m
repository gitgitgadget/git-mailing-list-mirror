Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D32E1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755599AbdC1TEW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:04:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65044 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755510AbdC1TEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:04:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8F6077175;
        Tue, 28 Mar 2017 15:03:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wp/lHbkRPWR/23DpY0575QTuxUo=; b=Y+wmEp
        1pyufkENrji9ztCVAcBgOri4z2WdzMH7rO4Eys4/MFxUChN56evvY7/qEHaP9+ru
        E9273OvdBzglU60Tg3GjjbB/V6wMTE01UXh0s7GcQCVIK56VuiX1l83d1S5v+eX+
        w70InILIrBG8oZVuxPaQ1ZJ+DSNBrKerg9RO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lI+gJRxe7XJLg+8MbDVccJhyxmQx5Flt
        xCokKOdj7G7DK77ycuQyatHzqkRp7enGbRmPND1BL0h5EqPSGZN40U63jW4gepwq
        QFq0PJZB2brQvZKmJkjluXNlIIHc4tIZ086Bm3x+7cMks17s7Qi86TrcK9Jgtq+e
        O5caEhfUdhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1E4B77174;
        Tue, 28 Mar 2017 15:03:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08FDC77172;
        Tue, 28 Mar 2017 15:03:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH RFC 2/2] diff: teach diff to expand tabs in output
References: <20170328122209.4861-1-jacob.e.keller@intel.com>
        <20170328122209.4861-2-jacob.e.keller@intel.com>
Date:   Tue, 28 Mar 2017 12:03:51 -0700
In-Reply-To: <20170328122209.4861-2-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 28 Mar 2017 05:22:09 -0700")
Message-ID: <xmqqk279cjfs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 498EEAA2-13E9-11E7-947B-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> I'm really not a fan of how the ws code ended up. It seems pretty ugly
> and weird to hack in the expand_tabs stuff here. However, I'm really not
> sure how else I could handle this. Additionally, I'm not 100% sure
> whether this interacts with format-patch or other machinery which may
> well want some way to be excluded. Thoughts?

As long as you do the same as "do we color the output?  no, no, we
are format-patch and must not color" logic to refrain from expanding
the tabs, you should be OK.

> I think there also may be some wonky bits when performing the tab
> expansion during whitespace checks, due to the way we expand, because I
> don't think that the tabexpand function takes into account the "current"
> location when adding a string, so it very well may not be correct.... I
> am unsure if there is a good way to fix this.

This "feature" is limited to the diff output, so one way may be to
leave the code as-is and pipe the output to a filter that is similar
to /usr/bin/expand but knows that the first column is special (this
is the part that "this is limited to diff" kicks in).  You may even
be able to implement it as a new option to "expand(1)" and then
people who aren't Git users would also benefit.

