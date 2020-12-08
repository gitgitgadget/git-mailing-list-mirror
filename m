Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B92C1B0D9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E770E23AFE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgLHU4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:56:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55245 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgLHU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:56:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E502EF03E;
        Tue,  8 Dec 2020 15:56:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zSVWJV7UB0UGqoxnpMcYU0MUA94=; b=wfidZJ
        +qwQOG4jsIdzNs8gn3lks5MjmATR4WMhR3QWcf20VRI3CLouCbZ7LhIygzS7eko9
        K8Sk5wBbw9TcABFWJtrspgrXgyRiNNZdVgyMeSYd1UERWPkucsk9Dj7my4hcilNS
        +Sb9nhwRaAmjY6gtFBxJWXDuHkDbeSw+0nyXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VQw5koF7kSiXhuCp4sgKJ7psRfLlGYbw
        d2cOfVR+UpiwzJdIWKaVJcbns7+m4B4TCi/AOWC2vxieoD2T6kqNSDAjaAI1sp0W
        dyhTbTSAVCY1ivrodSi2VZcoGTOtuwiLyfhqK1Tja0YcdJbMmgH76+yKaCYCuW4i
        Z7BCfbSrFR8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 062ACEF03D;
        Tue,  8 Dec 2020 15:56:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4FC03EF03C;
        Tue,  8 Dec 2020 15:56:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        dstolee@microsoft.com
Subject: Re: [PATCH v3 00/24] pack-bitmap: bitmap generation improvements
References: <cover.1605123652.git.me@ttaylorr.com>
        <cover.1607385833.git.me@ttaylorr.com>
Date:   Tue, 08 Dec 2020 12:56:05 -0800
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 7 Dec 2020 19:04:06 -0500")
Message-ID: <xmqqmtyo6mqi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAFDF786-3997-11EB-BC0C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here's an updated v3 of mine, Stolee, and Peff's series to improve the
> CPU performance of generating reachability bitmaps.

Has the "avoid having to assume the default branch name is 'master',
by naming the initial branch we create our history to use in testing
'second'" fix-up by Dscho, which has been queued in 'seen' on top of
the previous round of this topic, incorporated to this round?  

I think [4/24] and [15/24] can be adjusted by adding this piece from
Dscho to the set-up procedure and ...

@@ -64,6 +64,7 @@ has_any () {
 
 test_expect_success 'setup repo with moderate-sized history' '
 	test_commit_bulk --id=file 10 &&
+	git branch -M second &&
 	git checkout -b other HEAD~5 &&
 	test_commit_bulk --id=side 10 &&
 
... fixing the remainder of the test script by adjusting for the
fallout from the 'master' that is now called 'second'.

Thanks.

