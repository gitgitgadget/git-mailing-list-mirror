Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64C220133
	for <e@80x24.org>; Sat,  4 Mar 2017 00:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbdCDALK (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 19:11:10 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55212 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751963AbdCDALI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2017 19:11:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0FEEF20BB0
        for <git@vger.kernel.org>; Fri,  3 Mar 2017 19:10:07 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 03 Mar 2017 19:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=mplew.is; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=RHFVDAOCBuL5iHYiQXEvOeWKtys=; b=gsR/M6
        os39LKeSiQi4W21ek/kJX5ThBPYI1U0mhToPrCbpAHiQ9EiOvdD+dPlGitHsuw/s
        R1HVzEougB1NT6GUES0eNH8DdbSNWXP7SSE3AlEMglMIWSM1hj3emOq3nGI2ItDs
        OC2Fn4s3jZQxc1ca8mYp/IbVPP97b5jW/Uqj4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=RHFVDAOCBuL5iH
        YiQXEvOeWKtys=; b=fsx5xnmxChbH5+RnT584HMpxeehlQmhhbWaTm0WCkWL1df
        Q5tCcEvifOO1VYnr5SmCmCwnFLh4rlGRGA/FTdAs2MJwbkba8qjyWMDUus3u1NQp
        6GkS/xA/ixWlEzZ1gAIgHGgjvKwUDvRplUJoh5mmLIjWolxj3Uo1jdr6dV06o=
X-ME-Sender: <xms:3wW6WIuNio7LPuP8YPCG1r8BNvuLMAWe6qsjhjkcXch8YNUlNEEiiw>
X-Sasl-enc: Be5CHc5JMjWh7Jf/aO0XQSLdSrprvdChqwnklVQrp80H 1488586206
Received: from [10.0.17.241] (unknown [64.238.189.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id B4D4F24462
        for <git@vger.kernel.org>; Fri,  3 Mar 2017 19:10:06 -0500 (EST)
From:   Mike Lewis <mike@mplew.is>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Server-side hooks on non-bare repository
Message-Id: <719CE082-14AB-4E18-AE7D-7D2A818CF499@mplew.is>
Date:   Fri, 3 Mar 2017 19:10:05 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I=E2=80=99m having some issues with using server-side hooks when pushing =
to a non-bare repository. In my git config, I have =
`receive.denyCurrentBranch` set to `updateInstead`, which behaves as =
expected, and updates the current working tree when the current branch =
is pushed to. However, attempting to process those changes with =
pre-receive and post-receive hooks results in some unexpected behavior =
regarding the current working directory of the scripts and using git =
commands. I=E2=80=99ve tested these issues using both git 2.11 and 2.12 =
on various systems (macOS and CentOS), and get the same behavior each =
time.

Essentially, my problem boils down to two things:

1. When using a non-bare repository, I would expect the the working =
directory of the hook to be the root directory of the working tree, as =
this mirrors the behavior of =E2=80=9Cclient=E2=80=9D-side hooks like =
pre-commit. Instead, the working directory is set to the .git directory. =
That in and of itself is not a huge deal, but it leads into #2:

2. While running the hooks, git treats the repository as being bare, =
regardless of whether it actually is. For instance, changing the working =
directory of the scripts to the actual root of the working tree and =
attempting to run any git commands (for instance, `git rev-parse =
--abbrev-ref HEAD` to get the current branch name) results in "fatal: =
Not a git repository: =E2=80=98.=E2=80=99=E2=80=9D being returned to the =
client-side `git push` command. I=E2=80=99ve found a workaround to this, =
which is to explicitly set the =E2=80=9CGIT_DIR=E2=80=9D to the .git =
directory, and make sure that is passed to any external scripts as well. =
However, this is very unintuitive behavior, as the working tree is still =
there and either unmodified or done being updated, depending on which =
hook is being called. At the very least, this behavior should be in the =
documentation somewhere so that users can write their hooks accordingly.

TL;DR: it seems that server-side hooks don=E2=80=99t account for the =
repository being non-bare, which is no longer a valid assumption with =
the `receive.denyCurrentBranch=3DupdateInstead` configuration value =
introduced in 2.3.0.

Thanks, and I=E2=80=99d be happy to provide any other information that =
anyone needs to take a look at this.

Mike Lewis

