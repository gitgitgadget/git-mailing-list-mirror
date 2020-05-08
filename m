Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA8DC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669B620736
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZL0MPjxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHPSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 11:18:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53653 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgEHPSg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 11:18:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E24225AEA4;
        Fri,  8 May 2020 11:18:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6H167by21ItFjQbIJMQ60HJJpD8=; b=ZL0MPj
        xB+WU+TP4IkBxaAcnnRXe6TcyfGHYpIQqcBuT3Z0eEtP4TrrN49IZlZpLJS3K+gH
        wvxMpHwNBZsiOUdcPkwfCBKSi7O3G8iewWlWEeKi5E0QeLE/GQ/zkXQiU8QDDcOB
        EQqELHPu3GRoEDqN//e4+lTkJFhRV0+We1lIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HetAT8omAlTov2PeactmEKH7NrW97JWv
        ZdxQsCd0ew9DB15Q/t/mVpJb5jweuOeZGdq8JhistuZXIupG861G0iE0B/Xhxh80
        iOrVswvmFjf9dvhC9EfabAqxxdAjhcZ5lugnYrghzkccOBq8BAWbaunh4ejRI5SB
        eYyn9LV82Z8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D86F95AEA3;
        Fri,  8 May 2020 11:18:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AF505AEA1;
        Fri,  8 May 2020 11:18:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        chrisitan.couder@gmail.com, Denton Liu <liu.denton@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re* [PATCH v4] submodule: port subcommand 'set-url' from shell to C
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
        <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
        <20200506181239.GA5683@konoha>
        <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
        <20200507044028.GA5168@konoha>
        <xmqqv9l849i4.fsf@gitster.c.googlers.com>
        <20200508054728.GA8615@konoha>
        <CAP8UFD0=_8D8hkT5VVPV_F++dr131bkjby357fA+QfhQxktcMg@mail.gmail.com>
Date:   Fri, 08 May 2020 08:18:32 -0700
In-Reply-To: <CAP8UFD0=_8D8hkT5VVPV_F++dr131bkjby357fA+QfhQxktcMg@mail.gmail.com>
        (Christian Couder's message of "Fri, 8 May 2020 08:18:57 +0200")
Message-ID: <xmqq8si21mlz.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E421496-913F-11EA-91AE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, May 8, 2020 at 7:51 AM Shourya Shukla
> <shouryashukla.oo@gmail.com> wrote:
>>
>> On 06/05 10:08, Junio C Hamano wrote:
>
>> > Specifically, I would write "!path", not "path == NULL".  I thought
>> > a rule for that is in the CodingGuidelines (I didn't double check,
>> > though).
>>
>> I could not find a rule like that in the CodingGuidelines.
>> Should I add it?
>> https://github.com/git/git/blob/master/Documentation/CodingGuidelines
>
> Sure.

I'd rather not see too many unrelated things piled up on Shourya's
plate.  Without guidance, the new entry we'll see would be only
about comparing with NULL, and we'd need to spend review cycles
correcting that, too.

How about something like this, perhaps?

-- >8 --
CodingGuidelines: do not ==/!= compare with 0/NULL

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 390ceece52..41a89dd845 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -236,6 +236,19 @@ For C programs:
         while( condition )
 		func (bar+1);
 
+ - Do not explicitly compare an integral value with constant 0 or a
+   pointer value with constant NULL for equality; just say !value
+   instead.  To validate a counted array at ptr that has cnt elements
+   in it, write:
+
+	if (!ptr || !cnt)
+		BUG("array should not be empty at this point");
+
+   and not:
+
+	if (ptr == NULL || cnt == 0);
+		BUG("array should not be empty at this point");
+
  - We avoid using braces unnecessarily.  I.e.
 
 	if (bla) {
