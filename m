Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21CD01F462
	for <e@80x24.org>; Wed, 29 May 2019 16:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfE2Qn1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 29 May 2019 12:43:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34914 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2Qn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 12:43:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id q13so2351863vso.2
        for <git@vger.kernel.org>; Wed, 29 May 2019 09:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eDbSYM9hekfbWh0KWZ9juHbrla3gyc7yCnbjvUROxFc=;
        b=EppwNjt6jAz9hpE0Rb6BcU8dd0IvTzMNEsAm6AYt48e0AKMEv9JqyuotpT+IgCIJ05
         rEEmUjOMWKq1WQLfTmEimuOOVR7W/ZLOg0UlxyfcmYrytJqhLBbAsAWW0bhgDSOKietu
         WMUphwQ9JN4K2OEH7eHAja04u3UcTyihNcWEchVgYCzBCURKpZm3zkFiXnj1tsNK02M+
         fDOtV04KHZ4gz6CTB36b3gK2CRJPmloCO6nBsWdVNByGoIwhSklfTXE2H4o+1dSBxUsA
         k0JUc0OmLz5szxfL7go6bdX2rI94PMd7jas5IRqbO5LTFc1VoLkUMzokEaa5uqQGXJRl
         UI9g==
X-Gm-Message-State: APjAAAWHoThL+ok170kyegQiHwzHfywizZ3UMB3P84oGcpb9tZ30G4l3
        S0e756yOGehstmw7yMHUJqc4Rxrrifg+yNIGms3aQg==
X-Google-Smtp-Source: APXvYqwFnC/etkADgaN4AK5OhKEFsfbZmZfPgcjjWJlusFw1IvNn49VG1iPxIJqFsuDfExPru07zfZ32uZOmudGpv/4=
X-Received: by 2002:a05:6102:f:: with SMTP id j15mr48620384vsp.42.1559148205918;
 Wed, 29 May 2019 09:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190524092442.701-1-pclouds@gmail.com> <20190529091116.21898-1-pclouds@gmail.com>
 <20190529091116.21898-2-pclouds@gmail.com>
In-Reply-To: <20190529091116.21898-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 May 2019 12:43:15 -0400
Message-ID: <CAPig+cQgQcdkY2S3MO-hiLynDOJ9hkkFCtdAf9JQb82aqK1BRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] diff-parseopt: correct variable types that are
 used by parseopt
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 29, 2019 at 5:11 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Most number-related OPT_ macros store the value in an 'int'
> variable. Many of the variables in 'struct diff_options' have a
> different type, but during the conversion to using parse_options() I
> failed to notice and correct.
>
> The problem was reported on s360x which is a big-endian
> architechture. The variable to store '-w' option in this case is
> xdl_opts, 'long' type, 8 bytes. But since parse_options() assumes
> 'int' (4 bytes), it will store bits in the wrong part of xdl_opts. The
> problem was found on little-endian platforms because parse_options()

Did you mean s/found/not &/ ?

> will accidentally store at the right part of xdl_opts.
>
> There aren't much to say about the type change (except that 'int' for

s/aren't/isn't/

> xdl_opts should still be big enough, since Windows' long is the same
> size as 'int' and nobody has complained so far). Some safety checks may
> be implemented in the future to prevent class of bugs.
>
> Reported-by: Todd Zullinger <tmz@pobox.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
