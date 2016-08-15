Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67111F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 19:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbcHOT6c (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 15:58:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34911 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbcHOT6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 15:58:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so12842585wmg.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 12:58:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TH4l5QCUq9n3I6BCOBA0NX+CZIR4d16JZDpCXiQ+yXI=;
        b=AK5ikFQ+axIHQO39sKg+zC2oucfc5vhSHqLw5yvq4jV6rfYXfwV6bI73WNAzca4TlQ
         gmhv1a4k4rRWMIEbI9s5ZIqSZ2LeGRX3kb39l7VbPBneXBLH045hp5Om4KE6WeKmlevd
         HC9ejhIKBN2rBfnzfHtkQRG3RKGz712rqxWWA8aloHv1pUtSvzq+hhggapkPk2Xztzeg
         VQVW1EigeEBrSbBgM225nMMu2IF/C0oiCX060BlwikYBOHAi6hnf28RPGkM2/Q3t5Btv
         FDLvSEj81EYIBpGLkpRrWZCjW7fLvNoyUggHvxxLPs7KgNQfQrfP+prs1ypCMJqp42Bf
         wLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TH4l5QCUq9n3I6BCOBA0NX+CZIR4d16JZDpCXiQ+yXI=;
        b=cY+pxkA4kkQLinqgIZZiwGRUSzirK+CN7msXL6G5eh+QYZ/C4Cq63Lv80hh50rZdao
         EUg1rO5cYFrROjtd3x4FexDcZXEHW3flZOupf1a/SWVtJQZVW0ho4k1LWJ3OvCMp4cE1
         EC93nvrGy2cwTPnd2jtdYP0JuLGKqkct2nZOkES/60QE6Vm5X6SNd6aHjaBTVKH/l0sq
         1fYLOXpUbkSuTZEvO65mygUPpSWd9p29L5ll6ocBfc2beOlu/y5tIcELdqYwdwa49g+C
         Iv8KHZv7WLuI1gmG2BybO7bzIFwrNu1lNbksPhlqu9qiReIGWvZZY1EEQZ0TDsu+7a5d
         U1/Q==
X-Gm-Message-State: AEkoouvHe6+hTMp2L9+P4jUCcLnjyL/0W0Eui2x0jiv8d/cHEvUKdim3ztEYF4UKRqR1Nw==
X-Received: by 10.195.2.42 with SMTP id bl10mr34918373wjd.21.1471291110549;
        Mon, 15 Aug 2016 12:58:30 -0700 (PDT)
Received: from localhost.localdomain ([80.215.5.33])
        by smtp.gmail.com with ESMTPSA id p1sm23065623wjd.37.2016.08.15.12.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 12:58:29 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 0/3] limit the size of the packs we receive
Date:	Mon, 15 Aug 2016 21:57:26 +0200
Message-Id: <20160815195729.16826-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.4.g229e32c.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In https://public-inbox.org/git/20150612182045.GA23698%40peff.net/,
Peff sent a patch that is used by GitHub to abort `git receive-pack`
when the size of the pack we receive is bigger than a configured
limit.

GitLab is interested in using the same approach and in standardizing
the error messages the user could get back.

So I rebased Peff's patch to the current master, refreshed it a bit,
split it, and added the missing --max-input-size=<size> option to
`git unpack-objects` - to make it work for all `transfer.unpacklimit`
values - in a new patch.

There is no documentation yet for the `--max-input-size=<size>`
options added to `git index-pack` and `git unpack-objects`, nor for
the new `receive.maxsize` config option.

I kept Peff as the author of the patches that are made mostly from his
patch, but I added my Signed-off-by to them.

Christian Couder (1):
  unpack-objects: add --max-input-size=<size> option

Jeff King (2):
  index-pack: add --max-input-size=<size> option
  receive-pack: allow a maximum input size to be specified

 builtin/index-pack.c     |  5 +++++
 builtin/receive-pack.c   | 12 ++++++++++++
 builtin/unpack-objects.c |  7 +++++++
 t/t5546-push-limits.sh   | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)
 create mode 100755 t/t5546-push-limits.sh

-- 
2.10.0.rc0.4.g229e32c.dirty

