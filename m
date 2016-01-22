From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/2] submodule: port resolve_relative_url from shell to C
Date: Fri, 22 Jan 2016 15:32:15 -0800
Message-ID: <1453505536-14895-2-git-send-email-sbeller@google.com>
References: <1453505536-14895-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>, j6t@kdbg.org,
	sunshine@sunshineco.com, Jens.Lehmann@web.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 23 00:33:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMlCP-0005AY-28
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 00:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbcAVXct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2016 18:32:49 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33247 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566AbcAVXc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 18:32:27 -0500
Received: by mail-pf0-f178.google.com with SMTP id e65so49709127pfe.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 15:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:in-reply-to:references:content-type
         :content-transfer-encoding;
        bh=lnp7cIy+HlbJe6UTv7tTUOzrxGxJ61RM4a6I5krckEM=;
        b=ldYjQkLWfhPRXG6yXkkgDPnvzHAJnpT2KXtGjse9hpISJ/UkuDgFULNyX8XkllpSCz
         KubV68Sg4vVdVXWMatIzOph9aOgbBojs1NOPYFDootA/Yc8qyTjulmsYmDgK/LflRfID
         jlornU/LTjuWdvXo3J+B5CEnqscgXbqdrmvssJL3f+T5j2n+bqfemJfwLsCwDctR8W2N
         4yT9A5Z4b3pj0RohWtTQRGbz9JUorQWoZ5QPYGY76fiMj8PyYNHvFetFkTZj7h7OLyHP
         A5xY0jZWPMoToOx9q4Jx2oRZRX0ItDGGNWGiVfO5aO8QNgfxesQp1jneoFA/MpKA3uob
         1REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:in-reply-to:references:content-type
         :content-transfer-encoding;
        bh=lnp7cIy+HlbJe6UTv7tTUOzrxGxJ61RM4a6I5krckEM=;
        b=VEof27WeIN7h+wDsUq2x1tn8HA1l2lkucimqjpZYMB7HbRgmbKzD7XTN3G7jgXr2xk
         DeRXLaHxOOZE4cvP421D/utnPM979onZIiLok545W8FunLM67EV6Hiz9Ot6CwYnGd8Sb
         GGbtR09PwZ25bOiB03GLpeE2LTvkvncUE2xbkwRcvfuWMSWQ8IsiqGY9K84m9OojLoaW
         yl1yp8eqOEwPE1cj1DE251CFNf+u9L5096iqrK/0IozB43SAV6b9Q+jh3lr5WPYoR/Dp
         AQ6p1IzbUO81DIbLfUgRHn/SWWNSchYlQl13EV5mMoQbVpCnxNT0du1kL7yAaUX9VKM8
         Xo5w==
X-Gm-Message-State: AG10YOR/dvh27FdnKft0dsTQjIhOmTkmJzugy2TmjU8ZJSL4aRn7FxrbJ+5YhfR6QjQRYCj2
X-Received: by 10.98.14.80 with SMTP id w77mr8330329pfi.152.1453505547007;
        Fri, 22 Jan 2016 15:32:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id m70sm12005938pfi.90.2016.01.22.15.32.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 15:32:26 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.45.g0dba895.dirty
In-Reply-To: <1453505536-14895-1-git-send-email-sbeller@google.com>
In-Reply-To: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
References: <xmqqoacdtfh3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284610>

Later on we want to automatically call `git submodule init` from
other commands, such that the users don't have to initialize the
submodule themselves.  As these other commands are written in C
already, we'd need the init functionality in C, too.  The
`resolve_relative_url` function is a large part of that init
functionality, so start by porting this function to C.

To create the tests in t0060, the function `resolve_relative_url`
was temporarily enhanced to write all inputs and output to disk
when running the test suite. The added tests in this patch are
a small selection thereof.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 206 ++++++++++++++++++++++++++++++++++++=
+++++++-
 git-submodule.sh            |  81 +----------------
 t/t0060-path-utils.sh       |  42 +++++++++
 3 files changed, 251 insertions(+), 78 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8002187..92d7d32 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -9,6 +9,208 @@
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
+	int flag =3D 0;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *refname =3D resolve_ref_unsafe("HEAD", 0, sha1, &flag);
+
+	if (!refname)
+		die("No such ref: HEAD");
+
+	/* detached HEAD */
+	if (!strcmp(refname, "HEAD"))
+		return xstrdup("origin");
+
+	if (!skip_prefix(refname, "refs/heads/", &refname))
+		die(_("Expecting a full ref name, got %s"), refname);
+
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
+/*
+ * Returns 1 if it was the last chop before ':'.
+ */
+static int chop_last_dir(char **remoteurl, int is_relative)
+{
+	char *rfind =3D find_last_dir_sep(*remoteurl);
+	if (rfind) {
+		*rfind =3D '\0';
+		return 0;
+	}
+
+	rfind =3D strrchr(*remoteurl, ':');
+	if (rfind) {
+		*rfind =3D '\0';
+		return 1;
+	}
+
+	if (is_relative || !strcmp(".", *remoteurl))
+		die(_("cannot strip one component off url '%s'"),
+			*remoteurl);
+
+	free(*remoteurl);
+	*remoteurl =3D xstrdup(".");
+	return 0;
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
+ *
+ * NEEDSWORK: This works incorrectly on the domain and protocol part.
+ * remote_url      url              outcome          correct
+ * http://a.com/b  ../c             http://a.com/c   yes
+ * http://a.com/b  ../../c          http://c         no (domain should=
 be kept)
+ * http://a.com/b  ../../../c       http:/c          no
+ * http://a.com/b  ../../../../c    http:c           no
+ * http://a.com/b  ../../../../../c    .:c           no
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
+	size_t len =3D strlen(remoteurl);
+
+	if (is_dir_sep(remoteurl[len]))
+		remoteurl[len] =3D '\0';
+
+	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
+		is_relative =3D 0;
+	else {
+		is_relative =3D 1;
+		/*
+		 * Prepend a './' to ensure all relative
+		 * remoteurls start with './' or '../'
+		 */
+		if (!starts_with_dot_slash(remoteurl) &&
+		    !starts_with_dot_dot_slash(remoteurl)) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "./%s", remoteurl);
+			free(remoteurl);
+			remoteurl =3D strbuf_detach(&sb, NULL);
+		}
+	}
+	/*
+	 * When the url starts with '../', remove that and the
+	 * last directory in remoteurl.
+	 */
+	while (url) {
+		if (starts_with_dot_dot_slash(url)) {
+			url +=3D 3;
+			colonsep |=3D chop_last_dir(&remoteurl, is_relative);
+		} else if (starts_with_dot_slash(url))
+			url +=3D 2;
+		else
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
+		die("resolve-relative-url only accepts one or two arguments");
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
+	puts(res);
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
+		die("resolve-relative-url-test only accepts three arguments: <up_pat=
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
+	puts(res);
+	free(res);
+	return 0;
+}
=20
 struct module_list {
 	const struct cache_entry **entries;
@@ -502,7 +704,9 @@ static struct cmd_struct commands[] =3D {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
-	{"update-clone", update_clone}
+	{"update-clone", update_clone},
+	{"resolve-relative-url", resolve_relative_url},
+	{"resolve-relative-url-test", resolve_relative_url_test},
 };
=20
 int cmd_submodule__helper(int argc, const char **argv, const char *pre=
fix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 10c5af9..615ef9b 100755
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
@@ -1176,9 +1103,9 @@ cmd_sync()
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
2.7.0.rc0.45.g0dba895.dirty
