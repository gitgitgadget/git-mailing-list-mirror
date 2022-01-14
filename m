Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C3DC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 00:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiANAAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 19:00:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58732 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiANAAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 19:00:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42AFE101FAE;
        Thu, 13 Jan 2022 19:00:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H3UcvJntZDezQ4Ns9DDh5yYI8DAPgqQa3849EI
        W3SpM=; b=L771SPRm7nUC+E1WpBPImnI+Aea2gAEsvFEgrNs8bEQ38Pa5n4kH5/
        7qDVzhe6ft4AxdidWUVcquPHSabHkTvgkg0QVWVkUobu2T3Du5qjY3V0XWPg1Nc/
        vn8kCaBHkXq8GbJXlNLLXsHRnVgwzQi4FnOLWS0+kawpLJ1NgK9tM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A7D4101FAD;
        Thu, 13 Jan 2022 19:00:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 973B2101FAC;
        Thu, 13 Jan 2022 19:00:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        Tilman Vogel <tilman.vogel@web.de>
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
References: <20220104214522.10692-1-johncai86@gmail.com>
        <20220104214522.10692-2-johncai86@gmail.com>
        <xmqqbl0r9l0l.fsf@gitster.g>
        <4fe0e850-1c30-da70-5535-e2a4105ba734@gmail.com>
        <xmqq35m0el28.fsf@gitster.g>
Date:   Thu, 13 Jan 2022 16:00:48 -0800
In-Reply-To: <xmqq35m0el28.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        06 Jan 2022 11:11:27 -0800")
Message-ID: <xmqqee5bfaof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08339E82-74CD-11EC-9937-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Here is how I would explain your change.

This topic is in "Expecting an ack or two" state for some time.

 - Philippe, are you OK with the attached patch?  If so throw your
   Signed-off-by to this thread.

 - John, if you find Philippe's implementation a good idea (I think
   it is, as it is simpler and cleaner) after reading and
   understanding it, please throw an Acked-by or Reviewed-by to this
   thread.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Tue, 4 Jan 2022 22:58:32 -0500
Subject: [PATCH] pull --rebase: honor rebase.autostash even when
 fast-forwarding

"pull --rebase" internally uses the merge machinery when the other
history is a descendant of ours (i.e. perform fast-forward).  This
came from [1], where the discussion was started from a feature
request to do so.  It is a bit hard to read the rationale behind it
in the discussion, but it seems that it was an established fact for
everybody involved that does not even need to be mentioned that
fast-forwarding done with "rebase" was much undesirable than done
with "merge", and more importantly, the result left by "merge" is as
good as (or better than) that by "rebase".

Except for one thing.  Because "git merge" does not (and should not)
honor rebase.autostash, "git pull" needs to read it and forward it
when we use "git merge" as a (hopefully better) substitute for "git
rebase" during the fast-forwarding.  But we forgot to do so (we only
add "--[no-]autostash" to the "git merge" command when "git pull" was
invoked with "--[no-]autostash" command line option, so that "git merge"
can honor merge.autostash in such a case).

Make sure "git merge" is run with "--autostash" when
rebase.autostash is set and used to fast-forward the history on
behalf of "git rebase".  Incidentally this change also takes care of
the case where

 - "git pull --rebase" (without other command line options) is run
 - "rebase.autostash" is not set
 - The history fast-forwards

In such a case, "git merge" is run with an explicit "--no-autostash"
to prevent it from honoring merge.autostash configuration, which is
what we want.  After all, we want the "git merge" to pretend as if
it is "git rebase" while being used for this purpose.

[1]
https://lore.kernel.org/git/xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com/
---
 builtin/pull.c          |  7 +++---
 t/t5521-pull-options.sh | 52 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1cfaf9f343..9f8a8dd716 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1036,14 +1036,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		oidclr(&orig_head);
 
 	if (opt_rebase) {
-		int autostash = config_autostash;
-		if (opt_autostash != -1)
-			autostash = opt_autostash;
+		if (opt_autostash == -1)
+			opt_autostash = config_autostash;
 
 		if (is_null_oid(&orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		if (!autostash)
+		if (!opt_autostash)
 			require_clean_work_tree(the_repository,
 				N_("pull with rebase"),
 				_("please commit or stash them."), 1, 0);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 66cfcb09c5..4046a74cad 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -252,4 +252,56 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
 	test_must_fail git -C dst pull --no-ff --no-verify --verify
 '
 
+test_expect_success 'git pull --rebase --autostash succeeds on ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
+	echo "dirty" >>dst/file &&
+	git -C dst pull --rebase --autostash >actual 2>&1 &&
+	grep -q "Fast-forward" actual &&
+	grep -q "Applied autostash." actual
+'
+
+test_expect_success 'git pull --rebase with rebase.autostash succeeds on ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
+	echo "dirty" >>dst/file &&
+	test_config -C dst rebase.autostash true &&
+	git -C dst pull --rebase  >actual 2>&1 &&
+	grep -q "Fast-forward" actual &&
+	grep -q "Applied autostash." actual
+'
+
+test_expect_success 'git pull --rebase --autostash succeeds on non-ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "src_content" file "src content\ncontent\n" &&
+	test_commit -C dst --append "dst_content" file "dst content" &&
+	echo "dirty" >>dst/file &&
+	git -C dst pull --rebase --autostash >actual 2>&1 &&
+	grep -q "Successfully rebased and updated refs/heads/main." actual &&
+	grep -q "Applied autostash." actual
+'
+
+test_expect_success 'git pull --rebase with rebase.autostash succeeds on non-ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "src_content" file "src content\ncontent\n" &&
+	test_commit -C dst --append "dst_content" file "dst content" &&
+	echo "dirty" >>dst/file &&
+	test_config -C dst rebase.autostash true &&
+	git -C dst pull --rebase >actual 2>&1 &&
+	grep -q "Successfully rebased and updated refs/heads/main." actual &&
+	grep -q "Applied autostash." actual
+'
+
 test_done
-- 
2.35.0-rc0-182-gd99ee8e0c1

