Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7881F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfJJXfC (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:35:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39987 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfJJXfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 19:35:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so7024415edm.7
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 16:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zaFvQczaGqyFvQiHNroE3DH7T/c7UztwECotja/hiGI=;
        b=iNtE4Qmuj3RYnm6QztS5ujh+XFYpfvWuqxI+claJs92yhB7mbvZsmhsMzXGPTh4+Lf
         1/ZKeTon+b0SwQtXx1iWZ1Zv50OIk9O2743rTuGyEywy9Ry9RjDLnqyfKW25TVsuKLIz
         F8c6C+kV3ucRjZIKl2Csbr2cGgaxd0xmKLbRZHK77JIjoJCGP/8P6KuU+SXezquCFMfs
         dUBaXQ6C+MqeMICGxubAt9L7z0zOm/mMplxscoAO2pEvKZBqxMyiVGWXzJNv1S9+8ooZ
         xZ2kc/aPMDNZUXTMAxhXFJJgIYIcBP7AoA8uAKL5bYW/ZYAyXwOs4d49Wezbbl/4h7+x
         /GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zaFvQczaGqyFvQiHNroE3DH7T/c7UztwECotja/hiGI=;
        b=rjvnjf+nRUWD804SorU9D51Dvg/NzN5SK0k56WIJxChIuMMGfVfuoU/wnLa6iGnG0U
         79K5wePpDykT8jnP3EtGb02euT2fhusml2HTbDLtSls59euDhk5KBMf+mEs9Jx9e+LnS
         t4CoXbhmpGagyXaPTbXErkOXvzsJ/uHPyf1CCrI/JR/0pnpDsTgxO67Hz4irGJWkIZ+s
         Ee2VsUSyyrUAWHo/N04vjc7tPnQVc5SCD5Sr/2P8neeiUbgEuGcpuT7QIq6JWu7z3+AI
         cyAd9B1yWY/3BHiZdItKG8oIFP9hft35ln+bWZxfyZK3P+3LmDNaSMdxJ6prbsOM/UwM
         rPow==
X-Gm-Message-State: APjAAAXy8Ug+Se2zdWYdEI27aek3pptjwwF5eLUo1lfHWjqUQYv9qMbu
        nSJwz2pSeE3rw5wK3ofGqq9mcmLiSqqZ5Ym3k7fT1LHz
X-Google-Smtp-Source: APXvYqygvhqdBwJ/1A2ZRCn1mUlpRxZDGSq6SKa/Qqr9g5rEYIOisIMx6FWLwNohWvqohZUwzuXPVoqu7hN1RLQAuuk=
X-Received: by 2002:a17:906:7f03:: with SMTP id d3mr11120029ejr.209.1570750500334;
 Thu, 10 Oct 2019 16:35:00 -0700 (PDT)
MIME-Version: 1.0
From:   Jakob Jarmar <jakob.j@gmail.com>
Date:   Fri, 11 Oct 2019 01:34:56 +0200
Message-ID: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
Subject: [PATCH] stash: avoid recursive hard reset on submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash push does not recursively stash submodules, but if
submodule.recurse is set, it may recursively reset --hard them. Having
only the destructive action recurse is likely to be surprising
behaviour, and unlikely to be desirable, so the easiest fix should be to
ensure that the call to git reset --hard never recurses into submodules.

This matches the behavior of check_changes_tracked_files, which ignores
submodules.

Signed-off-by: Jakob Jarmar <jakob@jarmar.se>
---
 builtin/stash.c     | 2 +-
 git-legacy-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b5a301f24d..c986c258f2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1383,7 +1383,7 @@ static int do_push_stash(const struct pathspec
*ps, const char *stash_msg, int q
             struct child_process cp = CHILD_PROCESS_INIT;
             cp.git_cmd = 1;
             argv_array_pushl(&cp.args, "reset", "--hard", "-q",
-                     NULL);
+                     "--no-recurse-submodules", NULL);
             if (run_command(&cp)) {
                 ret = -1;
                 goto done;
diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
index f60e9b3e87..07ad4a5459 100755
--- a/git-legacy-stash.sh
+++ b/git-legacy-stash.sh
@@ -370,7 +370,7 @@ push_stash () {
             git diff-index -p --cached --binary HEAD -- "$@" |
             git apply --index -R
         else
-            git reset --hard -q
+            git reset --hard -q --no-recurse-submodules
         fi

         if test "$keep_index" = "t" && test -n "$i_tree"
-- 
2.23.0
