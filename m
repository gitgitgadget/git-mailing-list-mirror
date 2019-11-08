Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6804A1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 23:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfKHXls (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 18:41:48 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:35718 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfKHXls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 18:41:48 -0500
Received: by mail-il1-f172.google.com with SMTP id z12so6647847ilp.2
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 15:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=AmqCfaFb/975CcpQiPk6PvFNlVmFIbcIRuFnNi8ia8w=;
        b=OTgKT7ksJ9JhUdRiXbO+j6n1cnxxtJgPnMG7oJX+iXehMpGMM3S6CJx2N0P787M2I0
         ojEv1gIm2vAYP62L59aBWxRbuICg0AjWatp+yEpNWIIJzNZ+c5EFTRSWtN74GldC/WsX
         aD3j+/eyQZr2b/rmgtt2Sg72dixNXEUvoxfeDYiLJeBWwPfWEx3e1HmgjpIx4lWmjsSE
         Pl2LUANIasXJbVFw0086IVeJUHCF0byKBCBL4AVZoO9IOuMOyLFtz3S9l+MNYX1CHeNq
         3hpDc/Wog/SUzEoKwTQYfjIfttmZ/isX0Vak+1Nn/iWG8s22KMKCvuOS6F50oq25VHNr
         DHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AmqCfaFb/975CcpQiPk6PvFNlVmFIbcIRuFnNi8ia8w=;
        b=DWieHT65oJZ16WgquBXJ6pnLlZFYl0neTEehhtr+uxVltQk5pGS130MyrftHfqTDke
         1xp4DSYnPl8TM48+QhWHCnJtAOL8wA2l4VPm1rRPwClCt7zsSVpQdGxeXfcX+jwp4Z9T
         Y+XZUUK5ym4CgRyizA6PX3JnG6OfI07ZlDE6CQQ6Bc5nQ+XCIHYbi438TiSDdv43MfGc
         M50TMWaFcnXFVGbQtzSg3aVoAUvdbxHVjrJ8k02kfYkWY5hsFOuSw45tKCxIctlWkWiq
         fsgvJBZVnX4zev/RM2j7vBQ/e5V49G78VyNNtIype/3Mam39Kap2T1Xv20agaXeK4aUf
         IxOA==
X-Gm-Message-State: APjAAAW9Lm+Ozw76IOTviln2RoxD6KJVNBQxyMRzxcGRi8BKzy4lL0h4
        aEvxT/oDrmfAXOekylZ2w7d1rPCfw5wLIy8tVa1wfc5pB28=
X-Google-Smtp-Source: APXvYqwydGhjeTksJvveHBXiWP4CusOHbvul9jTIAr4IBSufPAmfqyJw+dpYG6Sm+BRZYUwPOwpb4oLaZ5S+IhQr1GI=
X-Received: by 2002:a92:db03:: with SMTP id b3mr6992740iln.109.1573256506886;
 Fri, 08 Nov 2019 15:41:46 -0800 (PST)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 8 Nov 2019 15:41:36 -0800
Message-ID: <CAGyf7-G3NDp--2nUbri_0EqvSLF21M0gsFCOKDCWMY+e68Htog@mail.gmail.com>
Subject: Split commit graphs and commit-graph read
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a quick question about a behavior I've noticed with the commit
graph. (Amazing feature, by the way!)

If the _very first_ write done is split:
git commit-graph write --reachable --split

You end up with something like this:
.../objects$ ls -R info
info:
commit-graphs  packs

info/commit-graphs:
commit-graph-chain  graph-6612fcc8fd04d3af2cc268a6bd9161ae40f5fcbf.graph

info/commit-graph doesn't exist, but I have a 1-graph "chain" in
place. (And subsequent write --split calls write additional ones; I've
got a few now in this repository, but still no info/commit-graph.)

git commit-graph verify seems happy:
.../objects$ git commit-graph verify
Verifying commits in commit graph: 100% (98768/98768), done.

But git commit-graph read isn't:
.../objects$ git commit-graph read
fatal: Could not open commit-graph
'/path/to/repository/objects/info/commit-graph': No such file or
directory

Running some tests with commands like git for-each-ref and git
rev-list shows that the "split" commit graph is being used (setting
core.commitGraph=false makes commands noticeably slower), so
functionally all seems well. But should git commit-graph read be
handling this better?

Best regards,
Bryan Turner
