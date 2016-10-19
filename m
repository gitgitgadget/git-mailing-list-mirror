Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1B52098B
	for <e@80x24.org>; Wed, 19 Oct 2016 15:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945154AbcJSPeO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 11:34:14 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36150 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938803AbcJSPeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 11:34:11 -0400
Received: by mail-qk0-f181.google.com with SMTP id o68so41917115qkf.3
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=piOOcVGvoK304UgIBDSq2+A6HFX/vUuTa4Gq1cb8A0c=;
        b=ZzCFtjzh30EVtzgwvE51feAq/I1ziL8eLxeWTG4cf5jbHssJrBDORotQpvFywDanKG
         DkAvLgnB8b0g1yMW86twXWVw9KU+SHq9AwVlHujC/j+Ev9TWaAw9T1fkFVsDCabp7ydH
         Go/ziBXOIChA2NVe+DNiiulF2FDBU6iQ3q4AoOprXPJK95YSh8xBIWzir1PQ0XGkkTs2
         1VoPhncVyCllt1fcCHfUVZ9qV/9w8NTrUD+5RKKO5iKiX0EP3inENvMPAXw6N+GAKYO7
         nvJiKywt3MdQ12719SkpRtvC0DEhsMmy8qZhZ1hksqLPWPPScy3IZ4Wegz3d4OdyBnwG
         kGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=piOOcVGvoK304UgIBDSq2+A6HFX/vUuTa4Gq1cb8A0c=;
        b=lVoYzhparEYz76koEDEpQ9K+v5Mh6lEYtucM0u5Vyc0NQnEWF7P3Ddd8MfyT8bQLsj
         4Lm+FcI2I80ZtcmeXGCBPZroScchXN7aMvyDRA2yVCp78g6uTZXiZf8Q3x6yhlMD4njn
         khVbxCWJKh7SM72XEmkQ+DXcUcvC+QuclTdIo2WyQ4bfoNO3QHespQgEonoTkmXmw97B
         EIPtJ6ZmbrcbVz5INSKM6snM2ym1s7zCy3xavS46yXeUIzJnrmCn6h3e6RwPiRceskLx
         mtN+RqLDBkkqhhf250tOvmkwBs9i3beVtTH7K81oQu0arwS3liiPznAV2kRfCcCugCaJ
         rgYw==
X-Gm-Message-State: AA6/9RmTsGo1SnzF8JPAx9IO5OWRkiJHw/Mny1Ye6qHi03HCAQ8BhkYrS9RuY82UaEFgpIwKz36a4QnLl25LFw==
X-Received: by 10.28.48.203 with SMTP id w194mr5914741wmw.115.1476891250261;
 Wed, 19 Oct 2016 08:34:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.194.4 with HTTP; Wed, 19 Oct 2016 08:34:09 -0700 (PDT)
From:   "Alex C. Reed, IV" <acreed4@gmail.com>
Date:   Wed, 19 Oct 2016 11:34:09 -0400
Message-ID: <CAGDUdtnUT+_G9bHOYVw_5i-+r9vJHFSjP=Zg2HzA=cQfOkKfwA@mail.gmail.com>
Subject: [BUG] git-stash fails when tracked file is replaced with directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a file is deleted from Git and replaced with a directory+file(s),
git-stash has two unexpected behaviors.  This is tested against
versions 2.8.1 and 2.10.1:


1) Old file is removed from index and newly-added directory+file(s)
are added to index.
In this scenario, 'git stash' fails with the message:

    error: <directory>: is a directory - add individual files instead
    fatal: Unable to process path <directory>
    Cannot save the current work tree state

The expected result would be that Git properly records the state
currently stored in index.


2) Old file is removed and new-added directory+file(s) are present
only in worktree, but not added to the index.
In this scenario, 'git stash -u' works fine, but 'git stash apply'
fails with the message:

    fatal: cannot create directory at '<directory>': File exists
    Could not restore untracked files from stash

The expected result would be that Git removes 'file' and replaces with
the untracked contents recorded in the original stash.


It is worth noting that Git does properly handle the scenario where
the stash operation of (1) is replaced with a commit to a temporary
branch, so this quirk seems to be restricted to stashes only.


I found a similar issue reported 22 April 2016 titled "possible bug of
git stash deleting uncommitted files in corner case".  The thread-view
of the message is here:

    http://marc.info/?t=146132568600002&r=1&w=2


Here's a quick-and-dirty bash script to re-create all three scenarios
(1, 2, and 'commit to branch'):

===== BEGIN stash-test.sh
#!/bin/bash

set -x
export GIT_TRACE=1

setup() {
  repo=$1

  # Prepare repo
  rm -rf $repo
  git init $repo
  cd $repo

  # Add initial file (symlink to external assets)
  ln -fs /external/dir dir
  git add dir
  git commit -m "Add symlink to /external/dir"

  # Replace symlink with local copy of assets
  rm dir
  mkdir -p dir
  touch dir/local_copy_of_dir_files
}

{
  ( setup stash-test-unstaged
    git stash -u
    git stash apply )

  ( setup stash-test-staged
    git add .
    git stash )

  ( setup stash-test-commit
    git add .
    git co -b stash-branch
    git commit -m "commit to branch instead of stash" )

} 2>&1 | tee stash-test.log
===== END stash-test.sh


Thanks,
-Alex Reed
