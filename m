Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1872FC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 06:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E729160F56
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 06:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhKBG2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 02:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBG2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 02:28:46 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A9BC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 23:26:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d204so50480801ybb.4
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=CUno1klsfSBQmABydcGl3UNWzFONGLUhDAhTHFKqi0g=;
        b=gYRXbDauLRX7M/BlpLFDpWvY0MuA+Q8a1PICXVvH/Vodzw7ETCZm33VkDozigSQxMj
         KtXwCDeuKivXHZ/x/gpxhyWNjC4RznzOFOzn4bK/QQbjY6/EfycM5Qbj2yXhs7sTcMy8
         1hTU9OriauBH3WDGzhpRdWrzOsdBMq18YatvHkJHghqYWs9GdnHAli50E1Jqt7QKwPTd
         jaMWBoyP8Jf73UW5fFC+CzSLOztwoBBAgZVJeJS411Wqf3OWYFFr/sZT5OVLGq9y7Cne
         0AsbPtPFpYOyD+rVI9EvPgQXxgiROj180Ri2/iARpwXL94Zv+1erXCcQGD8GdhusvHit
         X67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CUno1klsfSBQmABydcGl3UNWzFONGLUhDAhTHFKqi0g=;
        b=NK7KDka1p5pXENQ8Bb1vkPNJUau3uudqMonmq/vAvtwNo9YKsKMWZBPMh2rvi+snxu
         hPjWV2J0/MN3bull/c6kRPY51wWAG85RxWleDMbGC/ORuwgCjIK/6RkJMY2mRNf7CMfJ
         hvdTtxsMoiLB/Q4wTCFELyQvScOWaIo0B6IdbgZK4knGYSLhNZcM94dhtCpxqPG68r6T
         JXhCPANy28n5NElfUJSqQYjQqTw0dA9kGPB6F/EPWnGbaLSJKQovG7FWnfA6FTs7MGHA
         cq/qEp9AF949Ynit4fDp/D5enZnBc9QBbRDEVeanAh/y3fK0+lVTaKVdPdBY39ZeRq5f
         Hcgw==
X-Gm-Message-State: AOAM531JDu3xcA1EzoO6OigO8WBByLy7tGxPEKJ1ZCi6KsntWrLTvzVI
        L8S+yHTFynHgzU3lcUuVqJOPy10hoHYyC+dieW0ZKtUY2tQ=
X-Google-Smtp-Source: ABdhPJwya9MBXOJDaGDUWW3onBQxtGWFUCQ2edjOVbFCNDKleAia89rr6K99UVBjjzaW4n6/gD4Z3BV8PuuLj2I/+b4=
X-Received: by 2002:a25:4d83:: with SMTP id a125mr36992939ybb.277.1635834370854;
 Mon, 01 Nov 2021 23:26:10 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Schiff <schiff.michael@gmail.com>
Date:   Mon, 1 Nov 2021 23:26:00 -0700
Message-ID: <CAJcz5TVsv20+FmHR67_UhL_7rhEGvfPHeP3RMiRtnSGAEKiwBg@mail.gmail.com>
Subject: Possible merge bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Summary]
Issue occurs when two branches reorder lines of the same file and are
then merged back to the base branch. Instead of getting a content
merge conflict, the branches are merged successfully and a line in the
file is duplicated.


[Steps to Reproduce]
1. initialize a new repository and create a file with three lines of content:
```
a
b
c
```
and commit the result

2. branch from this commit and modify the contents of the file to be:
```
b
a
c
```
and commit the results

3. checkout master at commit from step one

4. branch from this commit and modify the contents of the file to be:
```
b
c
a
```
and commit the results

5. checkout master at the commit from step one

6. merge the first branch (results in ff-merge)

7. merge the second branch (results in auto merge_3way)

8. examine file contents:
```
b
a
c
a
```

[Expected Behavior]
I expected to get a content merge conflict when attempting to merge
the second branch.  If the example is changed to be a file starting
```
a
b
c
d
```
with two branches that change it to
```
c
a
b
d
```
and
```
c
d
a
b
```
respectively, and then the same sequence of merges, this is detected
as a merge conflict as I would expect the single line case to be.

[What Happened Instead]
Instead merge succeeds without conflict and results in duplication of
a line in the file


[System Info]
git version:
git version 2.34.0.rc0.377.g6d82a21a3b
cpu: x86_64
built from commit: 6d82a21a3b699caf378cb0f89b6b0e803fc58480
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Wed Jun 23 00:26:31
PDT 2021; root:xnu-7195.141.2~5/RELEASE_X86_64 x86_64
compiler info: clang: 13.0.0 (clang-1300.0.29.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

[Other Details]
I tried this experiment with a few different merge strategies and got
the same result regardless of which I picked.  I did some rudimentary
debugging and tracked handling of the merge for this file through
merge-ort.c -> merge_3way -> ll_merge -> xdiff/xmerge.c -- It seems
xdiff/xmerge is responsible for attempting the actual merge, deciding
if there are conflicts and dropping the usual markers, or successfully
auto-merging the changes.  Wasn't sure of the testing process for
xdiff and figured I would put this to the mailing list for feedback.
