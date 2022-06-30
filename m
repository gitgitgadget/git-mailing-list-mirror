Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45930C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiF3CiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiF3Chs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:37:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28A2220F2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:37:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id go6so17471654pjb.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wniLrbGn+dX+9xGLjcUe8ZTlpOouPIxH9fUnELjWf0U=;
        b=YBDcaJ0n2cX8tf5HNUCJ+JLS0s1I+rpqr6wSi19oC3sJibBHjldPhhg4KmbdjCkhP4
         qVev+I7uYu2KAYvFainoZ0r9m4Pn5oa6N49j52ykoJBejcJGzGYsPhvPKUCEYcY98JOg
         oJn2nUoOiQEz5Tx5oI2cC7fjpOFZDPACtxfkMAdqEHqh/793fwF1wH7cM+tUTIiSepny
         Bp48S9WNQbN+dv97agURt8Ks2nxuWantFCDYvn/NZx+RCBKE+GsFUw+ErcnNyCxwHTye
         6LVHGaK5uw0cjwksUGtWQPVieT2PvflXJ7QGmQT6DNen3gR5vePJH7h4mOE5KoiMXjuO
         3s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wniLrbGn+dX+9xGLjcUe8ZTlpOouPIxH9fUnELjWf0U=;
        b=4E63UUdysA9W51st5CR6OiqHbVWmci51UULU+GgJEYmCDUEfLvbWMvW0/tbagO/A3V
         NKNVDu9AUughXzuDqnDWEsmccjr3vQD6h3S5/N4EbpyGYF7CCQM9EPLVPYyDKOnC7r2b
         q2rpTzf8ahgMPH8oyTaFdoFIbgA85Yx2jjb0KVz6xe157OR6Y1ZfGI0gelrSoPXrZF1b
         oq0w9pe6jID6xa6pLCYzX9cRj69QW+0CYPczPWkthNyKfqI2alhjxS4uD7h0skl0ql1V
         5h+YNDQTIPzR8kMcq56j+mbU72BuBayaQQemHsOBik6mB5al6c7IbGBWb/VOa60bXPDr
         xlpg==
X-Gm-Message-State: AJIora/IL2yHlbuiDtI56emav//kjSatBwWE42m6/L1bbyd4r0utiOiw
        Se9AqoFC7qdHBVEHp+yYf3/3vhf3UUo=
X-Google-Smtp-Source: AGRyM1tfgUGrm8zgch4ILk76lXNL+s4NAVOW+RQHQiPQmF/HaKWybbuRXHa8drZpGOJYHl/N+zl8kg==
X-Received: by 2002:a17:902:b08e:b0:16a:85d:6cf5 with SMTP id p14-20020a170902b08e00b0016a085d6cf5mr12181363plr.36.1656556667042;
        Wed, 29 Jun 2022 19:37:47 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:37:45 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 0/8] mv: fix out-of-cone file/directory move logic
Date:   Thu, 30 Jun 2022 10:37:29 +0800
Message-Id: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

## Changes since PATCH v4 ##

1. Fix style-nits.

2. Add t1092 tests (2/8) for "mv: add check_dir_in_index() and solve 
   general dir check issue" (8/8).

## Changes since WIP v3 ##

1. Fix style-nits.

2. Move "mv: update sparsity after moving from out-of-cone to in-cone" to the 
   (2/7) position (was (7/7) position in WIP v3). Make this move so that we
   can drop "git sparse-checkout reapply" from the tests, as suggested by
   Victoria [1]. The reason is we need to check out the moved cache_entry
   for all out-of-cone to in-cone moves, so this commit works better if being the
   first one.

3. Fix the commit message of "mv: use flags mode for update_mode", as suggested
   here [2].

4. Add "Helped-by" and "Suggested-by" trailers.

5. In "mv: add check_dir_in_index() and solve general dir check issue", change
   the 'check_dir_in_index()' to no more accept 'namelen' as argument. The
   original "namelen + 1" logic can be erroneous, for example when 'name' already
   has a trailing slash. So just use strlen() to save the trouble.

[1] https://lore.kernel.org/git/adb795ba-56ce-8441-0c38-a3e6b0a6e861@github.com/
[2] https://lore.kernel.org/git/01b39c63-5652-4293-0424-ff99b6f9f7d2@github.com/

## Changes since WIP v2 ##

1. Write helper functions for t7002 to reuse some code.

2. Refactor/decouple the if/else-if checking chain.

3. Separate out the 'update_mode' refactor into a single commit.

4. Stop using update_sparsity() and instead update the SKIP_WORKTREE
   bit for each cache_entry and check it out to the working tree.

## Changes since WIP v1 ##

1. Move t7002 tests to the front and turn corresponding tests to 
   test_expect_success along with corresponding commits.

2. Add two tests to t7002.

3. Update check_dir_in_index() and added corresponding documentation.

4. Turn update_mode into enum flags.

5. Use update_sparsity() to replace advise*() function after touching
   sparse contents (this change is INCOMPLETE, NEED FIX).

6. Fix some format issues.

## Starting WIP v1 ##

Before integrating 'mv' with sparse-index, I still find some possibly buggy
UX when 'mv' is interacting with 'sparse-checkout'. 

So I kept sparse-index off in order to sort things out without a sparse index.
We can proceed to integrate with sparse-index once these changes are solid.

Note that this patch is tentative, and still have known glitches, but it 
illustrates a general approach that I intended to harmonize 'mv' 
with 'sparse-checkout'.

## Pre WIP v1 discussion ##

RFC patch about integarting sparse index with 'mv' [3]

[3] https://lore.kernel.org/git/20220315100145.214054-1-shaoxuan.yuan02@gmail.com/

Shaoxuan Yuan (8):
  t7002: add tests for moving out-of-cone file/directory
  t1092: mv directory from out-of-cone to in-cone
  mv: update sparsity after moving from out-of-cone to in-cone
  mv: decouple if/else-if checks using goto
  mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
  mv: check if <destination> exists in index to handle overwriting
  mv: use flags mode for update_mode
  mv: add check_dir_in_index() and solve general dir check issue

 builtin/mv.c                             | 239 +++++++++++++++++------
 t/t1092-sparse-checkout-compatibility.sh |  25 +++
 t/t7002-mv-sparse-checkout.sh            |  84 ++++++++
 3 files changed, 284 insertions(+), 64 deletions(-)

Range-diff against v4:
1:  6ec0fee96c = 1:  c2715ffd84 t7002: add tests for moving out-of-cone file/directory
-:  ---------- > 2:  7069755abd t1092: mv directory from out-of-cone to in-cone
2:  0887fbbc82 ! 3:  33188b9f1c mv: update sparsity after moving from out-of-cone to in-cone
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     +			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
     +
     +			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
    -+				die(_("cannot checkout %s"), ce->name);
    ++				die(_("cannot checkout %s"), active_cache[dst_pos]->name);
     +		}
      	}
      
3:  e79785487e = 4:  6100d6ca40 mv: decouple if/else-if checks using goto
4:  bdbfd90843 = 5:  c34e2871d1 mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
5:  807de09f19 = 6:  e4a0ba40df mv: check if <destination> exists in index to handle overwriting
6:  af84df7dd0 ! 7:  7bc5cddcf4 mv: use flags mode for update_mode
    @@ Metadata
      ## Commit message ##
         mv: use flags mode for update_mode
     
    -    As suggested by Derrick [1],
    -    move the in-line definition of "enum update_mode" to the top
    -    of the file and make it use "flags" mode (each state is a different
    -    bit in the word).
    +    As suggested by Derrick [1], move the in-line definition of
    +    "enum update_mode" to the top of the file and make it use "flags"
    +    mode (each state is a different bit in the word).
     
         Change the flag assignments from '=' (single assignment) to '|='
         (additive). Also change flag evaluation from '==' to '&', etc.
7:  d9fd1c452c ! 8:  9f89faa557 mv: add check_dir_in_index() and solve general dir check issue
    @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
      
      		pos = cache_name_pos(src, strlen(src));
     
    + ## t/t1092-sparse-checkout-compatibility.sh ##
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout behaves oddly with df-conflict-2' '
    + 	test_cmp full-checkout-err sparse-index-err
    + '
    + 
    +-test_expect_failure 'mv directory from out-of-cone to in-cone' '
    ++test_expect_success 'mv directory from out-of-cone to in-cone' '
    + 	init_repos &&
    + 
    + 	# <source> as a sparse directory (or SKIP_WORKTREE_DIR without enabling
    +
      ## t/t7002-mv-sparse-checkout.sh ##
     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
      	test_cmp expect stderr

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
2.35.1

