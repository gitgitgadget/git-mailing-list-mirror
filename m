Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582FC47420
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE450207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="o6IBrY0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgI2QN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgI2QNY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:24 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4792EC061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X/QgnMxnBeTNmgs/1HtQudVpedooiCuqDbzsfG1wTCM=; b=o6IBrY0Hj6sksyXx/HNatqxzcC
        5Cr7Hn7YjbFz6oX3mwYaNaYY4drskWgZ5fvEqQweYgqyaY1o/gYE3EtX6PoPRJQFbyU8s4t9K7AXi
        oD504hUR5ljQnaFqSvEDExm0eV4CcvvqvHV5466Gxo0KhNbOKyox3piiAH4Mfr5WQQF0=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNHx7-0004AY-1z; Tue, 29 Sep 2020 15:54:05 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 0/7] Submodules and partial clones
Date:   Tue, 29 Sep 2020 16:53:43 +0100
Message-Id: <20200929155350.49066-1-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been investigating what is required to get submodules and partial
clones to work well together.  The issue seems to be that the correct
repository is not passed around, so we sometimes end up trying to fetch
objects from the wrong place.

These patches don't make promisor_remote_get_direct handle different
repositories because I've not found a case where that is necessary.

The patches rework various cases where objects from a submodule are
added to the object store of the main repository.  There are some
remaining cases where add_to_alternates_memory is used to do this, but
add_submodule_odb has been removed.

I expect there will be some remaining issues, but these changes seem to
be enough to get the basics working.

Andrew Oakley (6):
  refs: store owning repository for object lookup
  submodule: use separate submodule repositories
  refs: use correct repo in refs_peel_ref
  merge-recursive: use separate submodule repository
  submodule: remove add_submodule_odb
  submodule: use partial clone filter

Luke Diamand (1):
  Add failing test for partial clones with submodules

 builtin/clone.c                     |   5 ++
 builtin/fsck.c                      |   2 +-
 builtin/pack-objects.c              |   2 +-
 builtin/submodule--helper.c         |  21 +++--
 git-submodule.sh                    |  20 ++++-
 http-push.c                         |   2 +-
 merge-recursive.c                   |  73 ++++++++-------
 object.c                            |   7 +-
 object.h                            |   2 +-
 refs.c                              |  37 ++++----
 refs.h                              |  37 +-------
 refs/debug.c                        |   3 +-
 refs/files-backend.c                |  22 +++--
 refs/iterator.c                     |  11 ++-
 refs/packed-backend.c               |  15 ++--
 refs/packed-backend.h               |   3 +-
 refs/ref-cache.c                    |   5 +-
 refs/refs-internal.h                |  18 +++-
 revision.c                          |  21 ++---
 revision.h                          |   1 -
 submodule.c                         | 135 +++++++++++++---------------
 submodule.h                         |  11 ++-
 t/helper/test-example-decorate.c    |   6 +-
 t/helper/test-reach.c               |   2 +-
 t/helper/test-ref-store.c           |   1 -
 t/t0411-partial-clone-submodules.sh |  44 +++++++++
 t/t1406-submodule-ref-store.sh      |  17 +---
 tag.c                               |   4 +-
 tag.h                               |   2 +-
 upload-pack.c                       |   2 +-
 walker.c                            |   3 +-
 31 files changed, 301 insertions(+), 233 deletions(-)
 create mode 100755 t/t0411-partial-clone-submodules.sh

-- 
2.26.2

