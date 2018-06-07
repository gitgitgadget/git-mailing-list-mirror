Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B1F1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 15:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935569AbeFGP1O (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 11:27:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935504AbeFGP1M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 11:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8vfkYhagLmtvhDkq9jknO9ybcVkc9eMXcuHWj+L2pKA=; b=gBrnFC7ahqql2nhMJ79smbXCuD
        LDf+ODfGFMQwRo91hVClzq6leXJPx9kWn8P7LtUg6vQHWH/wKQBC6ThCEv2tWv1i6em2HDMPdRZPi
        j15sj27ZTR7ZbIkiKFewQkZiMb08A/wfsgIud7Fh0+vwiz1/1BJcd8ijfmKNEuCrk0k3ELL6et9Rk
        cPlUWusraAePcdXzHtHiY29X0l5yC2uYri0VHVCUoagfniTwowcI8y9yGxxdiyHRew97nc82NZaJW
        Q+xgOUANTWQrDPbyM0ZOgSzVSkCkr/ybhviiaTayazvDAxenNXimfCzXi5hTQAHsF7rW//aRf5k7W
        7eu433Tg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQwoi-0005Px-3u
        for git@vger.kernel.org; Thu, 07 Jun 2018 15:27:12 +0000
Date:   Thu, 7 Jun 2018 08:27:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     git@vger.kernel.org
Subject: git grep with leading inverted bracket expression
Message-ID: <20180607152711.GA27079@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


If the first atom of a regex is a bracket expression with an inverted range,
git grep is very slow.

$ time git grep 'struct_size' >/dev/null

real	0m0.368s
user	0m0.563s
sys	0m0.453s

$ time git grep '[^t]truct_size' >/dev/null

real	0m31.529s
user	1m54.909s
sys	0m0.805s

If the bracket expression is moved to even the second position in the string,
it runs much faster:

$ time git grep 's[^p]ruct_size' >/dev/null

real	0m3.989s
user	0m13.939s
sys	0m0.403s

It's pretty bad with even a '.' as the first character:

$ time git grep '.truct_size' >/dev/null

real	0m14.514s
user	0m52.624s
sys	0m0.598s

$ git --version
git version 2.17.1

Setting LANG=C improves matters by a factor of 3-4 (depending if you
count real or user time):

$ time git grep '[^t]truct_size' >/dev/null
real	0m10.035s
user	0m28.795s
sys	0m0.537s

(this is using something pretty close to Linus' current HEAD of the
linux repository, an i7-7500, 16GB memory).
