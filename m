Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CAFC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiANTkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:40:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53786 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiANTkW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:40:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5429216708C;
        Fri, 14 Jan 2022 14:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=98vb3e8JNQD4PKExV/THCURFPN7EH6wYvgGmc1
        K+5F8=; b=Dj9Of5l0sQrjrMQmtTV2p+8kxjj3oHxkJwARca2Zl8T8DyT/OMgwC/
        ML+JE1aTCKDoADzcA3yjeGH1rtq0OpNvWk030H8mYiSmgAET+spU5m9R4CqBBA+H
        5hIQBkoJYEO0J7PVkhghFw+tZ4/MPdQKWtNKzz6JkN0HCIVE9qWhs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CC3816708B;
        Fri, 14 Jan 2022 14:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A563B16708A;
        Fri, 14 Jan 2022 14:40:19 -0500 (EST)
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
        <xmqq35m0el28.fsf@gitster.g> <xmqqee5bfaof.fsf@gitster.g>
        <8d19623b-4b11-8ecc-8f27-17ad4ba4167a@gmail.com>
Date:   Fri, 14 Jan 2022 11:40:18 -0800
In-Reply-To: <8d19623b-4b11-8ecc-8f27-17ad4ba4167a@gmail.com> (Philippe
        Blain's message of "Thu, 13 Jan 2022 22:14:51 -0500")
Message-ID: <xmqqr19aayxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE7171EC-7571-11EC-8B15-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> tests. I hoped that John would incorporate my suggestions in a v2, but he
> seems to be busy, so I'm including an updated patch at the end of this email.

Was about to say "Will replace the in-tree version with this. Thanks",
before I realized that your message is "text/plain; format=flawed" X-<.

I think I fixed it up correctly.  I'll pick this version up from the
list and replace what's in-tree with it.

Thanks.

----- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 -----
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Thu, 13 Jan 2022 22:14:51 -0500
Subject: [PATCH] pull --rebase: honor rebase.autostash when fast-forwarding

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
add "--[no-]autostash" to the "git merge" command when "git pull" itself
was invoked with "--[no-]autostash" command line option.

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

[1] https://lore.kernel.org/git/xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com/

Reported-by: Tilman Vogel <tilman.vogel@web.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/pull.c  |  7 +++----
 t/t5520-pull.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

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
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 93ecfcdd24..081808009b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -330,6 +330,19 @@ test_expect_success '--rebase --autostash fast forward' '
 	test_cmp_rev HEAD to-rebase-ff
 '
 
+test_expect_success '--rebase with rebase.autostash succeeds on ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
+	echo "dirty" >>dst/file &&
+	test_config -C dst rebase.autostash true &&
+	git -C dst pull --rebase >actual 2>&1 &&
+	grep -q "Fast-forward" actual &&
+	grep -q "Applied autostash." actual
+'
+
 test_expect_success '--rebase with conflicts shows advice' '
 	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
 	git checkout -b seq &&
-- 
2.35.0-rc0-182-g7444c100dc

