Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDFBC433E4
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB84020829
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 01:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="t0Lhguw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgG2BJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:09:28 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:38606 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgG2BJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 21:09:28 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 06T19Pfd015098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Jul 2020 21:09:25 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 06T19Pfd015098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1595984965; bh=OsCgZUJKXVF0eVaJrqNmJ4HMpTuX3azX5cxZLCu+pMM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=t0Lhguw8HIi+1XwcexefHPss5hC8yBzMTmei3B3BnFHImkJGdtlDwaNTjEaT21aYg
         54IyOHjB5vR2BnUtaIc4KpPRhif1hBl1qcVXSMpboWIZEj2IluBKKK9a2/ipb1GoWx
         CGClu4oyS3/uonI2pQ7KKYRbGhlFx6AQhl3rabdcEcgU9n0D5Q8dvX/wDyQWgx31+k
         DQe3Uvg82qhxDy1oe26wugcVbCTGv9p04k3dsfrUsZ6KnFvPsC+TSsdyv55eY8uPnM
         +AXbjN6ZcNZ+H76NWy6ryE9PlfyM8CkiOQ1w9omb00BZIYfLKOFI/+gbp3Po3BqgSC
         MdsU/eW0JyG6Q==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>
References: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us> <xmqqh7trb0sr.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7trb0sr.fsf@gitster.c.googlers.com>
Subject: RE: I have gone and done a bad thing - malformed tree objects
Date:   Tue, 28 Jul 2020 21:09:35 -0400
Organization: PD Inc
Message-ID: <19cab01d66544$ecb402d0$c61c0870$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKHJ3iYXck3tZcTjZrfcxic8TWr/wHXy0UBp618OBA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano
> Sent: Tuesday, July 28, 2020 8:52 PM
>=20
> "Jason Pyeron" writes:
>=20
> > I was trying to "do stuff" using hash-object -t tree --stdin -w,
> > but I accidentally created trees where other trees were marked as
> > blobs. They were dangling and not connected to any actual commits
> > on my branches.
> >
> > After gc and fsck clean ups, everything reports well...
> >
> > Except:
> >
> > $ GIT_TRACE=3D1 git cat-file --batch-all-objects =
--batch=3Dobjecttype
>=20
> gc and fsck may not have pruned the dangling object yet, but
> --batch-all-objects is a request to enumerate objects that exist in
> the repository, regardless of their reachability from any ref.
>=20
> Perhaps "git prune --expire=3Dnow" would get rid of it?

Both that and

git -c gc.reflogExpire=3Dnow -c gc.reflogExpireUnreachable=3Dnow   -c =
gc.rerereresolved=3Dnow -c gc.rerereunresolved=3Dnow   -c =
gc.pruneExpire=3Dnow -c gc.worktreePruneExpire=3Dnow gc --prune=3Dnow =
--aggressive

leave it in.

