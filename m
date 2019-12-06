Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA54C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D072173E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AR7VcqwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLFSYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:24:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57410 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLFSYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 13:24:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3424D1E4FC;
        Fri,  6 Dec 2019 13:24:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qCRAJbsqwQISJK0iQ+WKugPO/qc=; b=AR7Vcq
        wKCOyAs1rtyFY1Bclg/bgfsBeXFLnVyu9lw+UbXLQIsNzrtbyFC6dg76Ifj+ar/s
        N1yTRMwt4IUp9FNoIo35UDLJDK2DaGLBDpJSyXiuLDF7ZbvojXxIvXSaQ7cXsem6
        9DeJG+YfSAqkoLdsaWWiTBeSB7lpLCerM6j9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h6jy0ptwdLF3Qk7IXnCINZ5MptoIebl2
        PNch9m0kIoSTiggXQI83LSCFzpa1RVKUsBet8o04UqUDGl9Go2gkB4MY2hnObu5T
        TC+Hx4SFOdIs3mhU0Ue6TXRA9tXbOwaH/+chzkZgnjgE/T4B1T1cBqVEPpmgwpfM
        MfmGjDLfW2o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B87A1E4FB;
        Fri,  6 Dec 2019 13:24:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7AF0D1E4F8;
        Fri,  6 Dec 2019 13:24:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 6/9] commit: encapsulate determine_whence() for sequencer
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
        <20191206160614.631724-1-phillip.wood123@gmail.com>
        <20191206160614.631724-7-phillip.wood123@gmail.com>
Date:   Fri, 06 Dec 2019 10:24:01 -0800
In-Reply-To: <20191206160614.631724-7-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Fri, 6 Dec 2019 16:06:11 +0000")
Message-ID: <xmqqwob9wbwe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 942950CA-1855-11EA-98FD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Working out which command wants to create a commit requires detailed
> knowledge of the sequencer internals and that knowledge is going to
> increase in subsequent commits. With that in mind lets encapsulate that
> knowledge in sequencer.c rather than spreading it into builtin/commit.c.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/commit.c |  5 +----
>  sequencer.c      | 13 ++++++++++++-
>  sequencer.h      |  3 ++-
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 3b463522be..d8d4c8e419 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -178,10 +178,7 @@ static void determine_whence(struct wt_status *s)
>  {
>  	if (file_exists(git_path_merge_head(the_repository)))
>  		whence = FROM_MERGE;
> -	else if (file_exists(git_path_cherry_pick_head(the_repository)))
> -		whence = file_exists(git_path_seq_dir()) ?
> -			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
> -	else
> +	else if (!sequencer_determine_whence(the_repository, &whence))
>  		whence = FROM_COMMIT;
>  	if (s)
>  		s->whence = whence;
> diff --git a/sequencer.c b/sequencer.c
> index 4e0370277b..98e007556c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -40,7 +40,7 @@ static const char cherry_picked_prefix[] = "(cherry picked from commit ";
>  
>  GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
>  
> -GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
> +static GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
>  
>  static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
>  static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
> @@ -5256,3 +5256,14 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>  
>  	return 0;
>  }
> +
> +int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
> +{
> +	if (file_exists(git_path_cherry_pick_head(r))) {
> +		*whence = file_exists(git_path_seq_dir()) ?
> +			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
> +		return 1;
> +	}
> +
> +	return 0;
> +}

I am not sure if this is a good move---determine_whence() that can
tell not just we are in the middle of cherry-pick (either a single
or multi) but also during a merge may be at the right abstraction
level.  Why would we want to invent a separate function that says "I
dunno" during a merge, instead of moving the logic for merge to the
new helper as well?  The original determine_whence that takes
wt_status and populates it still has to call the new helper either
way.  Also for the matter FROM_COMMIT may also want to be part of
the helper.  This all depends on the new callers you plan to invent,
of course.

Not part of this topic, but the call to file_exists() may want to
become a call to dir_exists() as git-path-seq-dir is clearly a
directory and cannot be a file, right?
