Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7651B1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 11:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFNLCN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 07:02:13 -0400
Received: from codesynthesis.com ([142.44.161.217]:47684 "EHLO
        codesynthesis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfFNLCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 07:02:12 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 07:02:11 EDT
Received: from [10.5.0.1] (unknown [178.219.147.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 3047A5F4D6;
        Fri, 14 Jun 2019 10:54:19 +0000 (UTC)
From:   Karen Arutyunov <karen@codesynthesis.com>
Subject: advertised commit fetch using commit id fails
Organization: Code Synthesis
To:     git@vger.kernel.org
Message-ID: <38030a81-73bc-f877-362a-3fd8018b5977@codesynthesis.com>
Date:   Fri, 14 Jun 2019 13:54:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

git 2.22, in contrast to previous versions, fails to fetch advertised 
commit using commit id:

$ git --version
git version 2.22.0

$ git init git
$ git -C git remote add origin https://github.com/git/git

$ git ls-remote https://github.com/git/git | grep v2.21
2bb64867dc05d9a8432488ddc1d22a194cee4d31	refs/tags/v2.21.0
8104ec994ea3849a968b4667d072fedd1e688642	refs/tags/v2.21.0^{}
e4be0477c7bd475c863a361d7d8aeaeab621606c	refs/tags/v2.21.0-rc0
d62dad7a7dca3f6a65162bf0e52cdf6927958e78	refs/tags/v2.21.0-rc0^{}
8b301c10ed2bc973cec4f8395dec90fce2df42fb	refs/tags/v2.21.0-rc1
8989e1950a845ceeb186d490321a4f917ca4de47	refs/tags/v2.21.0-rc1^{}
1c668b7b88be5f46f8dc8fe403842cdc663185d9	refs/tags/v2.21.0-rc2
35ee755a8c43bcb3c2786522d423f006c23d32df	refs/tags/v2.21.0-rc2^{}

$ git -C git fetch origin 8104ec994ea3849a968b4667d072fedd1e688642
error: Server does not allow request for unadvertised object 
8104ec994ea3849a968b4667d072fedd1e688642


Fetching using tag id still works:

$ git -C git fetch origin 2bb64867dc05d9a8432488ddc1d22a194cee4d31
remote: Enumerating objects: 255575, done.
remote: Total 255575 (delta 0), reused 0 (delta 0), pack-reused 255575
Receiving objects: 100% (255575/255575), 107.95 MiB | 2.34 MiB/s, done.
Resolving deltas: 100% (190845/190845), done.
 From https://github.com/git/git
  * branch            2bb64867dc05d9a8432488ddc1d22a194cee4d31 -> FETCH_HEAD


Fetching using commit id that is a tip of some branch works also:

$ git ls-remote https://github.com/git/git | grep 
b697d92f56511e804b8ba20ccbe7bdc85dc66810
b697d92f56511e804b8ba20ccbe7bdc85dc66810	refs/heads/maint
b697d92f56511e804b8ba20ccbe7bdc85dc66810	refs/tags/v2.22.0^{}

$ git -C git fetch origin b697d92f56511e804b8ba20ccbe7bdc85dc66810
remote: Enumerating objects: 260471, done.
remote: Total 260471 (delta 0), reused 0 (delta 0), pack-reused 260471
Receiving objects: 100% (260471/260471), 112.66 MiB | 2.33 MiB/s, done.
Resolving deltas: 100% (194715/194715), done.
 From https://github.com/git/git
  * branch            b697d92f56511e804b8ba20ccbe7bdc85dc66810 -> FETCH_HEAD


Note that the git version at the tip of the master branch 
(2.22.0.68.g0aae918dd9) behaves the same way.


git 2.21 fetches fine:

$ git --version
git version 2.21.0

$ git -C git fetch origin 8104ec994ea3849a968b4667d072fedd1e688642
remote: Enumerating objects: 255574, done.
remote: Total 255574 (delta 0), reused 0 (delta 0), pack-reused 255574
Receiving objects: 100% (255574/255574), 107.95 MiB | 2.15 MiB/s, done.
Resolving deltas: 100% (190845/190845), done.
 From https://github.com/git/git
  * branch            8104ec994ea3849a968b4667d072fedd1e688642 -> FETCH_HEAD


Is it a bug or advertised object semantics change?

Best regards,
Karen
