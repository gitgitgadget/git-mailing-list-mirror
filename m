Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D811F803
	for <e@80x24.org>; Mon,  7 Jan 2019 15:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfAGP4y (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 10:56:54 -0500
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:64825
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbfAGP4y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Jan 2019 10:56:54 -0500
X-Sender-Id: s0seqk11zu|x-authuser|mrhmain@markhughes.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C6415436B3;
        Mon,  7 Jan 2019 15:56:52 +0000 (UTC)
Received: from libra.thewebhostserver.com (unknown [100.96.20.98])
        (Authenticated sender: s0seqk11zu)
        by relay.mailchannels.net (Postfix) with ESMTPA id 19C9543D6B;
        Mon,  7 Jan 2019 15:56:51 +0000 (UTC)
X-Sender-Id: s0seqk11zu|x-authuser|mrhmain@markhughes.com
Received: from libra.thewebhostserver.com (libra.thewebhostserver.com
 [185.38.44.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.16.2);
        Mon, 07 Jan 2019 15:56:52 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: s0seqk11zu|x-authuser|mrhmain@markhughes.com
X-MailChannels-Auth-Id: s0seqk11zu
X-Name-Decisive: 3311d4ab491870ea_1546876612661_964165162
X-MC-Loop-Signature: 1546876612660:2792019657
X-MC-Ingress-Time: 1546876612660
Received: from [185.16.85.134] (port=42804 helo=[10.99.22.221])
        by libra.thewebhostserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <git-mailinglist@happybeing.com>)
        id 1ggXGj-000ict-Nd; Mon, 07 Jan 2019 15:56:49 +0000
Subject: Re: Does "git push" open a pack for read before closing it?
To:     git@vger.kernel.org
References: <5878633d-cdbd-ce05-30de-3417386c720e@happybeing.com>
 <20181222231215.GC26554@genre.crustytoothpaste.net>
From:   git-mailinglist@happybeing.com
Openpgp: preference=signencrypt
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <151d357d-4234-bb86-9764-8057b28d7117@markhughes.com>
Date:   Mon, 7 Jan 2019 15:56:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181222231215.GC26554@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-thewebhostserver-MailScanner-Information: Please contact the ISP for more information
X-thewebhostserver-MailScanner-ID: 1ggXGj-000ict-Nd
X-thewebhostserver-MailScanner: Found to be clean
X-thewebhostserver-MailScanner-SpamCheck: 
X-thewebhostserver-MailScanner-From: git-mailinglist@happybeing.com
X-AuthUser: mrhmain@markhughes.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/2018 23:12, brian m. carlson wrote:
Thanks Brian, you helped me make some progress. I'm stuck again trying
to understand git behaviour though and wondering if there are better
ways of me seeing into git (source, debug o/p etc) than posting here.

As a reminder, I'm doing the following to create a bare repository on my
FUSE mounted decentralised storage:

  cd ~/SAFE/_public/tests/data1
  git init --bare blah
  cd ~/src/safe/sjs.git
  git remote remove origin
  git remote add origin ~/SAFE/_public/tests/data1/blah
  git push origin master

The bugs are in my implementation of FUSE on the SAFE storage.

I get additional output from git using the following (but it doesn't
help me):
 set -x; GIT_TRACE=2 GIT_CURL_VERBOSE=2 GIT_TRACE_PERFORMANCE=2 \
 GIT_TRACE_PACK_ACCESS=2 GIT_TRACE_PACKET=2 GIT_TRACE_PACKFILE=2 \
 GIT_TRACE_SETUP=2 GIT_TRACE_SHALLOW=2 git push origin master -v -v \
 2>&1 |tee ~/git-trace.log; set +x

Anyway, to add a little to your observations...

> What I expect is happening is that Git receives the objects and writes
> them to a temporary file (which you see in "objects/incoming") and then
> they're passed to either git unpack-objects or git index-pack, which
> then attempts to read it.
The git console output seems to confirm it is 'git index-pack' that
encounters the error, which is currently:

  Enumerating objects: 373, done.
  Counting objects: 100% (373/373), done.
  Delta compression using up to 8 threads
  Compressing objects: 100% (371/371), done.
  Writing objects: 100% (373/373), 192.43 KiB | 54.00 KiB/s, done.
  Total 373 (delta 255), reused 0 (delta 0)
  remote: fatal: premature end of pack file, 36 bytes missing
  remote: fatal: premature end of pack file, 65 bytes missing
  error: remote unpack failed: index-pack abnormal exit
  To /home/mrh/SAFE/_public/tests/data1/blah
   ! [remote rejected] master -> master (unpacker error)
  error: failed to push some refs to
'/home/mrh/SAFE/_public/tests/data/blah'

So I conclude I'm either not writing the file properly, or not reading
it back properly. I can continue looking into that of course, but
looking at the file requests I'm curious about what git is doing and how
to learn more about it as it looks odd.

I have quite a few questions, but will focus on just the point at which
it bails out. In summary, what I see is:

- The pack file is created and written with multiple calls, ending up
about 200k long.

- While still open for write, it is opened *four* times, so git has five
handles active on it. One write and four read.

- At this point I see the following FUSE read operation:

  read('/_public/tests/data1/blah/objects/incoming-quFPHB
        /pack/tmp_pack_E4ea92', 58, buf, 4096, 16384)

  58 is the file handle, 4096 the length of buf, and 16384 the position

- Presumably this is where git encounters a problem because it then
closes everything and cleans up the incoming directory.

It seems odd to me that it is starting to read the pack file at position
16384 rather than at 0 (or at 12 after the header). I can surmise it
might open it four times to speed access, but would expect to see it
read the beginning of the file (or at position 12) before trying to
interpret the content and bailing out.

So I'm wondering what git is doing there. Any comments on this, or a
pointer to the relevant git code so I can look myself would be great.

Thanks,

Mak
