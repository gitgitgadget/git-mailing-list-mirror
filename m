Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8F4C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 15:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiC0Pnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiC0Pnt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 11:43:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2612334B96
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 08:42:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2e5e31c34bfso125279587b3.10
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UWR8PbVWxe7GGgp/nLePADDHY5NM5CaLtXWLsYK66gE=;
        b=UE9EQHFG6sFZv+CXnXh39sk41Y7zN3lWhgz9uyzg4tZrUq32DyMHuQWDyofzexISNd
         nOKiCjLVOR2ovYjgL4/VZjLWGD7+Hdi4V+E2KhXOMi0hB4o30w6liQI9ay+chXrS6Ks8
         Ds2NBXpqu+BJ7JK5Cisw5jqlAQnKZKmp3oD/rUYJKkYGr/KMKwN5qN8OJ4yrCitRhwnR
         OvhQgKsaRKpVhl3qcz66seqqhhynjOYfdNLxRzLz9bRTrfwE7nIdpl6Y0GHfxrZGLL+b
         Afx++wTsK53vnLreECUIf+n1Scw1DDlb7+LTyCfBjWgxzzpfm5SpgURGAI0qdC2X+4Jl
         BJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UWR8PbVWxe7GGgp/nLePADDHY5NM5CaLtXWLsYK66gE=;
        b=a2z/ckBKS2mBXOEG0tzoxlWP0OTK72YpJhYYGFgYknwILwqpqzXSQtzH8JglIHzDd7
         anWpcJw0xUA4L8C1kLQZEU0icn419crew8OzWMewbtlFXo5T653MnY9IA4GQ8PjlKEnP
         WB5fooXz0d5xfpCvfNuOms/DbpddNMDFAXUnGB325pvNQE8G8W8q/KnmArjcuCPms9W1
         v30YcBcwcV6lxyZsXwyUQuN0d6OzBkSPXDPzmtuLFKIfnMOK1GYSwBch54p7gbA8NeYo
         DRUs76ELCNhAI5gPsNivlVmF4F1pSxjHXnf/Bg5Ms3pCzxJV3fWZjQNa8jPTZaxAPKx9
         50ow==
X-Gm-Message-State: AOAM532US4kMIWYtJMzwsd2oUQMudsF1s3BftuDmlpnBtTdDA2LNjZd0
        tKMXFcAWiaQnQuZYbK2a4k7tJr2txSYC2miSPpRMA8oQhz81UA==
X-Google-Smtp-Source: ABdhPJx/stHVTBCn1jO21krikhyufOgzZfUbhUpltG6mQGX0QLejxTv749ZhViOSmTDYES2n1iWyPTEvh0Baw9Q2Wmc=
X-Received: by 2002:a81:78d:0:b0:2e5:d440:d921 with SMTP id
 135-20020a81078d000000b002e5d440d921mr19988203ywh.251.1648395728204; Sun, 27
 Mar 2022 08:42:08 -0700 (PDT)
MIME-Version: 1.0
From:   Guillaume Cogoni <cogoni.guillaume@gmail.com>
Date:   Sun, 27 Mar 2022 17:41:57 +0200
Message-ID: <CAA0Qn1sBF=PAduCQCXbYkeu4cphw7O+AnvwFNMWijuKYskaT8g@mail.gmail.com>
Subject: [WIP]: make merge nicer to the user
To:     git@vger.kernel.org
Cc:     Matthieu.Moy@univ-lyon1.fr, git.jonathan.bressat@gmail.com,
        guillaume.cogoni@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
We were working on a patch to make merge nicer to the user on
tracked/untracked merge conflicts.
You can see that idea on this page:
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

When merging a commit which has tracked files with the same name as local
untracked files, Git refuses to proceed.
We want to change this behaviour. The idea is to check if the untracked and
the tracked file has the same content, so we can overwrite it.


Examples of use cases where it can be interesting:
The scenarios are the following:

A team member is modifying the templates for a website we are working on.
They are adding some images to the images directory (but forgets to add
them under source control).
They are sending the images by mail, later, to me.
I'm adding the images under the source control and pushing them to
GitHub together with other changes
They cannot pull updates from GitHub because Git doesn't want to
overwrite their files.
Source : https://stackoverflow.com/questions/1125968/how-do-i-force-git-pull-to-overwrite-local-files

When using rsync to get files from a distant directory, but then those
files are pushed on a repo from the distant directory, you don't want to
reset the change when you just need to pull the repo because files are
the same.


The following parts is our test file:

diff --git a/t/t7615-merge-conflict.sh b/t/t7615-merge-conflict.sh
new file mode 100644
index 0000000000..4d89fe99ed
--- /dev/null
+++ b/t/t7615-merge-conflict.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Copyright (c) 2022 Cogoni Guillaume and Bressat Jonathan
+#
+test_description='merge conflitct'
+. ./test-lib.sh
+
+test_expect_success '[FAST_FORWARD] merge conflict when untracked
file and tracked file have the same name and content' '
+ echo content >readme.md &&
+ test_commit "README" readme.md &&
+ git branch B &&
+ git checkout -b A &&
+ echo content >file &&
+ test_commit "tracked_file" file &&
+ git switch B &&
+ echo content >file &&
+ test_merge merge A
+'
+
+test_expect_success '[MERGE] merge conflict when untracked file and
tracked file have the same name and content' '
+ echo content >readme.md &&
+ test_commit "README" readme.md &&
+ git branch A &&
+ git checkout -b B &&
+ echo content1 >file1 &&
+ test_commit "B_tracked_file" file1 &&
+ git checkout A &&
+ echo content2 >file2 &&
+ test_commit "A_tracked_file" file2 &&
+ git switch B &&
+ echo content2 >file2 &&
+ test_merge merge A
+'
+
+test_expect_thatfailure 'merge conflict when untracked file and tracked
file have not the same content but the same name' '
+ echo content >readme.md &&
+ test_commit "README" readme.md &&
+ git branch B &&
+ git checkout -b A &&
+ echo content1 >file &&
+ test_commit "tracked_file" file &&
+ git switch B &&
+ echo content2 >file &&
+ test_merge merge A
+'
+
+test_done
Those tests must have assert in the end but it's just to explain our idea.

Our research lead us to these functions:

verify_absent_1() from /unpack-trees.c seems to be called for all files
and it check if a file from the merged branch exists in the current
branch in regard of the name and the path (In our test above, if a file
from the branch A exist in the branch B.). Then call check_ok_to_remove()
from /unpack-trees.c when an untracked file with the same name than a
tracked file on the merged branch is spotted.

static int verify_absent_1(const struct cache_entry *ce,
enum unpack_trees_error_types error_type,
enum absent_checking_type absent_type,
struct unpack_trees_options *o);

static int check_ok_to_remove(const char *name, int len, int dtype,
const struct cache_entry *ce, struct stat *st,
enum unpack_trees_error_types error_type,
enum absent_checking_type absent_type,
struct unpack_trees_options *o);


We think that a good way to solve this problem is to check the hash
of the tracked and untracked file in check_ok_to_remove and then if
they are similar we can
overwrite it (return 0). The hash is in ce->object_id.
In fact, it's more efficient than decompress the file and check
the content.

Do you think, we are going in the good way, and is it a good idea ?

thanks for your help and review.

Guillaume Cogoni and
Jonathan Bressat
