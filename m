Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA701FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 19:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbcIBTW2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 15:22:28 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33146 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932179AbcIBTW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 15:22:28 -0400
Received: by mail-vk0-f41.google.com with SMTP id f76so31748379vke.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=YeKra38Etu7R09X6+wPYGLTfV+x66hDcWqJvAvDJRLU=;
        b=h2UxLjeQ8R+87z0PZfWofgFwjjXuTHGCWcFkTlXvXUx8bATHvdqdlNyd8rjq1q0WRZ
         /d2L+5TDAv43mn+gIxag8YFORAHp9F61+d7Py6oVCvnOhasws7GbBIs4WXT9ib+lzh93
         w+yvOk0irsGTq8ycgNwhYXHhay+meVVqO2ipccPgjNkCTk4JV3HFMIDATrG1SobQXsuR
         pr7PKWitDImRHd+l7lCpKyjhOagIINCFJcZfOCnddfxdCkjCkc2dpq/GEtDqQUg0WT5f
         pUUE+xkBUHy/Qal8HqcaMjFsHKyO7E71gxR0596rRyGxUo6ZyO+uMls2iW6IPMla6qPw
         6G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YeKra38Etu7R09X6+wPYGLTfV+x66hDcWqJvAvDJRLU=;
        b=Qvy6xnV8qqaY5GolLvC03IxnLBmXpPCqt6OzYYLGxmXn9PXo9m9sLZ+80cW8B6Lqw3
         4hsgsjWmDMg+WWoHQPktlVRy1zPf++8p5/87P3l6mEws1H6B5t3eCcp7RThvrFc6MiFv
         C56Qb6poiPmWt6TEPrIs6I2LXyInJodV78G+zbhsTyeQSakNQihQoTDYorONddEcD5HE
         wq3kEmfcTY/jX+8N0Sg7CFWAk4JeuloMtAIGJQtAXXLdpoEDQeUIh9dQ6+t81w92wpee
         efqwzY3BnKfytqFW+MEwzod0ptX6dzidr+Gq3yp9IaCurtk8VyIr8/KSUhBRL4bgfZJB
         AxmA==
X-Gm-Message-State: AE9vXwP4IML9az9H3DzWMeiJj8DrX4vqYgD1T7NqgKiqBL107VUea2VDQHXHVspzdAAn1RDSeYNbPl5bkHf+ww==
X-Received: by 10.31.174.69 with SMTP id x66mr14890656vke.45.1472844146974;
 Fri, 02 Sep 2016 12:22:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.31.19 with HTTP; Fri, 2 Sep 2016 12:22:26 -0700 (PDT)
From:   Dakota Hawkins <dakotahawkins@gmail.com>
Date:   Fri, 2 Sep 2016 15:22:26 -0400
Message-ID: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
Subject: If a branch moves a submodule, "merge --ff[-only]" succeeds while
 "merge --no-ff" fails with conflicts
To:     Git Mailing List <git@vger.kernel.org>, mwitte@ara.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Below is a simple reproduction of the issue.

The _real_ problem is that this is how our pull request merges work,
they're not allowed to do fast-forward merges. To work around this we
are having to split this up into two pull requests/merges: One that
copies the submodules to the new location and includes any fixes
required to support the move, and a second that removes the old
locations.

## Setup steps
git clone https://github.com/dakotahawkins/submodule-move-merge-bug-main-repo.git
cd submodule-move-merge-bug-main-repo
    ## How it was initially constructed
    # git submodule add ../submodule-move-merge-bug-submodule-repo.git
./submodule-location-1
    # git commit -m "Added submodule in its initial location"
    # git push
    # git checkout -b move-submodule
    # git mv ./submodule-location-1 ./submodule-location-2
    # git commit -m "Moved submodule"
    # git push --set-upstream origin move-submodule
git branch move-submodule origin/move-submodule

## Test fast-forward merge, this will work
git checkout -b merge-ff-test master # warning: unable to rmdir
submodule-location-2: Directory not empty
rm -rf ./submodule-location-2
git merge --ff-only move-submodule

## Test no-fast-forward merge, this will fail with conflicts:
git checkout -b merge-no-ff-test master
git merge --no-ff move-submodule
    # Auto-merging submodule-location-2
    # Adding as submodule-location-2~move-submodule instead
    # Automatic merge failed; fix conflicts and then commit the result.
git status
    # On branch merge-no-ff-test
    # You have unmerged paths.
    #   (fix conflicts and run "git commit")
    #   (use "git merge --abort" to abort the merge)
    #
    # Changes to be committed:
    #
    #         modified:   .gitmodules
    #         deleted:    submodule-location-1
    #
    # Unmerged paths:
    #   (use "git add <file>..." to mark resolution)
    #
    #         added by us:     submodule-location-2
    #
    # fatal: Not a git repository: 'submodule-location-1/.git'
    # Submodule changes to be committed:
    #
    # * submodule-location-1 07fec24...0000000:
