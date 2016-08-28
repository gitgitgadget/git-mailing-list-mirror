Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF281F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756133AbcH1XY4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:24:56 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33781 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbcH1XY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 19:24:56 -0400
Received: by mail-oi0-f51.google.com with SMTP id c15so175742262oig.0
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 16:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=uTXS1B1QD70zU0Ib1VIa/ysD1UVSIwxxUeR3qHEaDIA=;
        b=EK+VgbFUYCdbJKDnrhZvmU4oXEGgIWdexwt7zJqSyphAdFnEkB6TAcq8YaaYPTi2fv
         MxQ4c+tAl9JXC6A1pZGgH49CTnuIX4Hn9nrnGDMgozPqvibwHoZfuT/yaU4Ucy8msC8M
         cS176o0Wh0DLcdJpS7txJDlWLxwjrvZ4mpQKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uTXS1B1QD70zU0Ib1VIa/ysD1UVSIwxxUeR3qHEaDIA=;
        b=kHyHPriQwlL9YieC5Am0jeYAZGWM1NDsn3xtW0WBfUF3AOgTX1zRyvKavZNF0bKlyl
         IGod2BxuD9h8s6BWrRBlycNJHolDf34zPA7Rlqj/lyHPAvbaWpfFF0Ue7JphLcYUfBC6
         EC1kD5VcedmWun3Wj+wLwOdTF/+/mirgnnv9bAvTLthdyNzS8eRUxJJgFU512x1EiR4s
         d6H0ncdSNy4UPq4LbVnDxp9wi+scHgLIbhQjQj8zbID3WzhLVJjKaWleFYT6rs6UYyz3
         dGPldA+uuQUaEJkxYCjWd8koOANg85DtX99jTHAK01FDssRj0Q/wV2hyg5qe/g0zorpM
         HvlA==
X-Gm-Message-State: AE9vXwOsa62x5ontgq15HeKoiA3RnC2sbaLu3wtH1CnjS9s61DJvM+1G4X7je5I4X3c2Q0CE6x6u20xh1t4xXl6v
X-Received: by 10.157.29.1 with SMTP id m1mr10389268otm.113.1472426694983;
 Sun, 28 Aug 2016 16:24:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.56.54 with HTTP; Sun, 28 Aug 2016 16:24:54 -0700 (PDT)
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Sun, 28 Aug 2016 16:24:54 -0700
Message-ID: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
Subject: git submodules implementation question
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am new to git source and internal development. Recently I've been
looking at a problem where issuing "git status" in a corrupted
workspace handed over to me by a user, forks several thousand child
processes recursively.

The symptoms of the corrupted workspace to reproduce this problem are
as follows:

there needs to be an entry in the index file that looks something like this....
0 groc 160000 0 0.000000000

Also, there's a subdirectory under the source dir with the name in the
index file above (i.e 'groc') that has a partially populated .git sub
directory within it, not a .git file with the contents providing a
link to the module subdirectory.

The "git submodule status" command returns "No submodule mapping found
in .gitmodules for path 'groc'"

Doing a "git read-tree HEAD" will regenerate the index file and make
the problem go away. Basically the line entry above relating to 'groc'
goes away as it is not a submodule in the source repo.

This problem can be reproduced with all current versions of GIT
including 2.4, 2.8 and the latest version v2.10.0-rc1.

In looking into the git source code for is_submodule_modified() which
forks off the new child process, I see the following lines in
submodule.c:

git_dir = read_gitfile(buf.buf);
if (!git_dir)

                git_dir = buf.buf;

Can anyone explain to me why we are replacing a failed reading of a
git file with the original sub directory name? When can we expect a
.git directory under a submodule?

Thanks,
Uma
