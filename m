Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D80DC433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C9F64E38
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 17:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhBMRuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 12:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhBMRuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 12:50:24 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F380C061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 09:49:44 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id p15so2150826ilq.8
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bburky.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=RbJzlky3+xjPNz2iXMeFhiNjUn062V24AGa3WtwfteM=;
        b=WKTDxqor8NOGNfaCdMT0FpjzKEFFGE6nukKnt37Q0UjhFeYwwaGEKDzO2IPXxdliL3
         J38Rwm4zHwLzQ+XX3mg8bf7l4uENif7B/oh2DGyTp3cGWMZuDH8wqDtt5HhuAavuqgzq
         Ds1WaFAUrwvjAWfW4uurLxCSnb/HRcufWdzVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RbJzlky3+xjPNz2iXMeFhiNjUn062V24AGa3WtwfteM=;
        b=tHNjMy3tB0NLCTo5oLnNgcRGS02dGR77LK48T9ElWBKwEmJWPiX9hHp+CW/WcDKWkL
         vxFqzIgTFs0r19HWusq3OPsL2B1eQ768qrNlW9xGtSKz2vxCRnx2/tnilaxmTsQDPI+w
         RI6sCOrXzssvDne8PE/63gQYXgE/NBMaJbsIJAGuZlUCxa6oOf6ef4cz3ESIxBsqkHnA
         cABXLz2jBAKGqrnhOSwM2qqyuhkKou1YdTS5N4iRq2o9PWjZTE1zx5Jj+KsxuLvvygVj
         cuRpKRF2rC/96vLS2zxjniWCQTVL99OVgEj8jtSwU1CJ8vTCXMeosheAe4EjCo4xBrDb
         Iing==
X-Gm-Message-State: AOAM5310BQE0B7gRUgFMnCzi3M0cjLCRW804HGmGPMDeLcGF3s77zjc9
        VYgxbJd1K9/Yxh2zZ7BJlkRNbKvaraA7yI+ByyB+4a7p65nZwSYq
X-Google-Smtp-Source: ABdhPJz9tS0fF/ALVfRu6GwndpdRNtKFvU+psBhAmkLHSKCPsmeyL7F7JUl4IF3q7lRMO2aLEV3Moh67hzS9zX+IVp0=
X-Received: by 2002:a05:6e02:144d:: with SMTP id p13mr6840123ilo.41.1613238582694;
 Sat, 13 Feb 2021 09:49:42 -0800 (PST)
MIME-Version: 1.0
From:   Blake Burkhart <bburky@bburky.com>
Date:   Sat, 13 Feb 2021 11:49:32 -0600
Message-ID: <CAP3OtXj15f9XV=Rzz2oBXQ1TQH3WWKJGBbeaWrmp6Ha4ZTn9nA@mail.gmail.com>
Subject: Limited local file inclusion with .mailmap symlinks and git-archive
To:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's mailmap implementation first tries using the blob from the
repository, but also supports using a local (possibly uncommitted)
.mailmap file. When reading from the local file, git will follow
symlinks. If a symlink is committed to a repository named .mailmap,
git will parse the file on the other side of the symlink if the
repository is cloned locally.

Git log supports an %aN placeholder which prints the result of the
mailmap, if it is possible for this value to be sent to an attacker
this could become a local file inclusion concern. With git-archive it
is possible to use $Format:%aN$ to include this value in an exported
archive.

Running git on bare repos or using git archive --remote=... is
unaffected because a local file is never used, only the in-repo blob.

Git's mailmap parser is very forgiving, it reads in each line, skips
lines starting with #, then considers whatever it finds between < and
> as the email address. It is even possible to use binary files as a
.mailmap. As a demonstration I used a symlink to /proc/self/exe (which
itself is a symlink to /usr/bin/git). The string [--exec-path[= was
extracted from the binary as the author name.

git init mailmap
cd mailmap
ln -s /proc/self/exe .mailmap
echo "test export-subst" > .gitattributes
echo '$Format:%aN$' > test
git add .mailmap .gitattributes test
git commit -m "test" --author="foo <path>"
cd ..

# Pretend you're cloning from the internet...
git clone mailmap mailmap-clone
cd mailmap-clone
git archive --format=tar HEAD
# Output contains [--exec-path[=

These are unaffected:

cd ..
git --git-dir=mailmap/.git archive --format=tar HEAD
git archive --remote=git://localhost/ --format=tar HEAD

I reported this issue to the private security list first and discussed
this issue with Peff. This is similar to existing concerns with
.gitmodules, .gitattributes and .gitignore. Git already disallows
checking out a .gitmodules file from a repository, and I understand
there are in progress patches to add similar protection for
.gitattributes and .gitignore. Please ensure the .mailmap file gets
similar symlink protection.

Exploitability is limited because the targeted file must contain a
string formatted like <foo> known to the attacker, or attacker
controlled. Also, most automated build systems that checkout code are
sandboxed and prepared to run arbitrary code already (it is
technically possible to read potentially sensitive variables from
/proc/self/environ with this, but is very limited because it contains
null bytes).

--
Blake Burkhart
