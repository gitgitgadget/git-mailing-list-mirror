Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4F11F405
	for <e@80x24.org>; Fri, 21 Dec 2018 12:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbeLUMqm (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 07:46:42 -0500
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:22076
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388162AbeLUMqm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Dec 2018 07:46:42 -0500
X-Greylist: delayed 4347 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 07:46:41 EST
X-Sender-Id: s0seqk11zu|x-authuser|mrhmain@markhughes.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BBD3D6829E8
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 12:46:40 +0000 (UTC)
Received: from libra.thewebhostserver.com (unknown [100.96.20.98])
        (Authenticated sender: s0seqk11zu)
        by relay.mailchannels.net (Postfix) with ESMTPA id 38BBE682BA6
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 12:46:40 +0000 (UTC)
X-Sender-Id: s0seqk11zu|x-authuser|mrhmain@markhughes.com
Received: from libra.thewebhostserver.com (libra.thewebhostserver.com
 [185.38.44.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.16.2);
        Fri, 21 Dec 2018 12:46:40 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: s0seqk11zu|x-authuser|mrhmain@markhughes.com
X-MailChannels-Auth-Id: s0seqk11zu
X-Glossy-Interest: 6670bdc705849efb_1545396400585_1742503164
X-MC-Loop-Signature: 1545396400585:574580426
X-MC-Ingress-Time: 1545396400584
Received: from [185.16.85.134] (port=33340 helo=[10.99.22.221])
        by libra.thewebhostserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <git-mailinglist@happybeing.com>)
        id 1gaKCJ-0008yd-MM
        for git@vger.kernel.org; Fri, 21 Dec 2018 12:46:35 +0000
From:   git-mailinglist@happybeing.com
Openpgp: preference=signencrypt
To:     git@vger.kernel.org
Subject: Does "git push" open a pack for read before closing it?
Message-ID: <5878633d-cdbd-ce05-30de-3417386c720e@happybeing.com>
Date:   Fri, 21 Dec 2018 12:46:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-thewebhostserver-MailScanner-Information: Please contact the ISP for more information
X-thewebhostserver-MailScanner-ID: 1gaKCJ-0008yd-MM
X-thewebhostserver-MailScanner: Found to be clean
X-thewebhostserver-MailScanner-SpamCheck: 
X-thewebhostserver-MailScanner-From: git-mailinglist@happybeing.com
X-AuthUser: mrhmain@markhughes.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Major ignorance alert]

I'm writing software to implement a FUSE mount for a decentralised file
system and during testing with git I see some strange behaviour which
I'd like to investigate. It might be a bug in my code, or even the FUSE
lib I'm using, or it might be intended behaviour by git.

So one thing I'd like to do is check if this is expected in git.

SYSTEM
OS: Ubuntu 18.10
git version 2.19.1
Decentralised storage mounted at ~/SAFE

What I'm doing
I'm testing my FUSE implementation for SAFE Network while exploring the
use of git with decentralised storage, so not necessarily in a sensible
arrangement (comments on that also welcome).

I have a folder at ~/SAFE/_public/tests/data1/ and want to create a bare
repo there to use as a remote from my local drive for an existing git
repo at ~/src/safe/sjs.git

Anyway, I do the following sequence of commands which are all fine up
until the last one which eventually fails:

  cd ~/SAFE/_public/tests/data1
  git init --bare blah
  cd ~/src/safe/sjs.git
  git remote remove origin
  git remote add origin ~/SAFE/_public/tests/data1/blah
  git push origin master

Here's the output from the last command above:

Enumerating objects: 373, done.
Counting objects: 100% (373/373), done.
Delta compression using up to 8 threads
Compressing objects: 100% (371/371), done.
Writing objects: 100% (373/373), 187.96 KiB | 33.00 KiB/s, done.
Total 373 (delta 254), reused 0 (delta 0)
remote: fatal: unable to open
/home/mrh/SAFE/_public/tests/data1/blah/./objects/incoming-73lbb6/pack/tmp_pack_pL28kQ:
Remote I/O error
error: remote unpack failed: index-pack abnormal exit
To /home/mrh/SAFE/_public/tests/data1/blah
 ! [remote rejected] master -> master (unpacker error)
error: failed to push some refs to '/home/mrh/SAFE/_public/tests/data1/blah'

Inspecting the logs from my FUSE implementation I see that there's a
problem related to this file on the mounted storage:

 /_public/tests/data1/blah/objects/incoming-73lbb6/pack/tmp_pack_pL28kQ

Prior to the error the file is written to multiple times by git - all
good (about 200kB in all). Then, before the file is closed I see an
attempt to open it for read, which fails. The failure is because I don't
support read on a file that is open for write yet, and I'm not sure if
that is sensible or what git might be expecting to do given the file has
not even been flushed to disk at this point.

So I'd like to know if this is expected behaviour by git (or where to
look to find out), and if it is expected, then what might git expect to
do if the file were opened successfully?

N.B. After the failure, the file is closed and then deleted!

Also note that it is possible the behaviour I'm seeing is not really git
but another issue, such as a bug in the sync/async aspect of my code.

Thanks

Mark
-- 
Secure Access For Everyone:
- SAFE Network
- First Autonomous Decentralised Internet
https://safenetwork.tech

