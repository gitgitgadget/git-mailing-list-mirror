Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80621F4B6
	for <e@80x24.org>; Tue, 14 May 2019 00:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfENAJT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:09:19 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:53300 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbfENAJT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 20:09:19 -0400
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-07v.sys.comcast.net with ESMTP
        id QKu9hM8DvC2gEQL0QhJo2k; Tue, 14 May 2019 00:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1557792558;
        bh=/Go+PeB37mwTwoc6TFFWK6oH9B3hM8kaF37qcaP2vek=;
        h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
         Message-Id:To;
        b=fI15HprypVBCPKvr9ObvZJeMrMoMUnvNEpsgI4ATFxBZ3uxingLWC1eECKa1G2ELR
         hrJ92PZZnCo2wELgdzPPLiXReWSe9k2w3VgRFWZsy/kD6AS2O28MJTyunalSZORMHV
         3sRDjPEkbq7MzbjjBFFHD4Q3BSvlhcFpitLwd2os/uxb9uqzLTkQwZ3bEYnF3Np2Ma
         yF3hSY4XAlGDcqnjNp7gTO00JpOTQV43z71ybagTjnl3ZYOhunpCNE+OiiogLZIGWO
         P4SnXWBz9jzuA/+WnGDwzy4+/g1BhVpVhXp+sUAX1Y0kxZ2MAdQqhB0qar3vFZf4Gh
         HQsghuRhD/86w==
Received: from [IPv6:2620::100e:913:30:a620:8e2a:82b3] ([IPv6:2620:0:100e:913:30:a620:8e2a:82b3])
        by resomta-po-15v.sys.comcast.net with ESMTPA
        id QL09hKJTS4A00QL0DhH9OL; Tue, 14 May 2019 00:09:16 +0000
X-Xfinity-VMeta: sc=0;st=legit
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Proposal: object negotiation for partial clones
From:   Matthew DeVore <matvore@comcast.net>
In-Reply-To: <20190509180022.91700-1-jonathantanmy@google.com>
Date:   Mon, 13 May 2019 17:09:00 -0700
Cc:     matvore@google.com, git@vger.kernel.org, jrn@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A3BD0B7-894F-4FB0-A3BA-15675F60046C@comcast.net>
References: <A0ADEE11-E3E1-4DE0-81BA-40771C783E4E@comcast.net>
 <20190509180022.91700-1-jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 2019/05/09, at 11:00, Jonathan Tan <jonathantanmy@google.com> =
wrote:
>=20
> Thanks for the numbers. Let me think about it some more, but I'm still
> reluctant to introduce multiple filter support in the protocol and the
> implementation for the following reasons:

Correction to the original command - I was tweaking it in the middle of =
running it, and introduced an error that I didn=E2=80=99t notice. Here =
is one that will work for an entire repo:

$ git rev-list --objects --filter=3Dblob:none HEAD: | awk '{print $1}' | =
xargs -n 1 git cat-file -s  | awk '{ total +=3D $1; print total }'

When run to completion, Chromium totaled 17 301 144 bytes.

>=20
> - For large projects like Linux and Chromium, it may be reasonable to
>  expect that an infrequent checkout would result in a few-megabyte
>  download.

Anyone developing on Chromium would definitely consider a 17 MB original =
clone to be an improvement over the status quo, but it is still not =
ideal.

And the 17MB initial download is only incurred once *assuming* the next =
idea is implemented:

> - (After some in-office discussion) It may be possible to mitigate =
much
>  of that by sending root trees that we have as "have" (e.g. by
>  consulting the reflog), and that wouldn't need any protocol change.

This would complicate the code - not in Git itself, but in my =
FUSE-related logic. We would have to explore the reflog and try to find =
the closest commits in history to the target commit being checked out. =
This is sounding a bit hacky and round-about, and it assumes that at the =
FUSE layer we can detect when a checkout is happening cleanly and =
sufficiently early (rather than when one of the sub-sub-trees is being =
accessed).

> - Supporting any combination of filter means that we have more to
>  implement and test, especially if we want to support more filters in
>  the future. In particular, the different filters (e.g. blob, tree)
>  have different code paths now in Git. One way to solve it would be to
>  combine everything into one monolith, but I would like to avoid it if
>  possible (after having to deal with revision walking a few times...)

I don=E2=80=99t believe there is any need to introduce monolithic code. =
The bulk of the filter implementation is in list-objects-filter.c, and I =
don=E2=80=99t think the file will get much longer with an additional =
filter that =E2=80=9Ccombines=E2=80=9D the existing filter. The new =
filter is likely simpler than the sparse filter. Once I add the new =
filter and send out the initial patch set, we can discuss splitting up =
the file, if it appears to be necessary.

My idea - if it is not clear already - is to add another OO-like =
interface to list-objects-filter.c which parallels the 5 that are =
already there.

