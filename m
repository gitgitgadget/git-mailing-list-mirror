Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DCDC433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 10:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiBGKhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 05:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbiBGKZf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 05:25:35 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D61DC043181
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 02:25:34 -0800 (PST)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2179vUVG034108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 7 Feb 2022 04:57:31 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Possible Bug] sparse-checkout disable followed by re-init
Date:   Mon, 7 Feb 2022 04:57:26 -0500
Organization: Nexbridge Inc.
Message-ID: <047901d81c09$1fc30eb0$5f492c10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdgcBmHBE1C9+bwHR6qlHeEtR44BpA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I noticed a change at 2.35.1 regarding sparse-checkout and am wondering
whether I am just missing something:

1. Create upstream.
2. Clone with --no-checkout --depth=1 --filter=blob:none
3. sparse-checkout init
4. sparse-checkout set, with a pattern
5. sparse-checkout list
6. checkout master
7. sparse-checkout reapply
8. sparse-checkout add (up to here, everything is fine, the working area is
consistent with the sparsity patterns)
9. sparse-checkout disable (the disable works - I think)
10. sparse-checkout list reports fatal: this worktree is not sparse, which
is new in 2.35.1. In 2.34.1, the sparse patterns are reported without error.
I think this is incorrect behaviour because the sparse patterns are still
configured.
Then I try to recover
11. sparse-checkout init (seems to work - no errors)
12. sparse-checkout list (correctly reports what was previously set/add)
13. sparse-checkout reapply (does nothing apparent - the objects that added
to the working area during the disable are still there. My assumption was
that the files not matching the sparsity patterns would be pruned).

The .git/config is:
[core]
        repositoryformatversion = 1
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = file:///home/randall/stuff/src.git
        fetch = +refs/heads/master:refs/remotes/origin/master
        promisor = true
        partialclonefilter = blob:none
[branch "master"]
        remote = origin
        merge = refs/heads/master
[extensions]
        worktreeConfig = true

My question is, from this point, is there a way to recover the sparsity of
the working index (which I expect), or do I have to clone again (not
desirable). This seems like a functional change. What is weird to me is that
I did not expect a worktreeConfig=true in this situation.

Thanks,
Randall



