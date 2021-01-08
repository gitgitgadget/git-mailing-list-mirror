Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F5C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2BE23772
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbhAHQkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:40:09 -0500
Received: from mailgw-e01.its.kfa-juelich.de ([134.94.4.38]:33982 "EHLO
        mailgw-e01.its.kfa-juelich.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728155AbhAHQkJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jan 2021 11:40:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw-e01.its.kfa-juelich.de (Postfix) with ESMTP id B5E12E00173
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 17:39:26 +0100 (CET)
Authentication-Results: mailgw-e01.its.kfa-juelich.de (amavisd-new);
        dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
        header.d=fz-juelich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fz-juelich.de; h=
        content-language:content-transfer-encoding:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:subject:subject:received
        :received:received; s=main; t=1610123953; bh=7XOX1ZtJfScLA5U+R0O
        yUKz0dw66+qqLwws+puHoXgI=; b=Yj9dLNeIRunrnmNagX1zQ9WfIEnF5XVs2jS
        KwXsMN7HrdiLNgwQFtSVXJ/nNXXTq5phKTFEvZ2GbhhgipLu7CS0THT957UaAVmO
        siv5Dr7iNH8sbGT1K2CXBEHo7Zk7G3f49hkS7vziU4VA6TmQ7KWCnboKuf5RjJn0
        QoW3Hp2I=
X-Virus-Scanned: Debian amavisd-new at mailgw-e01.its.kfa-juelich.de
Received: from mailgw-e01.its.kfa-juelich.de ([127.0.0.1])
        by localhost (mailgw-e01.its.kfa-juelich.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bbEScvruasEj for <git@vger.kernel.org>;
        Fri,  8 Jan 2021 17:39:13 +0100 (CET)
Received: from exch2016-e1.ad.fz-juelich.de (exch2016-e1.its.kfa-juelich.de [134.94.4.34])
        by mailgw-e01.its.kfa-juelich.de (Postfix) with ESMTPS
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 17:39:13 +0100 (CET)
Received: from [192.168.178.46] (46.253.62.73) by exch2016-e1.ad.fz-juelich.de
 (134.94.4.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 8 Jan 2021
 17:39:12 +0100
Subject: suspected race between packing and fetch (single case study)
References: <fe9babc8-a3ee-6be4-e4f8-9690cb7c79bd@fz-juelich.de>
To:     <git@vger.kernel.org>
From:   Adina Wagner <a.wagner@fz-juelich.de>
X-Forwarded-Message-Id: <fe9babc8-a3ee-6be4-e4f8-9690cb7c79bd@fz-juelich.de>
Message-ID: <e7301aaf-b341-ec0b-9e2d-ab7f60ac58da@fz-juelich.de>
Date:   Fri, 8 Jan 2021 17:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <fe9babc8-a3ee-6be4-e4f8-9690cb7c79bd@fz-juelich.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [46.253.62.73]
X-ClientProxiedBy: exch2016-e2.ad.fz-juelich.de (134.94.4.36) To
 exch2016-e1.ad.fz-juelich.de (134.94.4.34)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


colleagues encouraged me to report a "personal" bug I've stumbled
across. Its "personal", because I wasn't able to create a minimal
reproducer, or even reproduce it with the same script on other
infrastructure. We're suspecting a race between packing and fetch. The
script I am using is at the bottom of the email.

The script creates a joint Git/git-annex repository A with a large
number of objects. Afterwards, a repository B is created, and A is
cloned into it.
Cloning fails initially. Errors look like this:

+ git clone --progress ../A /tmp/B/subds
Cloning into '/tmp/B/subds'...
fatal: failed to copy file to
'/tmp/B/subds/.git/objects/44/93d6041a44b5a7280875ec9b6ecd78fbab7b6e':
No such file or directory

Running "ps aux -H | grep git" before and after cloning shows garbage
collection and packing processes in repo A. We're suspecting that there
is a race. Here is script output that shows the processes:
+ cd B
+ ps aux -H
+ grep git
adina     674763  0.0  0.0   6152   836 pts/5    S+   16:38
0:00           grep git
adina     674071  0.0  0.0   9584  2788 ?        Ss   16:38   0:00
/usr/lib/git-core/git gc --auto --no-quiet
adina     674072  0.0  0.0   9584  3884 ?        S    16:38   0:00
/usr/lib/git-core/git repack -d -l --no-write-bitmap-index
adina     674073  149  0.1 583780 20564 ?        R    16:38
0:02         /usr/lib/git-core/git pack-objects --local
--delta-base-offset .git/objects/pack/.tmp-674072-pack
--keep-true-parents --honor-pack-keep --non-empty --all --reflog
--indexed-objects --unpacked  --incremental
+ git clone --progress ../A /tmp/B/subds
Cloning into '/tmp/B/subds'...
fatal: failed to copy file to
'/tmp/B/subds/.git/objects/14/5a4c6775684788ecf51e5d745ac19ad5b204e3':
No such file or directory
+ ps aux -H
+ grep git
adina     674774  0.0  0.0   6152   896 pts/5    S+   16:38
0:00           grep git
adina     674071  0.0  0.0   9584  2788 ?        Ss   16:38   0:00
/usr/lib/git-core/git gc --auto --no-quiet
adina     674072 11.0  0.0  11160  3884 ?        R    16:38   0:00
/usr/lib/git-core/git repack -d -l --no-write-bitmap-index
bash script.sh  65.71s user 29.53s system 94% cpu 1:40.71 total



Both A and B are completely sane repositories, git fsck shows nothing
out of the ordinary, I can clone them fine in any situation but the
scripted workflow. If I add a short "sleep" between creating A and
cloning A into B the error vanishes.

I have been able to trigger this reliably for a month with the script. I
am running git version 2.29.2 (but also saw this when downgrading to
version 2.24) on Debian testing (bullseye). Other than simply waiting a
bit before the clone, setting git config --global gc.autodetach false
removes the bug, too.

I wonder if there is a way that Git could guard cases where background
gc processes may still be running?


For completeness, here is the script I am using to trigger this on my
machine. We didn't manage to reproduce the behavior on another machine,
and I didn't find a more minimal example (sorry :( ). The script
involves datalad (which uses git-annex):

#!/bin/sh

set -x

# this creates a joint git/git-annex repository
datalad create A && cd A
# this adds adds and extracts a tarball with ~13.000 JPEGs to the
repository. Data is added to git annex.
datalad download-url \
     --archive \
     --message "Download Imagenette dataset" \
     'https://s3.amazonaws.com/fast-ai-imageclas/imagenette2-160.tgz'
# this creates another joint git/git-annex repository
cd ../ && datalad create B
cd B
ps aux -H | grep git
git clone --progress ../A /tmp/B/subds
ps aux -H | grep git


Kind regards,
Adina



---------------------------------------------------------------------------=
---------------------
---------------------------------------------------------------------------=
---------------------
Forschungszentrum Juelich GmbH
52425 Juelich
Sitz der Gesellschaft: Juelich
Eingetragen im Handelsregister des Amtsgerichts Dueren Nr. HR B 3498
Vorsitzender des Aufsichtsrats: MinDir Volker Rieke
Geschaeftsfuehrung: Prof. Dr.-Ing. Wolfgang Marquardt (Vorsitzender),
Karsten Beneke (stellv. Vorsitzender), Prof. Dr.-Ing. Harald Bolt
---------------------------------------------------------------------------=
---------------------
---------------------------------------------------------------------------=
---------------------

