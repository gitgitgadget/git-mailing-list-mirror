Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F71C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiF0SsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbiF0Srr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:47:47 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF2D5D
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:47:46 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id pq3-20020a17090b3d8300b001ecc27ddc0bso6820125pjb.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=42OpFSfeXWDZUv2E24kgfKHrjgxVewL49vl5n85wH7w=;
        b=ZEjUgxbr/VlSFO1ikqbBwicMXWWIYlOug4oMBIOwGnoqPWrEmbjfpZ4DDSbcxBt6+x
         zBUZzggIDjLJZDm6A/NQjU4cUmIOi7nRmoW2qagdMutDiwcpn6Gi5Vqjsz84SiuI1DQ9
         gsCW1kq1xXqBYfD+hIiJ6U9b3pObJpalMxL75jMVsuM2Koo5VXR39ARvW6du1MTD2NI5
         xTVDKF5JBbyGJ1OivViP4hTmUFFVERA5dodYL4zn/p2ASdvObPPNdJJdqcawA1naqOgH
         LYgCrEwIEcKWIHvcGQT7kn+3VpzeOaXaOWOZxfo8KJlbyRZ5YP62zuQcZ76lquR85g2J
         rK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=42OpFSfeXWDZUv2E24kgfKHrjgxVewL49vl5n85wH7w=;
        b=FEp3v1HWIpurVyqlbWdg6JMEgo8AgoP42RiWjTthLubMt7bS+7bfDd5KoJIieNyD3b
         jNuSOZS87OC/qas9XQclvQ4gaeGcbw893Q3Dci2R7m/nqD/9jlNuWMXt8nTpOqZTJ1O0
         PdvMlaEFJ8oMIoWBfJMqDMMfDcZqvnmvhMqwElmLxpKSYMeSeFbp4PPuF+rmBfgNgrHu
         hDDNdEzG9xHuWsk6HHAO5Od1Xj7mVbDuL/J02HydTPEvoBgnXoh4CuWCKr/uMwY2sh9O
         SMzsY+cOcykx1z9w3omfdxIIjUSLCG71XCBMOGqS/OM7wFvyl+lAkIvs7di0HH/QFBA8
         WYRQ==
X-Gm-Message-State: AJIora+xN1AtIjiiOgvO9YE7zDZOwVKOb/uFnMpLltTj40nOAhsdAkLP
        +riViSYDQK+PTM85mnxUtH/plXaSvQZjxLN2ktAu
X-Google-Smtp-Source: AGRyM1urlQ49YoopJRoibhL0upSMH8wIUGEg54IhWr53o5DLWs1OR1ZzPLQo2OMzJkUCiTTvNyFdGYBAeC5Gbdv0V1yk
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:702:b0:1ec:6fc7:b718 with
 SMTP id l2-20020a17090a070200b001ec6fc7b718mr17004257pjl.219.1656355666571;
 Mon, 27 Jun 2022 11:47:46 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:47:44 -0700
In-Reply-To: <bb2badccb71d76efe0e47431246376b1e7016b05.1655871652.git.gitgitgadget@gmail.com>
Message-Id: <20220627184744.1361309-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH 3/3] merge-ort: fix issue with dual rename and add/add conflict
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> The testcases added in t6423 a couple commits ago are slightly different
> but similar in principle.  They involve a similar case of paired
> renaming but instead of A/ -> B/ and B/ -> C/, the second side renames
> a leading directory of B/ to C/.  

Hmm...one side moved sub1 -> sub3 and the other moved sub2 from the root
to under sub1, right? So it's more like A/ -> B/ and C/ -> A/C/.

> And both sides add a new file
> somewhere under the directory that the other side will rename.  

Rename or move, I think.

> While
> the new files added start within different directories and thus could
> logically end up within different directories, it is weird for a file
> on one side to end up where the other one started and not move along
> with it.  So, let's just turn off directory rename detection in this
> case as well.

Makes sense.

> diff --git a/merge-ort.c b/merge-ort.c
> index fa6667de18c..5bcb9a4980b 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2292,9 +2292,13 @@ static char *check_for_directory_rename(struct merge_options *opt,
>  	struct strmap_entry *rename_info;
>  	struct strmap_entry *otherinfo = NULL;
>  	const char *new_dir;
> +	int other_side = 3 - side_index;
>  
> +	/* Cases where there is no new path, so we return NULL */

What do you mean by "no new path"?

>  	if (strmap_empty(dir_renames))
>  		return new_path;
> +	if (strmap_get(&collisions[other_side], path))
> +		return new_path;

So as far as I understand, collisions here, for a given side, is a map.
The map's keys are all the filenames of added and renamed files (I'm
assuming that's what 'A' and 'R' are) from that side after any directory
moves on the other side are applied. So, for example, if we add "foo/a"
on side A and rename "foo/" to "bar/" on side B, then side A's collision
map would have a key "bar/a". So I'm not sure if "collision" is the
right name here, but the existing code already uses it so I'll leave it
be.

It makes sense that this situation (of side A having "bar/a" because
side B renamed "foo/" to "bar/", and at the same time, side B adds its
own "bar/a") is weird, as stated in the commit message, so I don't mind
disabling checking for directory rename in this case. However, in
theory, I don't see how disabling this check would fix anything, since
the bug seems to be about two different files on different sides being
renamed to the same filename through some convoluted means. (Unless this
is the only convoluted means to do it, and disabling it means that the
bug wouldn't occur.)
