Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC271F597
	for <e@80x24.org>; Sun,  5 Aug 2018 10:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeHEMfT (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 08:35:19 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36736 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeHEMfT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 08:35:19 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so4268575ybk.3
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 03:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJ9Ul8xqqYDXLnzPJWzRCWDL3HLzTiqAsJeBxDYbe0A=;
        b=axBMq5KUjDu2VJgb5j1LIyXxRbPYukISTXEqCywhAbdJoZKCUQmBRFYH48KNvtlpfF
         Cs8CZwtTc9qKQanH8dSTobsaWYgr7Lifa/xyuxgnUBgZpG087s8BtGagSsgIpS9YN8p5
         35sZ6rHUqV9aeWwGk7kBVfJu6YKP7Aoj5etCrfmUAg8XiD3Nm9YJRMx5IZ5kniRzEPTY
         /UedNXr2/bj0AG9Ym5AiXBEGWdX0qFtGLNNwZB+foA7OL77a8wIrbnGQmycCx4l0NItR
         fyajK8paKrfvVGg8GN1cnelIS8sexBoFUSwXToFZ/JFHBs4WYzfZsx+bxrQa7LiOQ/LH
         wQMQ==
X-Gm-Message-State: AOUpUlEB2gjuNQ/JyLfDXzxoisznizk5f1Yo9AHXRmuPU1UFbS0p/Pdk
        4mvIgWKgU8+Mu6WLRaUnBIndO43qZafpwoQOUKA=
X-Google-Smtp-Source: AAOMgpeCxN93IfhLJyhqdf8Wmy2gHrdhYm6fRglK6b52YqIdW8BQTNMRZRC9v7lc33WvcH1jzCwqwtgS9X+3qEPWDjA=
X-Received: by 2002:a25:2d28:: with SMTP id t40-v6mr4439848ybt.497.1533465073335;
 Sun, 05 Aug 2018 03:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.15.git.gitgitgadget@gmail.com> <d5d9db3c1124d29e26864596a8c36f0dc4de8a7e.1533421100.git.gitgitgadget@gmail.com>
 <9776862d-18b2-43ec-cfeb-829418d4d967@gmail.com>
In-Reply-To: <9776862d-18b2-43ec-cfeb-829418d4d967@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Aug 2018 06:31:02 -0400
Message-ID: <CAPig+cRoQB6Az=sYB_tjhOLewJyMzYAwqNxPh99a3aZFhzDcYg@mail.gmail.com>
Subject: Re: [PATCH 3/4] line-log: optimize ranges by joining them when possible
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 2018-08-05 00:18, Johannes Schindelin via GitGitGadget wrote:
> > Technically, it is okay to have line ranges that touch (i.e. the end of
> > the first range ends just before the next range begins). However, it is
> > inefficient, and when the user provides such touching ranges via
> > multiple `-L` options, we already join them.
> >
> >  void range_set_append(struct range_set *rs, long a, long b)
> >  {
> > +     if (rs->nr > 0 && rs->ranges[rs->nr-1].end + 1 == a) {
> > +             rs->ranges[rs->nr-1].end = b;
> > +             return;
> > +     }
>
> As I understand it, this patch attempts to make range_set_append extend
> the last range in the range set to include [a,b), if [a,b) "touches" the
> last range in rs.
> It seems that the first condition in range_set_append should be:
>
>         if (rs->nr > 0 && rs->ranges[rs->nr-1].end == a) {

I agree that this patch has an off-by-1 bug. 'end' is not included in
the previous range, so it should not be adding 1 to end before
checking against 'a'.

*However*, as mentioned in my review[1] of 2/4, the special-case added
by this patch is unnecessary, so this patch should be scrapped.

> With these consideration in mind the assert should become
>
>         assert(rs->nr == 0 || rs->ranges[rs->nr-1].end < a);

Agreed. The existing assertion() has an off-by-1 error.
range_set_append() is supposed to add a range _without_ breaking the
invariant that no two ranges can abut, and the assertion() was
supposed to protect against that. The existing "<= a" incorrectly
allows the new range to abut an existing one, whereas the proposed "<
a" doesn't.

(For adding abutting or overlapping ranges, range_set_append_unsafe()
followed, at some point, by sort_and_merge_range_set() is the
recommended alternative to the more strict range_set_append().)

[1]: https://public-inbox.org/git/CAPig+cRWcFVbA76_HT2iVD16bsUmbWdCgk_07rmiGneM5czdOQ@mail.gmail.com/
