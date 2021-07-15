Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C21C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84782608FC
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhGORW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:22:29 -0400
Received: from m12-13.163.com ([220.181.12.13]:40634 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhGORW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=krCcW
        wS7bv3g7BE92vHUsRCEi99BzFgYMZ/C3unjMRY=; b=GKxHUw3TyYu4ePyn1puJz
        KASIZTQRqclt0PQ3K56tyCmLIBJE35Xsclz7qymQa2Su/VFbyREzZwH5VWL458O4
        1/2AD+YKDSetTJ0ylWbjTe5+0L0agoaP/3jxJJStbfJcNXxnqvJzFbN8+UO5QEJr
        da6UWzT1exAiRncTH9SYTo=
Received: from smtpclient.apple (unknown [60.176.228.14])
        by smtp9 (Coremail) with SMTP id DcCowADHybWaYvBg10bWLA--.35399S3;
        Fri, 16 Jul 2021 00:30:19 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
From:   Sun Chao <16657101987@163.com>
In-Reply-To: <YO8XrOChAtxhpuxS@nand.local>
Date:   Fri, 16 Jul 2021 00:30:18 +0800
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACFA1FCF-3F24-470D-A3AE-DBAA269E9E2C@163.com>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com> <YO5RZ0Wix/K5q53Z@nand.local>
 <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com> <YO8XrOChAtxhpuxS@nand.local>
To:     Taylor Blau <ttaylorr@github.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-CM-TRANSID: DcCowADHybWaYvBg10bWLA--.35399S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFy3XFWkJry8Cry8XFy5Jwb_yoW5uF45pF
        WfKry8tr1kZF4Syw1Iy3ykWrWFvas7G3W5XFy5trWjvwn8W34Sqrs8Jw4Y9FWUGr9YkayY
        qayrWFykXr15WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jV7KxUUUUU=
X-Originating-IP: [60.176.228.14]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiQw-Qglc7Uua0qQAAsb
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 2021=E5=B9=B47=E6=9C=8815=E6=97=A5 01:04=EF=BC=8CTaylor Blau =
<ttaylorr@github.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> [...]
>>=20
>> However we find the mtime of ".pack" files changes over time which =
makes the
>> file system always reload the big files, that takes a lot of IO time =
and result
>> in lower speed of git upload-pack and even further the disk IOPS is =
exhausted.
>=20
> That's surprising behavior to me. Are you saying that calling utime(2)
> causes the *page* cache to be invalidated and that most reads are
> cache-misses lowering overall IOPS?
>=20
> If so, then I am quite surprised ;). The only state that should be
> dirtied by calling utime(2) is the inode itself, so the blocks =
referred
> to by the inode corresponding to a pack should be left in-tact.
>=20
> If you're on Linux, you can try observing the behavior of evicting
> inodes, blocks, or both from the disk cache by changing "2" in the
> following:
>=20
>    hyperfine 'git pack-objects --all --stdout --delta-base-offset =
>/dev/null'
>      --prepare=3D'sync; echo 2 | sudo tee /proc/sys/vm/drop_caches'
>=20
> where "1" drops the page cache, "2" drops the inodes, and "3" evicts
> both.
>=20
> I wonder if you could share the results of running the above varying
> the value of "1", "2", and "3", as well as swapping the `--prepare` =
for
> `--warmup=3D3` to warm your caches (and give us an idea of what your
> expected performance is probably like).
>=20
> Thanks,
> Taylor

I'm sorry to reply so late, I work long hours during the day, and the =
company
network can not send external mail, so I can only go home late at night =
to reply to you.

Thanks for your reply again, My explaination for 'why the mtime is so =
important' lost some
informations and it is not clear enough, I will tell the details here:

Servers:
- We maintain a number of servers, each mounting some NFS disks that =
hold our git
  repositories, some of them are so large (cannot reduce the size now), =
they are > 10GB
- There are too many objects and large files in the git history which =
result in some
  large '.pack' files in the '.git/objects/pack' directires
- We created the '.keep' files for each large '.pack' file, wish the =
disk cache can reduce
  the NFS IOPS and just load contents from caches.

Clients:
- There are too many CI systems are keep downloading the git =
repositories in a very
  high frequency, e.g. we find different CI systems make 600 download =
requests in a short
  period of time by 'git fetch'.
- Some developers are doing 'git push' at the same time, create Pull =
Requests after that
  (which trigger the CI then), so git servers will do some update tasks =
which may cause the
  mtime of '.pack' file freshend.

So, in this case there will be many 'git-upload-pack' processes running =
on the git servers,
they all need to load the big '.pack' files. The 'git-upload-pack' will =
be faster if the
disk cache is warmed up and the NFS server will be not so busy.

However we find the IOPS of the NFS server always be exhausted and the =
'git-upload-pack' will
runs for a very long time. We noticed the mtime of '.pack' changes over =
time, one of my
colleagues who is familiar with the file system tell me it's the mtime =
who invalidate the
disk caches.

So we want the caches to be valid for a long time which can speed up the =
'git-upload-pack'
processes.

I don't known if the `/proc/sys/vm/drop_caches` can help or not, but =
thanks for your tips,
I will try to check them and see if there are some differences.=

