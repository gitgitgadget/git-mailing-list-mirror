Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CFEB203C1
	for <e@80x24.org>; Thu, 21 Jul 2016 00:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbcGUAvf (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 20:51:35 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36377 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcGUAvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 20:51:33 -0400
Received: by mail-pa0-f51.google.com with SMTP id pp5so23101035pac.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 17:51:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XOLwu2qKMjEu+4mDjLHZtzZdyIG+DHewrXVzOtl8wPU=;
        b=mPFiombGwP6UhwQvPheuBDjbkXm3i7ToiOft51sZh/kFCvi/loejLCUzJf9k0RPEXW
         miDBHfAabR/Yjz8M3mybpBQ5IroDLxeCDwOBy7QhmdUP2ybsiWl8CayRaaCNdLvJCSXc
         anBG65+iffC2I9/E/TDAGe4Z0NlOmXhrIUbP5vfrSsBxcilNfIrwtJdmhvlKGu5BnjLc
         Xq6AQZl0e9YHvDXIFh/VZq+C99V0SwATVQYDJC+7wVCvmFJmc0Ju+9IaBfXWU9O2zDbY
         4zvJEFod+JvM6McEXf9OkcOXNpiFdibcPw0i58uAqWehnkz/9TWsPiihEan1Ljw9TWhe
         IzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XOLwu2qKMjEu+4mDjLHZtzZdyIG+DHewrXVzOtl8wPU=;
        b=HKdIo0dGvUXVAWbFrzbjmfNxoU/mXWfta5DAsm8wJNg+irF0dfFkgy4qlaZxo4Enas
         pNrnMD5M75a70P8cvTYgPeqHduuJ6TapZBp1kpHMduawu+VOjmKLyhG7lFV4XQQKECr4
         6jCBo2vj3Oyrw4LZY7h9OxTCiuQUWJQv/4SIzz43193SaRNYXNt+9dtTgSD/I1pA/e6w
         BzsBn31wGyEIyJqWk7rWQV4MgOjN4oMkxuDIZOuJJ9vAEVNeFcxx9WNG67LdX8tRImG8
         PId5QvpIjcIdZ9kqN1hhVxWRDtlIhmNEWMk94VHw65LrZy55VoEwQU8cGOhe5tiod/YB
         iFzQ==
X-Gm-Message-State: ALyK8tI/htTfe8EbFnpdByNUCbrW9xPVqvw2f/gQ5u/p9MDcKyJGTV5iCMF6wMKNIIvpckOQ
X-Received: by 10.66.146.69 with SMTP id ta5mr75476672pab.157.1469062292629;
        Wed, 20 Jul 2016 17:51:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:685b:61cf:78cb:f3fd])
        by smtp.gmail.com with ESMTPSA id ra13sm7211708pac.29.2016.07.20.17.51.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 17:51:31 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: do no re-read name in shell script
Date:	Wed, 20 Jul 2016 17:51:22 -0700
Message-Id: <20160721005122.15966-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.369.g0e67330
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Instead of making another call to a submodule helper (name), just
propagate the value when we know it (in the update-clone helper) already.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 4 ++--
 git-submodule.sh            | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b22352b..494e088 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -683,9 +683,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	needs_cloning = !file_exists(sb.buf);
 
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
+	strbuf_addf(&sb, "%06o %s %d %d %s\t%s\n", ce->ce_mode,
 			sha1_to_hex(ce->sha1), ce_stage(ce),
-			needs_cloning, ce->name);
+			needs_cloning, sub->name, sub->path);
 	string_list_append(&suc->projectlines, sb.buf);
 
 	if (!needs_cloning)
diff --git a/git-submodule.sh b/git-submodule.sh
index 4ec7546..e23aada 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -584,11 +584,10 @@ cmd_update()
 		"$@" || echo "#unmatched"
 	} | {
 	err=
-	while read mode sha1 stage just_cloned sm_path
+	while read mode sha1 stage just_cloned name sm_path
 	do
 		die_if_unmatched "$mode"
 
-		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
-- 
2.9.2.369.g0e67330

