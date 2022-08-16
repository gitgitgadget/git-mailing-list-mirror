Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76F2C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 19:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiHPTjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiHPTjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 15:39:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60736DADF
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 12:39:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1783B15D52D;
        Tue, 16 Aug 2022 15:39:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vWi5HYL3Ozo/HAyZDjhNgJRdK8YjDSz85f4eIO
        e8/1I=; b=D0wF0zYBAPIyG16woGQfltQCfVHMxG5QkuSa1JxbcM7zffg1La1My9
        H6YP4LGzkuQG3IPveRbESZEvIS4AXtmu/qs8slHaNbErrNVpCOhmPfstfJwOOHPU
        F+OBt0Nj2KhrCn81v3m50GJBDntTBaXCwwhCDlu8eG6iA8w4grqSM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FD5915D52C;
        Tue, 16 Aug 2022 15:39:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E0C915D52B;
        Tue, 16 Aug 2022 15:39:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Subject: Re: [PATCH v8] submodule merge: update conflict error message
References: <20220728211221.2913928-1-calvinwan@google.com>
        <20220804195105.1303455-1-calvinwan@google.com>
        <xmqqczd0xjrp.fsf@gitster.g> <xmqqk078t3r6.fsf@gitster.g>
        <CAFySSZCNVBiSXqvkmGkRoD6-+KL4cac9yZWDx=xyTSmNhhEc-Q@mail.gmail.com>
Date:   Tue, 16 Aug 2022 12:39:50 -0700
In-Reply-To: <CAFySSZCNVBiSXqvkmGkRoD6-+KL4cac9yZWDx=xyTSmNhhEc-Q@mail.gmail.com>
        (Calvin Wan's message of "Tue, 16 Aug 2022 12:34:35 -0700")
Message-ID: <xmqqa684t1tl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 320577FE-1D9B-11ED-81D0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> On Tue, Aug 16, 2022 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> >> +                     * languages, the following swap is suggested:
>> >> +                     *      "   %s\n" -> "%s   \n"
>> >> +                     */
>> >> +                    strbuf_addf(&tmp, _("   %s\n"), msg_list.items[i].string);
>> >> +    }
>> >> +    strbuf_reset(msg);
>> >> +    strbuf_add(msg, tmp.buf, tmp.len);
>> >> +}
>> >
>> > Here, tmp is not released, and mst_list holds the words split out of msg.
>>
>> FWIW, with this fixed, the tip of 'seen' passes the linux-leaks CI
>> job.
>>
>> >  merge-ort.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> ...
>
> Should I re-roll with just that change?

I think the topic is already in 'next', so no, it is too late for
that.

I queued the attached on top but haven't merged to 'next' yet.
Making sure that there is no silly mistakes (like "oh, no, that
temporary variable is still alive and it shouldn't be released there
just yet") by lending an extra pair of eyes is what is the most
useful at this point ;-)

--- >8 ---
Subject: [PATCH] merge-ort: plug leaks in "submodule conflict suggestion" code

The helper function uses two temporary variables that it forgets to
release after it is done with them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index a52faf6e21..f33df3ff65 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4507,6 +4507,8 @@ static void format_submodule_conflict_suggestion(struct strbuf *msg) {
 	}
 	strbuf_reset(msg);
 	strbuf_add(msg, tmp.buf, tmp.len);
+	string_list_clear(&msg_list, 0);
+	strbuf_release(&tmp);
 }
 
 static void print_submodule_conflict_suggestion(struct string_list *csub) {
-- 
2.37.2-492-g20f88697f3


