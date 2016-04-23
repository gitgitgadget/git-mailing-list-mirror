From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] hooks: Add ability to specify where the hook directory is
Date: Sat, 23 Apr 2016 02:13:02 +0200
Message-ID: <1461370382-16524-1-git-send-email-szeder@ira.uka.de>
References: <1461367997-28745-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 02:13:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atlCj-0006Fp-8c
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 02:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbcDWANj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 20:13:39 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:55630 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407AbcDWANi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 20:13:38 -0400
Received: from x590e2083.dyn.telefonica.de ([89.14.32.131] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1atlCT-00051B-04; Sat, 23 Apr 2016 02:13:34 +0200
X-Mailer: git-send-email 2.8.1.99.g5d5236f
In-Reply-To: <1461367997-28745-1-git-send-email-avarab@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461370414.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292293>


> Change the hardcoded lookup for .git/hooks/* to optionally lookup in
> $(git config core.hooksDirectory)/* instead if that config key is set=
=2E
>=20
> This is essentially a more intrusive version of the git-init ability =
to
> specify hooks on init time via init templates.
>=20
> The difference between that facility and this feature is that this ca=
n
> be set up after the fact via e.g. ~/.gitconfig or /etc/gitconfig to
> apply for all your personal repositories, or all repositories on the
> system.
>=20
> I plan on using this on a centralized Git server where users can crea=
te
> arbitrary repositories under /gitroot, but I'd like to manage all the
> hooks that should be run centrally via a unified dispatch mechanism.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  Documentation/config.txt          | 10 ++++++++++
>  Documentation/githooks.txt        |  5 ++++-
>  cache.h                           |  1 +
>  config.c                          |  3 +++
>  environment.c                     |  1 +
>  run-command.c                     |  5 ++++-
>  t/t1350-config-hooks-directory.sh | 35 +++++++++++++++++++++++++++++=
++++++
>  7 files changed, 58 insertions(+), 2 deletions(-)
>  create mode 100755 t/t1350-config-hooks-directory.sh
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 42d2b50..2faf3c0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -618,6 +618,16 @@ core.attributesFile::
>  	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
>  	set or empty, $HOME/.config/git/attributes is used instead.
> =20
> +core.hooksDirectory::
> +	By default Git will look for your hooks in the '$GIT_DIR/hooks'
> +	directory. Set this to different absolute directory name,

Mental note: here you say that it should be an absolute directory.

> +	e.g. '/etc/git/hooks', and Git will try to find your hooks that

s/hooks that/hooks in that/

> +	directory, e.g. '/etc/git/hooks/pre-receive' instead of in
> +	'$GIT_DIR/hooks'.
> ++
> +This is useful in cases where you'd like to centrally configure your
> +Git hooks instead of configuring them on a per-repository basis.
> +
>  core.editor::
>  	Commands such as `commit` and `tag` that lets you edit
>  	messages by launching an editor uses the value of this


> diff --git a/t/t1350-config-hooks-directory.sh b/t/t1350-config-hooks=
-directory.sh
> new file mode 100755
> index 0000000..556c1d3
> --- /dev/null
> +++ b/t/t1350-config-hooks-directory.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +
> +test_description=3D'Test the core.hooksDirectory configuration varia=
ble'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'set up a pre-commit hook in core.hooksDirectory=
' '
> +	mkdir -p .git/custom-hooks .git/hooks &&
> +	cat >.git/custom-hooks/pre-commit <<EOF &&
> +#!$SHELL_PATH
> +printf "%s" "." >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +EOF
> +	cat >.git/hooks/pre-commit <<EOF &&
> +	chmod +x .git/hooks/pre-commit
> +#!$SHELL_PATH
> +printf "%s" "SHOULD NOT BE CALLED" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
> +EOF
> +	chmod +x .git/custom-hooks/pre-commit
> +'

Please use the 'write_script' helper for, well, writing scripts.

> +
> +test_expect_success 'Check that various forms of specifying core.hoo=
ksDirectory work' '
> +	test_commit no_custom_hook &&
> +	git config core.hooksDirectory .git/custom-hooks &&
> +	test_commit have_custom_hook &&
> +	git config core.hooksDirectory .git/custom-hooks/ &&
> +	test_commit have_custom_hook_trailing_slash &&

These two cases ensure that it should work even when the configured
hook directory is given as a relative path, though the docs say it
should be an absolute path.

> +	git config core.hooksDirectory "$PWD/.git/custom-hooks" &&
> +	test_commit have_custom_hook_abs_path &&
> +	git config core.hooksDirectory "$PWD/.git/custom-hooks/" &&
> +	test_commit have_custom_hook_abs_path_trailing_slash &&
> +    printf "%s" "...." >.git/PRE-COMMIT-HOOK-WAS-CALLED.expect &&
> +    test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-=
HOOK-WAS-CALLED

Indentation with spaces.

> +'
> +
> +test_done
> --=20
> 2.1.3
