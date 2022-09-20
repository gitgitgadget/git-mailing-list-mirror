Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B964C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 03:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiITDM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiITDMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 23:12:25 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C236DF1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 20:12:23 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id ay9so945743qtb.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 20:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DTXAb8yez5LzVKeKUKO9fYRqyQz3e4AsD5Cc9Ikz6A0=;
        b=QPDwB3E5HWXcfyuvZfI0fb0LZTzNHBYpoR+J2YvQKEucIrOV3CKFqVaa0cNRDOm6Km
         bwtvZ5CaTqbVNFQh50cglCS/R6u9Afp2IWABrZ4pC9t7Cc8bVIgEFxoDJMFofFFg8lTb
         gBW/7VpsAVKZbHQK6pxIjscxq9qnBHObnQNtEtvnhMpFeamk4F1mHV/5+/vROfvzXxV/
         OtV7z4m4hZFLHYzadw1HQwGyul/3C9Y/6s+OhiZdrNkPNzI/B6YesfK8Nx6PDz2CIACg
         yzxyqa9kvW1vf4+vyJ/i0ajk8lOxJh2F+HKcvbZQNFjFb52dBqlMQ+aDUc9wd1QXEKZ4
         GGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DTXAb8yez5LzVKeKUKO9fYRqyQz3e4AsD5Cc9Ikz6A0=;
        b=GHmkvjTNwmzE6swZKa07fX4IgY8EcyHdxrADouNkUu4j2bgYMdAz6gKxwXRWZKOfxg
         UXpCdFJ26Y1gd0Qpz4myyKoblGsDia08zDyBThRLDdRDhSeE16SVMhrSxPXr/3s/m09i
         R4fs7zRXDJnuuL/N4tGExZ1+kIe6mlRRJuJ9YLOmtJ+UL30DgDmP/cZ03Xi307jMpa0d
         Nilpfx0gJ+U2tcgMQDcpZYU0MjHEmHTiUhrtCkA+Ovfpc4+1ifLvQbVm3XpP6mdr6r5X
         xVbvn9XGePDedNt9Zb5tbPYYDh1RKvDabMaL2A8EQS5Pai8xYZsXdLx37BKxPp6n//ks
         vUfg==
X-Gm-Message-State: ACrzQf0R+mLtqRJKsIfHolGXIUI4YhdJxGhTjcY+9Fq26St9NOHyEmBy
        AB2jGAARNxxacz5XwVIMUH4=
X-Google-Smtp-Source: AMsMyM4qExk6J9LVLmjGNw8jW9OwVu1sZLxHdAXZr2BW7hACXK7zK8QeoxS0rf8VXQkh38zce/gI4w==
X-Received: by 2002:ac8:5745:0:b0:35c:9f9b:9d56 with SMTP id 5-20020ac85745000000b0035c9f9b9d56mr17283811qtx.103.1663643542795;
        Mon, 19 Sep 2022 20:12:22 -0700 (PDT)
Received: from localhost.localdomain (207-237-203-247.s3058.c3-0.arm-cbr1.chi-arm.il.cable.rcncustomer.com. [207.237.203.247])
        by smtp.gmail.com with ESMTPSA id fb6-20020a05622a480600b00339b8a5639csm81688qtb.95.2022.09.19.20.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:12:22 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH v2] sequencer: avoid dropping fixup commit that targets self via commit-ish
Date:   Mon, 19 Sep 2022 22:11:40 -0500
Message-Id: <20220920031140.1220220-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.37.3.830.gf65be7a4d6
In-Reply-To: <xmqqleqfcoz3.fsf@gitster.g>
References: <xmqqleqfcoz3.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 68d5d03bc4 (rebase: teach --autosquash to match on sha1 in
addition to message, 2010-11-04) taught autosquash to recognize
subjects like "fixup! 7a235b" where 7a235b is an OID-prefix. It
actually did more than advertised: 7a235b can be an arbitrary
commit-ish (as long as it's not trailed by spaces).

Accidental(?) use of this secret feature revealed a bug where we
would silently drop a fixup commit. The bug can also be triggered
when using an OID-prefix but that's unlikely in practice.

Given a commit with subject "fixup! main" that is the tip of the
branch "main". When computing the fixup target for this commit, we
find the commit itself. This is wrong because, by definition, a fixup
target must be an earlier commit in the todo list. We wrongly find
the current commit because we added it to the todo list prematurely.
Avoid these fixup-cycles by only adding the current commit after we
have finished finding its target.

Reported-by: Erik Cervin Edin <erik@cervined.in>
Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 sequencer.c                  |  4 ++--
 t/t3415-rebase-autosquash.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

Changes to v1.
- Remove wrong assumptions from commit message. The commit message should
  be clearer now (though I didn't spend too much time on it).
- Drop one test because it's not related to the fix (and doesn't test anything
  I care about) and modify the other test so it requires the fix to pass.

1:  cb2ee0e003 ! 1:  410ca51936 sequencer: avoid dropping fixup commit that targets self via commit-ish
    @@ Commit message
         sequencer: avoid dropping fixup commit that targets self via commit-ish
     
         Commit 68d5d03bc4 (rebase: teach --autosquash to match on sha1 in
    -    addition to message, 2010-11-04) made --autosquash apply a commit
    -    with subject "fixup! 012345" to the first commit in the todo list
    -    whose OID starts with 012345. So far so good.
    +    addition to message, 2010-11-04) taught autosquash to recognize
    +    subjects like "fixup! 7a235b" where 7a235b is an OID-prefix. It
    +    actually did more than advertised: 7a235b can be an arbitrary
    +    commit-ish (as long as it's not trailed by spaces).
     
    -    More recently, c44a4c650c (rebase -i: rearrange fixup/squash lines
    -    using the rebase--helper, 2017-07-14) reimplemented this logic in C
    -    and introduced two behavior changes.
    -    First, OID matches are given precedence over subject prefix
    -    matches.  Second, instead of prefix-matching OIDs, we use
    -    lookup_commit_reference_by_name().  This means that if 012345 is a
    -    branch name, we will apply the fixup commit to the tip of that branch
    -    (if that is present in the todo list).
    +    Accidental(?) use of this secret feature revealed a bug where we
    +    would silently drop a fixup commit. The bug can also be triggered
    +    when using an OID-prefix but that's unlikely in practice.
     
    -    Both behavior changes might be motivated by performance concerns
    -    (since the commit message mentions performance).  Looking through
    -    the todo list to find a commit that matches the given prefix can be
    -    more expensive than looking up an OID.  The runtime of the former is
    -    of O(n*m) where n is the size of the todo list and m is the length
    -    of a commit subject. However, if this is really a problem, we could
    -    easily make it O(m) by constructing a trie (prefix tree).
    -
    -    Demonstrate both behavior changes by adding two test cases for
    -    "fixup! foo" where foo is a commit-ish that is not an OID-prefix.
    -    Arguably, this feature is very weird.  If no one uses it we should
    -    consider removing it.
    -
    -    Regardless, there is one bad edge case to fix.  Let refspec "foo" point
    -    to a commit with the subject "fixup! foo". Since rebase --autosquash
    -    finds the fixup target via lookup_commit_reference_by_name(), the
    -    fixup target is the fixup commit itself. Obviously this can't work.
    -    We proceed with the broken invariant and drop the fixup commit
    -    entirely.
    -
    -    The self-fixup was only allowed because the fixup commit was already
    -    added to the preliminary todo list, which it shouldn't be.  Rather,
    -    we should first compute the fixup target and only then add the fixup
    -    commit to the todo list. Make it so, avoiding this error by design,
    -    and add a third test for this case.
    +    Given a commit with subject "fixup! main" that is the tip of the
    +    branch "main". When computing the fixup target for this commit, we
    +    find the commit itself. This is wrong because, by definition, a fixup
    +    target must be an earlier commit in the todo list. We wrongly find
    +    the current commit because we added it to the todo list prematurely.
    +    Avoid these fixup-cycles by only adding the current commit after we
    +    have finished finding its target.
     
         Reported-by: Erik Cervin Edin <erik@cervined.in>
    -    Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## sequencer.c ##
     @@ sequencer.c: int todo_list_rearrange_squash(struct todo_list *todo_list)
    @@ t/t3415-rebase-autosquash.sh: test_expect_success 'auto squash that matches long
     +test_expect_success 'auto squash that matches regex' '
     +	git reset --hard base &&
     +	git commit --allow-empty -m "hay needle hay" &&
    -+	git commit --allow-empty -m "fixup! :/[n]eedle" &&
    ++	git commit --allow-empty -m "fixup! :/needle" &&
     +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
    -+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
    ++	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
     +	cat <<-EOF >expect &&
     +	pick HASH hay needle hay # empty
    -+	fixup HASH fixup! :/[n]eedle # empty
    -+	EOF
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success 'auto squash of fixup commit that matches branch name' '
    -+	git reset --hard base &&
    -+	git commit --allow-empty -m "wip commit (just a prefix match so overshadowed by branch)" &&
    -+	git commit --allow-empty -m "tip of wip" &&
    -+	git branch wip &&
    -+	git commit --allow-empty -m "unrelated commit" &&
    -+	git commit --allow-empty -m "fixup! wip" &&
    -+	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^^^ &&
    -+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
    -+	cat <<-EOF >expect &&
    -+	pick HASH wip commit (just a prefix match so overshadowed by branch) # empty
    -+	pick HASH tip of wip # empty
    -+	fixup HASH fixup! wip # empty
    -+	pick HASH unrelated commit # empty
    ++	fixup HASH fixup! :/needle # empty
     +	EOF
     +	test_cmp expect actual
     +'
    @@ t/t3415-rebase-autosquash.sh: test_expect_success 'auto squash that matches long
     +	git commit --allow-empty -m "fixup! self-cycle" &&
     +	git branch self-cycle &&
     +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
    -+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
    ++	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
     +	cat <<-EOF >expect &&
     +	pick HASH second commit
     +	pick HASH fixup! self-cycle # empty


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
index 78c27496d6..98af865268 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -232,6 +232,32 @@ test_expect_success 'auto squash that matches longer sha1' '
 	test_line_count = 1 actual
 '
 
+test_expect_success 'auto squash that matches regex' '
+	git reset --hard base &&
+	git commit --allow-empty -m "hay needle hay" &&
+	git commit --allow-empty -m "fixup! :/needle" &&
+	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
+	cat <<-EOF >expect &&
+	pick HASH hay needle hay # empty
+	fixup HASH fixup! :/needle # empty
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'auto squash of fixup commit that matches branch name which points back to fixup commit' '
+	git reset --hard base &&
+	git commit --allow-empty -m "fixup! self-cycle" &&
+	git branch self-cycle &&
+	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
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

