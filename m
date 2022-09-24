Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4377FC07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 22:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiIXW3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 18:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIXW3k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 18:29:40 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95CE64F7
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:29:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z191so2523714iof.10
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Cb4bqfrkFGiQOnO0aE2stgCtszNXIAOUg/ml1VcLKsQ=;
        b=ZyvjecyalKvimtzfTt7AeobmAVrAxTCuaJR2conY6PwKnHQf3wjzZPaWbYxYu/5o0q
         BSESUvIRZoZuybUE2aHyYHuycBX2YcM6aWZTTXUGFJQfqMSePWd2U7IalGr+Q3TScbGK
         LObuqUbbkAmjGOPrhaWTcQoVRaItCbihVu07S2g+2bx7KI0EwQZCSmloqePrHKKqDu5q
         58+NUW9tMSf4UX1Egw4A0u4CPugBafGHJKrb9LfgZXM+wphkvN1Y8K4aGlF1+Q7VP4Hd
         EVfiZuAl11U7qroeSUDch3Lxux+n1C6tjjWW73av9dC4PcbED9HVn9VK6i8ORgNVrKsw
         WTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Cb4bqfrkFGiQOnO0aE2stgCtszNXIAOUg/ml1VcLKsQ=;
        b=3E8WL7KhmjTO3UpG7bDwl32/gT/9/PF5Rhb5/J+/wzNfGiI4nBZNFItbdkfom2TwHW
         v0J3S5NO538HTWE2TLEGf/jtxY0ZUPL1N1yIdswsJC2X1OSNaIR214KDKlakW1Eo8Sny
         ESNdHXNgx+GLBg4pMlt5okuw4vUTNrJRehssQ+xWTdital4bjyWUgck/N0wYVAhYHwFu
         e7TSs0ntmz3L1JlyZCfb0x+jF83uyJrA/5UvoMdCm7GTWF/Poxu17RuMTKjOTQXrQQQ5
         YWS2XZIsFbkTrseieuZngWjVR79QNVWb8ps1iuqanXpEZGJn1jW7hnCrMkNbAugANqfk
         cV/g==
X-Gm-Message-State: ACrzQf0V2Tb/YZs7fgMGx//xZCQB5YkrXWDUv9lDD7GXTbfx/pig5e4n
        TVtDsQpO7mX0DmTV4D85SXQ=
X-Google-Smtp-Source: AMsMyM7K2sSR7QbYnktDSGnZLEvg5tsRSqTyYI0X35I0rbGCjCfna6VM1TR2Po+gYIAhx5WTStNOFw==
X-Received: by 2002:a05:6602:27cd:b0:669:3d8d:4d77 with SMTP id l13-20020a05660227cd00b006693d8d4d77mr6818179ios.216.1664058577206;
        Sat, 24 Sep 2022 15:29:37 -0700 (PDT)
Received: from localhost.localdomain (207-237-203-247.s3058.c3-0.arm-cbr1.chi-arm.il.cable.rcncustomer.com. [207.237.203.247])
        by smtp.gmail.com with ESMTPSA id b69-20020a021948000000b0034cb3d54758sm5018230jab.158.2022.09.24.15.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 15:29:36 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH v3] sequencer: avoid dropping fixup commit that targets self via commit-ish
Date:   Sat, 24 Sep 2022 17:29:04 -0500
Message-Id: <20220924222904.1784975-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.37.3.830.gf65be7a4d6
In-Reply-To: <xmqqpmfnxl1o.fsf@gitster.g>
References: <xmqqpmfnxl1o.fsf@gitster.g>
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

Let the commit with subject "fixup! main" be the tip of the "main"
branch. When computing the fixup target for this commit, we find
the commit itself. This is wrong because, by definition, a fixup
target must be an earlier commit in the todo list. We wrongly find
the current commit because we added it to the todo list prematurely.
Avoid these fixup-cycles by only adding the current commit to the
todo list after we have finished looking for the fixup target.

Reported-by: Erik Cervin Edin <erik@cervined.in>
Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 sequencer.c                  |  4 ++--
 t/t3415-rebase-autosquash.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

Changes since v2:
- minor commit message rewording and clarification
- dropped a test that was based on a wrong understanding of --autosquash.

  I saw b425461cb5 (SQUASH??? resurrect previous version of the tests,
  2022-09-21) today. I'm leaning towards not adding them back because
  those tests were only added to reflect the current behavior.  but that
  behavior is not something I care about.
  We might even want to change this behavior, by restricting OID fixup
  targets to SHAs only. So I don't think these tests are desirable,
  unless they help others understand the current state of affairs?

1:  37e00c51bd ! 1:  a25c886a78 sequencer: avoid dropping fixup commit that targets self via commit-ish
    @@ Commit message
         would silently drop a fixup commit. The bug can also be triggered
         when using an OID-prefix but that's unlikely in practice.
     
    -    Given a commit with subject "fixup! main" that is the tip of the
    -    branch "main". When computing the fixup target for this commit, we
    -    find the commit itself. This is wrong because, by definition, a fixup
    +    Let the commit with subject "fixup! main" be the tip of the "main"
    +    branch. When computing the fixup target for this commit, we find
    +    the commit itself. This is wrong because, by definition, a fixup
         target must be an earlier commit in the todo list. We wrongly find
         the current commit because we added it to the todo list prematurely.
    -    Avoid these fixup-cycles by only adding the current commit after we
    -    have finished finding its target.
    +    Avoid these fixup-cycles by only adding the current commit to the
    +    todo list after we have finished looking for the fixup target.
     
         Reported-by: Erik Cervin Edin <erik@cervined.in>
     
      ## sequencer.c ##
     @@ sequencer.c: int todo_list_rearrange_squash(struct todo_list *todo_list)
    @@ t/t3415-rebase-autosquash.sh: test_expect_success 'auto squash that matches long
      	test_line_count = 1 actual
      '
      
    -+test_expect_success 'auto squash that matches regex' '
    -+	git reset --hard base &&
    -+	git commit --allow-empty -m "hay needle hay" &&
    -+	git commit --allow-empty -m "fixup! :/needle" &&
    -+	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
    -+	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
    -+	cat <<-EOF >expect &&
    -+	pick HASH hay needle hay # empty
    -+	fixup HASH fixup! :/needle # empty
    -+	EOF
    -+	test_cmp expect actual
    -+'
    -+
     +test_expect_success 'auto squash of fixup commit that matches branch name which points back to fixup commit' '
     +	git reset --hard base &&
     +	git commit --allow-empty -m "fixup! self-cycle" &&


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
index 78c27496d6..a364530d76 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -232,6 +232,19 @@ test_expect_success 'auto squash that matches longer sha1' '
 	test_line_count = 1 actual
 '
 
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

