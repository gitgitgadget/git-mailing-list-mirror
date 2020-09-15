Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863D6C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 04:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23455212CC
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 04:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZWO9rfq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIOEbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 00:31:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58084 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOEbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 00:31:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B63C1076CB;
        Tue, 15 Sep 2020 00:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PlyF4k0tcTks
        Xk2TS61Zu3z+e9Q=; b=ZWO9rfq9DKM5eTx8Vv2r0/jStPiw2VaCJ8vMxCCeYRzy
        Utm45xnBWmxYmoumbGb3FDdAPycQP+tJmr/bxOHgtzFI2EgqeC2v3SN9A8LcO4xM
        NEKzlj6ImBcawh5gGFGJ6H77OjlIjrEApBdft5bFfQWIZ/+idph9hQVTYqs8E8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WDL51P
        UoayTauyic4PiFe2vvLBBta+Q6jnY6CZZeDRp89K7njhYaqtY2uLF9TZjdqzZe5C
        lkmoCJ34dKeHQi93POJPqjCQ1juVnZbi6ZGmWJRGwmfgVBLzXw83FHcy5AWZY8QJ
        jic7KB+a1DhLZ72bRGNUCTu56aEUBXMfgnab4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73BAA1076CA;
        Tue, 15 Sep 2020 00:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA6CA1076C9;
        Tue, 15 Sep 2020 00:31:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v2] builtin/clone: avoid failure with GIT_DEFAULT_HASH
References: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
        <20200915015845.4149976-1-sandals@crustytoothpaste.net>
Date:   Mon, 14 Sep 2020 21:31:14 -0700
In-Reply-To: <20200915015845.4149976-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 15 Sep 2020 01:58:45 +0000")
Message-ID: <xmqq8sdb1x0t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C2B6772-F70C-11EA-8CDD-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If a user is cloning a SHA-1 repository with GIT_DEFAULT_HASH set to
> "sha256", then we can end up with a repository where the repository
> format version is 0 but the extensions.objectformat key is set to
> "sha256".  This is both wrong (the user has a SHA-1 repository) and
> nonfunctional (because the extension cannot be used in a v0 repository)=
.
>
> This happens because in a clone, we initially set up the repository, an=
d
> then change its algorithm based on what the remote side tells us it's
> using.  We've initially set up the repository as SHA-256 in this case,
> and then later on reset the repository version without clearing the
> extension.
>
> We could just always set the extension in this case, but that would mea=
n
> that our SHA-1 repositories weren't compatible with older Git versions,
> even though there's no reason why they shouldn't be.  And we also don't
> want to initialize the repository as SHA-1 initially, since that means
> if we're cloning an empty repository, we'll have failed to honor the
> GIT_DEFAULT_HASH variable and will end up with a SHA-1 repository, not =
a
> SHA-256 repository.
>
> Neither of those are appealing, so let's tell the repository
> initialization code if we're doing a reinit like this, and if so, to
> clear the extension if we're using SHA-1.  This makes sure we produce a
> valid and functional repository and doesn't break any of our other use
> cases.
>
> Reported-by: Matheus Tavares <matheus.bernardino@usp.br>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> Changes since v1:
> * Use git_config_set_gently to make things work with SHA-1 repos as wel=
l
>   as SHA-256 repos.

Hmph, the reason why v1's bug weren't caught was because it was only
tested with GIT_TEST_DEFAULT_HASH=3Dsha256, right?  I am wondering if
adding two new tests that run the same end-user scenario except
for the choice of hash algorithms would be a good way to ensure this
will stay fixed.  Am I mistaken?

Thanks anyway for a quick turnaround.

> Diff-intervalle contre v1=C2=A0:
> 1:  32d3357460 ! 1:  1becbbbb50 builtin/clone: avoid failure with GIT_D=
EFAULT_HASH
>     @@ builtin/init-db.c: void initialize_repository_version(int hash_a=
lgo)
>       		git_config_set("extensions.objectformat",
>       			       hash_algos[hash_algo].name);
>      +	else if (reinit)
>     -+		git_config_set("extensions.objectformat", NULL);
>     ++		git_config_set_gently("extensions.objectformat", NULL);
>       }
>      =20
>       static int create_default_files(const char *template_path,
>
>  builtin/clone.c   |  2 +-
>  builtin/init-db.c |  6 ++++--
>  cache.h           |  2 +-
>  t/t5601-clone.sh  | 10 ++++++++++
>  4 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b087ee40c2..925a2e3dd6 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1235,7 +1235,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
>  		 * Now that we know what algorithm the remote side is using,
>  		 * let's set ours to the same thing.
>  		 */
> -		initialize_repository_version(hash_algo);
> +		initialize_repository_version(hash_algo, 1);
>  		repo_set_hash_algo(the_repository, hash_algo);
> =20
>  		mapped_refs =3D wanted_peer_refs(refs, &remote->fetch);
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index cd3e760541..01bc648d41 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -179,7 +179,7 @@ static int needs_work_tree_config(const char *git_d=
ir, const char *work_tree)
>  	return 1;
>  }
> =20
> -void initialize_repository_version(int hash_algo)
> +void initialize_repository_version(int hash_algo, int reinit)
>  {
>  	char repo_version_string[10];
>  	int repo_version =3D GIT_REPO_VERSION;
> @@ -195,6 +195,8 @@ void initialize_repository_version(int hash_algo)
>  	if (hash_algo !=3D GIT_HASH_SHA1)
>  		git_config_set("extensions.objectformat",
>  			       hash_algos[hash_algo].name);
> +	else if (reinit)
> +		git_config_set_gently("extensions.objectformat", NULL);
>  }
> =20
>  static int create_default_files(const char *template_path,
> @@ -277,7 +279,7 @@ static int create_default_files(const char *templat=
e_path,
>  		free(ref);
>  	}
> =20
> -	initialize_repository_version(fmt->hash_algo);
> +	initialize_repository_version(fmt->hash_algo, 0);
> =20
>  	/* Check filemode trustability */
>  	path =3D git_path_buf(&buf, "config");
> diff --git a/cache.h b/cache.h
> index cee8aa5dc3..c0072d43b1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -629,7 +629,7 @@ int path_inside_repo(const char *prefix, const char=
 *path);
>  int init_db(const char *git_dir, const char *real_git_dir,
>  	    const char *template_dir, int hash_algo,
>  	    const char *initial_branch, unsigned int flags);
> -void initialize_repository_version(int hash_algo);
> +void initialize_repository_version(int hash_algo, int reinit);
> =20
>  void sanitize_stdfds(void);
>  int daemonize(void);
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 15fb64c18d..570d989795 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -631,6 +631,16 @@ test_expect_success CASE_INSENSITIVE_FS 'colliding=
 file detection' '
>  	test_i18ngrep "the following paths have collided" icasefs/warning
>  '
> =20
> +test_expect_success 'clone with GIT_DEFAULT_HASH' '
> +	(
> +		sane_unset GIT_DEFAULT_HASH &&
> +		git init test
> +	) &&
> +	test_commit -C test foo &&
> +	git clone test test-clone &&
> +	git -C test-clone status
> +'
> +
>  partial_clone_server () {
>  	       SERVER=3D"$1" &&
> =20
