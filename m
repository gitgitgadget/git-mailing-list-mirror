Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35BDC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 21:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGVVXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 17:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGVVXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 17:23:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D07B5C81
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 14:23:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p10so1997457lfd.9
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8+O+ynw/raEHKeIuRYhc5J2hRidyabdDPoFGekbr0w=;
        b=aNWQteMDE1QAuaF8psioiicIZpQVPiecJHebC7jmprXgXgMIYkJsDcqE8yIwOe+IIV
         TV9HtLAj8K2821OVBHYrKcHoRJy9X8tqddSZOUriEvhc3k6dgR+A/3b0nFuQbcuGtrP0
         Qxhjc6EcS6Nv9CPjpVWLf6zbDF6C6B+D3a4uBL7k3yxA/bV24UfTURPd7N0ESuVAs1sy
         0+y0Ujj//ic8HU2K6ZcxMgsQVHNYI4DO0m9EU1YHYTmt3uhxppMhPzQm6QMpLza55Gc0
         Qtgwjo+i8v68EStich3eIXPEPUILZW385+x8dujnDEM2u3JQAW41TKrn1gibU75l/KHC
         lzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8+O+ynw/raEHKeIuRYhc5J2hRidyabdDPoFGekbr0w=;
        b=dIlK7iqkmLWLLLHf3W594dxwDjN8kdPk63IvUiDPAechIaDZX9cbkObmClAUpxQgrN
         VSImZ0pb/es0VDdO31D+x3Tkn8aDC7TSjpRUtlIMamt68ll5NOAZlFm+ORMu+jZiWDiQ
         E1Rl5OVtSKow+7xmSXdRXkTq5TdUKMJ06mKhx5qLc1M63N4nATeaoU41zjqMpmh2ugDa
         ViznxcyzOXW8I+fUnx3xNrlyjQ+5wqQ/imO1g1lwiMAjiPGyVeINLoSqvUHbSj9YxHgq
         PazMI6qtWshkjjm/a8s9o2+CsrN1/klHDcqvIcNfTvb3uxt7+EE6FzFl8lD9tgcxda4U
         BImw==
X-Gm-Message-State: AJIora8bhj+vmD2nsFP1WXfI2qQvKJeej2IeBoRtq0Q+5b3Ht6wdLd/F
        CiNOjeH01htU1EaDZTZ0Zgw=
X-Google-Smtp-Source: AGRyM1v8f5xwL2+FY4thqKSrTNVxihdC214dBeIl5R2Y4QUjVBGetejN+X2xJ30foNbDbciP+6MK3Q==
X-Received: by 2002:a05:6512:130d:b0:48a:28a1:d40e with SMTP id x13-20020a056512130d00b0048a28a1d40emr707384lfu.169.1658525022930;
        Fri, 22 Jul 2022 14:23:42 -0700 (PDT)
Received: from localhost.localdomain (81-231-137-145-no600.tbcn.telia.com. [81.231.137.145])
        by smtp.gmail.com with ESMTPSA id y17-20020ac24211000000b0047f963bf815sm1253625lfh.93.2022.07.22.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:23:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Tao Klerks <tao@klerks.biz>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH] read-cache: make `do_read_index()` always set up `istate->repo`
Date:   Fri, 22 Jul 2022 23:22:32 +0200
Message-Id: <20220722212232.833188-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5
In-Reply-To: <xmqq35etc4vm.fsf@gitster.g>
References: <xmqq35etc4vm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Jul 2022 at 21:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin Ågren <martin.agren@gmail.com> writes:
>
> > I can't help but think that e6a653554b was just unlucky enough to
> > dereference `istate->repo` and that the real issue is that we're missing
> >
> >       if (!istate->repo)
> >               istate->repo = the_repository;
> >
> > in some strategic place a fair bit earlier. It seems to me like the diff
>
> Perhaps backtrace to see where the istate came from would quickly
> reveal where the real issue lies?

Here's an attempt at finding a proper spot for such a check. We end up
with a small amount of duplicated code, but I think it should be ok,
especially for a bugfix.

This is on top of tk/untracked-cache-with-uall and conflicts with
491df5f679 ("read-cache: set sparsity when index is new", 2022-05-10).
The conflict could be resolved by taking my hunk before Victoria's
[after which her helper function could be simplified accordingly] -- at
least that passes all the tests.

I'm a bit out of my depth here. Hopefully one of the area experts can
say more about this approach.

Martin

-- >8 --

If there is no index file, e.g., because the repository has just been
created, we return zero early (unless `must_exist` makes us die
instead.)

This early return means we do not set up `istate->repo`. With
`core.untrackedCache=true`, the recent e6a653554b ("untracked-cache:
support '--untracked-files=all' if configured", 2022-03-31) will
eventually pass down `istate->repo` as a null pointer to
`repo_config_get_string()`, causing a segmentation fault.

If we do hit this early return, set up `istate->repo` similar to when we
actually read the index.

Reported-by: Joey Hess <id@joeyh.name>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 read-cache.c                      | 5 ++++-
 t/t7063-status-untracked-cache.sh | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 3e0e7d4183..68ed65035b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2268,8 +2268,11 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->timestamp.nsec = 0;
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (!must_exist && errno == ENOENT)
+		if (!must_exist && errno == ENOENT) {
+			if (!istate->repo)
+				istate->repo = the_repository;
 			return 0;
+		}
 		die_errno(_("%s: index file open failed"), path);
 	}
 
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 9936cc329e..7dc5631f3d 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -985,4 +985,10 @@ test_expect_success '"status" after file replacement should be clean with UC=fal
 	status_is_clean
 '
 
+test_expect_success 'empty repo (no index) and core.untrackedCache' '
+	git init emptyrepo &&
+	cd emptyrepo/ &&
+	git -c core.untrackedCache=true write-tree
+'
+
 test_done
-- 
2.37.1.455.g008518b4e5

