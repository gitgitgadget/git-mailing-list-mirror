Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A8CF20966
	for <e@80x24.org>; Thu,  6 Apr 2017 06:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933439AbdDFGLo (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 02:11:44 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34879 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754270AbdDFGKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 02:10:25 -0400
Received: by mail-wr0-f181.google.com with SMTP id o21so16809194wrb.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=FM5AVmfUTXBYVlZkvX2MX5Oqdn3BEebVy348a770Ne4=;
        b=iLpCM5KvC9vbX0iQzojbdoUbT463W6pCWb1kwUMzHaqZJI4wEBOCQDMf9av6UdjYQb
         jQiwfMDXGOGnKaKitJdIXNFoI4Wk9JifNrMAjjp4uC2THC1N/hZ5nMhNUX4PcLstrlcL
         0H/RBwT9OrktJ6uxdV8z3cH42HzHyBXxjbtUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FM5AVmfUTXBYVlZkvX2MX5Oqdn3BEebVy348a770Ne4=;
        b=kal0nWdpmfsQqfhSZuRimDu8KSWrxymHXTwfkE+iVQrke6SzsTnZ2j5Ax9j9WvvT6F
         NimxpyLmKNgzd6etq5gSGX1WrIwhPs3kflL2UkA9OTgtNyzETpU3I4rqL3aPmlovZSFW
         q8HUi89LIpUtQt8blCThxQlhV37aF3PftOddWlsymxME5dwv3US+qNbh+ZSoRux7jVDN
         ZsmLnvrkK6O+ELyl023WSUmUW7LZuFQMjZsOEduVx+TTgLhHeHIcIskLT88507TWDz0q
         QdQyU8IicjWsNC8gBKDXwIeNo0t3KUYAJ0Lk4fULgHfJtMUXQfeU2YzUot8KngL7APIF
         s1yg==
X-Gm-Message-State: AFeK/H3MNpcjFqwmWZcH+gQ7+DP98oYZvbMdbg0FZ5Kot3fPj+wbRXbM4lNd9K/twTwZgzkon3J31/R1ycegw1y1
X-Received: by 10.223.161.220 with SMTP id v28mr29705821wrv.54.1491459022852;
 Wed, 05 Apr 2017 23:10:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.142.247 with HTTP; Wed, 5 Apr 2017 23:10:02 -0700 (PDT)
From:   Ben Nason <bnason@netflix.com>
Date:   Wed, 5 Apr 2017 23:10:02 -0700
Message-ID: <CAA-fqg2EwfMQ-KoAMHDFca1c7jpQgihhqsLejEK3Zs8O1D4DLg@mail.gmail.com>
Subject: [BUG?] Issue with merging from another branch after replacing
 subdirectory with submodule
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In git if you replace a subdirectory with a submodule in one branch,
every successive merge from another branch without that change will
cause a conflict. To reproduce this please see below (DOS batch file).

Is this expected behavior?

Thanks,
Benbuck

:: prep simple repo with subdir
git init repo
pushd repo
echo foo > foo.txt
git add --all
git commit -m "foo"
mkdir sub
echo bar > sub\bar.txt
git add --all
git commit -m "bar"
popd

:: prep simple submodule
git init submod
pushd submod
echo baz2 > baz.txt
git add --all
git commit -m "baz2"
popd

:: in a new branch: delete subdir, replace with submodule
pushd repo
git checkout -b resub
git rm -rf sub
git commit -m "delete subdir"
git submodule add ../submod sub
git submodule update --init
git commit -m "add submod"

:: in old branch: make an unrelated change
git checkout master
git clean -fd
git rs --hard master
echo foo2 > foo.txt
git commit --all -m "foo2"

:: switch back to new branch
git checkout resub
git rs --hard resub
git submodule update --init
pushd sub
git reset --hard master
popd

:: all is good so far, now merge
git merge master
git status
@echo !!!!!! note the above merge conflict !!!!!!
pause
:: resolve the conflict to keep the submodule
git reset sub
git commit --no-edit


:: make another change to old branch
git checkout master
git clean -fd
git rs --hard master
echo foo3 > foo.txt
git commit --all -m "foo3"
git checkout resub
git rs --hard resub
git submodule update --init
pushd sub
git reset --hard master
popd

:: merge again
git merge master
git status
@echo !!!!!! note that the conflict happens on every single merge !!!!!!
pause

popd
