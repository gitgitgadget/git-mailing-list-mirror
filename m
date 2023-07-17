Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE5CEB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 04:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGQETe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 00:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQETd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 00:19:33 -0400
Received: from mail.nicholasjohnson.ch (mail.nicholasjohnson.ch [93.95.231.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9AF10F
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 21:19:32 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicholasjohnson.ch;
        s=dkim1; t=1689567569;
        bh=Z9GwqXJI3v1KZwC628pxqDTGB0aWRdUxypDam5qOU5Y=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=inmdMsjEGtkw4mfuOhuk2DKdOZ425mlTIi3+/WTjRWKfOfYT4WtU8SsiZlQI4RoOl
         vU6px8vn0db2VTQ2BfJS/OMwUyIP87X0+0VqzsMKJ6pd+2Dx8nVC0pKYOEg15S0lo4
         AgYBSLmFL8t7qjCbZiFiT6+vsvVv/6P1yotCvMpwoKshzBAjb3XlcoTsoqTv+I0M1j
         Qd/MWF2a8fLhQw7tcw0V2FntbYaM5qCUZKDEUsBajhs0MgCxwThdE5AOB738LO5Nux
         K/ZzGgtsOEQNyAxiR2FXwRzP5VihNx22mE4iO5jLaRqY/4NaF1U+2CTLw2K2SkK/g8
         bLMd5XtUs3YMA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 04:20:12 +0000
Message-Id: <CU45QDSITT7K.1HLDIM21MXW7H@anonymous>
To:     "Jason Pyeron" <jpyeron@pdinc.us>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Git Privacy
From:   "nick" <nick@nicholasjohnson.ch>
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
 <CU3Z2NYP6BGG.1PQ6S5AF60XX6@anonymous>
 <00b901d9b83d$249a2d20$6dce8760$@pdinc.us>
In-Reply-To: <00b901d9b83d$249a2d20$6dce8760$@pdinc.us>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Pyeron wrote:
> > nick wrote:
> > Come to think of it, even if timezones were converted to UTC by default=
,
> > time of day would still leak information about a user's likely timezone=
.
>
> Discussed this with our policy wonks...
>
> Short answer - no. There is no legal assumption that can be made - your
> work hours cannot be assumed to be 9-5. They also said that time zone is
> "too broad at 1/24th of the world", but understood the concern.

An adversary may have other information which can be correlated with the
timestamps or timezone, making them less benign than in isolation.

> That being said the recommendation is to add --privacy

I'm not familiar with the processes here. Is it my responsibility to
implement it since I proposed it or who shall implement it?

> Where it assumes some defaults and those defaults can be controlled in
> your config or via --privacy=3Doption1,option2
>
> And then some of the options can be:
>
> date-timezone=3DUTC
>
> date-precision=3D8hour

This sounds great. A few preliminary ideas on implementation:

'date-precision' must round the author AND committer timestamps
otherwise it's useless

'date-precision' must round down, never into the future

'date-timezone' must convert the date from local time and not just
replace the timezone

Any thoughts on making 'date-precision' also apply to GnuPG signature
timestamps? It's possible to specify a custom GnuPG command which does
this using gpg.program, but it's inconvenient. The relevant GnuPG option
is '--faked-system-time <epoch>!'

If that idea is no good, there should at least be a warning displayed
when the user signs anything with GnuPG with 'date-precision' enabled.

If that idea is good, then there should be a conditional check that the
rounding performed by 'date-precision' does not round down to before the
signing key was generated. Otherwise the signature will be invalid.
