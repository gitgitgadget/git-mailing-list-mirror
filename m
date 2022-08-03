Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0B8C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 17:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiHCRyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiHCRyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 13:54:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CFD3F332
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 10:54:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 632271B6ED0;
        Wed,  3 Aug 2022 13:54:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DVSU2Vf+Lg5R
        6iXkW+iHlVTlYIX5tsCdvqoHhdo6mUo=; b=GA824mq+wqVCcnLMbZbWSPhuGUn7
        7ehGB7o3mRArBRaimN3g7zoCm2zMvfL6MysuJc2E6iwUC2mqQSA1Yj0SyPCK4TUK
        qQDuQcOerwKviVv3oAMzpXAmKoN6hVyGnFb35XplLn6U6BmjFGNdDugRc0+vnqJ2
        AU8U2pIkN+D36V8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C4011B6ECF;
        Wed,  3 Aug 2022 13:54:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F18BF1B6ECE;
        Wed,  3 Aug 2022 13:54:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/6] log: fix a memory leak in "git show <revision>..."
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
        <patch-v3-3.6-83fc1835fe5-20220802T152925Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 10:54:09 -0700
In-Reply-To: <patch-v3-3.6-83fc1835fe5-20220802T152925Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 17:33:13
        +0200")
Message-ID: <xmqqv8r99pry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47703F7A-1355-11ED-A3BF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak in code added in 5d7eeee2ac6 (git-show: grok blobs,
> trees and tags, too, 2006-12-14). As we iterate over a "<revision>..."
> command-line and encounter ad OBJ_COMMIT we want to use our "struct

"... encounter an OBJ_COMMIT, we want to ..."?

> rev_info", but with a "pending" array of one element: the one commit
> we're showing in the loop.
>
> To do this 5d7eeee2ac6 saved away a pointer to rev.pending.objects and
> rev.pending.nr for its iteration. We'd then clobber those (and alloc)
> when we needed to show an OBJ_COMMIT.
>
> We'd therefore leak the "rev.pending" we started out with, and only
> free the new "rev.pending" in the "OBJ_COMMIT" case arm as
> prepare_revision_walk() would draw it down.
>
> Let's fix this memory leak. Now when we encounter an OBJ_COMMIT we
> save away the "rev.pending" before clearing it. We then add a single
> commit to it, which our indirect invocation of prepare_revision_walk()
> will remove. After that we restore the "rev.pending".
>
> Our "rev.pending" will then get free'd by the release_revisions()
> added in f6bfea0ad01 (revisions API users: use release_revisions() in
> builtin/log.c, 2022-04-13)

Hmph, this gives me a strange sense of deja-vu that I saw a better
solution in a separate patch from you, strange because I do not see
anything at the tip of 'seen' like what I thought you did elsewhere.

We do need to reuse "rev_info" we got from outside the loop so that
we will have to consistently apply diffopt and other things we got
in there from the configuration and the command line.  But after we
decide to go to "each object is shown individually" mode, the
contents of the pending array (rather, what we got from the command
line in cmdline member) is only relevant to enumerate which
individual objects are shown in the loop, and should not even be
visible to the code that handles each individual object, e.g. even
we pass &rev to this code when we see a blob:

		switch (o->type) {
		case OBJ_BLOB:
			ret =3D show_blob_object(&o->oid, &rev, name);
			break;

there is no point in exposing the rev.pending to show_blob_object()
at al.  The same is true for codepaths used to show a tag or a tree.
When showing a commit, we do not even want the codepath that shows a
single-commit range to touch and destroy the original rev.pending;
we instead want to give a single-element pending array.

So instead of keeping rev.pending when we enter the loop and saving
it away and restoring it, it feels a lot cleaner to invent/use an
interface to "clone" the settings in an existing rev_info by:

 * Grab rev.pending into a separate "struct object_array" that is a
   local variable in cmd_show() and clear rev.pending, immediately
   after we decide to go to "show individually" mode.

 * Iterate over the objects in that local variable.  For each object
   to be shown, prepare a rev_info, clone the setting from the
   original rev_info, put that single object to the pending member
   of the clone, use that cloned rev_info, and release the resources
   held by the cloned rev_info once we are done.

> diff --git a/builtin/log.c b/builtin/log.c
> index 88a5e98875a..b4b1d974617 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -743,11 +743,17 @@ int cmd_show(int argc, const char **argv, const c=
har *prefix)
>  			rev.shown_one =3D 1;
>  			break;
>  		case OBJ_COMMIT:
> +		{
> +			struct object_array old;
> +
> +			memcpy(&old, &rev.pending, sizeof(old));
>  			rev.pending.nr =3D rev.pending.alloc =3D 0;
>  			rev.pending.objects =3D NULL;
>  			add_object_array(o, name, &rev.pending);
>  			ret =3D cmd_log_walk_no_free(&rev);
> +			memcpy(&rev.pending, &old, sizeof(rev.pending));
>  			break;
> +		}

The reason why I find this approach a bit disturbing is that we
pretend to know for certain that pending is the only thing we need
to protect across multiple calls to the log_walk(), but I suspect
that such an overconfidence will come back and bite us.  We are not
re-initializing other states reachable from the rev_info (e.g. the
diff_options struct has various members that records what happened
in an invocation, like needed_rename_limit, found_follow, and
found_changes, that would want to be reinitialized if we are
starting a new and totally independent traversal after we are done
one traversal).

But I do not mind at all to leave such a fundamental clean-up to a
totally separate topic, and keep this patch only about "we are
clobbering and leaking rev.pending, let's plug the leak".  In fact,
I would prefer it that way.  So take all of the above as material
for possible NEEDSWORK comment, food for further thought.

