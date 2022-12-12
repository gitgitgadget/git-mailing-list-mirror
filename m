Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37287C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 11:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiLLLkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 06:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiLLLkR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 06:40:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF64559D
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 03:35:30 -0800 (PST)
Received: from localhost (unknown [86.123.78.117])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63CC2660159C
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 11:35:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670844928;
        bh=p9tBDdWH/l5ewDRL2ut0BozfCAEMi/AHce1BylwBbF0=;
        h=From:To:Subject:Date:From;
        b=gdrzuResy+f8GFAkAZSqf4bCcXjxlbiOsEJx4jQDylSpnU6fNkWtn5E1jiApsMp9K
         fVJ3CXkHx0Js+nMHmJG6Oe6Y9EfUmB3LrPf74xxqxuYGF7u+38jn3aM4QZDoIcAT6g
         yVV0m5EhRgg+VZLjLvs7H7M4JWJ+yUPMqyXkTl2P/kdpPDeBAszVcvfpUVon+errSF
         Q0LWY7I6L8RgSzL+cqgqtlK10YRhuHKx2AUrSQMRsS8wpKHMs3KqNztUvpOT70EvYi
         ZxzSzKqLAGJ40LRKtbdrwXaNF/+GKIVoUfKdUNZ5HAwKwg3GS6ugioOozlT2blNG8K
         +6uP7v0Na1yUQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/1] rebase --onto detection of already applied commits
Date:   Mon, 12 Dec 2022 13:35:15 +0200
Message-Id: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's consider the following operation:

  git rebase --onto new-base upstream feature

where 'feature' contains a few commits on top of 'upstream' which need to be
rebased onto 'new-base'.

The problem is that some of those commits have been already applied to
'new-base' and we would like to skip them as in a regular rebase command that
doesn't use '--onto', i.e. expecting to see messages like:

  warning: skipped previously applied commit [...]

However, that doesn't happen and we either get

  dropping [...] -- patch contents already upstream

or a conflict if one of the rebased commits doesn't resolve to an empty patch
anymore, e.g. due to additional changes applied on the target branch. 

This seems to be similar to the behavior of '--reapply-cherry-picks' and cannot
be disabled via '--no-reapply-cherry-picks' or by any other means.

The proposed patch is just a quick workaround, as I'm not sure what would be the
proper or recommended approach to handle the scenario described. Any advice
would be highly appreciated!

Cristian Ciocaltea (1):
  rebase --onto: Skip previously applied commits

 builtin/rebase.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.38.1

