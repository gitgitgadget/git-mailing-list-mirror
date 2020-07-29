Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62028C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E322076E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 00:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="RoUV6tQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgG2ArJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:47:09 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:38312 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbgG2ArI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 20:47:08 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 06T0l7cO014316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 20:47:07 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 06T0l7cO014316
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1595983627; bh=Bo6k8BrbbO6uHwbK+hgIIwXXuZhFh/bF2gq88Jcxkgo=;
        h=From:To:Subject:Date:From;
        b=RoUV6tQbgRxaxcOjJWQYW5ov7DthSsTr70ctBMZ6jlRGUi1kXkgjW8mi29gFT8uPr
         jfjtmIQOVom2ek7F0iegsZCAjH5+9uR8HgxMm8pfx3ciG6aXY5t1LEkyU+W9m/A2Wr
         f9Iq9zaMY9UFEGXam1evZ8LrgWhUPn+4hCLARDNqdYEWXVsWe+Gg9uBPvwTVvIBMKi
         dIfA7hEPowJqKKvlzb3PX0YU7vRjKqkKfz4NAZyi5YHs/zBI/vyqI/vnCU/AoPAydv
         q6268Cm7wpgreZRLDDPXf15yYj1ro0ey0y51kkayQjHUCbV+/jWm+plm2QUnlxC9R0
         y4Z7Dj+dsM0Gg==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: I have gone and done a bad thing - malformed tree objects
Date:   Tue, 28 Jul 2020 20:47:18 -0400
Organization: PD Inc
Message-ID: <19ca801d66541$cf872af0$6e9580d0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZlQK4rfZOIwUqOQYm/XSobNdylag==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was trying to "do stuff" using hash-object -t tree --stdin -w, but I =
accidentally created trees where other trees were marked as blobs. They =
were dangling and not connected to any actual commits on my branches.

After gc and fsck clean ups, everything reports well...

Except:

$ GIT_TRACE=3D1 git cat-file --batch-all-objects --batch=3Dobjecttype
20:41:33.323399 git.c:442               trace: built-in: git cat-file =
--batch-all-objects --batch=3Dobjecttype
objecttype
fatal: object 00009623a06b8dea7c151542fc789539599c07d0 changed type!?

Where to start on this? I think the unused malformed tree referring to =
that object got put in to a pack. No idea how to find the malformed =
tree's id.

For that fact, cat-file views the object properly:

$ git cat-file -p 00009623a06b8dea7c151542fc789539599c07d0
100644 blob e465d57c345e2dcb117b5a30f9272b7fc5ec77cd    =
.p-truncated-names-because-they-are-not-needed-in-this-email
100755 blob 7f16c1d4cbb75cf7bd635970a2588ced6ccea8ad    Ap
040000 tree 5261c0a3f3b4c688a082c3c5eaf03f8039bf153c    CA
100644 blob 188c0d0541523016352b6851e0f7200c18a372e6    CM
100644 blob c8b040ec356b21fcc06911c544149dc6f5d5b861    CM
100644 blob e441983f0fd4d57fb7bf640de31f728529f12c29    CM
100644 blob fd06c9c6ad662e099341f4e0a05b272c6370e64b    CM
100644 blob d433fb05ebca807f4487ae4cecf48ec3b66cce78    CM
100755 blob 4b1b049b83bcc7821a7b62977124bfcaa024d960    CM
040000 tree 150d60813c913ec9a178c4230b18fbda84edc2af    RE
100644 blob ec54be851b811bff55a2034886a683969ef39880    ac
040000 tree f541fe035a345b5b3fcf84c83c64135899adadda    ad
040000 tree 80f08d7c97c88da471495a7e93e1466a737a7d29    au
040000 tree 7130737ca26ee3f1ac7d437bd8123d024c1cbfeb    cf
100755 blob 9637152c0a45a7ea716c5c05a7a3a68e2f655bc2    cm
100755 blob bde5db875d0c5d2bc6874ac62bff026bafd91914    co
100755 blob 308678b6e4f4aec8c03c6ced43750c84f8a0659d    cr
040000 tree 1657e8a77ed7430e4845b60cc1e1fb277b385d8a    da
100644 blob ed2eb8b686d008b895c52ddfca2ef2692174a722    de
100755 blob 6fe10b9f4d0df0d0c357b7ddee56e5612143c6b9    de
040000 tree 58a3cb399b25cf54f3ec92d52b79e3f081614d68    de
100755 blob f09ba30b1d5be4015dbcd8e8cec37449fae504e1    er
040000 tree 951642bc2f183e984e1879eab68f3414c16e535a    fa
100755 blob 5b796b1747de423f1fb81f976c860f50c3b1d02a    fi
100755 blob c2074af9676af85beb9f08bb1a5339b14d6ee485    ge
100755 blob 22ca54226a6c8e2bb2c9eb6d0db1731553e4b5ae    gl
100755 blob 57060dc44448e5b6c14a0df59bf81050a8464472    he
040000 tree af5e7c654837923730d15cc051f843d42ef84b56    hr
040000 tree 0a0f5e8c1b2968d516b501f7995d6e85897b26ab    im
040000 tree 6abe0be44fad7a58c0035010137431d9c581aabc    in
100755 blob 156ee5024cd8fb361552e873b843a8d90b861fb6    in
100644 blob 3371f55d5057ea4f4d29eae0184dfe17ca2919ff    jb
040000 tree eef927bf134d3c3777e7c02f6e81f3de06be0bdc    li
100755 blob 8d0cfbb604a92c2b24b9761efc5320f851c96ac6    lo
100755 blob 25efc4fd596e651d22c4bfdd8d694acefb5aa004    lo
100755 blob 92b3f44a17c12485923cf0143938c6f2490bced9    lo
100755 blob af171c4a7b37c1763d05275ddeeb994fd6ec5d01    ma
100755 blob 4047be1da363bf55fa9773218665f723d4d9941d    mc
100755 blob 0a28fb9de61bb5fb9de7876514dabbbc35b8d444    me
040000 tree b9b374e4925ece4b5781ef70c6590fab8a85b0f5    mi
100755 blob 6bb288db5b11856ea79577b52d57bf8b0c8ea422    po
040000 tree 2e18b952c4c796afdcdf4d41230c2e8a4212a8b9    re
040000 tree 002c945c849e2b976ae193481ad299181322663f    re
040000 tree 40dd932e877ad3aee47628277d9e75c53284dea5    re
100755 blob ea520d8ccda4207e732c3549d4c18d1ae0e6136b    sc
040000 tree 9a7014ee2249be58fd79bbb1a76f8ef94ef1af8e    sc
100644 blob dfbbb48c461b7739c211ae84a7b1355a03a0bd5e    se
040000 tree cdb9bdb60dc857cb04e707582852e700cc5c1d63    se
100755 blob 87542658ec3f45076443a278f7aac8cdcdc649cd    se
100755 blob bc50a5c1ba42b95abef98c31c36ad1c154b480b4    si
100644 blob 6e96fb004b88d5537bec9fcfeab581253886a61f    sq
100644 blob 6e96fb004b88d5537bec9fcfeab581253886a61f    sq
040000 tree a614f05126c49e0ad2c35243907d3d7300db85a2    te
040000 tree 1f7e4a51903a860fb4710060aa035beda35e18df    te
100755 blob ebb1a7029de2062a00b851463922560ed1a369ae    te
100644 blob e794743d0bf1c99b3ba211bdcf5d60e8261aa8f5    te
100644 blob da41b803b2a86c90417b3ed1f7fda1b9524fa897    te
100755 blob 43803c936c25f29895dc1c78a8f1ebcd10ab77b8    te
040000 tree 042ca993b1f44d4cd7abd846f669c9b0ee9d5545    tr
040000 tree de84b6f6c8a562a001a492efe640c43e158b2dd8    tr
100755 blob 90dbabed658c0cbf9f74eed9eff6da0ef6155464    un
100644 blob ebc83b2afb7bed3c360b7cc5da8750ab3038a2ee    vd
100644 blob 7c689ba4641860b103a6afda8dc2c0cc803eabdf    xl

Thanks in advance, and sorry for my silliness.

-Jason

