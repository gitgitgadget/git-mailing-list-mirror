Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD68B66F
	for <git@vger.kernel.org>; Sat,  1 Jun 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717257309; cv=none; b=QUUNKWVx6y7hg0/pD7xGSuMQsYuM53XWw+oGyG3Di9JPtGtCv/HDXpyhAdxbsiBvHxwUe0dL7Bk+zyMcPA0Eqkudh3pjRsiw25fJu8EOL2VFvEBaJtrEXgSjVJw/Lx7nq64vssMmqT3enZom87C07xaMECTzpEvpetZreaZIuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717257309; c=relaxed/simple;
	bh=UpUpCuUlph6LyHQNC+IHvbbUF0DMW9Pn7sGxhIXf44s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hV1NN1tB53QbPDFK3vbGx2I+J7umULCWBw2W2azciL2g8j9VecSnOsLXrIXZuZq7zqhH/NU4nUBM9cskfvCGTlvGVQU0Imtx0ZOTipU6nBxL8gkyyocvDDo0v8hy+rFX9StlQwHx17da3znDa60RRchd0M6SwVD1CJ4uOKMjQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BZa1H+vS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BZa1H+vS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6831223821;
	Sat,  1 Jun 2024 11:55:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UpUpCuUlph6L
	yHQNC+IHvbbUF0DMW9Pn7sGxhIXf44s=; b=BZa1H+vS5qjHziAfqcQemAjdHAqb
	W5BsPS1i5V8ktlHmpZ4Auw7unVGzaT8Pt7DUTjv2z4HegnhrNOQDuJPcg97Ijjxr
	9qB083eCrC0ioldFj8DcLNqwBAyM0QUnS69WzHASHAXFczGWGL3vR2wRQjY2p8aI
	xhDJjIkI86Kkock=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 549F12381F;
	Sat,  1 Jun 2024 11:55:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8329F2381E;
	Sat,  1 Jun 2024 11:55:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v4 1/1] macOS: ls-files path fails if path of workdir is
 NFD
In-Reply-To: <20240531193156.28046-1-tboegi@web.de> (tboegi@web.de's message
	of "Fri, 31 May 2024 21:31:56 +0200")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240531193156.28046-1-tboegi@web.de>
Date: Sat, 01 Jun 2024 08:55:03 -0700
Message-ID: <xmqqh6ecbqug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4FC63A74-202F-11EF-B557-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

tboegi@web.de writes:

> The problem is the_repository->config->hash_initialized
> is set to 1 before the_repository->commondir is set to ".git".
> Due to this, .git/config is never read, and precomposed_unicode
> is never set to 1 (remains -1).

The "is never read" part is a bit confusing and misleading.  If it
were

    At the point of code flow where we would want to learn the value
    of precompose configuration, the local configuration has not
    been read.

then I would understand it, though.

Is the analysis telling us that we need to rethink the order of
things setup_git_directory() does?  Or is this inherently unsolvable
because we need to discover the .git/ directory and path to it
before we can read configuration to learn from it, but we need the
value of precompose setting to compute the "path to it"?

Presumably chdir() done in setup_discovered_git_dir() can be done
with either NFC or NFD if the filesystem is squashing the
differences between them, so perhaps doing the repo_set_worktree()
done in setup_discovered_git_dir() is wrong, and we could delay
populating the .worktree member until much later?  For reading the
local config, it does matter we know where the git-dir and
common-dir are, but the location of worktree is immaterial.

Anyway, thanks for a patch.  Will queue.

> run_builtin() {
>     setup_git_directory() {
>         strbuf_getcwd() {   # setup.c:1542
>             precompose_{strbuf,string}_if_needed() {
>                 # precomposed_unicode is still -1
>                 git_congig_get_bool("core.precomposeunicode") {
>                     git_config_check_init() {
>                         repo_read_config() {
>                             git_config_init() {
>                                 # !!!
>                                 the_repository->config->hash_initialize=
d=3D1
>                                 # !!!
>                             }
>                             # does not read .git/config since
>                             # the_repository->commondir is still NULL
>                         }
>                     }
>                 }
>                 returns without converting to NFC
>             }
>             returns cwd in NFD
>         }
>
>         setup_discovered_git_dir() {
>             set_git_work_tree(".") {
>                 repo_set_worktree() {
>                     # this function indirectly calls strbuf_getcwd()
>                     # --> precompose_{strbuf,string}_if_needed() -->
>                     # {git,repo}_config_get_bool("core.precomposeunicod=
e"),
>                     # but does not try to read .git/config since
>                     # the_repository->config->hash_initialized
>                     # is already set to 1 above. And it will not read
>                     # .git/config even if hash_initialized is 0
>                     # since the_repository->commondir is still NULL.
>
>                     the_repository->worktree =3D NFD
>                 }
>             }
>         }
>
>         setup_git_env() {
>             repo_setup_gitdir() {
>                 repo_set_commondir() {
>                     # finally commondir is set here
>                     the_repository->commondir =3D ".git"
>                 }
>             }
>         }
>
>     } // END setup_git_directory
>
> Reported-by: Jun T <takimoto-j@kba.biglobe.ne.jp>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  setup.c                      |  2 +-
>  t/t3910-mac-os-precompose.sh | 39 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 2e607632db..61f61496ec 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -48,7 +48,7 @@ static int abspath_part_inside_repo(char *path)
>  	size_t wtlen;
>  	char *path0;
>  	int off;
> -	const char *work_tree =3D get_git_work_tree();
> +	const char *work_tree =3D precompose_string_if_needed(get_git_work_tr=
ee());
>  	struct strbuf realpath =3D STRBUF_INIT;
>
>  	if (!work_tree)
> diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.s=
h
> index 898267a6bd..6d5918c8fe 100755
> --- a/t/t3910-mac-os-precompose.sh
> +++ b/t/t3910-mac-os-precompose.sh
> @@ -37,6 +37,27 @@ Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc        =
   #50 Byte
>  Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc           #250 Byte
>  Alongc=3D$Alongc$AEligatu$AEligatu                     #254 Byte
>
> +
> +ls_files_nfc_nfd () {
> +	test_when_finished "git config --global --unset core.precomposeunicod=
e" &&
> +	prglbl=3D$1
> +	prlocl=3D$2
> +	aumlcreat=3D$3
> +	aumllist=3D$4
> +	git config --global core.precomposeunicode $prglbl &&
> +	(
> +		rm -rf .git &&
> +		mkdir -p "somewhere/$prglbl/$prlocl/$aumlcreat" &&
> +		mypwd=3D$PWD &&
> +		cd "somewhere/$prglbl/$prlocl/$aumlcreat" &&
> +		git init &&
> +		git config core.precomposeunicode $prlocl &&
> +		git --literal-pathspecs ls-files "$mypwd/somewhere/$prglbl/$prlocl/$=
aumllist" 2>err &&
> +		>expected &&
> +		test_cmp expected err
> +	)
> +}
> +
>  test_expect_success "detect if nfd needed" '
>  	precomposeunicode=3D$(git config core.precomposeunicode) &&
>  	test "$precomposeunicode" =3D true &&
> @@ -211,8 +232,8 @@ test_expect_success "unicode decomposed: git restor=
e -p . " '
>  '
>
>  # Test if the global core.precomposeunicode stops autosensing
> -# Must be the last test case
>  test_expect_success "respect git config --global core.precomposeunicod=
e" '
> +	test_when_finished "git config --global --unset core.precomposeunicod=
e" &&
>  	git config --global core.precomposeunicode true &&
>  	rm -rf .git &&
>  	git init &&
> @@ -220,4 +241,20 @@ test_expect_success "respect git config --global c=
ore.precomposeunicode" '
>  	test "$precomposeunicode" =3D "true"
>  '
>
> +test_expect_success "ls-files false false nfd nfd" '
> +	ls_files_nfc_nfd false false $Adiarnfd $Adiarnfd
> +'
> +
> +test_expect_success "ls-files false true nfd nfd" '
> +	ls_files_nfc_nfd false true $Adiarnfd $Adiarnfd
> +'
> +
> +test_expect_success "ls-files true false nfd nfd" '
> +	ls_files_nfc_nfd true false $Adiarnfd $Adiarnfd
> +'
> +
> +test_expect_success "ls-files true true nfd nfd" '
> +	ls_files_nfc_nfd true true $Adiarnfd $Adiarnfd
> +'
> +
>  test_done
> --
> 2.41.0.394.ge43f4fd0bd
