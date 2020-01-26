Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D500FC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 18:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B103520708
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 18:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgAZSyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 13:54:03 -0500
Received: from locusts.copyleft.no ([193.58.250.85]:62832 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZSyD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 13:54:03 -0500
X-Greylist: delayed 2128 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jan 2020 13:54:02 EST
Received: from mail-lf1-f44.google.com ([209.85.167.44])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1ivmUS-000K2w-Jl
        for git@vger.kernel.org; Sun, 26 Jan 2020 19:18:32 +0100
Received: by mail-lf1-f44.google.com with SMTP id 9so4626894lfq.10
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 10:18:32 -0800 (PST)
X-Gm-Message-State: APjAAAUfwuZGKOW68A++aIPJ+8DoWdUEuN522NVnl7wPRJoSoJy4TgZV
        AThZ+DAf0mcGw7cVCwRy5JLBF/plIv6Rh8BVYsE=
X-Google-Smtp-Source: APXvYqx8Nt6iCctlkKPxtG4cVhB7mZwOVn9pdTB1xoQm3s/eu1rWpfLAc6KkJWrpU+RN38n3H2OfLO7aLG9vB6jw6TA=
X-Received: by 2002:a19:4cc6:: with SMTP id z189mr6021277lfa.171.1580062707179;
 Sun, 26 Jan 2020 10:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-4-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2001261209590.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001261209590.46@tvgsbejvaqbjf.bet>
From:   Johan Herland <johan@herland.net>
Date:   Sun, 26 Jan 2020 19:18:15 +0100
X-Gmail-Original-Message-ID: <CALKQrgcF0KK1gEvyKe3th2w0YJBbmv+grgbCeN4fOzHKo=H1UA@mail.gmail.com>
Message-ID: <CALKQrgcF0KK1gEvyKe3th2w0YJBbmv+grgbCeN4fOzHKo=H1UA@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] t3305: annotate with SHA1 prerequisite
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 26, 2020 at 12:16 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 25 Jan 2020, brian m. carlson wrote:
> > This test relies on a roughly equal distribution of hashes for notes in
> > order to ensure that fanouts are compressed.  If there are subtrees with
> > only one item left after removing notes, they'll end up still with one
> > level of fanout, causing the test to fail.
>
> That is _almost_ correct: The heuristic wants to see one bucket that has
> a note in it. Or something like that.
>
> See 73f77b909f8 (Notes API: for_each_note(): Traverse the entire notes
> tree with a callback, 2010-02-13) for details. (Cc:ing Johan.)

Something like that, yeah... Re-reading this code, I believe we stop
the fanout at the current level when we can find one or more notes
that do not share the high-nibble of their path with another note.

Here we're at the top level, so this corresponds to looking at the
very first hex character (0-9a-f) of the path (oid of annotated
object), and if there are at least two such objects for each hex
character, we will use a fanout of 1, otherwise, we collapse the
fanout to 0.

Hence we need an absolute minimum of 32 notes (and some rotten luck)
to get a fanout of 1. As the number of notes increase, the probably of
fanning out increases, passing 50% at ~79 notes, and reaching ~100%
somewhere north of 150 notes.

> > The test happens to pass with SHA-1, but doesn't necessarily with other
> > hash algorithms, so annotate it with the SHA1 prerequisite.
>
> I would rather see this tested, still, and reducing the number of notes
> that are retained from 50 to 20 before testing that the fanout has been
> reduced to 0 seems to do the trick. Therefore, I would love to submit this
> for squashing:

Yes, it seems that for SHA1 and the (deterministic) objects used in
the test, we got away with 50 notes, but that is not the case for
other hash algorithms. Lowering the number to 20 definitely results a
fanout of 0, as should any other number below 32.

+1 to Dscho's squash.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
