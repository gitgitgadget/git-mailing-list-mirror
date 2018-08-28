Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138241F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeH2BO1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34093 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeH2BOX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:23 -0400
Received: by mail-io0-f193.google.com with SMTP id c22-v6so2733372iob.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eq1s1DsF+TFzd1axJk+Pk/RMVNqPHRI9zG4y/32N8sc=;
        b=rdoElwAL6hn4zxJAnbXwuYKveWIx3FM6MSQ7LZ1YiuICuH8mjtr84NSVMYSTS3DIaN
         uu6cuHOk5toigW36/yGCwxjbksQsqK/6Say2AQOSng99Lumget5ftCEINOPZzCDF6QIA
         FejHh/YbNhLZh4YQB1GDv84EJm7BM1Ug60CBwgCps7q2I6hfXgbYFs6F8LrwDBdveGiM
         7aDcNupgiQi+lVjw4pW5c1H5jtSiDudhvfeiDN6pflRINKJCYzNCEvmP3LsBl8Taywmf
         ov03wxaBG9OmDBAf+mVE35UWwOVLAOMgnuY+YQOUfesm2Pjy13XJ7N8G2iKjVbCacUrn
         ZR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Eq1s1DsF+TFzd1axJk+Pk/RMVNqPHRI9zG4y/32N8sc=;
        b=IghsUsIKYKYjN2bksXFv6OfHPCypHIfI7HeaeHCrxNCUe7wlAbvFk6UynqA7Oksmz0
         MVTI5rinbytdAww+c0OooFz5thy8wEoagoLUF7NEBrEP4PH73k3ya9GtJOlmOm43hKBd
         Or+EErah/agtDGrnmk+aDtrln49p+PZ1eeYgcCR+oWG9wXAUHgjw87NT81gmCtcrm/fk
         nnVkWzh3xLd4Pdq1d+17tdf+tCvdvpSXylANVALoWI1U3MW9gEUSIbWdUHjNPHW5sTkS
         r1NpYlMTe5IyD5X7kW/BHNAC6qh4/F0Q1nrVyjzrt/5VTzD9a7/nq0EkqinD1uh2z2ge
         qiBQ==
X-Gm-Message-State: APzg51CynVpg8S+jJIJtza4ildC0EAGmZtAe/2S65806wHxzHj2fFVNZ
        SZkEFrkx0FVQcQAAdz+8C9KXmt38
X-Google-Smtp-Source: ANB0VdY0G15/3bI4YqfkjvJjlEXa9cLZSOCNi9LdyAJwqHw/biJasMRxqjQBAEi68KFmbFYZx2qvSA==
X-Received: by 2002:a6b:b8d4:: with SMTP id i203-v6mr2964896iof.287.1535491252535;
        Tue, 28 Aug 2018 14:20:52 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:52 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 7/9] worktree: teach 'move' to override lock when --force given twice
Date:   Tue, 28 Aug 2018 17:20:24 -0400
Message-Id: <20180828212026.21989-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For consistency with "add -f -f", which allows a missing but locked
worktree path to be re-used, allow "move -f -f" to override a lock,
as well, as a convenience.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt |  3 +++
 builtin/worktree.c             | 13 +++++++++----
 t/t2028-worktree-move.sh       | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 8537692f05..d08b8d8e4f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -125,6 +125,9 @@ OPTIONS
 	manually). This option overrides these safeguards. To add a missing but
 	locked working tree path, specify `--force` twice.
 +
+`move` refuses to move a locked working tree unless `--force` is specified
+twice.
++
 `remove` refuses to remove an unclean working tree unless `--force` is used.
 
 -b <new-branch>::
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3eb2f89b0f..354a6c0eb5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -740,13 +740,17 @@ static void validate_no_submodules(const struct worktree *wt)
 
 static int move_worktree(int ac, const char **av, const char *prefix)
 {
+	int force = 0;
 	struct option options[] = {
+		OPT__FORCE(&force,
+			 N_("force move even if worktree is dirty or locked"),
+			 PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
 	struct strbuf dst = STRBUF_INIT;
 	struct strbuf errmsg = STRBUF_INIT;
-	const char *reason;
+	const char *reason = NULL;
 	char *path;
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
@@ -777,12 +781,13 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 
 	validate_no_submodules(wt);
 
-	reason = is_worktree_locked(wt);
+	if (force < 2)
+		reason = is_worktree_locked(wt);
 	if (reason) {
 		if (*reason)
-			die(_("cannot move a locked working tree, lock reason: %s"),
+			die(_("cannot move a locked working tree, lock reason: %s\nuse 'move -f -f' to override or unlock first"),
 			    reason);
-		die(_("cannot move a locked working tree"));
+		die(_("cannot move a locked working tree;\nuse 'move -f -f' to override or unlock first"));
 	}
 	if (validate_worktree(wt, &errmsg, 0))
 		die(_("validation failed, cannot move working tree: %s"),
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 60aba7c41a..9756ede8f1 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -98,6 +98,20 @@ test_expect_success 'move worktree to another dir' '
 	test_cmp expected2 actual2
 '
 
+test_expect_success 'move locked worktree (force)' '
+	test_when_finished "
+		git worktree unlock flump || :
+		git worktree remove flump || :
+		git worktree unlock ploof || :
+		git worktree remove ploof || :
+		" &&
+	git worktree add --detach flump &&
+	git worktree lock flump &&
+	test_must_fail git worktree move flump ploof" &&
+	test_must_fail git worktree move --force flump ploof" &&
+	git worktree move --force --force flump ploof
+'
+
 test_expect_success 'remove main worktree' '
 	test_must_fail git worktree remove .
 '
-- 
2.19.0.rc1.350.ge57e33dbd1

