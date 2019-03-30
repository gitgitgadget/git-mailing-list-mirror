Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5451A20248
	for <e@80x24.org>; Sat, 30 Mar 2019 14:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfC3ONS (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 10:13:18 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:39080 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfC3ONS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 10:13:18 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id AEjSh6HwxgI7iAEjShNiw9; Sat, 30 Mar 2019 14:13:15 +0000
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=IkcTkHD0fZMA:10 a=w0RzvLSWAAAA:20
 a=aulWLQ49AAAA:20 a=52-Yb1kGAAAA:20 a=IoXxO10MqF6Dbp1GsckA:9
 a=QEXdDO2ut3YA:10 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
From:   Philip Oakley <philipoakley@iee.org>
Subject: test suite: why does git add large_file create a pack, rather than an
 object?
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Message-ID: <f0c838f0-2f75-2b05-1aeb-3db4743ce89a@iee.org>
Date:   Sat, 30 Mar 2019 14:13:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDfm6YHOMXQ1kyVXHxNccXO8prO0/4f6MBCuKApwF3CyyFezohbDi+nGkZqIKTGOuCI9wKhkLqEx+87YtvLFIjiju5Vr+DcmhDWl/10ogf0XqcrmA76O
 2ckXydY8NCItfOU9R5ZcLMb+YR/jFqPfYcgxfV9XUJ9IXz8z8rcarlKCY+fr+ogQ9Wvh2cLQMI22XP/XFzET9R4FtpRfVKpMUDlppgzRCM6TK1wsy4KlW0Lo
 B7BZpoYHm+hrlqu7OHEMoXRiUxN6V6kN3eXDW7WffJ1gQBSL3TEKZStEg8DHlS4RfKD7I0nuInbGNpc5Bcu4CA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm looking at the Git-for-Windows(GfW) >4Gb  large file problem 
following Torsten and Thomas's work (and others). [1,2,3, etc.]

I've added a few more changes to my branch [2] to get the zlib to 
properly count past its 32bit limit when wrapped in the git_inflate 
(etc) wrapper code. [4]

At the moment I'm using an extended _test_ case that starts by adding a 
~5.1Gb file and then using verify-pack, which aborts with an error.

         dd if=/dev/zero of=file bs=1M count=5100 &&
         git config core.compression 0 &&
         git config core.looseCompression 0 &&
         git add file &&
         git verify-pack -s .git/objects/pack/*.pack &&
         git fsck --verbose --strict --full &&
         ...

If however I simple execute the commands from the GfW bash, the added 
file is stored as a blob object, rather than a pack.

I'm at a loss to understand the reason for the change in behaviour 
[store file as pack, vs store as object] between running the code as a 
test script and at the terminal. What am I missing?

I have 'good' output from the test script on the WSL (and have 
identified the packs' specific byte differences), but my gdb experience 
is limited so executing that test while within the test script meant I 
couldn't start debugging there. Hence the direct execution from the 
terminal that raised the issue.

-- 

Philip
[1] <20190131203842.633ztr4yckn7kl2d@tb-raspi4>
[2] https://github.com/gitgitgadget/git/pull/115#issuecomment-4753008375
[3] https://github.com/git-for-windows/git/issues/1848
[4] https://github.com/PhilipOakley/git/tree/size_t2

