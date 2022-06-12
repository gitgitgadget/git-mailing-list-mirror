Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C3CC433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 16:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiFLQRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiFLQRt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 12:17:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E155B8BD
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 09:17:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id r1so3181314plo.10
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2Hv5/SaWbIMGJ2OTpL4bseyzAOPZbNGxRGiuONLL7I=;
        b=ivimOAFHqCnIADpqU/zmmoJ3Drf+iLQffcE+8G0L9wOgnO5BvnSbSiFjTcaaNrl3UY
         W/DD0eK8MygFDGNZy6fXpl6AUix5Y+W+XXQn9dlMqd5/anR/XlBfvhNAqWKiou01f2Xp
         2RaBr1ueBgsf7kyaB0H78JkxD9y8dFcrbVNsa0EIwqqWQ9fWa3VcHEC4wooZ8uirljdF
         3xE2YpG4IPs3p8zK43DuCI1YiE33sGsW/mUbcP37hq87356feQxVQE6tgS9WXL2SDcTZ
         rKLTTCIu0Vcv9qFBP/6nEJ9ZpKhcN3bqnDMnmasKhO/7JDC2D/kB63A48g8xROuotPdI
         uCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2Hv5/SaWbIMGJ2OTpL4bseyzAOPZbNGxRGiuONLL7I=;
        b=sWLrDAGXi6BCqTx1+OKGmKwllz84cLk5YN+JT5Ie0neYe9cILYaSoRRD875mMm/0tF
         Pwje85RxwJGq0BclL1BJP99QIrc2U/O7EfBVNLBFdeUmft/wvYXKL4SyuCppF+avElam
         lSCKEy/17vCuinHZE05uyWMNpQdJOn88BGk2+Z8eP2n5QtryHOCRhq0JttSCzFb5QGTm
         SMv2V/HAW1RmGiPjdcVU0VGXOUXmHtr2ha3yJSwh2PY0LC26Nvrp6N2X7D2wf0ElxYIU
         7+ZLTJYmCuFkFKXLpM8JqoeYY7eK3zl7vjqvynV9xwmlqgFQrn97x6jYYciRmcSkbUIJ
         naZQ==
X-Gm-Message-State: AOAM532J0EKSfTAR176VIBzLDQ+R6YqzaRSHmlMZHUVmH8fgm3MQULbb
        HsVnOJRrnQ2ra3HlK4WzRxjgXS0cCUk=
X-Google-Smtp-Source: ABdhPJw4gQh/oQGwMeududEReYVtRLB7Q9aAruQH6hjlTY9hp6LBsZcQL3O7QdOko+BiDfR4kIhfzQ==
X-Received: by 2002:a17:90a:65ca:b0:1e8:ae4e:69f8 with SMTP id i10-20020a17090a65ca00b001e8ae4e69f8mr10955161pjs.76.1655050665790;
        Sun, 12 Jun 2022 09:17:45 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([2409:8a28:80c:ca60:6957:cd88:1852:9438])
        by smtp.gmail.com with ESMTPSA id d190-20020a6368c7000000b003fd4bd3befesm3549392pgc.55.2022.06.12.09.17.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Jun 2022 09:17:45 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     git@vger.kernel.org
Cc:     Han Xin <chiyutianyi@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: An endless loop fetching issue with partial clone, alternates and commit graph
Date:   Mon, 13 Jun 2022 00:17:07 +0800
Message-Id: <20220612161707.21807-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1.378.g1e59178e3f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We found an issue that could create an endless loop where alternates
objects are used improperly.

While do fetching in a partial cloned repository with a commit graph,
deref_without_lazy_fetch_extended() will call lookup_commit_in_graph()
to find the commit object. We can found the code in commit-graph.c:

     struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id)
     {
          ...
          if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
               return NULL;
          if (!repo_has_object_file(repo, id))
               return NULL;

If we found the object in the commit graph, but missing it in the repository,
we will go into an endless loop:
     git fetch -> deref_without_lazy_fetch_extended() -> 
          lookup_commit_in_graph() -> repo_has_object_file() -> 
               promisor_remote_get_direct() -> fetch_objects() ->
                    git fetch

I know that the reason for this issue is due to improper use of
alternates, we can ensure that objects will not be lost by maintaining
all the references. But shouldn't we do something about this unusual
usage, it will cause a fetch bombardment of the remote git service.

We can reproduce this issue with the following test case, it will
generate a lot of git processes, please be careful to stop it.
------------------------------------------------------
#!/bin/sh

test_description='test for an endless loop fetching'

GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

. ./test-lib.sh

test_expect_success 'setup' '
    git init --bare dest.git &&
    test_commit one &&
    git checkout -b testbranch &&
    test_commit two &&
    git push dest.git --all
'

test_expect_success 'prepare a alternates repository without testbranch' '
    git clone -b $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME dest.git alternates &&
    oid=$(git -C alternates rev-parse refs/remotes/origin/testbranch) &&
    git -C alternates update-ref -d refs/remotes/origin/testbranch &&
    git -C alternates gc --prune=now
'

test_expect_success 'prepare a repository with commit-graph' '
    git init source &&
    echo "$(pwd)/dest.git/objects" >source/.git/objects/info/alternates &&
    git -C source remote add origin "$(pwd)/dest.git" &&
    git -C source config remote.origin.promisor true &&
    git -C source config remote.origin.partialclonefilter blob:none &&
    git -C source fetch origin &&
    (
        cd source &&
        test_commit three &&
        git -c gc.writeCommitGraph=true gc
    )
'

test_expect_success 'change alternates' '
    echo "$(pwd)/alternates/.git/objects" >source/.git/objects/info/alternates &&
    # this will bring an endless loop fetching
    git -C source fetch origin $oid
'

test_done

------------------------------------------------------

Thanks
-Han Xin
