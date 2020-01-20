Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A7C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 20:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C5622522
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 20:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATUI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:08:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39777 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgATUI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 15:08:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so795457wrt.6
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 12:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Tgi6woUaIufW+iBPVATkW9DEyGJARg6YikJGZTpTk8=;
        b=sJpCt1iXjkdFvQJLYxpC/Z3b+SxAj+bwVRDU2ra9XZgOqECoPis93c1UaelnSDn3QI
         u2m17HuVm6url3ECu7in/frUm1a57PfZWknBZganVjMBbrNpNEaVV7WfsuoLZ0JZNbml
         HdVDL+6l8n+Xs9J0IxM+gU39OHwYNwM3XB2d397dFAKRhkTCK4Xay5DSGnyR4A/QpfK5
         N4HTXvtGEMbJSzfTWRItG+eGM4fqv5mz85kV7vZ+8vnCTHYq15iwWo0DgYKvp9xyJyQG
         1fZm+AhLmsJ7VsFz4xbI6jOVuNThB7XnFAZLMau4fiLyoZD9GT4IpLm5FQ/2eT7wQqWB
         xbBQ==
X-Gm-Message-State: APjAAAXavP9+qHKzhDKLmv0chcWwuIZdiDr7L+WE6EptchbPeQxvWdi9
        FAkreQ1vVnwEVJJw8/812hYOchtlJ0tOFuNS90M=
X-Google-Smtp-Source: APXvYqxpaEIf2O7ckY/gI1L/vXZ8SgI5aal9EhxSEymuR0CwKwYYLJ67G2REwUg8nB2iAqHzxj/eUbBgCYnnXtwwvYs=
X-Received: by 2002:adf:ee52:: with SMTP id w18mr1137487wro.415.1579550906788;
 Mon, 20 Jan 2020 12:08:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
 <pull.529.v2.git.1579304283.gitgitgadget@gmail.com> <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com>
 <CAPig+cT8t39UvnF2i6CDoHW4kfEGr-CRFxZKOCstCTU0YzrCgQ@mail.gmail.com> <nycvar.QRO.7.76.6.2001202103221.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202103221.46@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Jan 2020 15:08:15 -0500
Message-ID: <CAPig+cR2T26nJ1G5n82r_Xi8Y84k211n6bhBxG4Ku27vaW1pWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rebase -i: re-fix short SHA-1 collision
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 20, 2020 at 3:04 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 20 Jan 2020, Eric Sunshine wrote:
> > On Fri, Jan 17, 2020 at 6:38 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > +       test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
> >
> > How much do we care that this is introducing new code with git
> > upstream of a pipe (considering recent efforts to eradicate such
> > usage)? Same question regarding several other new instances introduce
> > by this patch.
>
> I would argue that the test case will fail if the `git` call fails. So I
> am not overly concerned if that `git` call is upstream of a pipe.

Unless the git command crashes _after_ it produces the correct output...
