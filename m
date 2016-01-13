From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Wed, 13 Jan 2016 10:15:27 -0800
Message-ID: <1452708927-9401-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j6t@kdbg.org, peff@peff.net, jens.lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 13 19:15:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJPxP-00036z-Aw
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbcAMSPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2016 13:15:39 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35356 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcAMSPh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:15:37 -0500
Received: by mail-pf0-f177.google.com with SMTP id 65so85040202pff.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=lMapeOjbLo4iBiRFMvSkDvNuihZTUj1xDa2DZs4sNxU=;
        b=VFXW3Q/uKlmcw541ZmaqStsmFxaRbInbnZPozzBOFBwhDv6NPpdTnK5NauV09+TyB3
         CBF08Yk6XuOS43F4mxCpBdXbbMR+0gFB65w59GDxBvotQwG2AY7bFUqzj0axL5eJFNyV
         styTprhbEqOSZrXeEKer/Y8kKNH2gGpYlEdXxdSGlxxqZVDX3OYlH2abo9AOL3sGRa2o
         qh5+9Q1SUeJ/spiP6yalg0GhSCIZJKVe3E3MPua+LdR1+O88HBf5rh2ufOfYOjWzP7VH
         IYNAEQn0/hFIF5F+8WkjsAnhuy8AkXXQqfouW7ZkFrj0+dJwJMqF2sNRcVu7dDzDNgOK
         i8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=lMapeOjbLo4iBiRFMvSkDvNuihZTUj1xDa2DZs4sNxU=;
        b=NOod2KVgzneZgqTAGo8AKSSsd6ba2BUbsdGfOqwQUJBW3FdsdlmkELPpU4P+OB7/oM
         hgEMYK08l27d4Lplx/YKEOq6dxtjCpn1FhPQ0ajc+gFUk8xPqr/v28cn2CL6nF9w8jy6
         jBQ4Pz3pT32lWX6HmNd9ny2JcTTTapNszZoysXlGpGXpVTj0iFQq7JHXCAU4EpJkt1IA
         2xla5YnLTi9iZ/jj0SMgFxxW8xUfO6KwQhnfjg5YL4b7fUNBsCSb/URU499/Pm/nDysU
         dyJo65HxcfTx5y8YE9mQOAnM4pWtBzmF6RYu8QIbmrbhePFGvusjDhuOnJnf6ZieqDTg
         7tjQ==
X-Gm-Message-State: ALoCoQnpcggrkDSc1C+qJ+hAvCESZ/XZsYimKxkc2uP5I/4OdEaZEeCJNtXmiXzwniRd6OF2HsvJxpjvNdU2ykZeSaLJ/bQBtQ==
X-Received: by 10.98.86.214 with SMTP id h83mr44147510pfj.112.1452708937358;
        Wed, 13 Jan 2016 10:15:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:98f:a29f:abf0:a73f])
        by smtp.gmail.com with ESMTPSA id c86sm4082699pfd.75.2016.01.13.10.15.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 10:15:36 -0800 (PST)
X-Mailer: git-send-email 2.7.0.1.g33e69b5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283958>

Later on we want to deprecate the `git submodule init` command and make
it implicit in other submodule commands. As these other commands are
written in C already, we'd need the init functionality in C, too.
The `resolve_relative_url` function is a rather large part of that init
functionality, so start by porting this function to C.

As I was porting the functionality I noticed some odds with the inputs.
To fully understand the situation I added some logging to the function
temporarily to capture all calls to the function throughout the test
suite. Duplicates have been removed and all unique testing inputs have
been recorded into t0060.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
> up_path seems to be ignored when remoteurl is absolute. Is that
> combination an invalid use case?

Yes, that is invalid. See the original:
=20
    echo "${is_relative:+${up_path}}${remoteurl#./}"

This also only adds up_path in case of is_relative being true.
Did you mean to say that fact should be documented?

> I think that you strike a good balance between a direct rewrite
> of the shell function and possible optimizations. Therefore,
> further improvements should go into separate patches.

ok.

> In these two cases, it is unclear whether the "bar" in the 4th
> argument is copied from the 2nd or the 3rd argument. I suggest to
> use a different token:
> ...

I just produced all possible test cases I could find in the test suite,
which looked like they are a good fit. (I did some deduplication there =
already,
the test suite produced over 100 different mostly subtly reworded test =
cases)

I wonder if I should slim down this more as the test suite already take=
s very long
to run. However these tests don't take very long on their own.

Thanks for the review,
Stefan

interdiff to v2:
	diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
	index 3dd8008..3e58b5d 100644
	--- a/builtin/submodule--helper.c
	+++ b/builtin/submodule--helper.c
	@@ -117,9 +117,9 @@ static char *relative_url(const char *remote_url,
						colonsep =3D 1;
					} else {
						if (is_relative || !strcmp(".", remoteurl))
	-						die(N_("cannot strip one component off url '%s'"), remoteurl);
	+						die(_("cannot strip one component off url '%s'"), remoteurl);
						else
	-						remoteurl =3D ".";
	+						remoteurl =3D xstrdup(".");
					}
				}
			} else if (starts_with_dot_slash(url)) {
	@@ -139,12 +139,10 @@ static char *relative_url(const char *remote_url=
,
		free(remoteurl);
		if (!up_path || !is_relative)
			return out;
	-	else {
	-		strbuf_addf(&sb, "%s%s", up_path, out);
	=20
	-		free(out);
	-		return strbuf_detach(&sb, NULL);
	-	}
	+	strbuf_addf(&sb, "%s%s", up_path, out);
	+	free(out);
	+	return strbuf_detach(&sb, NULL);
	 }
	=20
	 static int resolve_relative_url(int argc, const char **argv, const ch=
ar *prefix)
	diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
	index 2ae1bbd..8a1579c 100755
	--- a/t/t0060-path-utils.sh
	+++ b/t/t0060-path-utils.sh
	@@ -20,9 +20,10 @@ relative_path() {
	 }
	=20
	 test_submodule_relative_url() {
	-	expected=3D"$4"
	-	test_expect_success "test_submodule_relative_url: $1 $2 $3 =3D> $4" =
\
	-	"test \"\$(git submodule--helper resolve-relative-url-test '$1' '$2'=
 '$3')\" =3D '$expected'"
	+	test_expect_success "test_submodule_relative_url: $1 $2 $3 =3D> $4" =
"
	+		actual=3D\$(git submodule--helper resolve-relative-url-test '$1' '$=
2' '$3') &&
	+		test \"\$actual\" =3D '$4'
	+	"
	 }
	=20
	 test_git_path() {
	@@ -292,8 +293,8 @@ test_git_path GIT_COMMON_DIR=3Dbar config         =
          bar/config
	 test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/packe=
d-refs
	 test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shall=
ow
	=20
	-test_submodule_relative_url "(null)" "../foo/bar" "../bar/a/b/c" "../=
foo/bar/a/b/c"
	-test_submodule_relative_url "../../../" "../foo/bar" "../bar/a/b/c" "=
=2E./../../../foo/bar/a/b/c"
	+test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../=
foo/sub/a/b/c"
	+test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" "=
=2E./../../../foo/sub/a/b/c"
	 test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "../=
foo/submodule"
	 test_submodule_relative_url "../" "../foo/bar" "../submodule" "../../=
foo/submodule"
	 test_submodule_relative_url "(null)" "../foo/submodule" "../submodule=
" "../foo/submodule"

I tried considering an alternative implementation for `relative_url`,
which is not a direct translation of the shell code. There are some
advanced path/url functions, such as `normalize_path_copy`, however
using that function is not straightforward as it seems. The idea would
have been to use that on a concatenation of remoteurl and url, however
there are cases like ("foo/." "../.") to result in "foo/.", so we reall=
y
need to count the slashes ourselves.

---
 builtin/submodule--helper.c | 189 ++++++++++++++++++++++++++++++++++++=
++++++++
 git-submodule.sh            |  81 +------------------
 t/t0060-path-utils.sh       |  42 ++++++++++
 3 files changed, 235 insertions(+), 77 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..3e58b5d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -9,6 +9,193 @@
 #include "submodule-config.h"
 #include "string-list.h"
 #include "run-command.h"
+#include "remote.h"
+#include "refs.h"
+#include "connect.h"
+
+static char *get_default_remote(void)
+{
+	char *dest =3D NULL, *ret;
+	unsigned char sha1[20];
+	int flag;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *refname =3D resolve_ref_unsafe("HEAD", 0, sha1, &flag);
+
+	if (!refname)
+		die("No such ref: HEAD");
+
+	refname =3D shorten_unambiguous_ref(refname, 0);
+	strbuf_addf(&sb, "branch.%s.remote", refname);
+	if (git_config_get_string(sb.buf, &dest))
+		ret =3D xstrdup("origin");
+	else
+		ret =3D xstrdup(dest);
+
+	strbuf_release(&sb);
+	return ret;
+}
+
+static int starts_with_dot_slash(const char *str)
+{
+	return str[0] =3D=3D '.' && is_dir_sep(str[1]);
+}
+
+static int starts_with_dot_dot_slash(const char *str)
+{
+	return str[0] =3D=3D '.' && str[1] =3D=3D '.' && is_dir_sep(str[2]);
+}
+
+static char *last_dir_separator(char *str)
+{
+	char* p =3D str + strlen(str);
+	while (p-- !=3D str)
+		if (is_dir_sep(*p))
+			return p;
+	return NULL;
+}
+
+/*
+ * The `url` argument is the URL that navigates to the submodule origi=
n
+ * repo. When relative, this URL is relative to the superproject origi=
n
+ * URL repo. The `up_path` argument, if specified, is the relative
+ * path that navigates from the submodule working tree to the superpro=
ject
+ * working tree. Returns the origin URL of the submodule.
+ *
+ * Return either an absolute URL or filesystem path (if the superproje=
ct
+ * origin URL is an absolute URL or filesystem path, respectively) or =
a
+ * relative file system path (if the superproject origin URL is a rela=
tive
+ * file system path).
+ *
+ * When the output is a relative file system path, the path is either
+ * relative to the submodule working tree, if up_path is specified, or=
 to
+ * the superproject working tree otherwise.
+ */
+static char *relative_url(const char *remote_url,
+				const char *url,
+				const char *up_path)
+{
+	int is_relative =3D 0;
+	int colonsep =3D 0;
+	char *out;
+	char *remoteurl =3D xstrdup(remote_url);
+	struct strbuf sb =3D STRBUF_INIT;
+	size_t len;
+
+	len =3D strlen(remoteurl);
+	if (is_dir_sep(remoteurl[len]))
+		remoteurl[len] =3D '\0';
+
+	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
+		is_relative =3D 0;
+	else {
+		is_relative =3D 1;
+
+		/* Prepend a './' to ensure all relative remoteurls start
+		 * with './' or '../'. */
+		if (!starts_with_dot_slash(remoteurl) &&
+		    !starts_with_dot_dot_slash(remoteurl)) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "./%s", remoteurl);
+			free(remoteurl);
+			remoteurl =3D strbuf_detach(&sb, NULL);
+		}
+	}
+	/* When the url starts with '../', remove that and the
+	 * last directory in remoteurl. */
+	while (url) {
+		if (starts_with_dot_dot_slash(url)) {
+			char *rfind;
+			url +=3D 3;
+
+			rfind =3D last_dir_separator(remoteurl);
+			if (rfind)
+				*rfind =3D '\0';
+			else {
+				rfind =3D strrchr(remoteurl, ':');
+				if (rfind) {
+					*rfind =3D '\0';
+					colonsep =3D 1;
+				} else {
+					if (is_relative || !strcmp(".", remoteurl))
+						die(_("cannot strip one component off url '%s'"), remoteurl);
+					else
+						remoteurl =3D xstrdup(".");
+				}
+			}
+		} else if (starts_with_dot_slash(url)) {
+			url +=3D 2;
+		} else
+			break;
+	}
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
+
+	if (starts_with_dot_slash(sb.buf))
+		out =3D xstrdup(sb.buf + 2);
+	else
+		out =3D xstrdup(sb.buf);
+	strbuf_reset(&sb);
+
+	free(remoteurl);
+	if (!up_path || !is_relative)
+		return out;
+
+	strbuf_addf(&sb, "%s%s", up_path, out);
+	free(out);
+	return strbuf_detach(&sb, NULL);
+}
+
+static int resolve_relative_url(int argc, const char **argv, const cha=
r *prefix)
+{
+	char *remoteurl =3D NULL;
+	char *remote =3D get_default_remote();
+	const char *up_path =3D NULL;
+	char *res;
+	const char *url;
+	struct strbuf sb =3D STRBUF_INIT;
+
+	if (argc !=3D 2 && argc !=3D 3)
+		die("BUG: resolve_relative_url only accepts one or two arguments");
+
+	url =3D argv[1];
+	strbuf_addf(&sb, "remote.%s.url", remote);
+	free(remote);
+
+	if (git_config_get_string(sb.buf, &remoteurl))
+		/* the repository is its own authoritative upstream */
+		remoteurl =3D xgetcwd();
+
+	if (argc =3D=3D 3)
+		up_path =3D argv[2];
+
+	res =3D relative_url(remoteurl, url, up_path);
+	printf("%s\n", res);
+
+	free(res);
+	return 0;
+}
+
+static int resolve_relative_url_test(int argc, const char **argv, cons=
t char *prefix)
+{
+	char *remoteurl, *res;
+	const char *up_path, *url;
+
+	if (argc !=3D 4)
+		die("BUG: resolve_relative_url only accepts three arguments: <up_pat=
h> <remoteurl> <url>");
+
+	up_path =3D argv[1];
+	remoteurl =3D xstrdup(argv[2]);
+	url =3D argv[3];
+
+	if (!strcmp(up_path, "(null)"))
+		up_path =3D NULL;
+
+	res =3D relative_url(remoteurl, url, up_path);
+	printf("%s\n", res);
+
+	free(res);
+	return 0;
+}
=20
 struct module_list {
 	const struct cache_entry **entries;
@@ -264,6 +451,8 @@ static struct cmd_struct commands[] =3D {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"resolve-relative-url", resolve_relative_url},
+	{"resolve-relative-url-test", resolve_relative_url_test},
 };
=20
 int cmd_submodule__helper(int argc, const char **argv, const char *pre=
fix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..3e409af 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -46,79 +46,6 @@ prefix=3D
 custom_name=3D
 depth=3D
=20
-# The function takes at most 2 arguments. The first argument is the
-# URL that navigates to the submodule origin repo. When relative, this=
 URL
-# is relative to the superproject origin URL repo. The second up_path
-# argument, if specified, is the relative path that navigates
-# from the submodule working tree to the superproject working tree.
-#
-# The output of the function is the origin URL of the submodule.
-#
-# The output will either be an absolute URL or filesystem path (if the
-# superproject origin URL is an absolute URL or filesystem path,
-# respectively) or a relative file system path (if the superproject
-# origin URL is a relative file system path).
-#
-# When the output is a relative file system path, the path is either
-# relative to the submodule working tree, if up_path is specified, or =
to
-# the superproject working tree otherwise.
-resolve_relative_url ()
-{
-	remote=3D$(get_default_remote)
-	remoteurl=3D$(git config "remote.$remote.url") ||
-		remoteurl=3D$(pwd) # the repository is its own authoritative upstrea=
m
-	url=3D"$1"
-	remoteurl=3D${remoteurl%/}
-	sep=3D/
-	up_path=3D"$2"
-
-	case "$remoteurl" in
-	*:*|/*)
-		is_relative=3D
-		;;
-	./*|../*)
-		is_relative=3Dt
-		;;
-	*)
-		is_relative=3Dt
-		remoteurl=3D"./$remoteurl"
-		;;
-	esac
-
-	while test -n "$url"
-	do
-		case "$url" in
-		../*)
-			url=3D"${url#../}"
-			case "$remoteurl" in
-			*/*)
-				remoteurl=3D"${remoteurl%/*}"
-				;;
-			*:*)
-				remoteurl=3D"${remoteurl%:*}"
-				sep=3D:
-				;;
-			*)
-				if test -z "$is_relative" || test "." =3D "$remoteurl"
-				then
-					die "$(eval_gettext "cannot strip one component off url '\$remote=
url'")"
-				else
-					remoteurl=3D.
-				fi
-				;;
-			esac
-			;;
-		./*)
-			url=3D"${url#./}"
-			;;
-		*)
-			break;;
-		esac
-	done
-	remoteurl=3D"$remoteurl$sep${url%/}"
-	echo "${is_relative:+${up_path}}${remoteurl#./}"
-}
-
 # Resolve a path to be relative to another path.  This is intended for
 # converting submodule paths when git-submodule is run in a subdirecto=
ry
 # and only handles paths where the directory separator is '/'.
@@ -281,7 +208,7 @@ cmd_add()
 		die "$(gettext "Relative path can only be used from the toplevel of =
the working tree")"
=20
 		# dereference source url relative to parent's url
-		realrepo=3D$(resolve_relative_url "$repo") || exit
+		realrepo=3D$(git submodule--helper resolve-relative-url "$repo") || =
exit
 		;;
 	*:*|/*)
 		# absolute url
@@ -485,7 +412,7 @@ cmd_init()
 			# Possibly a url relative to parent
 			case "$url" in
 			./*|../*)
-				url=3D$(resolve_relative_url "$url") || exit
+				url=3D$(git submodule--helper resolve-relative-url "$url") || exit
 				;;
 			esac
 			git config submodule."$name".url "$url" ||
@@ -1190,9 +1117,9 @@ cmd_sync()
 			# guarantee a trailing /
 			up_path=3D${up_path%/}/ &&
 			# path from submodule work tree to submodule origin repo
-			sub_origin_url=3D$(resolve_relative_url "$url" "$up_path") &&
+			sub_origin_url=3D$(git submodule--helper resolve-relative-url "$url=
" "$up_path") &&
 			# path from superproject work tree to submodule origin repo
-			super_config_url=3D$(resolve_relative_url "$url") || exit
+			super_config_url=3D$(git submodule--helper resolve-relative-url "$u=
rl") || exit
 			;;
 		*)
 			sub_origin_url=3D"$url"
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 627ef85..8a1579c 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -19,6 +19,13 @@ relative_path() {
 	"test \"\$(test-path-utils relative_path '$1' '$2')\" =3D '$expected'=
"
 }
=20
+test_submodule_relative_url() {
+	test_expect_success "test_submodule_relative_url: $1 $2 $3 =3D> $4" "
+		actual=3D\$(git submodule--helper resolve-relative-url-test '$1' '$2=
' '$3') &&
+		test \"\$actual\" =3D '$4'
+	"
+}
+
 test_git_path() {
 	test_expect_success "git-path $1 $2 =3D> $3" "
 		$1 git rev-parse --git-path $2 >actual &&
@@ -286,4 +293,39 @@ test_git_path GIT_COMMON_DIR=3Dbar config         =
          bar/config
 test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/packed=
-refs
 test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shallo=
w
=20
+test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../f=
oo/sub/a/b/c"
+test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c" ".=
=2E/../../../foo/sub/a/b/c"
+test_submodule_relative_url "(null)" "../foo/bar" "../submodule" "../f=
oo/submodule"
+test_submodule_relative_url "../" "../foo/bar" "../submodule" "../../f=
oo/submodule"
+test_submodule_relative_url "(null)" "../foo/submodule" "../submodule"=
 "../foo/submodule"
+test_submodule_relative_url "../" "../foo/submodule" "../submodule" ".=
=2E/../foo/submodule"
+test_submodule_relative_url "(null)" "../foo" "../submodule" "../submo=
dule"
+test_submodule_relative_url "../" "../foo" "../submodule" "../../submo=
dule"
+test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "foo/s=
ubmodule"
+test_submodule_relative_url "../" "./foo/bar" "../submodule" "../foo/s=
ubmodule"
+test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule=
"
+test_submodule_relative_url "../" "./foo" "../submodule" "../submodule=
"
+test_submodule_relative_url "(null)" "//somewhere else/repo" "../subre=
po" "//somewhere else/subrepo"
+test_submodule_relative_url "(null)" "/u//trash directory.t7406-submod=
ule-update/subsuper_update_r" "../subsubsuper_update_r" "/u//trash dire=
ctory.t7406-submodule-update/subsubsuper_update_r"
+test_submodule_relative_url "(null)" "/u//trash directory.t7406-submod=
ule-update/super_update_r2" "../subsuper_update_r" "/u//trash directory=
=2Et7406-submodule-update/subsuper_update_r"
+test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm/." "=
=2E./." "/u/trash directory.t3600-rm/."
+test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm" "./=
=2E" "/u/trash directory.t3600-rm/."
+test_submodule_relative_url "(null)" "/u/trash directory.t7400-submodu=
le-basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic/r=
epo"
+test_submodule_relative_url "../" "/u/trash directory.t7400-submodule-=
basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic/repo=
"
+test_submodule_relative_url "(null)" "/u/trash directory.t7400-submodu=
le-basic" "./=C3=A5 =C3=A4=C3=B6" "/u/trash directory.t7400-submodule-b=
asic/=C3=A5 =C3=A4=C3=B6"
+test_submodule_relative_url "(null)" "/u/trash directory.t7403-submodu=
le-sync/." "../submodule" "/u/trash directory.t7403-submodule-sync/subm=
odule"
+test_submodule_relative_url "(null)" "/u/trash directory.t7407-submodu=
le-foreach/submodule" "../submodule" "/u/trash directory.t7407-submodul=
e-foreach/submodule"
+test_submodule_relative_url "(null)" "/u/trash directory.t7409-submodu=
le-detached-worktree/home2/../remote" "../bundle1" "/u/trash directory.=
t7409-submodule-detached-worktree/home2/../bundle1"
+test_submodule_relative_url "(null)" "/u/trash directory.t7613-merge-s=
ubmodule/submodule_update_repo" "./." "/u/trash directory.t7613-merge-s=
ubmodule/submodule_update_repo/."
+test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "=
file:///tmp/subrepo"
+test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/sub=
module"
+test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/sub=
module"
+test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"
+test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
+test_submodule_relative_url "(null)" "helper:://hostname/repo" "../sub=
repo" "helper:://hostname/subrepo"
+test_submodule_relative_url "(null)" "ssh://hostname/repo" "../subrepo=
" "ssh://hostname/subrepo"
+test_submodule_relative_url "(null)" "ssh://hostname:22/repo" "../subr=
epo" "ssh://hostname:22/subrepo"
+test_submodule_relative_url "(null)" "user@host:path/to/repo" "../subr=
epo" "user@host:path/to/subrepo"
+test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" "us=
er@host:subrepo"
+
 test_done
--=20
2.7.0.1.g33e69b5.dirty
