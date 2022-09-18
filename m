Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FE3C32771
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 12:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIRMLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIRMLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 08:11:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0574255A9
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 05:11:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o7so15144095qkj.10
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cpmMzzf6Z00XM5hYI2x7VKDNslI2OyMWscw+1VqMpxo=;
        b=LIW5Ud6UAVHPpub20nlH48AMCJe38vp3DBrf6r3MMlmJ7GCukxAaLHlzO7G/FC9hHh
         bKlGLorXKJK3IrwftZR71Conf0lShnm7hcyoJyux3Pe43Af4QDMubpEO3kZDc6UxmLo1
         GVTd1iy4EuZSFQ2MACgomAfPQKONVBRvpbf3KRcJgzKT1zDnb2koGu07vedRatY+u3Ie
         bt9agT/OA6YV2sbnGitBLrV6gRHL/CeA3T6j3RjPvI7+Wlg0SHOuZWqu6Qci5Od9YrEs
         AIvtQl52JujRBMoEn+IFdPOYdMeWiLA8hP9nAg1Q5tir+A6/ppLBi9xAhBsqc/dviVoo
         3xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cpmMzzf6Z00XM5hYI2x7VKDNslI2OyMWscw+1VqMpxo=;
        b=yYZEBwGG+VYOnERgXs1p49ZDPmPuFvd+wSv+KRYuKgwFyLXelBTcAlr+mLOoIiV/BH
         5CN5PVQxH3SysQ4cyv+OE8Z8720x4hVwUoYD+zfw5+XWpaAq14XKxlluXupwgQZJGUNH
         tIeKKa0F6gyc9jRdY01R30SIBHaNnV8M0+1JuggPZ0tLNpJ77ySBrP/bM6px7ErMBrss
         sOHvynCBfKEV+WfU4iFt0KMf+WWYiDRVkMaNJ88/+EhxvUaB2qw5zpsp6TLvIucQPsRW
         Y/XMN+X8CSyKqD/n5z3ZhLmM51cpwJ8Ix2wl/exf8bbcA+WuIIm3orHHUSotJehP1Jsw
         +lVA==
X-Gm-Message-State: ACrzQf0u45Dz6M1RpsTMB1/Y0Rysrt/lNR2+G3+og5/6cwdcJLZ+7x0h
        R/JxVvoDOfp2SuMKuzcJSZw=
X-Google-Smtp-Source: AMsMyM4f4pQ9rtS/t6ATi7oUUul3BiIBD37RrTahQE8UAXsYPHRRusB5M7geYLwzFzBOdzMxiVfCWg==
X-Received: by 2002:a05:620a:1239:b0:6ce:24c1:12d7 with SMTP id v25-20020a05620a123900b006ce24c112d7mr9737095qkj.496.1663503078433;
        Sun, 18 Sep 2022 05:11:18 -0700 (PDT)
Received: from localhost.localdomain (207-237-203-247.s3058.c3-0.arm-cbr1.chi-arm.il.cable.rcncustomer.com. [207.237.203.247])
        by smtp.gmail.com with ESMTPSA id c16-20020a05622a025000b0031f287f58b4sm9113384qtx.51.2022.09.18.05.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 05:11:18 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH] sequencer: avoid dropping fixup commit that targets self via commit-ish
Date:   Sun, 18 Sep 2022 07:10:53 -0500
Message-Id: <20220918121053.880225-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.37.3.830.gf65be7a4d6
In-Reply-To: <YyZWDkZWAkS7q+Wf@gmail.com>
References: <YyZWDkZWAkS7q+Wf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 68d5d03bc4 (rebase: teach --autosquash to match on sha1 in
addition to message, 2010-11-04) made --autosquash apply a commit
with subject "fixup! 012345" to the first commit in the todo list
whose OID starts with 012345. So far so good.

More recently, c44a4c650c (rebase -i: rearrange fixup/squash lines
using the rebase--helper, 2017-07-14) reimplemented this logic in C
and introduced two behavior changes.
First, OID matches are given precedence over subject prefix
matches.  Second, instead of prefix-matching OIDs, we use
lookup_commit_reference_by_name().  This means that if 012345 is a
branch name, we will apply the fixup commit to the tip of that branch
(if that is present in the todo list).

Both behavior changes might be motivated by performance concerns
(since the commit message mentions performance).  Looking through
the todo list to find a commit that matches the given prefix can be
more expensive than looking up an OID.  The runtime of the former is
of O(n*m) where n is the size of the todo list and m is the length
of a commit subject. However, if this is really a problem, we could
easily make it O(m) by constructing a trie (prefix tree).

Demonstrate both behavior changes by adding two test cases for
"fixup! foo" where foo is a commit-ish that is not an OID-prefix.
Arguably, this feature is very weird.  If no one uses it we should
consider removing it.

Regardless, there is one bad edge case to fix.  Let refspec "foo" point
to a commit with the subject "fixup! foo". Since rebase --autosquash
finds the fixup target via lookup_commit_reference_by_name(), the
fixup target is the fixup commit itself. Obviously this can't work.
We proceed with the broken invariant and drop the fixup commit
entirely.

The self-fixup was only allowed because the fixup commit was already
added to the preliminary todo list, which it shouldn't be.  Rather,
we should first compute the fixup target and only then add the fixup
commit to the todo list. Make it so, avoiding this error by design,
and add a third test for this case.

Reported-by: Erik Cervin Edin <erik@cervined.in>
Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 sequencer.c                  |  4 ++--
 t/t3415-rebase-autosquash.sh | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 484ca9aa50..777200a6dc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6287,8 +6287,6 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 			return error(_("the script was already rearranged."));
 		}
 
-		*commit_todo_item_at(&commit_todo, item->commit) = item;
-
 		parse_commit(item->commit);
 		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");
 		find_commit_subject(commit_buffer, &subject);
@@ -6355,6 +6353,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 					strhash(entry->subject));
 			hashmap_put(&subject2item, &entry->entry);
 		}
+
+		*commit_todo_item_at(&commit_todo, item->commit) = item;
 	}
 
 	if (rearranged) {
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 78c27496d6..879e628512 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -232,6 +232,50 @@ test_expect_success 'auto squash that matches longer sha1' '
 	test_line_count = 1 actual
 '
 
+test_expect_success 'auto squash that matches regex' '
+	git reset --hard base &&
+	git commit --allow-empty -m "hay needle hay" &&
+	git commit --allow-empty -m "fixup! :/[n]eedle" &&
+	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
+	cat <<-EOF >expect &&
+	pick HASH hay needle hay # empty
+	fixup HASH fixup! :/[n]eedle # empty
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'auto squash of fixup commit that matches branch name' '
+	git reset --hard base &&
+	git commit --allow-empty -m "wip commit (just a prefix match so overshadowed by branch)" &&
+	git commit --allow-empty -m "tip of wip" &&
+	git branch wip &&
+	git commit --allow-empty -m "unrelated commit" &&
+	git commit --allow-empty -m "fixup! wip" &&
+	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^^^ &&
+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
+	cat <<-EOF >expect &&
+	pick HASH wip commit (just a prefix match so overshadowed by branch) # empty
+	pick HASH tip of wip # empty
+	fixup HASH fixup! wip # empty
+	pick HASH unrelated commit # empty
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'auto squash of fixup commit that matches branch name which points back to fixup commit' '
+	git reset --hard base &&
+	git commit --allow-empty -m "fixup! self-cycle" &&
+	git branch self-cycle &&
+	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
+	cat <<-EOF >expect &&
+	pick HASH second commit
+	pick HASH fixup! self-cycle # empty
+	EOF
+	test_cmp expect actual
+'
+
 test_auto_commit_flags () {
 	git reset --hard base &&
 	echo 1 >file1 &&
-- 
2.37.3.830.gf65be7a4d6

