Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E371FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 18:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbdDLSht (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 14:37:49 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35767 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbdDLShr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 14:37:47 -0400
Received: by mail-qk0-f176.google.com with SMTP id f133so30772613qke.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RC/GzIToWp1RNcak63MZQ64jbNbfPMdX1uo/wp3bHuk=;
        b=YDc1pIaO/w6agHEIxOqrSTuAPHw4NMj3QjEUJvsFNSz9/O9AH13MTUkzfWXlNWJwcK
         h2F4cft/ahqrdJskwou1hq2LwTEvRysTdEd4cpVywbOQYzLEswjX1VGN2O8Xkot7KNgB
         s5Sf/h9AEd54J6gKSx5MZ31iAj/uqwHVVLdYOeBDTMkglTkrF4LRCfK+nwQ/ChxBigGf
         DoGnviu9nGJ1doTglnLHZZXm9BgeLyciArdCWZN73Nsz6Jfl/caoQWUP/xwuDNuZrorh
         rJGyFGfu/ouC7v+8VBXLnq3EIignAbwwJRzl+s67O7b6oVlEtTPhXiOZkfywiCQKErtV
         FK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RC/GzIToWp1RNcak63MZQ64jbNbfPMdX1uo/wp3bHuk=;
        b=HEhZqYxkK5RI3RqtJd2MkINUl14lEviX/OsWgKDz43yX0ta1/Nag4hYM/7dq318y+P
         vk5N/ti6kU9GcOcfqffcIrR6atMiEnYugBxdn5nWMR4ZI7VyBew9xQyd+mHSAMldPbny
         KM6h9ojIqFhQF9AwB/Iao3MRhr7O/UwMjsdAItqOL1DmiPgRQU7ML+DWDvwWkA8i/d9q
         V4KYB/Amo1XewpRNiPRupoG0Ai3dSkpzpw3Rq9NSxWc4VTl4iS8FPybkcdB+Gh1CHhQF
         IjgHcxAVuomT9CC8bJSbpa3gRcuNaVLQ8X1e5BxhzsQp+6IKPDWHj3yeMfKrzSUk55Pl
         sE8Q==
X-Gm-Message-State: AFeK/H0VLlnZWR5LdykNv8PrPXVNvreDIhaaDvMbOhfOoRK9auBq2towdXrnWrpkP7NLyL96aGPnXu7hwAtJaQ==
X-Received: by 10.55.70.20 with SMTP id t20mr66971185qka.166.1492022266835;
 Wed, 12 Apr 2017 11:37:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.129.36 with HTTP; Wed, 12 Apr 2017 11:37:46 -0700 (PDT)
From:   Andrew Hoyt <andrewhoyt@gmail.com>
Date:   Wed, 12 Apr 2017 14:37:46 -0400
Message-ID: <CAOiUhTHqbjN=S5eFWVs1x2dvCeyai_ys6EhWvKPjj21QozEtOg@mail.gmail.com>
Subject: git subtree bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

I've been using git subtrees extensively to include third party tools
in my projects. Today I stumbled across a bug with git-subtree when I
was trying to update the jacoco (https://github.com/jacoco/jacoco.git)
subtree in one of my projects.

The problem stems from adding a project as a subtree with a prefix
that has the same name as a top-level subdirectory in that project.
From then on, any changes made to the top-level directory of that
sub-project will cause issues when you attempt a git subtree pull
(e.g. the entire subtree AND the parent project will be deleted in
your working directory).

Steps to reproduce:
====================================================================
mkdir --parents /tmp/project/prj
cd /tmp/project
echo "file in subdirectory" > prj/file_in_subdirectory
echo "file in root" > file_in_root
git init
git add .
git commit -m "Init subproject repository"

mkdir /tmp/test
cd /tmp/test
git init
git commit --allow-empty -m "Init test repository"
git subtree add --prefix prj /tmp/project master

cd /tmp/project
echo "temp file" > temp
git add temp
git commit -m "add temp file"

cd /tmp/test
git subtree pull --prefix=prj /tmp/project master
====================================================================

In the above example, the problem occurs because we've added the
subtree with the prefix "prj" when it happens to contain a top-level
directory also called "prj". A change is then made to "project"s
top-level directory (the file "temp" is created) and thus the "git
subtree pull" command puts "test" into a broken state. If we had added
the subtree with any other prefix, the problem would not have
occurred. Likewise, if we had added "temp" anywhere other than the top
level of "project" the subtree pull would not have caused problems.

Anyhow, I'm not sure if you guys are aware of the problem or not, but
I figured I'd bring it to your attention just in case.

Thanks so much,
- Andrew
