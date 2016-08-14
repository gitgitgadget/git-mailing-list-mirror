Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120631FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 15:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbcHNP6g (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 11:58:36 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33573 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbcHNP6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 11:58:35 -0400
Received: by mail-oi0-f44.google.com with SMTP id c15so37148044oig.0
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 08:58:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=JxS3u0SsCsprz5LFms3ulzJiyvPzb1PfQxsNpKELwwY=;
        b=K4cRqk++ckk1jzbljaIxYOPYY7NiVgkLvuL7Ybw3/NttUM1FKfsl8O2c1UOtWVxuH8
         Orhr5S3nyEI5yL3tutllyXjNZJ6IddHP+U11kLVSrZLDJZpICNfFjj383jSTWmoCMNsV
         aEcSSr49wbQtenZ/mvbR8rcuD6UQHfEYbLdM1ddFesSdXw9+LASUSEdK9cdOmqtSB1jG
         0X/J/9MpWEveSFUKeHUA9/blDsXUb4nIgqxtWk/98J3GE4hMNWiJbL7zSQCHS7EtmFmR
         V45zxkhS8BRSpOPEnaBko8Y+kjMi6BXNI8QjhF6iZaJdRA+6T7Dc69TIhjCMTH0+Vp8s
         Pj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JxS3u0SsCsprz5LFms3ulzJiyvPzb1PfQxsNpKELwwY=;
        b=Nc7e4pLjrOeQCmR3CR+8vMlgjUR/muytgeIBxAKxE7dBetDo19Y9uJ83KvEpepWQvI
         RJJt5fnx5PhM/G8OyL41PHR5aJNsZA7srXE2a5ty36uRa6DvgjB6ZLsOYQDFxKzal4/s
         sJSAcisdKkj7HNIdifTn2Bon7RGVdHh0LwrW9RViP/Ljn+ng8HbT6hauTSynDMLdDr3w
         NhTO1nL8+zfwc3syn7mz9HcGrc2OVCFEEW71IDO7V9ff+p5Yp63bPSaKqoOHLHUOayls
         QZ/Szj+SJ0MXUCDdVR9krppjCG7oePggMRvRddRkCqaa6OVxMRJ8/UeRTDWODlqjtapA
         s5yw==
X-Gm-Message-State: AEkoouu/NDakXzJXQ7ABzZGftBEjzNtOPF2cpWpPTS4R6W4Z2i2rVyuNOdfRk12qR2dLAULEGmQDCfzWQny3tg==
X-Received: by 10.157.1.49 with SMTP id 46mr9070437otu.99.1471190314099; Sun,
 14 Aug 2016 08:58:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.245.203 with HTTP; Sun, 14 Aug 2016 08:58:13 -0700 (PDT)
From:	ryenus <ryenus@gmail.com>
Date:	Sun, 14 Aug 2016 23:58:13 +0800
Message-ID: <CAKkAvaxWk6SK4EYPaWXHQoVBh9qLgHoEqAh9+dgOrjncsi5QyA@mail.gmail.com>
Subject: [PATCH] make rebase respect core.hooksPath if set
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

when looking for pre-rebase and post-rewrite hooks, git-rebase
only looks for hooks dir using `git rev-parse --git-path hooks`,
which didn't consider the path overridden by core.hooksPath.

Signed-off-by: ryenus <ryenus@gmail.com>
---
 git-rebase--interactive.sh | 14 +++++++++-----
 git-rebase--merge.sh       |  4 +++-
 git-rebase.sh              |  7 +++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e2da524..e8af70d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -724,11 +724,15 @@ Commit or stash your changes, and then run
  git notes copy --for-rewrite=rebase < "$rewritten_list" ||
  true # we don't care if this copying failed
  } &&
- hook="$(git rev-parse --git-path hooks/post-rewrite)"
- if test -x "$hook" && test -s "$rewritten_list"; then
- "$hook" rebase < "$rewritten_list"
- true # we don't care if this hook failed
- fi &&
+ {
+ hooks_path=$(git config --get core.hooksPath)
+ hooks_path="${hooks_path:-$(git rev-parse --git-path hooks)}"
+ hook="${hooks_path}/post-rewrite"
+ if test -x "$hook" && test -s "$rewritten_list"; then
+ "$hook" rebase < "$rewritten_list"
+ true # we don't care if this hook failed
+ fi
+ } &&
  warn "$(eval_gettext "Successfully rebased and updated \$head_name.")"

  return 1 # not failure; just to break the do_rest loop
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 06a4723..df5073e 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -96,7 +96,9 @@ finish_rb_merge () {
  if test -s "$state_dir"/rewritten
  then
  git notes copy --for-rewrite=rebase <"$state_dir"/rewritten
- hook="$(git rev-parse --git-path hooks/post-rewrite)"
+ hooks_path=$(git config --get core.hooksPath)
+ hooks_path="${hooks_path:-$(git rev-parse --git-path hooks)}"
+ hook="${hooks_path}/post-rewrite"
  test -x "$hook" && "$hook" rebase <"$state_dir"/rewritten
  fi
  say All done.
diff --git a/git-rebase.sh b/git-rebase.sh
index 04f6e44..c9ba747 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -203,10 +203,13 @@ run_specific_rebase () {
 }

 run_pre_rebase_hook () {
+ hooks_path=$(git config --get core.hooksPath)
+ hooks_path="${hooks_path:-$(git rev-parse --git-path hooks)}"
+ hook="${hooks_path}/pre-rebase"
  if test -z "$ok_to_skip_pre_rebase" &&
-   test -x "$(git rev-parse --git-path hooks/pre-rebase)"
+   test -x "$hook"
  then
- "$(git rev-parse --git-path hooks/pre-rebase)" ${1+"$@"} ||
+ "$hook" ${1+"$@"} ||
  die "$(gettext "The pre-rebase hook refused to rebase.")"
  fi
 }
-- 
2.9.3
