Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C4C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5792063A
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="J0ThBZ60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGaXFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:05:39 -0400
Received: from mail.pdinc.us ([67.90.184.27]:39248 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgGaXFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 19:05:39 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 06VN5YKH009579
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Jul 2020 19:05:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 06VN5YKH009579
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1596236734; bh=/KHAnDICGJZEjlE3V1/sa4xNrkndHWFRwLfhktNoozg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=J0ThBZ60/YHLEhLopMZz1ma/lkZ1DMjGPtiQxMrgoZkKLlWS191uvbZzWxD4EB0ku
         jEKuLmgxOPA11oQkLRhxLdaQ43p7nrU0juFg+lbzZlTGt8qluq5DG/2iK0UMFY5M2/
         DtKDPcvnyXHOjrruDmOozgmd0EDkvEQcLG06gToXjsd7rJ7NNW+2k0k3xxZgNxUGKU
         DIqhwEnnNu9OARaE6+fvaMisZZH7z54o7zQ5zbsmc7QcVSK63V3vIKRVCP2wEPAHlj
         SZekDwCME15dm4zSJat77BWw+cj/oLqI7fn2GP++6WeRc8amy2oawmg8y5UFj7n9Gx
         8ymML6xm/CFOw==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us>        <xmqqh7trb0sr.fsf@gitster.c.googlers.com>        <19cab01d66544$ecb402d0$c61c0870$@pdinc.us> <xmqq8sf2b3be.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sf2b3be.fsf@gitster.c.googlers.com>
Subject: RE: I have gone and done a bad thing - malformed tree objects
Date:   Fri, 31 Jul 2020 19:05:42 -0400
Organization: PD Inc
Message-ID: <045701d6678f$1f03df20$5d0b9d60$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKHJ3iYXck3tZcTjZrfcxic8TWr/wHXy0UBAeX6BREByOzHD6eRhxmw
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano
> Sent: Wednesday, July 29, 2020 2:10 PM
>=20
> "Jason Pyeron" writes:
>=20
> >> gc and fsck may not have pruned the dangling object yet, but
> >> --batch-all-objects is a request to enumerate objects that exist in
> >> the repository, regardless of their reachability from any ref.
> >>
> >> Perhaps "git prune --expire=3Dnow" would get rid of it?
> >
> > Both that and
> >
> > git -c gc.reflogExpire=3Dnow -c gc.reflogExpireUnreachable=3Dnow   =
-c gc.rerereresolved=3Dnow -c
> gc.rerereunresolved=3Dnow   -c gc.pruneExpire=3Dnow -c =
gc.worktreePruneExpire=3Dnow gc --prune=3Dnow --
> aggressive
> >
> > leave it in.
>=20
> If the cruft has already been stored in a packfile, then prune would
> not touch it.  "git repack -a -d && git prune --expire=3Dnow" would be
> the next thing to do.

$ git repack -a -d && git prune --expire=3Dnow
Enumerating objects: 327236, done.
Counting objects: 100% (327125/327125), done.
Delta compression using up to 8 threads
Compressing objects: 100% (104728/104728), done.
Writing objects: 100% (327125/327125), done.
Total 327125 (delta 205244), reused 326116 (delta 204678), pack-reused 0

$ git cat-file --batch-all-objects --batch=3Dobjecttype
fatal: object 00009623a06b8dea7c151542fc789539599c07d0 changed type!?

Grrrrr....


$ mkdir bak/objects/pack -p

$ mv objects/pack/* bak/objects/pack/

$ for i in bak/objects/pack/*.pack; do git unpack-objects < $i ; done
Unpacking objects: 100% (111/111), 142.57 KiB | 41.00 KiB/s, done.
Unpacking objects: 100% (303/303), 1.16 MiB | 182.00 KiB/s, done.
Unpacking objects: 100% (327125/327125), 1.39 GiB | 158.00 KiB/s, done.

$ git -c gc.reflogExpire=3Dnow -c gc.reflogExpireUnreachable=3Dnow   -c =
gc.rerereresolved=3Dnow -c gc.rerereunresolved=3Dnow   -c =
gc.pruneExpire=3Dnow -c gc.worktreePruneExpire=3Dnow gc --prune=3Dnow =
--aggressive
Enumerating objects: 327314, done.
Counting objects: 100% (327314/327314), done.
Delta compression using up to 8 threads
Compressing objects: 100% (309595/309595), done.
Writing objects: 100% (327314/327314), done.
Selecting bitmap commits: 33000, done.
Building bitmaps: 100% (311/311), done.
Total 327314 (delta 170421), reused 0 (delta 0), pack-reused 0
Removing duplicate objects: 100% (256/256), done.

$ ls -Gg objects/pack/
total 1620740
-r--r-----+ 1    1979274 Jul 30 19:50 =
pack-45501d1b4064e03537158f14ea1cd40158424086.bitmap
-r--r-----+ 1    9165864 Jul 30 17:00 =
pack-45501d1b4064e03537158f14ea1cd40158424086.idx
-r--r-----+ 1 1648486198 Jul 30 17:00 =
pack-45501d1b4064e03537158f14ea1cd40158424086.pack

$ git fsck
Checking object directories: 100% (256/256), done.
warning in tree 64dee778f5cb68573709e04d5bdd0f391c002599: =
zeroPaddedFilemode: contains zero-padded file modes
Checking objects: 100% (327314/327314), done.
Checking connectivity: 327540, done.

jpyeron@blackfat /projects/disa-cmis/cmis.git
$ git cat-file -p 64dee778f5cb68573709e04d5bdd0f391c002599
040000 tree cee1ca9232b589fd8721cbe8c9a2910413f5607e    00
040000 tree d8e1f140eaa746fe358e5eb8c3d1573b432158c2    01
040000 tree 5b1b2826f56a9d7ce4ae4040cdf809bded41557c    02
...
040000 tree 49d3bcf3bf2dcaac80c12a6075b16ef6d067e807    fd
040000 tree 64a163e509b2c061927133eacc68826df202f933    fe
040000 tree 6572fafefd58be1364e7a8dc8230a13d0fd1c9b2    ff

$ git cat-file --batch-all-objects --batch=3Dobjecttype
objecttype
fatal: object 00009623a06b8dea7c151542fc789539599c07d0 changed type!?

Double Grrrrr.....


$ mv bak bak2

$ mkdir bak/objects/pack -p

$ mv -v objects/pack/* bak/objects/pack/
'objects/pack/pack-45501d1b4064e03537158f14ea1cd40158424086.bitmap' -> =
'bak/objects/pack/pack-45501d1b4064e03537158f14ea1cd40158424086.bitmap'
'objects/pack/pack-45501d1b4064e03537158f14ea1cd40158424086.idx' -> =
'bak/objects/pack/pack-45501d1b4064e03537158f14ea1cd40158424086.idx'
'objects/pack/pack-45501d1b4064e03537158f14ea1cd40158424086.pack' -> =
'bak/objects/pack/pack-45501d1b4064e03537158f14ea1cd40158424086.pack'

$ for i in bak/objects/pack/*.pack; do git unpack-objects < $i ; done
Unpacking objects: 100% (327314/327314), 1.53 GiB | 179.00 KiB/s, done.

$ git fsck --lost-found --no-reflogs
warning in tree 64dee778f5cb68573709e04d5bdd0f391c002599: =
zeroPaddedFilemode: contains zero-padded file modes
Checking object directories: 100% (256/256), done.
Checking connectivity: 326145, done.
dangling tree 9e6a1003b4999aacfe522160843059484350f34d
dangling tree ff42e36dc8727cb5c664ba42add1b42e70de209d
dangling blob d761c46714331a15dbcef84fd9af92678cd3c79d
dangling tree cfdf35b71ec160a5cf37cb52647f766dee0a3737
dangling tree 78dbd6e5a37fea6b708952a00e8bf1d1eb3eb5b5
dangling tree 798377228d213226f3b068aeb346b84c4df916a1
dangling tree d4d84773d2523d4d3290ebb669fbc37a3f16808d
dangling tree fa1de9e451e8f51f51f31ba15d1f0d941be0e51e
missing commit 37b7f95fd6b1a015559d0a1dfb0df8f0524fc660
dangling commit e3300a5773d39735a8930303f58411fc145eff93
dangling tree 9e3bba142e03a3b9f08a58ff88385e030553540d
dangling blob e5474ae6ae5fde0d0dfe83a32fa72b3c71601317
dangling tree ba486ad81526bc6bfed81a292ad4713a170f9cc6
dangling commit 8cba1b102d044d4098087c4b5fed1f02f3b63ad7
dangling tree 90657cf7213475972835035494edfa0ae2fea3fc
dangling commit e0d29cbbdf18cbaf6b23781f08f199d9bd11b7ef
dangling commit d22f7d69cb188b067c1ae385537aac67063a0bcd
dangling tree b7f16f536f3c5f6b0642fb2cae2e969da4c81f22

$ git cat-file --batch-all-objects --batch=3Dobjecttype
objecttype
fatal: object 00009623a06b8dea7c151542fc789539599c07d0 changed type!?

I'm running fsck a second time with no packs to see what happens. =
Thoughts?

-Jason

