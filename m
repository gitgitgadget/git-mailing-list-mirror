Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10463C43463
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 23:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5AF420809
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 23:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgITXWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 19:22:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35280 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgITXWl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Sep 2020 19:22:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 528F461FE5;
        Sun, 20 Sep 2020 23:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600644160;
        bh=vMaPNa+Tp7gO4QclUDL1Alyyb2qxOZGMZxuFccZr1y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=u8EtYIpBoNLv2ait7lzknR2mB/hpeiMkWFjQddMHBSRrBlodpSyZRuN2X5l9SNO1s
         /+K7ankwkRsSBzF6QzoLd0U9+dRrHMvHVLVbsWCj+DKST5XisaUgC7Sk3K/v5J5Y8e
         1QN3vTs7QiVXgEyFXrmOT/1xZZu7+2PX1JCHOS/B62alsjV+YRGO0nb9yt2zstPKDm
         Zero6bIB8tBSck6mPRERmSpWNyJxDMjqPcD2rQkEWaX3pSUxgLc6ZNTueH8nR6StZX
         Y4NDO9F06pcL5WJTILwJzDIYexZ1ej3wfYYULpzK18Mz6umowriLNhFw/SbgPNrt97
         SVMXCFNDJrGpIDUyfMHFPtCIwK+7YJ3c+tTVDaLFdIRUa+t5Ge0okYwnQunhk8A2Vr
         NzSyQieiiCQOxM+DG6zfT82U/GC093eZI5yS7NzhIa274jBKq1aR23Zcd8pBtkdeVW
         oGzzQWcjN9HATpEEZ4QP7EcDNhqfWrX/BbF3dDfbAfjy94T69Ci
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 1/3] docs: explain why squash merges are broken with long-running branches
Date:   Sun, 20 Sep 2020 23:22:29 +0000
Message-Id: <20200920232231.1300394-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200920232231.1300394-1-sandals@crustytoothpaste.net>
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
 <20200920232231.1300394-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many projects, squash merges are commonly used, primarily to keep a
tidy history in the face of developers who do not use logically
independent, bisectable commits.  As common as this is, this tends to
cause significant problems when squash merges are used to merge
long-running branches due to the lack of any new merge bases.  Even very
experienced developers may make this mistake, so let's add a FAQ entry
explaining why this is problematic and explaining that regular merge
commits should be used to merge two long-running branches.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 9cd7a592ac..51d305d58f 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -241,6 +241,38 @@ How do I know if I want to do a fetch or a pull?::
 	ignore the upstream changes.  A pull consists of a fetch followed
 	immediately by either a merge or rebase.  See linkgit:git-pull[1].
 
+Merging and Rebasing
+--------------------
+
+[[long-running-squash-merge]]
+What kinds of problems can occur when merging long-lived branches with squash merges?::
+	In general, there are a variety of problems that can occur when using squash
+	merges to merge two branches multiple times.  These can include seeing extra
+	commits in `git log` output, with a GUI, or when using the `...` notation to
+	express a range, as well as the possibility of needing to re-resolve conflicts
+	again and again.
++
+When Git does a normal merge between two branches, it considers exactly three
+points: the two branches and a third commit, called the _merge base_, which is
+usually the common ancestor of the commits.  The result of the merge is the sum
+of the changes between the merge base and each head.  When you merge two
+branches with a regular merge commit, this results in a new commit which will
+end up as a merge base when they're merged again, because there is now a new
+common ancestor.  Git doesn't have to consider changes that occurred before the
+merge base, so you don't have to re-resolve any conflicts you resolved before.
++
+When you perform a squash merge, a merge commit isn't created; instead, the
+changes from one side are applied as a regular commit to the other side.  This
+means that the merge base for these branches won't have changed, and so when Git
+goes to perform its next merge, it considers all of the changes that it
+considered the last time plus the new changes.  That means any conflicts may
+need to be re-resolved.  Similarly, anything using the `...` notation in `git
+diff`, `git log`, or a GUI will result in showing all of the changes since the
+original merge base.
++
+As a consequence, if you want to merge two long-lived branches repeatedly, it's
+best to always use a regular merge commit.
+
 Hooks
 -----
 
