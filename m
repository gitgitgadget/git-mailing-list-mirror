Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05A01F404
	for <e@80x24.org>; Fri, 31 Aug 2018 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeHaWtI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 31 Aug 2018 18:49:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44624 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaWtI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 18:49:08 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so15607939qtk.11
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 11:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WsttEDukfcBIJE77P1eHR6Kuc+7VHyKdOCLo4DGVBAQ=;
        b=ksBIbQ47AY1ZzImaK/ixgCsqTw2oBlBfHtpe0J+/kqkpTf9BDfoyKArWb43Ppk0mVD
         fazqk6vaRtF4unYCv3C1owSfsnJdw0yAliOyNPv4MJuBtT2oGU8RiLH0BEbjTbWyHXhz
         heVUQO6C6BCYQUSF9GGhK0pXQFgrq+onRWiDELH0pUXwtppVojprv6eJYa6xftBcwDW2
         3B8PksLndfZn/y2DM2OSBgZsmFAoWV8eXDgMEqWUXSK3JK/WRPQDh5c+xViSnitjLKEJ
         U89bu3jXamEoOt8atO3mGorXqj1lQZ3Cot7AnJ9EwujJBzRJ7TdnxgKECiBhe3BwUseD
         eItA==
X-Gm-Message-State: APzg51BiIq6IXONc5EFQNZK6bd0NZoKCgz+CUUB/asOGfqEM5vUdq3KL
        i7Zh6vEBVpGwIN7d++LVIySdJcBeb0kJcr7X6BE=
X-Google-Smtp-Source: ANB0VdZkS0w46lQw0eu2g6Qiyqu1BqHYN0IRxmEuIwlpWxqLxv+LzW521nbwTrINVS4ZTEwvb3PunqiFU/wnFkuNc2c=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr17435236qtd.101.1535740823327;
 Fri, 31 Aug 2018 11:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
 <20180829005642.980617-6-sandals@crustytoothpaste.net> <20180831182141.GA9399@tor.lan>
In-Reply-To: <20180831182141.GA9399@tor.lan>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 31 Aug 2018 14:40:12 -0400
Message-ID: <CAPig+cSSs9a_RSnc6==zb70Swh1L1Ok4y-DGc8YawPyea0Gm9Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] t0027: make hash size independent
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 2:21 PM Torsten Bögershausen <tboegi@web.de> wrote:
> > diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> > @@ -14,11 +14,13 @@ compare_files () {
> >  compare_ws_file () {
> > +     tmp=$2.tmp
> >       act=$pfx.actual.$3
> > -     tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
> > +     tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$tmp" &&
> >       tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
> > +     sed -e "s/0000*/$ZERO_OID/" "$tmp" >"$exp" &&
>
> Out of interest: why do we use a "tmp" file here?
> Would it make more sense  to chain the 'tr' with 'sed' and skip the
> tmp file ?
>
>         tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
>         sed -e "s/0000*/$ZERO_OID/"  >"$exp" &&
>
> Yes, we will loose the exit status of 'tr', I think.
> How important is the exit status ?

As far as I understand, it is only Git commands for which we worry
about losing the exit status upstream in pipes. System utilities, on
the other hand, are presumed to be bug-free, thus we don't mind having
them upstream.

A different question is why does this need to run both 'tr' and 'sed'
when 'sed itself could do the entire job since 'sed' has 'tr'
functionality built in (see sed's "y" command)?
