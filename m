Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD15C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 22:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJNWDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJNWDh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 18:03:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118117FD69
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 15:03:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7768C147700;
        Fri, 14 Oct 2022 18:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R5WoZ7C0rNEyH/63OPtvU9PwBWMkoVgvh8rIOO
        Hntms=; b=vViijqg7IVj5OiKtFKSzTMjRjsD9YdoER9nrhOnbJfmnBGG95zU7wG
        BbWC8NNATikmxnSEERNMyRswz0KZwuqZfYJJL+4qG0kfVThpDkLSLDPLsotMwzbk
        HEsC+Kypg8PDl+bKQ7ty12eG/Ds8zQXZGisKKuEZ3VzriWc4246B0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FDDD1476FE;
        Fri, 14 Oct 2022 18:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D15DE1476FD;
        Fri, 14 Oct 2022 18:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v3 6/7] builtin: patch-id: remove unused diff-tree prefix
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <a1f6f36d4878ade4fae1142f03e53d0cc42dfb2b.1665737804.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 15:03:31 -0700
In-Reply-To: <a1f6f36d4878ade4fae1142f03e53d0cc42dfb2b.1665737804.git.gitgitgadget@gmail.com>
        (Jerry Zhang via GitGitGadget's message of "Fri, 14 Oct 2022 08:56:43
        +0000")
Message-ID: <xmqq1qra6p1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B2673B4-4C0C-11ED-B3F5-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jerry Zhang <Jerry@skydio.com>
>
> From a "git grep" of the repo, no command, including diff-tree itself,
> produces diff output with "diff-tree " prefixed in the header.

I think you are lucky and it is OK in this case, but the "grep" only
tells about the current source, and a bit more due dilligence is in
general needed.

 * f9767222 (Add "git-patch-id" program to generate patch ID's.,
   2005-06-23) introduced the line that prepares us to see
   "diff-tree" prefix.  In that version, "git diff-tree --pretty
   --stdin" did use the prefix (it comes from 'diff-tree.c").

 * 5f1c3f07 (log-tree: separate major part of diff-tree.,
   2006-04-09) moved things around from "diff-tree.c" to
   "log-tree.c", without changing the behaviour.

 * cd2bdc53 (Common option parsing for "git log --diff" and friends,
   2006-04-14) further moved revs->header_prefix set-up to
   revision.c::setup_revisions(), without changing the behaviour.

 * 91539833 (Log message printout cleanups, 2006-04-17) did change
   the things drastically.  Its log message says:

       This does change "git whatchanged" from using "diff-tree" as
       the commit descriptor to "commit", and I changed one of the
       tests to reflect that new reality. Otherwise everything still
       passes, and my other tests look fine too.

As long as nobody keeps output from version of Git before v1.3.0
this change is safe to do ;-)

There may be third-party tools that was written in 2005-2006 that
still emit diff-tree prefix, but I somehow do not think it is likely
anobody would feed such an output to us.  Given how widely Git is
used, I might be overly optimistic, though.

> Thus remove its handling in "patch-id".
>
> Signed-off-by: Jerry Zhang <Jerry@skydio.com>
> ---
>  builtin/patch-id.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 745fe193a71..c37b8f573b7 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -74,8 +74,8 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
>  		const char *p = line;
>  		int len;
>  
> -		if (!skip_prefix(line, "diff-tree ", &p) &&
> -		    !skip_prefix(line, "commit ", &p) &&
> +		/* Possibly skip over the prefix added by "log" or "format-patch" */
> +		if (!skip_prefix(line, "commit ", &p) &&
>  		    !skip_prefix(line, "From ", &p) &&
>  		    starts_with(line, "\\ ") && 12 < strlen(line)) {
>  			if (include_whitespace)
