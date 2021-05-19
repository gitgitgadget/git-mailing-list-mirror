Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE13C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 04:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D1861369
	for <git@archiver.kernel.org>; Wed, 19 May 2021 04:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhESECU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 00:02:20 -0400
Received: from smtp2.mail.cwp.pnp-hcl.com ([3.219.121.237]:55662 "EHLO
        smtp2.mail.pnp-hcl.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229379AbhESECR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 00:02:17 -0400
X-Greylist: delayed 880 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 00:02:17 EDT
X-ASG-Debug-ID: 1621395978-156ea86a5c034f0001-QuoKaX
Received: from mailhub1.domino.cwp.pnp-hcl.com (ip-10-134-103-34.ec2.internal [10.134.103.34]) by smtp2.mail.pnp-hcl.com with ESMTP id aN0Ox91Dp52z8mhs (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO) for <git@vger.kernel.org>; Tue, 18 May 2021 23:46:18 -0400 (EDT)
X-Barracuda-Envelope-From: greg.pflaum@pnp-hcl.com
X-Barracuda-RBL-Trusted-Forwarder: 10.134.103.34
To:     git@vger.kernel.org
MIME-Version: 1.0
Subject: [BUG] clone of large repo fails when server closes idle SSH session during
 "Resolving deltas"
X-KeepSent: 9ECB0D17:7C6A7258-852586DA:0014125E;
 type=4; name=$KeepSent
X-ASG-Orig-Subj: [BUG] clone of large repo fails when server closes idle SSH session during
 "Resolving deltas"
X-Mailer: HCL Notes Release 12.0 May 04, 2021
From:   Greg Pflaum <greg.pflaum@pnp-hcl.com>
Message-ID: <OF9ECB0D17.7C6A7258-ON852586DA.0014125E-852586DA.0014B7AB@pnp-hcl.com>
Date:   Tue, 18 May 2021 23:46:17 -0400
X-MIMETrack: Serialize by Router on Mailhub1/PNPHCL(Release 12.0|May 14, 2021) at 05/18/2021
 11:45:57 PM,
        Serialize complete at 05/18/2021 11:45:57 PM
Content-Type: text/plain; charset="US-ASCII"
X-Barracuda-Connect: ip-10-134-103-34.ec2.internal[10.134.103.34]
X-Barracuda-Start-Time: 1621395978
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://172.30.1.184:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at pnp-hcl.com
X-Barracuda-Scan-Msg-Size: 3057
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.90039
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's handling of the SSH session during "git clone" changed between Git
2.17.0 and 2.31.1, causing cloning of a large repo to fail when the server
closes the idle session during the "Resolving deltas" phase.

In the older version, git closes the SSH session after "Receiving objects"
and before "Resolving deltas". In the newer version, git doesn't close the
SSH session until after "Resolving deltas" finishes. In the newer version,
if "Resolving deltas" takes a long time (over 2 minutes for our large 
repo)
and the server closes the idle SSH session (60 seconds for our GitHub
Enterprise server), git displays the error message "Connection to
git.example.com closed by remote host", finishes resolving deltas, then 
exits
without checking out files.

Successful with Git 2.17.0:

> git clone git@git.example.com:org/bigrepo.git
Cloning into 'bigrepo'...
remote: Enumerating objects: 260, done.
remote: Counting objects: 100% (260/260), done.
remote: Compressing objects: 100% (170/170), done.
remote: Total 361839 (delta 74), reused 174 (delta 37), pack-reused 361579
Receiving objects: 100% (361839/361839), 4.47 GiB | 36.71 MiB/s, done.
Resolving deltas: 100% (252249/252249), done.
Checking out files: 100% (59466/59466), done.

Fails with Git 2.31.1:

git clone git@git.example.com:org/bigrepo.git
Cloning into 'bigrepo'...
remote: Enumerating objects: 363, done.
remote: Counting objects: 100% (363/363), done.
remote: Compressing objects: 100% (221/221), done.
Receiving objects: 100% (361930/361930), 4.47 GiB | 36.37 MiB/s, done.
RConnection to git.example.com closed by remote host.esolving deltas:  39% 
(98729/252244)
Resolving deltas: 100% (252244/252244), done.

What did you do before the bug happened? (Steps to reproduce your issue)

Ran "git clone git@git.example.com:org/bigrepo.git"

What did you expect to happen? (Expected behavior)

Expected successful creation of a cloned repo.

What happened instead? (Actual behavior)

Repo was partially created, but files were not checked out. Branches and 
tags
also seem to be missing from the repo.

What's different between what you expected and what actually happened?

With the old Git version, cloning the repo is successful. With the newer
version it fails.

Anything else you want to add:

A workaround is to configure the SSH client to prevent the server from
seeing an idle session, by adding these lines to .ssh/config:

Host git.example.com
    # Send keep-alive message to server every 30 seconds
    # so the server won't close an idle session.
    ServerAliveInterval 30


[System Info]
git version:
git version 2.31.1.windows.1
cpu: x86_64
built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 14393
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show

