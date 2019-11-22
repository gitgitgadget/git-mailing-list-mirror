Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4D4C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E18B2071F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKVUmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:42:33 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:35055 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUmd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 15:42:33 -0500
Received: by mail-il1-f171.google.com with SMTP id z12so8204847ilp.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 12:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0auAWUVZypFXE9SZzSyLPhmJNS0800F6aNRlsTX/2nw=;
        b=Ecixu+VWqg3uehTVAhPhe+9fAOxYPd3upXl2ndTNNdIG61HK/kIDZsMVvlz1R8iSoU
         AqGG8TteZdUVhDQp8qxsskjXBMzU3+O8MjuW32WnMqj1cvyoKaTsdsaYAPSTPIkG5XyL
         08CCet8EXQ59RilenzdBHFLG38pyn1qkPS8hAPCvZ/U7Gk2WnnyapReU3aF9puH66PSV
         JnCtKYxvKe3o8FvYjN4EQbmfvHRFVyTu0groHrYONDkQN/2dt/ezcuTp7O8zC3NBV9o/
         /3dE1xqMl9qgyJwuNTY1rNjdmexjV6GCQNiVPMhgSLLjeeW6ra4xFUx8qQJxf5MHYd+G
         FbtA==
X-Gm-Message-State: APjAAAVr2KskPr8shxfnc/scpGL+7vmFTd1B3TWcql04rfIpKc300we/
        S++JXasTzrZrbkgvFnKJ7mW6TpqR82aIeEGpaqUW9w==
X-Google-Smtp-Source: APXvYqxy6l6a+H1Qd55LdwndDYrFZfxG0AtG9kBHNFxGJkWVYRwd/Oez5AZcEmA+S/1/WiEiLu0kdRMg5hkQsJM9Apc=
X-Received: by 2002:a92:9c95:: with SMTP id x21mr18766343ill.115.1574455352149;
 Fri, 22 Nov 2019 12:42:32 -0800 (PST)
MIME-Version: 1.0
From:   Ed Maste <emaste@freebsd.org>
Date:   Fri, 22 Nov 2019 11:55:47 -0500
Message-ID: <CAPyFy2AsmaxU-BDf_teZJE5hiaVpTSZc8fftnuXPb_4-j7j5Fw@mail.gmail.com>
Subject: git-subtree split misbehaviour with a commit having empty ls-tree for
 the specified subdir
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I encountered an issue while trying to use git subtree with the
FreeBSD svn->git mirror: I found that when "git subtree split"
encounters a commit with an empty "git ls-tree" for the subdirectory
being split, it ends up recording the original parent as the new
parent in the split history that's being created. This then leads to
unrelated history appearing in the split subtree.

Below is a shell script that demonstrates the issue - this is not the
precise case that I encountered in the FreeBSD repo, but the behaviour
is identical (and it doesn't take nearly 10 minutes to run). Running
the script and then "git log" of the commit printed by the final (git
subtree) command includes the unrelated history in dir2/.

It looks like this comes from the cache_set "$rev" "$rev" in
process_split_commit() added in 39f5fff0d53. This is under the
suspicious-looking "ugly. is there no better way to tell if this is a
subtree vs. a mainline commit? Does it matter" comment. However, I
don't yet understand enough of git-subtree's operation to propose a
fix.

--repro.sh--
#!/bin/sh

rm -rf subrepo-issue
mkdir -p subrepo-issue
cd subrepo-issue

git init .
mkdir -p dir1 dir2
touch dir1/file1 dir2/file2
git add dir1 dir2
git commit -m 'initial commit'
echo 'file2' > dir2/file2
git commit -m 'file2 modified' dir2/file2
git rm dir1/file1
git commit -m 'remove file1'
mkdir -p dir1
touch dir1/file1
git add dir1
git commit -m 'restore file1'
echo 'file1' > dir1/file1
git commit -m 'file1 modified' dir1/file1
git subtree split --prefix=dir1/
