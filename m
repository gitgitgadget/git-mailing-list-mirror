From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] submodule: Port resolve_relative_url from shell to C
Date: Tue, 12 Jan 2016 15:35:26 -0800
Message-ID: <1452641726-25625-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, j6t@kdbg.org, jens.lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 00:35:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ8TS-0001eN-04
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 00:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbcALXfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2016 18:35:34 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36495 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbcALXfc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 18:35:32 -0500
Received: by mail-pa0-f48.google.com with SMTP id yy13so254747657pab.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 15:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=HpE7zE4k/AWxwI/qWZtX1UUsOd0qSwpcYimNmhVJHVg=;
        b=n+1H0i97tXRZACyo39601z0S2qHcoF5+1ESBitq028cX0H/QuWcZKNYEs417OF2d30
         BCSuy15rgJfHp+XA4HjgySoge/PeE6/PZPOs1l51PUrSUkrmswerLU/exjlqO8pkZ9Js
         wpjS1H8JdBNOAFfgO3qc4d0WsdzQsVLi+/XMV8sPLyDJIhUEKRE4cPpBq1dV/JL7ACPB
         ge+/syEbPN6cXdI+J/4QNunq7JMYc2bzRuu6EM2FjsMq8h3Wvhxinw+XV0iWqg21zo0Q
         uwYFNIR1Xk4I4QV/mkLgrhHvv7w9b5VgS7yX4ZJ2AybX7vCdNG1h+EHVZu+jU5cZmnUk
         KX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=HpE7zE4k/AWxwI/qWZtX1UUsOd0qSwpcYimNmhVJHVg=;
        b=BjNOcnDXWYPH9dLDAADxklKrpZ4qfhDmkmHkWPvzntYyyiEN19gzVp4qCtKyQzC5Oj
         /SMAOHOI96PTwURKv3rmrtGq9RVT0Da/8mXsCzQ2boGgEoyyKcanQDj8mJO03xcfV78E
         S9181i9tXSmB7zpEaKv1qdfLJVA+ndU5OkuEMU0J9AGm6H27blj/X5jCGl54QRcvJ7ZS
         qh1N1xOqEL2gSWfotpXw5XtIR++hziZtbLln7C97qD56R3eJwpwSTv9DAG6Ih07vhJgg
         BD65OL7xPe7zIMLewLRpWFdHjVvkUI4/YjN/smSYfgXTPQ9gB9RCm+Ef7EfPrqDAWuoG
         O0LA==
X-Gm-Message-State: ALoCoQmGjPKqkHsABOahFAhc9cUivsLPUVrAAUOsBiF1RzxANpU6I2AlwXNaqH+G2tHO+jowiAcx7WfoTTVampoIRmgFGcdtrQ==
X-Received: by 10.66.155.8 with SMTP id vs8mr193089049pab.18.1452641731951;
        Tue, 12 Jan 2016 15:35:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:6038:d779:8402:c491])
        by smtp.gmail.com with ESMTPSA id yl1sm195355838pac.35.2016.01.12.15.35.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Jan 2016 15:35:31 -0800 (PST)
X-Mailer: git-send-email 2.7.0.9.g9d9d16f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283852>

Later on we want to deprecate the `git submodule init` command and make
it implicit in other submodule commands. As these other commands are
written in C already, we'd need the init functionality in C, too.
The `resolve_relative_url` function is a major part of that init
functionality, so start by porting this function to C.

As I was porting the functionality I noticed some odds with the inputs.
To fully understand the situation I added some logging to the function
temporarily to capture all calls to the function throughout the test
suite. Duplicates have been removed and all unique testing inputs have
been recorded into t0060.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I tried considering an alternative implementation for `relative_url`,
which is not a direct translation of the shell code. There are some
advanced path/url functions, such as `normalize_path_copy`, however
using that function is not straightforward as it seems. The idea would
have been to use that on a concatenation of remoteurl and url, however
there are cases like ("foo/." "../.") to result in "foo/.", so we reall=
y
need to count the slashes ourselves.

This applies on top of current master (2.7.0).

Thanks,
Stefan

---
 builtin/submodule--helper.c | 191 ++++++++++++++++++++++++++++++++++++=
++++++++
 git-submodule.sh            |  81 +------------------
 t/t0060-path-utils.sh       |  41 ++++++++++
 3 files changed, 236 insertions(+), 77 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..db9d627 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -9,6 +9,195 @@
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
+		/* prepend a './' to ensure all relative remoteurls start with
+		 * './' or '../' */
+		if (!starts_with_dot_slash(remoteurl) &&
+		    !starts_with_dot_dot_slash(remoteurl)) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "./%s", remoteurl);
+			free(remoteurl);
+			remoteurl =3D strbuf_detach(&sb, NULL);
+		}
+	}
+	/* When the url starts with '../', remove that and the last directory
+	 * in remoteurl */
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
+						die(N_("cannot strip one component off url '%s'"), remoteurl);
+					else
+						remoteurl =3D ".";
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
+	else {
+		strbuf_addf(&sb, "%s%s", up_path, out);
+
+		free(out);
+		return strbuf_detach(&sb, NULL);
+	}
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
@@ -264,6 +453,8 @@ static struct cmd_struct commands[] =3D {
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
index 627ef85..2ae1bbd 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -19,6 +19,12 @@ relative_path() {
 	"test \"\$(test-path-utils relative_path '$1' '$2')\" =3D '$expected'=
"
 }
=20
+test_submodule_relative_url() {
+	expected=3D"$4"
+	test_expect_success "test_submodule_relative_url: $1 $2 $3 =3D> $4" \
+	"test \"\$(git submodule--helper resolve-relative-url-test '$1' '$2' =
'$3')\" =3D '$expected'"
+}
+
 test_git_path() {
 	test_expect_success "git-path $1 $2 =3D> $3" "
 		$1 git rev-parse --git-path $2 >actual &&
@@ -286,4 +292,39 @@ test_git_path GIT_COMMON_DIR=3Dbar config         =
          bar/config
 test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/packed=
-refs
 test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shallo=
w
=20
+test_submodule_relative_url "(null)" "../foo/bar" "../bar/a/b/c" "../f=
oo/bar/a/b/c"
+test_submodule_relative_url "../../../" "../foo/bar" "../bar/a/b/c" ".=
=2E/../../../foo/bar/a/b/c"
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
2.7.0.9.g9d9d16f.dirty
