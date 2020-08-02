Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100ABC433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 03:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5BD2072A
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 03:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="WV9Io6BS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHBCuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 22:50:05 -0400
Received: from mail.pdinc.us ([67.90.184.27]:32962 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBCuE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 22:50:04 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 0722nucA027414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 1 Aug 2020 22:49:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 0722nucA027414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1596336597; bh=G7G1ssPUnapHzKmIsp43V5mcxJk7u0Rthddee6XOtJw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=WV9Io6BSidzg3fEM63g/JxSwywTiJaJEfOY2TtKM2vD6LePk3mtP5JvPfXFU0DxFY
         EoSUi0+1WP32B3ZOMV/AR4sizri7v3Iq8OZk6X1ArS7zW50zlV/hQvmMoKa1KXjvCj
         iHFPxGr+FS0pyzi3Up7UpgVYhTToKXbhdZ+T/AMzXYA70d2f2XTOIB59qrzfadPtPL
         Rsjk2rJzIe/NAB/c4fHT+IvpJ5/uNEYdawgdLWr9E6B192SgfQUkGftzix54DGLD2W
         HZ622ebb8ZVMWweCrrRnXF2xBoOBQHSHmc9nZwKeyEss+FgCEy80WGTq2TVZF8ocrO
         fsNtM/I/QW40A==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us> <xmqqh7trb0sr.fsf@gitster.c.googlers.com> <19cab01d66544$ecb402d0$c61c0870$@pdinc.us> <xmqq8sf2b3be.fsf@gitster.c.googlers.com> <045701d6678f$1f03df20$5d0b9d60$@pdinc.us> <20200731231521.GB1461090@coredump.intra.peff.net> <046201d66796$fb575bd0$f2061370$@pdinc.us> <20200801014443.GA1464485@coredump.intra.peff.net>
In-Reply-To: <20200801014443.GA1464485@coredump.intra.peff.net>
Subject: RE: I have gone and done a bad thing - malformed tree objects
Date:   Sat, 1 Aug 2020 22:50:04 -0400
Organization: PD Inc
Message-ID: <052601d66877$a191c450$e4b54cf0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKHJ3iYXck3tZcTjZrfcxic8TWr/wHXy0UBAeX6BREByOzHDwNana1QAqebctgB9F6vawIf/OR+p0WrZsA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Jeff King
> Sent: Friday, July 31, 2020 9:45 PM
>=20
> On Fri, Jul 31, 2020 at 08:01:58PM -0400, Jason Pyeron wrote:
>=20
> > > That should be dropping everything that isn't reachable. I'd =
suggest to
> > > expire reflogs, though it looks like you've also tried "git gc" =
with
> > > reflog expiration. Does removing .git/logs entirely help?
> > >
> > > If not, are you sure it isn't actually reachable from your =
history? What
> > > does:
> > >
> > >   git rev-list --all --objects | grep 00009623a06
> >
> > $ git rev-list --all --objects | grep 00009623a06
> > 00009623a06b8dea7c151542fc789539599c07d0 src/htdocs
> > (it is still running...)

$ git rev-list --all --objects | grep 00009623a06
00009623a06b8dea7c151542fc789539599c07d0 src/htdocs

$ git rev-list --all --objects --reflog | grep 00009623a06
00009623a06b8dea7c151542fc789539599c07d0 src/htdocs

No unexpected results, just the correct tree pointing to the 00009623a06 =
as a tree.

> >
> > But that is an expected result, I will be back at work on Sunday.
>=20
> So it sounds like it's still reachable, and you'd need to rewrite
> history to get rid of it. Or is that object OK, and it's a containing
> tree that mentions it with the wrong mode the problem? In that case,
> same question: is the containing tree reachable?

Backing up to the beginning.

There has always been a tree with a tree entry for that blob - which is =
reachable.

I then created a tree manually, in it I added that tree id as a blob =
reference when it should have been a tree. (e.g. 100644 blob =
00009623a06b8dea7c151542fc789539599c07d0 =
00009623a06b8dea7c151542fc789539599c07d0.blob)=20

I realized my mistake, dropped the commit referring to my butchered tree =
object (reset to new correct commit with correct tree).

The tree I created should no longer be reachable.

$ mv logs logs.bak

$ git cat-file --batch-all-objects --batch=3Dobjecttype --unordered =
--allow-unknown-type
objecttype
fatal: object 00009623a06b8dea7c151542fc789539599c07d0 changed type!?

$ git cat-file -t 00009623a06b8dea7c151542fc789539599c07d0
tree

$ git cat-file -s 00009623a06b8dea7c151542fc789539599c07d0
2375

$ echo -e 'import zlib\nfrom hashlib import =
sha1\ndecompressed_contents=3Dzlib.decompress(open("objects/00/009623a06b=
8dea7c151542fc789539599c07d0", "rb").read())\nprint =
sha1(decompressed_contents).hexdigest()\nprint =
decompressed_contents[0:19]' | python | hexdump -C
00000000  30 30 30 30 39 36 32 33  61 30 36 62 38 64 65 61  =
|00009623a06b8dea|
00000010  37 63 31 35 31 35 34 32  66 63 37 38 39 35 33 39  =
|7c151542fc789539|
00000020  35 39 39 63 30 37 64 30  0a 74 72 65 65 20 32 33  =
|599c07d0.tree 23|
00000030  37 35 00 31 30 30 36 34  34 20 2e 70 0a           |75.100644 =
.p.|
0000003d

$ git cat-file -p 00009623a06b8dea7c151542fc789539599c07d0 | cut -c -55 =
| head
100644 blob e465d57c345e2dcb117b5a30f9272b7fc5ec77cd    .p
100755 blob 7f16c1d4cbb75cf7bd635970a2588ced6ccea8ad    Ap
040000 tree 5261c0a3f3b4c688a082c3c5eaf03f8039bf153c    CA
100644 blob 188c0d0541523016352b6851e0f7200c18a372e6    CM
100644 blob c8b040ec356b21fcc06911c544149dc6f5d5b861    CM
100644 blob e441983f0fd4d57fb7bf640de31f728529f12c29    CM
100644 blob fd06c9c6ad662e099341f4e0a05b272c6370e64b    CM
100644 blob d433fb05ebca807f4487ae4cecf48ec3b66cce78    CM
100755 blob 4b1b049b83bcc7821a7b62977124bfcaa024d960    CM
040000 tree 150d60813c913ec9a178c4230b18fbda84edc2af    RE



