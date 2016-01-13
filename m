From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv3] submodule: Port resolve_relative_url from shell to C
Date: Wed, 13 Jan 2016 08:42:18 +0100
Message-ID: <5695FFDA.9050409@kdbg.org>
References: <1452641726-25625-1-git-send-email-sbeller@google.com>
 <1452643808-29384-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	jens.lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 08:42:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJG4a-0001kV-3E
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 08:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbcAMHmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2016 02:42:24 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:36758 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbcAMHmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 02:42:23 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pgLMb4tS9z5tlL;
	Wed, 13 Jan 2016 08:42:19 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 23DB551EB;
	Wed, 13 Jan 2016 08:42:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <1452643808-29384-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283895>

Am 13.01.2016 um 01:10 schrieb Stefan Beller:
> Later on we want to deprecate the `git submodule init` command and ma=
ke
> it implicit in other submodule commands. As these other commands are
> written in C already, we'd need the init functionality in C, too.
> The `resolve_relative_url` function is a major part of that init
> functionality, so start by porting this function to C.

Maybe tone down the word "major" to "a large and non-trivial function"?
Otherwise, the lack of proof for the claim is irritating. (As we saw,
the savings with the port to C are not breath-taking. But we have to
start somewhere.)

>=20
> As I was porting the functionality I noticed some odds with the input=
s.
> To fully understand the situation I added some logging to the functio=
n
> temporarily to capture all calls to the function throughout the test
> suite. Duplicates have been removed and all unique testing inputs hav=
e
> been recorded into t0060.
>=20
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
=2E..
> +/*
> + * The `url` argument is the URL that navigates to the submodule ori=
gin
> + * repo. When relative, this URL is relative to the superproject ori=
gin
> + * URL repo. The `up_path` argument, if specified, is the relative
> + * path that navigates from the submodule working tree to the superp=
roject
> + * working tree. Returns the origin URL of the submodule.
> + *
> + * Return either an absolute URL or filesystem path (if the superpro=
ject
> + * origin URL is an absolute URL or filesystem path, respectively) o=
r a
> + * relative file system path (if the superproject origin URL is a re=
lative
> + * file system path).
> + *
> + * When the output is a relative file system path, the path is eithe=
r
> + * relative to the submodule working tree, if up_path is specified, =
or to
> + * the superproject working tree otherwise.
> + */
> +static char *relative_url(const char *remote_url,
> +				const char *url,
> +				const char *up_path)
> +{
> +	int is_relative =3D 0;
> +	int colonsep =3D 0;
> +	char *out;
> +	char *remoteurl =3D xstrdup(remote_url);
> +	struct strbuf sb =3D STRBUF_INIT;
> +	size_t len;
> +
> +	len =3D strlen(remoteurl);
> +	if (is_dir_sep(remoteurl[len]))
> +		remoteurl[len] =3D '\0';
> +
> +	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl)=
)
> +		is_relative =3D 0;
> +	else {
> +		is_relative =3D 1;
> +
> +		/* Prepend a './' to ensure all relative remoteurls start
> +		 * with './' or '../'. */
> +		if (!starts_with_dot_slash(remoteurl) &&
> +		    !starts_with_dot_dot_slash(remoteurl)) {
> +			strbuf_reset(&sb);
> +			strbuf_addf(&sb, "./%s", remoteurl);
> +			free(remoteurl);
> +			remoteurl =3D strbuf_detach(&sb, NULL);
> +		}
> +	}
> +	/* When the url starts with '../', remove that and the
> +	 * last directory in remoteurl. */
> +	while (url) {
> +		if (starts_with_dot_dot_slash(url)) {
> +			char *rfind;
> +			url +=3D 3;
> +
> +			rfind =3D last_dir_separator(remoteurl);
> +			if (rfind)
> +				*rfind =3D '\0';
> +			else {
> +				rfind =3D strrchr(remoteurl, ':');
> +				if (rfind) {
> +					*rfind =3D '\0';
> +					colonsep =3D 1;
> +				} else {
> +					if (is_relative || !strcmp(".", remoteurl))
> +						die(N_("cannot strip one component off url '%s'"), remoteurl);

This must be _("..."), not N_("..."), otherwise no translation
happens at run-time.

> +					else
> +						remoteurl =3D ".";

This must be xstrdup(".") because remoteurl is free()d below.

> +				}
> +			}
> +		} else if (starts_with_dot_slash(url)) {
> +			url +=3D 2;
> +		} else
> +			break;
> +	}
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
> +
> +	if (starts_with_dot_slash(sb.buf))
> +		out =3D xstrdup(sb.buf + 2);
> +	else
> +		out =3D xstrdup(sb.buf);
> +	strbuf_reset(&sb);
> +
> +	free(remoteurl);
> +	if (!up_path || !is_relative)
> +		return out;

Nit: This conditional clearly feels like (and is) an early function
exit...

> +	else {
> +		strbuf_addf(&sb, "%s%s", up_path, out);
> +
> +		free(out);
> +		return strbuf_detach(&sb, NULL);
> +	}

=2E.. hence, you don't need to place the rest of the function into the
else branch.

> +}

up_path seems to be ignored when remoteurl is absolute. Is that
combination an invalid use case?

I think that you strike a good balance between a direct rewrite
of the shell function and possible optimizations. Therefore,
further improvements should go into separate patches.

> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 627ef85..2ae1bbd 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -19,6 +19,12 @@ relative_path() {
>   	"test \"\$(test-path-utils relative_path '$1' '$2')\" =3D '$expect=
ed'"
>   }
>  =20
> +test_submodule_relative_url() {
> +	expected=3D"$4"
> +	test_expect_success "test_submodule_relative_url: $1 $2 $3 =3D> $4"=
 \
> +	"test \"\$(git submodule--helper resolve-relative-url-test '$1' '$2=
' '$3')\" =3D '$expected'"
> +}

relative_url() has an error exit mode that is not unlikely to trigger,
but the way this test is written such a failure would be detected
only indirectly as a mismatch between actual and expected result. The
reason is that a failed command substitution does not cause the
surrounding command to fail unless it is in the last variable
assignment. Therefore, I suggest to write the helper function like this=
:

test_submodule_relative_url() {
	test_expect_success "test_submodule_relative_url: $1 $2 $3 =3D> $4" "
		actual=3D\$(git submodule--helper resolve-relative-url-test '$1' '$2'=
 '$3') &&
		"test \"\$actual\" =3D '$4'
	"
}

> +
>   test_git_path() {
>   	test_expect_success "git-path $1 $2 =3D> $3" "
>   		$1 git rev-parse --git-path $2 >actual &&
> @@ -286,4 +292,39 @@ test_git_path GIT_COMMON_DIR=3Dbar config       =
            bar/config
>   test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/pac=
ked-refs
>   test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/sha=
llow
>  =20
> +test_submodule_relative_url "(null)" "../foo/bar" "../bar/a/b/c" "..=
/foo/bar/a/b/c"
> +test_submodule_relative_url "../../../" "../foo/bar" "../bar/a/b/c" =
"../../../../foo/bar/a/b/c"

In these two cases, it is unclear whether the "bar" in the 4th
argument is copied from the 2nd or the 3rd argument. I suggest to
use a different token:

test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../fo=
o/sub/a/b/c"
test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" "..=
/../../../foo/sub/a/b/c"

> +test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "..=
/foo/submodule"
> +test_submodule_relative_url "../" "../foo/bar" "../submodule" "../..=
/foo/submodule"
> +test_submodule_relative_url "(null)" "../foo/submodule" "../submodul=
e" "../foo/submodule"
> +test_submodule_relative_url "../" "../foo/submodule" "../submodule" =
"../../foo/submodule"
> +test_submodule_relative_url "(null)" "../foo" "../submodule" "../sub=
module"
> +test_submodule_relative_url "../" "../foo" "../submodule" "../../sub=
module"
> +test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo=
/submodule"
> +test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo=
/submodule"
> +test_submodule_relative_url "(null)" "./foo" "../submodule" "submodu=
le"
> +test_submodule_relative_url "../" "./foo" "../submodule" "../submodu=
le"
> +test_submodule_relative_url "(null)" "//somewhere else/repo" "../sub=
repo" "//somewhere else/subrepo"
> +test_submodule_relative_url "(null)" "/u//trash directory.t7406-subm=
odule-update/subsuper_update_r" "../subsubsuper_update_r" "/u//trash di=
rectory.t7406-submodule-update/subsubsuper_update_r"
> +test_submodule_relative_url "(null)" "/u//trash directory.t7406-subm=
odule-update/super_update_r2" "../subsuper_update_r" "/u//trash directo=
ry.t7406-submodule-update/subsuper_update_r"
> +test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm/."=
 "../." "/u/trash directory.t3600-rm/."
> +test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm" "=
=2E/." "/u/trash directory.t3600-rm/."
> +test_submodule_relative_url "(null)" "/u/trash directory.t7400-submo=
dule-basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic=
/repo"
> +test_submodule_relative_url "../" "/u/trash directory.t7400-submodul=
e-basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic/re=
po"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7400-submo=
dule-basic" "./=C3=A5 =C3=A4=C3=B6" "/u/trash directory.t7400-submodule=
-basic/=C3=A5 =C3=A4=C3=B6"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7403-submo=
dule-sync/." "../submodule" "/u/trash directory.t7403-submodule-sync/su=
bmodule"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7407-submo=
dule-foreach/submodule" "../submodule" "/u/trash directory.t7407-submod=
ule-foreach/submodule"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7409-submo=
dule-detached-worktree/home2/../remote" "../bundle1" "/u/trash director=
y.t7409-submodule-detached-worktree/home2/../bundle1"
> +test_submodule_relative_url "(null)" "/u/trash directory.t7613-merge=
-submodule/submodule_update_repo" "./." "/u/trash directory.t7613-merge=
-submodule/submodule_update_repo/."
> +test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo"=
 "file:///tmp/subrepo"
> +test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/s=
ubmodule"
> +test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/s=
ubmodule"
> +test_submodule_relative_url "(null)" "foo" "../submodule" "submodule=
"
> +test_submodule_relative_url "../" "foo" "../submodule" "../submodule=
"
> +test_submodule_relative_url "(null)" "helper:://hostname/repo" "../s=
ubrepo" "helper:://hostname/subrepo"
> +test_submodule_relative_url "(null)" "ssh://hostname/repo" "../subre=
po" "ssh://hostname/subrepo"
> +test_submodule_relative_url "(null)" "ssh://hostname:22/repo" "../su=
brepo" "ssh://hostname:22/subrepo"
> +test_submodule_relative_url "(null)" "user@host:path/to/repo" "../su=
brepo" "user@host:path/to/subrepo"
> +test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" "=
user@host:subrepo"
> +
>   test_done
>=20
