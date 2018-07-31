Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACA81F597
	for <e@80x24.org>; Tue, 31 Jul 2018 04:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeGaGLt (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 02:11:49 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:42054 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeGaGLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 02:11:49 -0400
Received: by mail-oi0-f51.google.com with SMTP id n84-v6so25465723oib.9
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 21:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=risWXzqWyuHc3I+1H6hAFfi6FNd9ea6RKIXN4qXIhJY=;
        b=Z29+2Kmm0UIlOhQI4Bqp5TvOewxI84OL64DCZo18iTXXLe6v3m5rkgFO4NeKV0Qfqg
         JPsr899bQSbG511QsmGtN/uEcQxDgK10yYiJFhVm8MaLD9017kYA0X77lS63wGk6th6k
         WdVBy8vvhyzJolEAr5sS7+NsawP3wsvuPwuvWsqlL/oZckUOQ0O4yxDIg8HqmqLT+lQY
         OLaSYDNwExZwaMHRTJ9nzTWfn7WkzWTPHArTGbqEgEAQBZNM/09uRvl56zQgg886mMqt
         hdNOjkiQZpajPdOGVWr3VpmbDG8qxvx4Wp+fKhO8xPubwy7rV2USOkKUlNJzyIiFoe7i
         v22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=risWXzqWyuHc3I+1H6hAFfi6FNd9ea6RKIXN4qXIhJY=;
        b=jeVflJHexaAiYlkvDbjM6F0Ax9DEl0ZTDJ7Mf2/dQReHWXgCAzskB0D1376ie0mW+6
         r7l5BiV9TZ6BZk65VTGT5/A/2G7/a0PrmnDxBt7fjQ29bgW2mdLXnIivK5yLP7uh96dV
         mh5Oqr1vOZFSYisVYa3gMkmGhiM6IPzsHV/blcAvPcHO4Jjuo/KzwTdmupV5Vyg4V6TV
         AOVm4Rec50qZ6GY1xeK0N1C4vebP31aNJsEQWGQQy/D/OEo3+Qq7+V64agCqvotNEOzs
         V27N5lYfmy1l/b5DjqvlXzPbXdRyeRxHksx5ktkaGpPNLuP/2vT0iKcnzoSj+lbrqj8g
         lgiQ==
X-Gm-Message-State: AOUpUlGRw8G7pbdkbW7UZY92u9I4HXVe/Dgw2ATX4NAZngUyUESnx0hS
        9PyoLcpJCGj0Bx74LHSWQaUNEYW77PbChcHI6LM1MA==
X-Google-Smtp-Source: AAOMgpfGp1W3nyKbaSzI1EcoylsI736/tFafg0wFP6eRD7aAzPhDUW4hN1ppW1afWeVo8/Ztq6kq+AcXMWj3HIR07s8=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr19676500oig.295.1533011610302;
 Mon, 30 Jul 2018 21:33:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6718:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 21:33:30
 -0700 (PDT)
In-Reply-To: <CADryqKxnj0c7srjLz4dzYymBWG140+g=disDF61duVTYjvCx7g@mail.gmail.com>
References: <CADryqKxnj0c7srjLz4dzYymBWG140+g=disDF61duVTYjvCx7g@mail.gmail.com>
From:   Christine Frankel <chrisconnorsfrank@gmail.com>
Date:   Mon, 30 Jul 2018 21:33:30 -0700
Message-ID: <CADryqKzps0sc4VXiq+ZEU436qrO6RKR11-aBN2fSvKu6-mZ_Bg@mail.gmail.com>
Subject: Re: b on my mailing list!
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000077fd000572441479"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000077fd000572441479
Content-Type: text/plain; charset="UTF-8"

dammit! those threat actors found a way and were on for quite a
while....should we do something different?  These people need a life.

On Mon, Jul 30, 2018 at 9:29 PM, Christine Frankel <
chrisconnorsfrank@gmail.com> wrote:

>
>

--00000000000077fd000572441479
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">dammit! those threat actors found a way and were on for qu=
ite a while....should we do something different?=C2=A0 These people need a =
life.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon=
, Jul 30, 2018 at 9:29 PM, Christine Frankel <span dir=3D"ltr">&lt;<a href=
=3D"mailto:chrisconnorsfrank@gmail.com" target=3D"_blank">chrisconnorsfrank=
@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr"><br></div>
</blockquote></div><br></div>

--00000000000077fd000572441479--
