Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953E9C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6606660F45
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhKAGmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:42:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60896 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhKAGmn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 02:42:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CECE15D00E;
        Mon,  1 Nov 2021 02:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dIYk4+LpBHVyRmPCXEy1oAh6hVLuh4unQuNd2Y
        qp7No=; b=ezKyccwyMYBrb/z4/Yd8EW0Q73bh/2OgluPRA625AZ9dEnqkOCmxNM
        s1C3R8nPR9uXtOKoR4xTkljobP8ItzRmJKLKlcyBPDbFQ0+Eb6pEfo4oFQCYmPY5
        b48dyF47/gUuHoAJ1EwJyuECduGHkgy4KLHsNgbg2sLNsKjymNMEE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6539315D00D;
        Mon,  1 Nov 2021 02:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E04A15D00B;
        Mon,  1 Nov 2021 02:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     rhodges@cisco.com, git@vger.kernel.org, rphodges@gmail.com
Subject: Re: [PATCH v2] apply: make --intent-to-add not stomp index
References: <20211030204155.2500624-1-aclopte@gmail.com>
        <20211030205147.2503327-1-aclopte@gmail.com>
Date:   Sun, 31 Oct 2021 23:40:05 -0700
In-Reply-To: <20211030205147.2503327-1-aclopte@gmail.com> (Johannes
        Altmanninger's message of "Sat, 30 Oct 2021 22:51:47 +0200")
Message-ID: <xmqqr1c0cray.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D6AC8A6-3ADE-11EC-B824-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> Commit cff5dc09ed (apply: add --intent-to-add, 2018-05-26) introduced
> "apply -N" plus a test to make sure it behaves exactly as "add -N"
> when given equivalent changes.  However, the test only checks working
> tree changes. Now "apply -N" forgot to read the index, so it left
> all tracked files as deleted, except for the ones it touched.
>
> Fix this by reading the index file, like we do for "apply --cached".
> and test that we leave no content changes in the index.
>
> Reported-by: Ryan Hodges <rhodges@cisco.com>
> Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
> ---
>
> Sorry I used the wrong Reported-by: address in v1
>
>  apply.c               | 2 +-
>  t/t2203-add-intent.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 43a0aebf4e..4f740e373b 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4771,7 +4771,7 @@ static int apply_patch(struct apply_state *state,
>  					       LOCK_DIE_ON_ERROR);
>  	}
>  
> -	if (state->check_index && read_apply_cache(state) < 0) {
> +	if ((state->check_index || state->ita_only) && read_apply_cache(state) < 0) {
>  		error(_("unable to read index file"));
>  		res = -128;
>  		goto end;

Thanks for an attempt, but I am not sure if it is wise to keep
ita_only independent from check_index like this patch does.

There are many safety/correctness related checks that check_index
enables, and that is why not just the "--index" option, but "--3way"
and "--cached" enable it internally.  As "instead of adding the
contents to the index, mark the new path with i-t-a bit" is also
futzing with the index, it should enable the same safety checks by
enabling check_index _much_ earlier.  And if you did so, the above
hunk will become a totally unnecessary change, because by the time
the control gets there, because you accepted ita_only earlier and
enabled check_index, just like you did for "--3way" and "--cached".

One thing that check_index does is that it drops unsafe_paths bit,
which means we would be protected from patch application that tries
to step out of our narrow cone of the directory hierarchy, which is
a safety measure.  There are probably others I am forgetting.

Can you study the code to decide if check_apply_state() is the right
place to do this instead?  I have this feeling that the following
bit in the function

	if (state->ita_only && (state->check_index || is_not_gitdir))
		state->ita_only = 0;

is simply _wrong_ to silently drop the ita_only bit when not in a
repository, or other index-touching options are in effect.  Rather,
I wonder if it should look more like the attached (the other parts
of the implementation of ita_only may be depending on the buggy
construct, which might result in other breakages if we did this
alone, though).

Thanks.


 apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/apply.c w/apply.c
index 43a0aebf4e..887465347b 100644
--- c/apply.c
+++ w/apply.c
@@ -146,15 +146,15 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
+	if (state->ita_only)
+		state->check_index = 1;
 	if (state->check_index && is_not_gitdir)
 		return error(_("--index outside a repository"));
 	if (state->cached) {
 		if (is_not_gitdir)
 			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
-	if (state->ita_only && (state->check_index || is_not_gitdir))
-		state->ita_only = 0;
 	if (state->check_index)
 		state->unsafe_paths = 0;
 
