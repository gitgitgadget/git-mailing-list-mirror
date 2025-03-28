Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF71C8615
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186344; cv=none; b=IzIi6o2HrgdaUIzE5bTOIpCMrZlGxPX9RHZxZJV6uXO4NzKv/pvePR0Bu844NSTEwQoVm+8eQM+kvbPH3Eczu7GdQvMxpeK4HFVrKjIXyDMxHmgGgcsn4LKWtUIJViZHXSB1MUVCsnEp98s4YI1qSPa/5Y1prucDcbAPoEhm/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186344; c=relaxed/simple;
	bh=KdI5I3neHEN4s9zMvdyPlT4O+HjX6xWC9RDHyziF2G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RoZ0op5W9VIRaQqVq6S4vgGR4PljeJHvoN4uBCNPnk+9PgVva1PlaYieFnRhbR+PKFGMiIo45Hyy+X06DGq6pNBCo/kZ2D7nZTPeHpy5sfSRciKxZmdI+r5mCBIiEIxyvwrbX4PI0y3BZqoNDc26L9x0KqDmaX2qGpfbMfQmguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3D0FE3430E1;
	Fri, 28 Mar 2025 18:25:41 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Junio C Hamano <gitster@pobox.com>,  Eli Schwartz
 <eschwartz@gentoo.org>,  Thorsten Glaser <tg@debian.org>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] meson: respect 'tests' build option in contrib
In-Reply-To: <20250328-b4-pks-collect-build-fixes-v1-4-ead9deda3fbc@pks.im>
Organization: Gentoo
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
	<20250328-b4-pks-collect-build-fixes-v1-4-ead9deda3fbc@pks.im>
User-Agent: mu4e 1.12.9; emacs 31.0.50
Date: Fri, 28 Mar 2025 18:25:38 +0000
Message-ID: <87semx3tct.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Both the "netrc" credential helper and git-subtree(1) from "contrib/"
> carry a couple of tests with them. These tests get wired up in Meson
> unconditionally even in the case where `-Dtests=false`. As those tests
> depend on the `test_enviroment` variable, which only gets defined in
> case `-Dtests=true`, the result is an error:
>
> ```
> $ meson setup -Dtests=false -Dcontrib=subtree build
> [...]
>
> contrib/subtree/meson.build:15:27: ERROR: Unknown variable "test_environment".
> ```
>
> Fix the issue by not defining these tests at all in case the "tests"
> option is set to `false`.

Thank you! Sorry for the delay in getting back to you -- I had some
thought that I was trying to resolve about the nicer style and then
dropped the ball. LGTM.

>
> Reported-by: Sam James <sam@gentoo.org>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  contrib/credential/netrc/meson.build | 22 ++++++++++++----------
>  contrib/subtree/meson.build          | 20 +++++++++++---------
>  2 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
> index a990dbb86da..3d74547c8ae 100644
> --- a/contrib/credential/netrc/meson.build
> +++ b/contrib/credential/netrc/meson.build
> @@ -7,14 +7,16 @@ credential_netrc = custom_target(
>    install_dir: get_option('libexecdir') / 'git-core',
>  )
>  
> -credential_netrc_testenv = test_environment
> -credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
> +if get_option('tests')
> +  credential_netrc_testenv = test_environment
> +  credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
>  
> -test('t-git-credential-netrc',
> -  shell,
> -  args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
> -  workdir: meson.current_source_dir(),
> -  env: credential_netrc_testenv,
> -  depends: test_dependencies + bin_wrappers + [credential_netrc],
> -  timeout: 0,
> -)
> +  test('t-git-credential-netrc',
> +    shell,
> +    args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
> +    workdir: meson.current_source_dir(),
> +    env: credential_netrc_testenv,
> +    depends: test_dependencies + bin_wrappers + [credential_netrc],
> +    timeout: 0,
> +  )
> +endif
> diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
> index 9c72b236259..63714166a61 100644
> --- a/contrib/subtree/meson.build
> +++ b/contrib/subtree/meson.build
> @@ -12,16 +12,18 @@ git_subtree = custom_target(
>    install_dir: get_option('libexecdir') / 'git-core',
>  )
>  
> -subtree_test_environment = test_environment
> -subtree_test_environment.prepend('PATH', meson.current_build_dir())
> +if get_option('tests')
> +  subtree_test_environment = test_environment
> +  subtree_test_environment.prepend('PATH', meson.current_build_dir())
>  
> -test('t7900-subtree', shell,
> -  args: [ 't7900-subtree.sh' ],
> -  env: subtree_test_environment,
> -  workdir: meson.current_source_dir() / 't',
> -  depends: test_dependencies + bin_wrappers + [ git_subtree ],
> -  timeout: 0,
> -)
> +  test('t7900-subtree', shell,
> +    args: [ 't7900-subtree.sh' ],
> +    env: subtree_test_environment,
> +    workdir: meson.current_source_dir() / 't',
> +    depends: test_dependencies + bin_wrappers + [ git_subtree ],
> +    timeout: 0,
> +  )
> +endif
>  
>  if get_option('docs').contains('man')
>    subtree_xml = custom_target(
