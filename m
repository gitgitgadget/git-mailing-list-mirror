Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26159C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 23:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59F2221EA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 23:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgLCX0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 18:26:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCXZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 18:25:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72A3F9D15F;
        Thu,  3 Dec 2020 18:25:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=emBKHwWUny8XO2mHxzJs7PoF4Ho=; b=cWstyU
        5IF4wHJ79E83+snj6pNNlYjSpp+iNu5C6rdbFadMxxFWa/9Ty7ZgKNNYUomfAbsK
        pVcjXyNuquwtro69lTy8xV4f/C6NxL90Lvk9SNfyR1vRd0oqw0BuFQu90Oj6Z2Iq
        cJtZ1UMwoK6ZutzRoq2OLFES9KxOAXeExtWVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NoMpMpVb6sTCuz7N8dY+TnXuCDpq1nYo
        HSMxULZPbxJaJMNybeTdE0cEi6Dvw3FuStFbSNxze2AitbRqgKwgfU9ZAnaDRK0Y
        VQdJf4xZa6k5PHwicYH3X6/6TnkRPwzXv27q93vb2gvNcERmzRxTOhoUPqJHfbIX
        dQZXimIoQyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6981E9D15E;
        Thu,  3 Dec 2020 18:25:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF6F59D15D;
        Thu,  3 Dec 2020 18:25:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] init-db: init the_repository->hash_algo early from
 GIT_DEFAULT_HASH
References: <pull.924.git.git.1606419582190.gitgitgadget@gmail.com>
        <xmqq5z5mruia.fsf@gitster.c.googlers.com>
        <CAFQ2z_M3OO_nR6dhw6zzE0orYxcawP1DaJ_EOL5=+RUiZgCo8w@mail.gmail.com>
Date:   Thu, 03 Dec 2020 15:25:12 -0800
In-Reply-To: <CAFQ2z_M3OO_nR6dhw6zzE0orYxcawP1DaJ_EOL5=+RUiZgCo8w@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 3 Dec 2020 21:23:36 +0100")
Message-ID: <xmqqtut2fp5z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB655C78-35BE-11EB-A004-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> If the_repository is only half-initialized at this point in init_db(),
> then why are we passing it in refs_init_db() just a couple of lines
> further? At what point the_repository considered initialized?

I would have to say it probably depends on what callees expect.  The
current implementation of refs_init_db() for files backend may not
need anything other than the hash algorithm enum, but many other
fields are missing, and they should ideally be populated, no?  

For example, I see files_ref_store_create() cheats by calling
get_common_dir_noenv() to find out where the commondir is, instead
of ever asking the repository the ref store belongs to. At least,
get_main_ref_store() is told to get the ref store that belongs to
the_repository, and it would be the right place to learn relevant
pieces of information (for that matter, I am not sure why struct
ref_store does not have a pointer to a repository structure; perhaps
we are seeing the result of piecemeal evolution, not a designed
structure?).

> I'm a bit at a loss here; I never learned how to cleanly work with so
> many global variables, so I'm happy to take your suggestion.

I am only interested in giving a clear direction to future
developers where to populate the_repository's members (and nothing
else) if their enhancement needs members other than the hash
algorithm to be populated, as if it were the_repository initialized
in an already working repository (I am not talking about many global
variables, whichever you are referring to).

One way to do so would probably be to do something like the
attached.

The patch that started this thread (or the equivalent one in the
updated reftable series) may want to initialize a bit more members
while at it (looking at how commondir from the_repository is not
used by the refs/files-backend.c::files_init_db() to decide where
the function creates the refs/heads and refs/tags directories, we
probably would need to populate the_repository->commondir before
that codepath can be fixed to look at the member, for example).


 builtin/init-db.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git c/builtin/init-db.c w/builtin/init-db.c
index dcc45bef51..2b5c94596f 100644
--- c/builtin/init-db.c
+++ w/builtin/init-db.c
@@ -438,6 +438,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
+	/*
+	 * At this point, the_repository we have in-core does not look
+	 * anything like one that we would see initialized in an already
+	 * working repository after calling setup_git_directory().
+	 *
+	 * Calling repository.c::initialize_the_repository() may have
+	 * prepared the .index .objects and .parsed_objects members, but
+	 * other members like .gitdir, .commondir, etc. have not been
+	 * initialized.
+	 *
+	 * Many API functions assume they are working with the_repository
+	 * that has sensibly been initialized, but because we haven't
+	 * really read from an existing repository, we need to hand-craft
+	 * the necessary members of the structure to get out of this
+	 * chicken-and-egg situation.
+	 *
+	 * For now, we update the hash algorithm member to what the
+	 * validate_hash_algorithm() call decided for us.
+	 */
+	repo_set_hash_algo(the_repository, repo_fmt->hash_algo);
+
 	reinit = create_default_files(template_dir, original_git_dir,
 				      initial_branch, &repo_fmt,
 				      flags & INIT_DB_QUIET);


