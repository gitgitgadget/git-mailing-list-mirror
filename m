Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33169C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1075E6024A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhGLQU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:20:29 -0400
Received: from m12-12.163.com ([220.181.12.12]:35706 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhGLQU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=ZWZ7M
        Gmb+Fz/NlKGTJ8MC/WkogU8XxV/XuY50NLIBkE=; b=T5OP2c8ShPhjtDxRKETk0
        4OWZFd5SlMBqca8BgcoSznx73bwytSlwVxB8GMq3CUihr+SF0SU1zr3I6KgYh2r4
        SefM00qcRpJ3FvrtRNeSQdbVhv7HjfQEON98XKPDblX7ljQK2j0H5YTdP3RSA5wI
        JTYQ3adMofEz+ttCLmnM5M=
Received: from smtpclient.apple (unknown [60.176.228.119])
        by smtp8 (Coremail) with SMTP id DMCowAAXyjgMa+xgHDscOg--.35957S3;
        Tue, 13 Jul 2021 00:17:16 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] packfile: enhance the mtime of packfile by idx file
From:   Sun Chao <16657101987@163.com>
In-Reply-To: <874kd04dgo.fsf@evledraar.gmail.com>
Date:   Tue, 13 Jul 2021 00:17:15 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9FCDF81A-F466-44F2-8B70-543748E91CB9@163.com>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <874kd04dgo.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-CM-TRANSID: DMCowAAXyjgMa+xgHDscOg--.35957S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyxtF1DJr43KFy8CFW3KFg_yoW8tw4xpF
        Z5Kr92k3yvqrWfJr1qqa1UXFWjqw4fXw1Sqas0gFy5Jry5CFySvrWxt34YvFWUWr4vkw4j
        va10k3s3GF1UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=
X-Originating-IP: [60.176.228.119]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiWwzNglSIqzF5wAAAsn
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 2021=E5=B9=B47=E6=9C=8812=E6=97=A5 07:44=EF=BC=8C=C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason <avarab@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> On Sat, Jul 10 2021, Sun Chao via GitGitGadget wrote:
>=20
>> From: Sun Chao <16657101987@163.com>
>>=20
>> Commit 33d4221c79 (write_sha1_file: freshen existing objects,
>> 2014-10-15) avoid writing existing objects by freshen their
>> mtime (especially the packfiles contains them) in order to
>> aid the correct caching, and some process like find_lru_pack
>> can make good decision. However, this is unfriendly to
>> incremental backup jobs or services rely on file system
>> cache when there are large '.pack' files exists.
>>=20
>> For example, after packed all objects, use 'write-tree' to
>> create same commit with the same tree and same environments
>> such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
>> notice the '.pack' file's mtime changed, but '.idx' file not.
>>=20
>> So if we update the mtime of packfile by updating the '.idx'
>> file instead of '.pack' file, when we check the mtime
>> of packfile, get it from '.idx' file instead. Large git
>> repository may contains large '.pack' files, but '.idx'
>> files are smaller enough, this can avoid file system cache
>> reload the large files again and speed up git commands.
>>=20
>> Signed-off-by: Sun Chao <16657101987@163.com>
>=20
> Does this have the unstated trade-off that in a mixed-version
> environment (say two git versions coordinating writes to an NFS share)
> where one is old and thinks *.pack needs updating, and the other is =
new
> and thinks *.idx is what should be checked, that until both are =
upgraded
> we're effectively back to pre-33d4221c79.
>=20
Thanks for your reply, I can not agree with you more.

> I don't think it's a dealbreaker, just wondering if I've got that =
right
> & if it is's a trade-off you thought about, maybe we should check the
> mtime of both. The stat() is cheap, it's the re-sync that matters for
> you.
>=20
> But just to run with that thought, wouldn't it be even more helpful to
> you to have say a config setting to create a *.bump file next to the
> *.{idx,pack}.
>=20
> Then you'd have an empty file (the *.idx is smaller, but still not
> empty), and as a patch it seems relatively simple, i.e. some core.* or
> gc.* or pack.* setting changing what we touch/stat().

Yes, thanks. This is a good idea, let me try this way.


