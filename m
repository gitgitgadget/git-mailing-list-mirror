Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC611CA9
	for <git@vger.kernel.org>; Fri,  3 May 2024 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714703005; cv=none; b=XoIl+4J0M6+aNgjOj4Z3Qmgq2pLyPKf6kqH2zIKjgSufYutclF0e0pf48rDlNdvFWtgpGXlCmHfe0SfQf+CEwMpKqe/GKz81Lx4+lMzSSUnE8Vgd1Y7uIk36IQMlEvPpm1VawgS3/f3PSd3YrifM8UfA+bP2On0JIp+q1jPzRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714703005; c=relaxed/simple;
	bh=/7WU2nvEZICCobdYyzQfJ5NLXMKXAMcepfCuxHUv2KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfiE2oZ2rZ6mOQHQTvBl4Ik8OBpoTUI7vrv04vmkIbVSFOPVITUEaG7FrKxK2PClJaRhAnJXJ/pDrLuW8zlfZ0pnLwCIpdckhDhFKdxA1rcHBXyhjcJv2qGy0XYFcS1maqRWnJx71etM5fn9f5KRlvqn8rTA3MJr19hPyOjSI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3418120-ipxg00d01tokaisakaetozai.aichi.ocn.ne.jp ([114.171.163.120] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1s2iHx-006tPO-2k;
	Fri, 03 May 2024 02:04:46 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1s2iHo-00B8D6-2s;
	Fri, 03 May 2024 11:04:32 +0900
Date: Fri, 3 May 2024 11:04:32 +0900
From: Mike Hommey <mh@glandium.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/clone: allow remote helpers to detect repo
Message-ID: <20240503020432.2fxwuhjsvumy7i7z@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover.1709041721.git.ps@pks.im>
 <9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.im>

Hey, it's me again, coming back way too late to figure out that this fix
had an adverse side effect in a corner case.

Here's a simplified reproducer:
```
$ cat > git-remote-foo <<EOF
#!/bin/sh
# capabilities
echo option
echo import
echo push
echo
# option progress true
echo ok
# option verbosity 1
echo ok
# list
echo
EOF
$ chmod +x git-remote-foo
$ PATH=$PWD:$PATH git clone foo::bar
Cloning into 'bar'...
created HEAD
warning: this remote helper should implement refspec capability
created reference db
warning: You appear to have cloned an empty repository.
hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint: 	git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint: 	git branch -m <name>
```

That hint is the adverse side effect. It shouldn't be shown.

It's happening because `builtin/clone.c` does this:
	`create_reference_database(the_repository->ref_storage_format, NULL, 1);`

`create_reference` calls `is_reinit`, which returns true because there is
HEAD, and proceeds to skip the block behind `if (!reinit)`.

Before the change, that code block that is now skipped would have called
`git_default_branch_name(quiet)` (where `quiet` is 1, per the above call
to `create_reference_database`). In turn
`git_default_branch_name(quiet)` would have a) skipped the initial
branch hint (because quiet), and b) cached the branch name for subsequent
`git_default_branch_name` calls.

Then later in `builtin/clone.c`, we end up in this code:
	`branch = git_default_branch_name(0);`

Before the change, this would get the cache value from the previous
call, but now it has to compute it, and because 0 is passed, it's not
quiet about the initial branch hint.

The non-remote-helper case goes through with this without a problem
because it ends up in the transport_ls_refs_options.unborn_head_target
case and never calls `git_default_branch_name(0)`.

Mike

On Tue, Feb 27, 2024 at 03:27:44PM +0100, Patrick Steinhardt wrote:
> In 18c9cb7524 (builtin/clone: create the refdb with the correct object
> format, 2023-12-12), we have changed git-clone(1) so that it delays
> creation of the refdb until after it has learned about the remote's
> object format. This change was required for the reftable backend, which
> encodes the object format into the tables. So if we pre-initialized the
> refdb with the default object format, but the remote uses a different
> object format than that, then the resulting tables would have encoded
> the wrong object format.
> 
> This change unfortunately breaks remote helpers which try to access the
> repository that is about to be created. Because the refdb has not yet
> been initialized at the point where we spawn the remote helper, we also
> don't yet have "HEAD" or "refs/". Consequently, any Git commands ran by
> the remote helper which try to access the repository would fail because
> it cannot be discovered.
> 
> This is essentially a chicken-and-egg problem: we cannot initialize the
> refdb because we don't know about the object format. But we cannot learn
> about the object format because the remote helper may be unable to
> access the partially-initialized repository.
> 
> Ideally, we would address this issue via capabilities. But the remote
> helper protocol is not structured in a way that guarantees that the
> capability announcement happens before the remote helper tries to access
> the repository.
> 
> Instead, fix this issue by partially initializing the refdb up to the
> point where it becomes discoverable by Git commands.
> 
> Reported-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c            | 46 ++++++++++++++++++++++++++++++++++++++
>  setup.c                    |  9 +++++++-
>  t/t5801/git-remote-testgit |  5 +++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index bad1b70ce8..5d7f112125 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -926,6 +926,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	struct ref *mapped_refs = NULL;
>  	const struct ref *ref;
>  	struct strbuf key = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
>  	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
>  	struct transport *transport = NULL;
>  	const char *src_ref_prefix = "refs/heads/";
> @@ -1125,6 +1126,50 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		git_dir = real_git_dir;
>  	}
>  
> +	/*
> +	 * We have a chicken-and-egg situation between initializing the refdb
> +	 * and spawning transport helpers:
> +	 *
> +	 *   - Initializing the refdb requires us to know about the object
> +	 *     format. We thus have to spawn the transport helper to learn
> +	 *     about it.
> +	 *
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
> +	 *
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
> +	 *
> +	 * This is sufficient for Git commands to discover the Git directory.
> +	 */
> +	initialize_repository_version(GIT_HASH_UNKNOWN,
> +				      the_repository->ref_storage_format, 1);
> +
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
>  
> -- 
> 2.44.0
> 


