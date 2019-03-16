Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA5B20248
	for <e@80x24.org>; Sat, 16 Mar 2019 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCPVEp (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 17:04:45 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:39637 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfCPVEp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 17:04:45 -0400
Received: by mail-io1-f45.google.com with SMTP id e13so975843ioq.6
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbU3O0KkpdqRSK0BvnLNhZE6A2DwHDkQ4B/seasDQrM=;
        b=hba16/0EUBVWpT2ADxB3sdTxztxaG2gmzSl5c/H+hS+QLMGhzG0QOhpHfEewvAAcc+
         PmW4bw+tTxifv+GyvJtbISNGdvarE+pRn4rbnfhisLXBV7uruErhKcEqWtx7IPVamrIj
         spPXrYvsujbMrUe3Kq+E+jbjVk8uyWqQ75pLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbU3O0KkpdqRSK0BvnLNhZE6A2DwHDkQ4B/seasDQrM=;
        b=JytI4jA6siCCnX1e9oOI7p8n9l0Q1as6ndje5FQxXpuO32Li8j7C92ukTPxiwJlS2a
         o0Fvq19ULUIIVDHOuYQNGpzDTorOMOSkKzA55REJub0HOCG+Oc/rt5p2tFUKMnJ78Ogw
         jS5xmoO3Fc+5wS1obwsZ/GzM70JX2+J7297NsmvPgJpkZQvaCOr0XTFYWz/GJEaR0Y0L
         mRv0OPm4oWbnJdAKmH6wk6gaxiDYukRLeoqCnD9wWxPl+Qo47YS4uold6vAvWXU1vdXq
         y/h1HfApfZ8REBioLNIMthiJHEoeccL0MLFILuJW/PobUq9N6YXP44vW/8+KTsJVSOvq
         aigg==
X-Gm-Message-State: APjAAAVyjiB7zcQrnMhQmz6wBxkyXhxm5yPO/0OkfGrJqbsXciLZly2q
        S4e8wowdLfO2LsSdKvPzTAdtTo2OMF4+wbLsgzZ5yoQvAfc=
X-Google-Smtp-Source: APXvYqykpFbMjEpiBJO6n9yMWxMh3rrnaRYkbki1/aUHEpkwkC+xG8W1FogQigkHvPpzZgC8B2dPSetrfevdZ4aIGp8=
X-Received: by 2002:a5e:a804:: with SMTP id c4mr6625423ioa.15.1552770284494;
 Sat, 16 Mar 2019 14:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALwJ=MzrqPUNw=jc0NRtaJaJG+ErXNb577JNSN66GiGY4UFtRw@mail.gmail.com>
In-Reply-To: <CALwJ=MzrqPUNw=jc0NRtaJaJG+ErXNb577JNSN66GiGY4UFtRw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Mar 2019 14:04:33 -0700
Message-ID: <CAADWXX81agAg1B9+FM5c4JsWzANKochNTcv2ShsRzAsZpHAVWw@mail.gmail.com>
Subject: Re: git-fast-import yields huge packfile
To:     Richard Hipp <drh@sqlite.org>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 16, 2019 at 1:31 PM Richard Hipp <drh@sqlite.org> wrote:
>
> Maybe I'm doing something wrong with the fast-import stream that is
> defeating Git's attempts at delta compression....

fast-import doesn't do fancy delta compression becayse that would
defeat the "fast" part of fast-import.

Just do a git repack after the import to do the proper repacking. I
get a 41Mb packfile when I try that on your repo.

So a simple

   git repack -adf

should fix things up for you (the "-f" to make sure it doesn't try to
re-use things from the silly bad pack). Alternatively, use "git gc
--aggressive", which will do that forced repack too.

                  Linus
