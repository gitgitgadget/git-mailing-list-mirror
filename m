Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22FBC433DF
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 00:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80C220829
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 00:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="Kx5XzEjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHAABx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 20:01:53 -0400
Received: from mail.pdinc.us ([67.90.184.27]:40000 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgHAABx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 20:01:53 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 07101ons012688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Jul 2020 20:01:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 07101ons012688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1596240111; bh=rKyZMPlF1irZPngAF+8fmWTXuX2MpcSK6rMOahWDYOc=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=Kx5XzEjlLE4RVnGHD4bbNrtRq9/Y0LRdGOdqubfBVgjzCRTdmblMzxqWd7+MjSVx/
         3nB+lRzHpKUcWxYFDzkBn1B8kcENdjdDY7BjKbVkxCN0kYQ0eV0HcEuFAweis+9NXE
         GMlIme9cvV7RamYk3v6eAGDtso/yCMJcefjHyay7FYpaU5vKrT7dQmv/lOdVweDN7L
         csl7F/xiUfoIBeSO/zkRQphoZfZE3OmYX4LqKWKIfU5jyBy7wrqvEHusnfLFDOA7FS
         Z9rp4+S6S6Zoh1Y/Qj/coD2zJooMf6jAl/ox6ESI96sGofiCWTL0wzP5vFzo3Pvak8
         R2aiFTee6O0aw==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us> <xmqqh7trb0sr.fsf@gitster.c.googlers.com> <19cab01d66544$ecb402d0$c61c0870$@pdinc.us> <xmqq8sf2b3be.fsf@gitster.c.googlers.com> <045701d6678f$1f03df20$5d0b9d60$@pdinc.us> <20200731231521.GB1461090@coredump.intra.peff.net>
In-Reply-To: <20200731231521.GB1461090@coredump.intra.peff.net>
Subject: RE: I have gone and done a bad thing - malformed tree objects
Date:   Fri, 31 Jul 2020 20:01:58 -0400
Organization: PD Inc
Message-ID: <046201d66796$fb575bd0$f2061370$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKHJ3iYXck3tZcTjZrfcxic8TWr/wHXy0UBAeX6BREByOzHDwNana1QAqebctinZJbKEA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Jeff King
> Sent: Friday, July 31, 2020 7:15 PM
> 
> On Fri, Jul 31, 2020 at 07:05:42PM -0400, Jason Pyeron wrote:
> 
> > > If the cruft has already been stored in a packfile, then prune would
> > > not touch it.  "git repack -a -d && git prune --expire=now" would be
> > > the next thing to do.
> >
> > $ git repack -a -d && git prune --expire=now
> > Enumerating objects: 327236, done.
> > Counting objects: 100% (327125/327125), done.
> > Delta compression using up to 8 threads
> > Compressing objects: 100% (104728/104728), done.
> > Writing objects: 100% (327125/327125), done.
> > Total 327125 (delta 205244), reused 326116 (delta 204678), pack-reused 0
> >
> > $ git cat-file --batch-all-objects --batch=objecttype
> > fatal: object 00009623a06b8dea7c151542fc789539599c07d0 changed type!?
> 
> That should be dropping everything that isn't reachable. I'd suggest to
> expire reflogs, though it looks like you've also tried "git gc" with
> reflog expiration. Does removing .git/logs entirely help?
> 
> If not, are you sure it isn't actually reachable from your history? What
> does:
> 
>   git rev-list --all --objects | grep 00009623a06

$ git rev-list --all --objects | grep 00009623a06
00009623a06b8dea7c151542fc789539599c07d0 src/htdocs
(it is still running...)

But that is an expected result, I will be back at work on Sunday.


> 
> say? If no hits, does adding --reflogs to the command-line change it?
> 
> We also consider blobs in the index reachable. I don't recall offhand
> whether that applies to trees mentioned by the cache-trees extension. I
> don't _think_ that would apply to your broken tree, since they'd have
> been generated by Git itself, but possibly removing .git/index (if this
> isn't a bare repo) would help?
> 
> -Peff

