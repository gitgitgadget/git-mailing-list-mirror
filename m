Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B8DCE7A91
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 01:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjIYBFX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 24 Sep 2023 21:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIYBFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 21:05:22 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A3FB
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 18:05:15 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 38P12BPw2430670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 01:02:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jiang Xin'" <worldhello.net@gmail.com>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Ilari Liusvaara'" <ilari.liusvaara@elisanet.fi>,
        "'Jiang Xin'" <zhiyou.jx@alibaba-inc.com>
References: <xmqqy1h2f5dv.fsf@gitster.g> <20230923152201.14741-4-worldhello.net@gmail.com> <CAPig+cTRByz10ySknTxPB2yVJf5Snz29LNRq5MtPk2MF3nMziQ@mail.gmail.com> <CANYiYbFkG+CvrNFBkdNewZs7ADROVsjd051SDQsU0zVq8eBhew@mail.gmail.com> <007601d9ef43$00731690$015943b0$@nexbridge.com> <CANYiYbGf4U2_UG674GqfauNPg+TgOtzRT=xCJ=x0gHM+TcrNpQ@mail.gmail.com>
In-Reply-To: <CANYiYbGf4U2_UG674GqfauNPg+TgOtzRT=xCJ=x0gHM+TcrNpQ@mail.gmail.com>
Subject: RE: [PATCH v2 3/3] archive: support remote archive from stateless transport
Date:   Sun, 24 Sep 2023 21:04:49 -0400
Organization: Nexbridge Inc.
Message-ID: <007b01d9ef4c$4c4e8eb0$e4ebac10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJtBuME2K9dYgfYpOTrEuwe32qH0AIwuGadAjQqHuYB+FVLcAERTBLbAZizWaKuvFDYsA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, September 24, 2023 8:16 PM, Jiang Xin wrote:
>On Mon, Sep 25, 2023 at 7:58 AM <rsbecker@nexbridge.com> wrote:
>>
>> On Sunday, September 24, 2023 7:40 PM, Jiang Xin wrote:
>> >On Sun, Sep 24, 2023 at 2:52 PM Eric Sunshine
>> ><sunshine@sunshineco.com>
>> >wrote:
>> >>
>> >> On Sat, Sep 23, 2023 at 11:22 AM Jiang Xin <worldhello.net@gmail.com>
>wrote:
>> >> > Even though we can establish a stateless connection, we still
>> >> > cannot archive the remote repository using a stateless HTTP
>> >> > protocol. Try the following steps to make it work.
>> >> > [...]
>> >> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> >> > ---
>> >> > diff --git a/http-backend.c b/http-backend.c @@ -639,10 +640,19
>> >> > @@ static void check_content_type(struct strbuf *hdr, const char
>*accepted_type)
>> >> > -       const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
>> >> > +       const char *argv[4];
>> >> >
>> >> > +       if (!strcmp(service_name, "git-upload-archive")) {
>> >> > +               argv[1] = ".";
>> >> > +               argv[2] = NULL;
>> >> > +       } else {
>> >> > +               argv[1] = "--stateless-rpc";
>> >> > +               argv[2] = ".";
>> >> > +               argv[3] = NULL;
>> >> > +       }
>> >>
>> >> It may not be worth a reroll, but since you're touching this code
>> >> anyhow, these days we'd use `strvec` for this:
>> >>
>> >>     struct strvec argv = STRVEC_INIT;
>> >>     if (strcmp(service_name, "git-upload-archive"))
>> >>         strvec_push(&argv, "--stateless-rpc");
>> >>     strvec_push(&argv, ".");
>> >
>> >Good suggestion, I'll queue this up as part of next reroll.
>>
>> Which test covers this change?
>
>See: https://lore.kernel.org/git/20230923152201.14741-4-
>worldhello.net@gmail.com/#Z31t:t5003-archive-zip.sh

Thanks. That is what I needed. Looking forward to the merge.
--Randall

