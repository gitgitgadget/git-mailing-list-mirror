Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853BCC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 19:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbiEPTER (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiEPTEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 15:04:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C23EB82
        for <git@vger.kernel.org>; Mon, 16 May 2022 12:04:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2A18126F18;
        Mon, 16 May 2022 15:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gaUyOdSIcLj1PPcv5Kufn1TLer+tTCirpBzCeA
        0S6rU=; b=BIGK1J+aZwAfQNFLft/KQuc6g1MYw5Mnd2NGQvCTwDbZrYkRYPjTOQ
        yxvySw86thZO5+j4AMLcM3M57M20huDQ7vlZ68oNGIzMMq4ssM2LGRkDiOPBkaxQ
        +G25lii8SslYA4QIynttDzG72wl+6xPpz2K1l2Zzhe09juZEXlgr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9826126F17;
        Mon, 16 May 2022 15:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56A55126F16;
        Mon, 16 May 2022 15:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Subject: Re: Bugreport - submodules are fetched twice in some cases
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
        <xmqqczgzdc1r.fsf@gitster.g>
        <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq1qxfbqtq.fsf@gitster.g>
        <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqpmkg8z58.fsf@gitster.g>
        <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq4k1p2v40.fsf@gitster.g>
Date:   Mon, 16 May 2022 12:04:12 -0700
In-Reply-To: <xmqq4k1p2v40.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        16 May 2022 11:25:03 -0700")
Message-ID: <xmqqwnel1eqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F99C3378-D54A-11EC-B4A1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> The +1 fetch is redundant, so it's probably good to get rid of it
>> anyway.

Another thing I noticed is that this +1 is *not* limited to "--all".
If you give a group that expands to multiple remotes, you'd take the
same fetch_multiple() code path (that is why the "single liner"
patch in the message I am responding to looks at the "is remote
set?", which is the same condition that decides if we use
fetch_one() or fetch_multiple()).


I also notice that there is a strange "optimzation" that is used
after expanding a group into one or more remotes and when it turns
out it was a group of one.  In such a case (and only in such a
case), we set "remote" and bypass the code path that uses &list.

I wonder if this "optimization" should be also used for "--all".

 builtin/fetch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git c/builtin/fetch.c w/builtin/fetch.c
index e3791f09ed..9093455e81 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -2187,6 +2187,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		else if (argc > 1)
 			die(_("fetch --all does not make sense with refspecs"));
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
+		/* no point doing fetch_multiple() of one */
+		if (list.nr == 1)
+			remote = remote_get(list.items[0].string);
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
 		remote = remote_get(NULL);


