Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F66202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 13:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbdCONtE (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 09:49:04 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:44026 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753643AbdCONtA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Mar 2017 09:49:00 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1co9IQ-00085O-5Y; Wed, 15 Mar 2017 14:48:58 +0100
Subject: Re: Commiting files larger than 4 GB on Windows
To:     Florian Adamus <florian-adamus@gmx.de>, git@vger.kernel.org
References: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <179b5d92-ee96-c2df-dbd8-eb96f7bbdb24@virtuell-zuhause.de>
Date:   Wed, 15 Mar 2017 14:48:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <trinity-9f703269-6f73-4f6d-b90b-45e09e1c094c-1489582854278@3capp-gmx-bs66>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1489585740;afbff0b8;
X-HE-SMSGID: 1co9IQ-00085O-5Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.03.2017 um 14:00 schrieb Florian Adamus:
> Hello,
> 
> I am managing my large files with the git-lfs-extension. Some of them
> were more than 4GB in size. After deleting one of those files from my
> working tree and do a normal git checkout I ended up with a somehow
> crippled file with a size of only 46 MB left. For testing reasons I
> tried to commit a 4,3 GB file to my git repository without the LFS
> extension. After checking out a different branch and switching back
> to the branch with the large file, I ended up with the same small
> file as mentioned before. I already wrote a bug issues to Git for
> Windows and I was told that it is a problem with the git source code,
> which uses unsinged long, where it should use size_t. For more
> information on the issue you can check the issue tracker of Git for
> Windows on github. Issue #1063 Is there a way to fix this problem?

Hi,

I can not comment on the git-lfs issues. The issue that you can not properly use files larger than 4GB on windows (no matter if 32bit or 64bit) is known, see my findings from May last year [1]. Unfortunately nobody, including me, did find time to fix the underlying issue properly.

My band-aid patch from [1]

diff --git a/pack-write.c b/pack-write.c
index 33293ce..ebb8b0a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -313,6 +313,9 @@ int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned
        if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
                die("bad type %d", type);

+       if (bitsizeof(unsigned long) != bitsizeof(uintmax_t) && size > (unsigned long) size)
+               die("Cannot handle files this big");
+
        c = (type << 4) | (size & 15);
        size >>= 4;
        while (size) {

would at least tell the user much earlier about the problem. I can submit the above diff as proper patch if it is deemed a worthy change.

Thomas

[1]: http://public-inbox.org/git/56EF1402.4050708@virtuell-zuhause.de/  



