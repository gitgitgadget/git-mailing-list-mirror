Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F4C433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 16:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiDQQ5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiDQQ4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:53 -0400
X-Greylist: delayed 2045 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Apr 2022 09:54:12 PDT
Received: from ita.aagh.net (ita.aagh.net [IPv6:2a03:9800:10:11::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3088436B42
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aagh.net;
        s=ita; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZkN9OekJeVSINvS0KD2hxV2jDbChLNZvsQtEaUQv9WQ=; b=ZsL4Eq0T6ozoQBY32NBOz0sziz
        ijSDyr8Wd2KcEVsRAmBuOkc0lhUIFVhallK2gTmOk1qUfqJvr8QqNFQyxO8NUonGxK0e2WsdEvDIH
        hooOtNubwmkOxT6eHG43kOb0yw/P6OHbyscegDaFsd621AVwjfp/OdTc20Vi3t4rODEdCXLcx+iGE
        NMQmdvUqzWsofj1GCfTIhUOn6j0FvCAaVCwbs/0pgmyrj4rgjujgGn0XKp2rsF7iu/LTo/kKGz3dr
        4YrhKPhlu4x/Rr4sykdmlj7VIDmAtacHDh8JPYokQXTvwvUuDtiy/uhi5dDJceG4frtcc60x7A3t8
        +0bJ1jmV6YcRD0bNEJw7KYMsM95hSEX/EMagolQiuhFdc59ZEVOklhx/jz5KeEsecPEKQ34bwqwHO
        4YzjejW66piOHPWSOTQBQ9TksCEbV3HW9a0HrNVPXYbmC5aFqlgR9OOvgzEE9inWhB1gTLPHj8Zyy
        FQS1rwPZvQH5+Ewrljb19SAkvtYGqDPFMG7tQdjA+WEZXY8FRNcOpf+7oCA5zLYf0EL1FDG3/UNFM
        GFADCyVrdzG1+Ks+0vnooEhoXjx7h/o/ieiuvBkSPbMHfLcN2rH+zoVVAGMbKV7GuT9oD+Ea9qCp3
        5nbw20lBCc82sXnh039POu0j0g3a2F0k3u6OCC1sg=;
Received: from [10.0.0.1] (helo=voi.aagh.net ident=mailnull)
        by ita.aagh.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95 (FreeBSD))
        (envelope-from <tom@hur.st>)
        id 1ng7d5-000EPR-KZ;
        Sun, 17 Apr 2022 16:20:03 +0000
Received: from freaky by voi.aagh.net with local (Exim 4.95 (FreeBSD))
        (envelope-from <tom@hur.st>)
        id 1ng7d5-000FXe-8Q;
        Sun, 17 Apr 2022 16:20:03 +0000
Date:   Sun, 17 Apr 2022 16:20:03 +0000
From:   Thomas Hurst <tom@hur.st>
To:     git@vger.kernel.org
Subject: Corrupt name-rev output
Message-ID: <Ylw+M5wwUYKcLM+M@voi.aagh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.2 (2022-03-25)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've noticed a series of about 20 commits in the HardenedBSD repository
fairly reliably produce garbage names from git name-rev - usually
fragments of another commit, sometimes unprintable nonsense.  Sometimes
it works just fine...

Here's a quick demo showing how to reproduce the problem:

% uname -mrs
FreeBSD 13.0-RELEASE-p11 amd64
% git --version
git version 2.35.2
% git clone --bare --mirror https://github.com/HardenedBSD/hardenedBSD.git
% cd hardenedBSD.git
% git rev-list --branches=\* |
  git name-rev --stdin --refs=heads/\* |
  egrep -v '^[0-9a-f]{40}( \([a-zA-Z0-9_/.^~-]+\))?$'
3eb67b534cab6a78b44b13e4323fd60353003089 (y:    marcel
MFC after:      3 days
Relnotes:       yes
Sponsored by:   ScaleEngine Inc.
Differential Revision:  https://reviews.freebsd.org/D3065
~3)
3ac660fc0c6eb0f876972e7e415c89f1ebed1939 (y:    marcel
MFC after:      3 days
Relnotes:       yes
Sponsored by:   ScaleEngine Inc.
Differential Revision:  https://reviews.freebsd.org/D3065
~4)
<continues>

Here's the result of another run, which includes all the affected
hashes - the name here presumably also has some non-printable garbage
not shown:

3eb67b534cab6a78b44b13e4323fd60353003089 (H~3)
3ac660fc0c6eb0f876972e7e415c89f1ebed1939 (H~4)
888a2df901616fb2900279c75580de3d4bc93278 (H~5)
58b9ad4f2e737ff922ff49ae564a32ee94c0ff6b (H~6)
59181d461b8d8c45144dc1856fa94da8a197b2ee (H~7)
9dd8627f2d53008b73ed93f92b71e24e8e319d93 (H~8)
3e1340e9928c7398551d3192a08acb678defc75e (H~9)
6ed06b88b912202db5b9d28b281ddbf4a1b0652a (H~10)
03b1b642f686502c128ac78ccf9dba7605f2aedf (H~11)
e7861fb764975a2c5f2f558b0800656679959624 (H~12)
4c28d4a51469dbb69bac67ec3b1c3a3d114ddf80 (H~13)
9ad0ed2485e40adce13b3900230640db66a38311 (H~14)
88dbdc409320e2785be4b1fcf0392999e3ab4374 (H~15)
c09997f49b7ca54f8d7305be57a037a294c32780 (H~16)
1f95262a4cda63a14016278f8ccc42c217858c36 (H~17)
50fec7a08d222bfd97499afa1c4000322c2280ff (H~18)
df3a215e38869117f8297e0910e08ae95eea5a59 (H~19)
cc81f4cf69d01cfc329827dbbc44da219bdddc05 (H~20)
5a7f7f242655f04a42e152d2c2f45819e9de4376 (H~21)
39cb585f2d4d4db10a282b06d9f7a9f07b658804 (H~22)
1264cc1d38cb1f1f03e34e395b33011108945638 (H~23)
98883cdf600f4aa3d5aba1d60248000132b6ad58 (H~24)
541df39729d32a70ba4da5184a8e82aaa3c87ae5 (H~25)
288fdc199a6936caab9d89d7deeb9b2bcf3b1f68 (H~26)

Passing these commits into name-rev as arguments finds them under
hardened/current/relro~199^2

git fsck --full does not reveal or fix anything, and the problem also
persists with a build from source from the next branch.

I was unable to reproduce on an Ubuntu machine with 2.32.0, so I used
that as a starting point for bisection and landed here:

  3656f842789d25d75da41c6c029470052a573b54
  name-rev: prefer shorter names over following merges

-- 
Thomas 'Freaky' Hurst
    http://hur.st/
