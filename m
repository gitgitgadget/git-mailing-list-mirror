Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96914C593
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069513; cv=none; b=poHk4DLf2ocHVuUCV5p851eqnkpkKxKAvrCAl0CIURGmKDuZB6gSlAMLAi2w2h9Qm1QWLhglsUumD2MpaT8NjAs2VUHGFNRrAvRSHM/Zi4PgfIUpWu/AIOajEo/5PDuRvxlUfNH0iq77QkW5z9+1tGS0zfR0L+mqiTbfTKKQK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069513; c=relaxed/simple;
	bh=jQvpWtUCwHJxcutzVGrJ5EOcbaq1NK5VVixuWzJg3Ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WdKdZNSu3YAOXB5LknTrF4+SKlIPbXESnuJju44wege34sryFYKzVCXhIZtx3QpnWTeH1XTCTW6V0MpmKSRzWYmPpzIrJ7OycO7DRgGtAdgmbs0AgUgoIn2JRYn2fs44Rml7JXreTCoTW3HgYGXSgtckXQCoWg84wYctuPoJE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IRvf7zW5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IRvf7zW5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 56D601D30CB;
	Tue, 27 Feb 2024 16:31:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jQvpWtUCwHJxcutzVGrJ5EOcbaq1NK5VVixuWz
	Jg3Ow=; b=IRvf7zW5O3EHlZB8bilUixZaFEZScUiTdzGUqc/MIwICaiuyLJAwsT
	s4Q9R+j0AvJnsG6BDxcc/DLBZu53XOsneCun6LqfxR4QItxTBCy1NGMSsCbwtyjs
	CkYrI6/tBHHwAzivj55VEIFP8KKzs99ajpkZ535Tz3l+IKtOViIfA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EC301D30CA;
	Tue, 27 Feb 2024 16:31:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B7D91D30C9;
	Tue, 27 Feb 2024 16:31:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] builtin/clone: allow remote helpers to detect repo
In-Reply-To: <9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 27 Feb 2024 15:27:44 +0100")
References: <cover.1709041721.git.ps@pks.im>
	<9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.im>
Date: Tue, 27 Feb 2024 13:31:48 -0800
Message-ID: <xmqqle75ppa3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9DA8A06E-D5B7-11EE-AF2E-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Instead, fix this issue by partially initializing the refdb up to the
> point where it becomes discoverable by Git commands.

As you mentioned earlier, this indeed is ugly, but I agree that
there is no other reasonable way out.  I am also unsure if this is a
viable workaround in the longer term, but it should do for now.

> +	/*
> +	 * We have a chicken-and-egg situation between initializing the refdb
> +	 * and spawning transport helpers:
> +	 *
> +	 *   - Initializing the refdb requires us to know about the object
> +	 *     format. We thus have to spawn the transport helper to learn
> +	 *     about it.
> +	 *   - The transport helper may want to access the Git repository. But
> +	 *     because the refdb has not been initialized, we don't have "HEAD"
> +	 *     or "refs/". Thus, the helper cannot find the Git repository.
> +	 *
> +	 * Ideally, we would have structured the helper protocol such that it's
> +	 * mandatory for the helper to first announce its capabilities without
> +	 * yet assuming a fully initialized repository. Like that, we could
> +	 * have added a "lazy-refdb-init" capability that announces whether the
> +	 * helper is ready to handle not-yet-initialized refdbs. If any helper
> +	 * didn't support them, we would have fully initialized the refdb with
> +	 * the SHA1 object format, but later on bailed out if we found out that
> +	 * the remote repository used a different object format.
> +	 * But we didn't, and thus we use the following workaround to partially
> +	 * initialize the repository's refdb such that it can be discovered by
> +	 * Git commands. To do so, we:
> +	 *
> +	 *   - Create an invalid HEAD ref pointing at "refs/heads/.invalid".
> +	 *
> +	 *   - Create the "refs/" directory.
> +	 *
> +	 *   - Set up the ref storage format and repository version as
> +	 *     required.

"as required" by whom and in what way?  

"The code to recognize a repository requires them to be set already,
but they do not have to be the real value---we just assign random
valid values for now, let remote helper do its work and then set the
real values after they are done" would be a plausible interpretation
of the above.  Is that what is going on?

> +	 * This is sufficient for Git commands to discover the Git directory.
> +	 */
> +	initialize_repository_version(GIT_HASH_UNKNOWN,
> +				      the_repository->ref_storage_format, 1);

OK, so we start with "we do not know it yet" here.

> +	strbuf_addf(&buf, "%s/HEAD", git_dir);
> +	write_file(buf.buf, "ref: refs/heads/.invalid");
> +
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "%s/refs", git_dir);
> +	safe_create_dir(buf.buf, 1);
> +
>  	/*
>  	 * additional config can be injected with -c, make sure it's included
>  	 * after init_db, which clears the entire config environment.
> @@ -1453,6 +1498,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	free(remote_name);
>  	strbuf_release(&reflog_msg);
>  	strbuf_release(&branch_top);
> +	strbuf_release(&buf);
>  	strbuf_release(&key);
>  	free_refs(mapped_refs);
>  	free_refs(remote_head_points_at);
> diff --git a/setup.c b/setup.c
> index b69b1cbc2a..e3b76e84b5 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1889,6 +1889,13 @@ void initialize_repository_version(int hash_algo,
>  	char repo_version_string[10];
>  	int repo_version = GIT_REPO_VERSION;
>  
> +	/*
> +	 * Note that we initialize the repository version to 1 when the ref
> +	 * storage format is unknown. This is on purpose so that we can add the
> +	 * correct object format to the config during git-clone(1). The format
> +	 * version will get adjusted by git-clone(1) once it has learned about
> +	 * the remote repository's format.
> +	 */
>  	if (hash_algo != GIT_HASH_SHA1 ||
>  	    ref_storage_format != REF_STORAGE_FORMAT_FILES)
>  		repo_version = GIT_REPO_VERSION_READ;
> @@ -1898,7 +1905,7 @@ void initialize_repository_version(int hash_algo,
>  		  "%d", repo_version);
>  	git_config_set("core.repositoryformatversion", repo_version_string);
>  
> -	if (hash_algo != GIT_HASH_SHA1)
> +	if (hash_algo != GIT_HASH_SHA1 && hash_algo != GIT_HASH_UNKNOWN)
>  		git_config_set("extensions.objectformat",
>  			       hash_algos[hash_algo].name);
>  	else if (reinit)

Here we refrain from writing extensions.objectformat in the
repository when we do not know what hash function is being used.
Without this change, we would instead remove extensions.objectformat,
which does not sound too bad, as "reinit" is passed by the new call
we saw above and this "else if (reinit)" will do exactly that anyway.

In any case, after we finish talking with the other side over the
transport, we make another call to initialize_repository_version()
with the real objectformat and everything will be fine.

The ealier description of the implementation idea made it sound
really yucky, but I do not think the solution presented here is too
bad.

> diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
> index 1544d6dc6b..bcfb358c51 100755
> --- a/t/t5801/git-remote-testgit
> +++ b/t/t5801/git-remote-testgit
> @@ -12,6 +12,11 @@ url=$2
>  
>  dir="$GIT_DIR/testgit/$alias"
>  
> +if ! git rev-parse --is-inside-git-dir
> +then
> +	exit 1
> +fi
> +
>  h_refspec="refs/heads/*:refs/testgit/$alias/heads/*"
>  t_refspec="refs/tags/*:refs/testgit/$alias/tags/*"
