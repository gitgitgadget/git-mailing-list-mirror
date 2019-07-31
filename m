Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42C81F731
	for <e@80x24.org>; Wed, 31 Jul 2019 18:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfGaSgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 14:36:17 -0400
Received: from m12-16.163.com ([220.181.12.16]:33886 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfGaSgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 14:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=nco6VAQueeuYfoEWsk
        ZLz2bc7SlDPKfUAEsShpevxlU=; b=SyzjnLTszPbssZ3RosXBWmxsk7PD1Omutr
        T4N8aeiAAi6WF3a2VMGnlhfT6qJTe3CNBN4YL0p1Wx9W+/E5C5iRIGVfbI8SH4r1
        dkoymbxT22oiyG7+SkvwQe+EyuF4BoyFw8LSm6kvLvmo/YQq75dFHmpieDzYW7nx
        orHgi9NJc=
Received: from localhost.localdomain (unknown [113.118.224.79])
        by smtp12 (Coremail) with SMTP id EMCowAB3PyuM30FdnWFpAA--.16797S4;
        Thu, 01 Aug 2019 02:36:01 +0800 (CST)
From:   16657101987@163.com
To:     peff@peff.net
Cc:     16657101987@163.com, git@vger.kernel.org, gitster@pobox.com,
        mhagger@alum.mit.edu, sunchao9@huawei.com, worldhello.net@gmail.com
Subject: [PATCH v2 1/1] pack-refs: always refreshing after take the lock file
Date:   Thu,  1 Aug 2019 02:35:44 +0800
Message-Id: <20190731183544.24406-2-16657101987@163.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190731183544.24406-1-16657101987@163.com>
References: <20190730063634.GA4901@sigill.intra.peff.net>
 <20190731183544.24406-1-16657101987@163.com>
In-Reply-To: <20190730063634.GA4901@sigill.intra.peff.net>
References: <20190730063634.GA4901@sigill.intra.peff.net>
X-CM-TRANSID: EMCowAB3PyuM30FdnWFpAA--.16797S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw4UAryrWw4xtrykJryUGFg_yoW7Ar48pr
        Z8C3s8Gw4DCF1Svrn7Wr18XFW8Ga95tFy5Xr95W39F9w4UXw1IqrWfK3WYgrZxGrn3Aw4U
        Zr45KrWkGFnYv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3pnQUUUUU=
X-Originating-IP: [113.118.224.79]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/xtbB0RQDglzH5US2IgAAsq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <16657101987@163.com>

When a packed ref is deleted, the whole packed-refs file is
rewrite and omit the ref that no longer exists. However if
another gc command is running and call `pack-refs --all`
simultaneously, there is a chance that a ref just updated
will lost the newly commits.

Through these steps, losting commits of newly updated refs
could be demonstrated:

  # step 1: compile git without `USE_NSEC` option
  Some kernerl releases does enable it by default while some
  does not. And if we compile git without `USE_NSEC`, it
  will be easier demonstrated by the following steps.

  # step 2: setup a repository and add first commit
  git init repo &&
  (cd repo &&
   git config core.logallrefupdates true &&
   git commit --allow-empty -m foo)

  # step 3: in one terminal, repack the refs repeatedly
  cd repo &&
  while true; do
    git pack-refs --all
  done

  # step 4: in another terminal, simultaneously update the
  # master with update-ref, and create and delete an
  # unrelated ref also with update-ref
  cd repo &&
  while true; do
    us=$(git commit-tree -m foo -p HEAD HEAD^{tree}) &&
    git update-ref refs/heads/newbranch $us &&
    git update-ref refs/heads/master $us &&
    git update-ref -d refs/heads/newbranch &&
    them=$(git rev-parse master) &&
    if test "$them" != "$us"; then
      echo >&2 "lost commit: $us"
      exit 1
    fi
    # eye candy
    printf .
  done

Though we have the packed-refs lock file and loose refs lock
files to avoid updating conflicts, a ref will lost its newly
commits if racy stat-validity of `packed-refs` file happens
(which is quite same as the racy-git described in
`Documentation/technical/racy-git.txt`), the following
specific set of operations demonstrates the problem:

  1. Call `pack-refs --all` to pack all the loose refs to
     packed-refs, and let say the modify time of the
     packed-refs is DATE_M.

  2. Call `update-ref` to update a new commit to master while
     it is already packed.  the old value (let us call it
     OID_A) remains in the packed-refs file and write the new
     value (let us call it OID_B) to $GIT_DIR/refs/heads/master.

  3. Call `update-ref -d` within the same DATE_M from the 1th
     step to delete a different ref newbranch which is packed
     in the packed-refs file. It check newbranch's oid from
     packed-refs file without locking it.

     Meanwhile it keeps a snapshot of the packed-refs file in
     memory and record the file's attributes with the snapshot.
     The oid of master in the packed-refs's snapshot is OID_A.

  4. Call a new `pack-refs --all` to pack the loose refs, the
     oid of master in packe-refs file is OID_B, and the loose
     refs $GIT_DIR/refs/heads/master is removed. Let's say
     the `pack-refs --all` is very quickly done and the new
     packed-refs file's modify time is still DATE_M, and it
     has the same file size, even the same inode.

  5. 3th step now goes on after checking the newbranch, it
     begin to rewrite the packed-refs file. After get the
     lock file of packed-ref file, it checks it's on-disk
     file attributes with the snapshot, suck as the timestamp,
     the file size and the inode value. If they are both the
     same values, and the snapshot is not refreshed.

     Because the loose ref of master is removed by 4th step,
     `update-ref -d` will updates the new packed-ref to disk
     which contains master with the oid OID_A. So now the
     newly commit OID_B of master is lost.

The best path forward is just always refreshing after take
the lock file of `packed-refs` file. Traditionally we avoided
that because refreshing it implied parsing the whole file.
But these days we mmap it, so it really is just an extra
open()/mmap() and a quick read of the header. That doesn't seem
like an outrageous cost to pay when we're already taking the lock.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 refs/packed-backend.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c01c7f5901..4458a0f69c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1012,14 +1012,23 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	}
 
 	/*
-	 * Now that we hold the `packed-refs` lock, make sure that our
-	 * snapshot matches the current version of the file. Normally
-	 * `get_snapshot()` does that for us, but that function
-	 * assumes that when the file is locked, any existing snapshot
-	 * is still valid. We've just locked the file, but it might
-	 * have changed the moment *before* we locked it.
+	 * There is a stat-validity problem might cause `update-ref -d`
+	 * lost the newly commit of a ref, because a new `packed-refs`
+	 * file might has the same on-disk file attributes such as
+	 * timestamp, file size and inode value, but has a changed
+	 * ref value.
+	 *
+	 * This could happen with a very small chance when
+	 * `update-ref -d` is called and at the same time another
+	 * `pack-refs --all` process is running.
+	 *
+	 * Now that we hold the `packed-refs` lock, it is important
+	 * to make sure we could read the latest version of
+	 * `packed-refs` file no matter we have just mmap it or not.
+	 * So what need to do is clear the snapshot if we hold it
+	 * already.
 	 */
-	validate_snapshot(refs);
+	clear_snapshot(refs);
 
 	/*
 	 * Now make sure that the packed-refs file as it exists in the
-- 
2.22.0.214.g8dca754b1e


