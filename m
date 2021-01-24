Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3CEC433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 22:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5ADF22C7B
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 22:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAXWEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 17:04:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57632 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbhAXWEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 17:04:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CD8E993A0;
        Sun, 24 Jan 2021 17:04:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vq237B2PMpskf8jQ4eKUQCgBRW4=; b=xF9jcj
        B0ivUpE4xxm91v7qKNTDhpiFilul/u8+OFSrGeEkI6uhyCfRQFfyfPrdxBoarAF6
        uR/c3A6ZONIZogh2S44m3hZrb0w6FS01vTNdMRKzlm6FMIAIQlYNAdclDfvHYZLw
        HrCufXzKwdkdho0YjeOL/El2F52rH2DDVTG1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IGBweT+4eJrs21XMJwoit6kLy1ugfzKh
        cb4JrK5S1GGC59i9b3MDzQTyPIKzoww0Dsxh3UxBHaauUTxrdjuri/E0V6MynoRx
        yWNk3HoyFhMJcd5SySh/3txIdAmEG8vK/mVcBJ0sgCB7+x9/RLDMpjVecjwMTghx
        H8dbbpmfBc4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43AC69939F;
        Sun, 24 Jan 2021 17:04:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA9269939E;
        Sun, 24 Jan 2021 17:04:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 1/3] ls_files.c: bugfix for --deleted and --modified
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
        <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
        <8b02367a359e62d7721b9078ac8393a467d83724.1611485667.git.gitgitgadget@gmail.com>
Date:   Sun, 24 Jan 2021 14:04:09 -0800
In-Reply-To: <8b02367a359e62d7721b9078ac8393a467d83724.1611485667.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sun, 24 Jan 2021 10:54:25
        +0000")
Message-ID: <xmqqo8heyoti.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15C53AD2-5E90-11EB-B104-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> This situation may occur in the original code: lstat() failed
> but we use `&st` to feed ie_modified() later.
>
> Therefore, we can directly execute show_ce without the judgment of
> ie_modified() when lstat() has failed.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> [jc: fixed misindented code]

I noticed that you reverted my fix in this version, when this is
compared with the one I sent last night.

Comparing the result of applying all three with what I sent last
night, this v7 looks worse (see below).  Let's discard this round
and declare victory with what is already on 'seen'.

Thanks.


---

comparison between what these three patches would produce (preimage)
and what is on 'seen' (postimage)is shown here.

diff --git w/builtin/ls-files.c c/builtin/ls-files.c
index fb9cf50d76..f6f9e483b2 100644
--- w/builtin/ls-files.c
+++ c/builtin/ls-files.c
@@ -313,7 +313,8 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 		if (show_killed)
 			show_killed_files(repo->index, dir);
 	}
-	if (! (show_cached || show_stage || show_deleted || show_modified))
+
+	if (!(show_cached || show_stage || show_deleted || show_modified))
 		return;
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
@@ -328,15 +329,16 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
 		if ((show_cached || show_stage) &&
-			(!show_unmerged || ce_stage(ce))) {
-				show_ce(repo, dir, ce, fullname.buf,
-					ce_stage(ce) ? tag_unmerged :
-					(ce_skip_worktree(ce) ? tag_skip_worktree :
-						tag_cached));
+		    (!show_unmerged || ce_stage(ce))) {
+			show_ce(repo, dir, ce, fullname.buf,
+				ce_stage(ce) ? tag_unmerged :
+				(ce_skip_worktree(ce) ? tag_skip_worktree :
+				 tag_cached));
 			if (skipping_duplicates)
 				goto skip_to_next_name;
 		}
-		if (!show_deleted && !show_modified)
+
+		if (!(show_deleted || show_modified))
 			continue;
 		if (ce_skip_worktree(ce))
 			continue;
@@ -349,12 +351,13 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 				goto skip_to_next_name;
 		}
 		if (show_modified &&
-			(stat_err || ie_modified(repo->index, ce, &st, 0))) {
-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
+		    (stat_err || ie_modified(repo->index, ce, &st, 0))) {
+			show_ce(repo, dir, ce, fullname.buf, tag_modified);
 			if (skipping_duplicates)
 				goto skip_to_next_name;
 		}
 		continue;
+
 skip_to_next_name:
 		{
 			int j;
@@ -362,7 +365,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			for (j = i + 1; j < repo->index->cache_nr; j++)
 				if (strcmp(ce->name, cache[j]->name))
 					break;
-			i = j - 1; /* compensate for outer for loop */
+			i = j - 1; /* compensate for the for loop */
 		}
 	}
 
@@ -590,7 +593,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
-		OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppress duplicate entries")),
+		OPT_BOOL(0, "deduplicate", &skipping_duplicates,
+			 N_("suppress duplicate entries")),
 		OPT_END()
 	};
 
