Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1021F461
	for <e@80x24.org>; Sun, 21 Jul 2019 18:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGUSSA (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jul 2019 14:18:00 -0400
Received: from m12-13.163.com ([220.181.12.13]:32857 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfGUSSA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jul 2019 14:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qXojT
        GyRo5onlPitXOMGNr1GzG3lF6fV41QH79ByauY=; b=LDT1qQGiy6R2VmTzbePcz
        T8Rf1ZS13vszoFvfdEFq4U2AnY8hTLJElrrFpktLtK0exRiPQJex1Qo+fjOVJIP6
        gEYdESfMZ2Z8ZiOF4juPlfswJHwM8QqFRM5coB9sl3nx/dj7xq7iXVCbBBVYYex+
        qAeDtG/cZIL8t1XJncVhWY=
Received: from localhost.localdomain (unknown [122.233.177.66])
        by smtp9 (Coremail) with SMTP id DcCowAAnZ79OrDRdTDH8CA--.21881S3;
        Mon, 22 Jul 2019 02:17:51 +0800 (CST)
From:   16657101987@163.com
Cc:     git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com,
        Sun Chao <sunchao9@huawei.com>
Subject: [PATCH v1 0/1] pack-refs: pack expired loose refs to packed_refs
Date:   Mon, 22 Jul 2019 02:17:38 +0800
Message-Id: <20190721181739.81110-1-16657101987@163.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnZ79OrDRdTDH8CA--.21881S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWDXFWkXr1rXF4Dtw15CFg_yoW8Gw47pF
        Z0yFn8G3WvyF1fZrnIq3yvqFWrJanYqr90q3yfWr12v3yfJF1xGr10qF1UGay7XryfA3yU
        JF4jqayv9wn5Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b8R6wUUUUU=
X-Originating-IP: [122.233.177.66]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiFQ-4glWBoSBjNQAAsj
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

When a packed ref is deleted, the whole packed-refs file is
rewrite and omit the ref that no longer exists. However if
another gc command is running and call `pack-refs --all`
simultaneously, there is a change that a ref just updated
will lost the newly commits.

There are two valid methods to avoid losting commit of ref:
  - force `update-ref -d` to update the snapshot before
    rewrite packed-refs.
  - do not pack a recently updated ref, where *recently*
    could be set by *pack.looserefsexpire* option.

I prefer **do not pack a recently updated ref**, here is the
reasons:

  1. It could avoid losting the newly commit of a ref which I
     described upon.

  2. Sometime, the git server will do `pack-refs --all` and
     `update-ref` the same time, and the two commands have
     chances to trying lock the same ref such as master, if
     this happends one command will fail with such error:

     **cannot lock ref 'refs/heads/master'**

     This could happen if a ref is updated frequently, and
     avoid pack the ref which is update recently could avoid
     this error most of the time.

Sun Chao (1):
  pack-refs: pack expired loose refs to packed_refs

 builtin/pack-refs.c       | 13 ++++++++++++-
 refs.c                    |  4 ++--
 refs.h                    |  2 +-
 refs/files-backend.c      | 18 +++++++++++++++++-
 refs/packed-backend.c     |  2 +-
 refs/refs-internal.h      |  2 +-
 t/helper/test-ref-store.c |  2 +-
 7 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.22.0.214.g8dca754b1e


