Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8701FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbcH2Tu3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:50:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32932 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbcH2Tu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:50:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so172549wme.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWyOCoS7D+hLuv9DslWAa/B5CoGwjbUSXz/znlS5Q1Y=;
        b=YOKmoZtJZFy+lPEp2GmOAciQIlnNXJGRljSAwKja23h195ztdbUpgMSAUkPsiA0Qqu
         8vr5HZ1M8/eBNBsvBXNrScr+zTlF6wDg7MCXHZqiXMZNxWU9XAbsMlgojqkN2O6Y2fsR
         caLcX4kgngngR7oe70Vvqcvf2LkOBnpqEWfFueb9hQ1IzpKTwlJH/VBfXQ9IYJq+Ldty
         LFtuqULcy/XbTo5H944tBP4UaxFuzv16eYaGwM/V+uZvQpaQ6iOlXuZOyrezhF4Jsxej
         7ZWvvQbfK4YdTrDmEEKQpIYR7U/gBUQtF4Y73vMDHuflYDoZNSbIFDbfa+4CT9P34XNT
         Dz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sWyOCoS7D+hLuv9DslWAa/B5CoGwjbUSXz/znlS5Q1Y=;
        b=lyaZIuC1fPg3R2JrA/y5Dsjiwo/UzZdqGBl6H/+LQjbWn/whH4KpZd+S6bthPvopP4
         lO1G+rG+XJFjANqRtEwVecacAx7u7QmGmHhiWCTR1IEZrGoSKnG6WfB9R0jUIuJXIsAh
         VL30CQHyb3mKRg8K29nXoE+Q0jFe3KKWIBUSqowHDUZ40VN4/l2ElnLoMWtfEC6UR6XF
         QvtDTYaF6Ox4gw8nFzEqrDxP6mf/H4C0XlCnbutzVxWqoibwygqd34z6A99d1jbE9thy
         yc0EH7sJ8BFpDzNGp8LQUaMhvHA9/EmiYR6rtBGvwRlKXDVyjXQ43HlcNSo3OugdaEtz
         tKsg==
X-Gm-Message-State: AE9vXwPtP1aO+2ZPReOGzaSg33fGQB63Yi7deqFTknAupmGCH2EJlO7xtTYS+RECR9ocvg==
X-Received: by 10.194.187.7 with SMTP id fo7mr17174778wjc.162.1472500227451;
        Mon, 29 Aug 2016 12:50:27 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id i80sm292163wmf.11.2016.08.29.12.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Aug 2016 12:50:26 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2] blame: fix segfault on untracked files
Date:   Mon, 29 Aug 2016 20:50:19 +0100
Message-Id: <20160829195019.30876-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.rc2.246.g4fd2c60
In-Reply-To: <xmqqeg57bfcu.fsf@gitster.mtv.corp.google.com>
References: <xmqqeg57bfcu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 3b75ee9 ("blame: allow to blame paths freshly added to the index",
2016-07-16) git blame also looks at the index to determine if there is a
file that was freshly added to the index.

cache_name_pos returns -pos - 1 in case there is no match is found, or
if the name matches, but the entry has a stage other than 0.  As git
blame should work for unmerged files, it uses strcmp to determine
whether the name of the returned position matches, in which case the
file exists, but is merely unmerged, or if the file actually doesn't
exist in the index.

If the repository is empty, or if the file would lexicographically be
sorted as the last file in the repository, -cache_name_pos - 1 is
outside of the length of the active_cache array, causing git blame to
segfault.  Guard against that, and die() normally to restore the old
behaviour.

Reported-by: Simon Ruderich <simon@ruderich.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
> The point of this fix is not that we show the exact error message,
> but we fail in a controlled manner.  I think
>
> test_expect_success 'blame untracked file in empty repo' '
>                >untracked &&
>                test_must_fail git blame untracked
>        '
>
> is sufficient.

Yeah, I agree with that.

Thanks for the review!

 builtin/blame.c  | 3 ++-
 t/t8002-blame.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 7ec7823..a5bbf91 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2244,7 +2244,8 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos >= 0)
 		; /* path is in the index */
-	else if (!strcmp(active_cache[-1 - pos]->name, path))
+	else if (-1 - pos < active_nr &&
+		 !strcmp(active_cache[-1 - pos]->name, path))
 		; /* path is in the index, unmerged */
 	else
 		die("no such path '%s' in HEAD", path);
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index ff09ace..ab79de9 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -6,6 +6,11 @@ test_description='git blame'
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
+test_expect_success 'blame untracked file in empty repo' '
+	>untracked &&
+	test_must_fail git blame untracked
+'
+
 PROG='git blame -c -e'
 test_expect_success 'blame --show-email' '
 	check_count \
-- 
2.10.0.rc2.246.g4fd2c60

