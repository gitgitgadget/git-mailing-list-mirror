From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V2] git clone: is an URL local or ssh
Date: Mon, 28 Oct 2013 21:16:19 +0100
Message-ID: <201310282116.21551.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, peff@peff.net, pclouds@gmail.com
To: git@vger.kernel.org, tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Oct 28 21:16:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VatEr-0007pw-My
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 21:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab3J1UQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Oct 2013 16:16:33 -0400
Received: from mout.web.de ([212.227.15.4]:63465 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755775Ab3J1UQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Oct 2013 16:16:32 -0400
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MDPEX-1VTWRn0BTB-00Gp86 for <git@vger.kernel.org>; Mon,
 28 Oct 2013 21:16:30 +0100
X-Provags-ID: V03:K0:v4VfdwnGArIHG4blyAdgqBU9V6vypF/BqojP6iLLUxqwzr4Gcow
 dKGO7Mmy7tJ2EtxRxOFAum9Zf+jH7Dp5OsOObzUwu85nyx0hAUQf4N2fMCbVYAKmgIuDPfA
 c6IwHcwWxRBBqqHoRhScXBHpMYCGw6a/YaQnpMdVfqtHLDzNMXYMxA0q5hTd9hkQFLKlSyp
 x9IC3BGCccWdwzUD9iGzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236856>

Commit 8d3d28f5 added test cases for URLs which should be ssh.

Add more tests testing all the combinations:
 -IPv4 or IPv6
 -path starting with "/" or with "/~"
 -with and without the ssh:// scheme

Add tests for ssh:// with port number.

When a git repository "foo:bar" exist, git clone will call
absolute_path() and git_connect() will be called with
something like "/home/user/projects/foo:bar"

Tighten the test and use "foo:bar" instead of "./foo:bar",
refactor clear_ssh() and expect_ssh() into test_clone_url().

"git clone foo/bar:baz" should not be ssh:
  Make the rule
  "if there is a slash before the first colon, it is not ssh"
  more strict by using the same is_local() in both connect.c
  and transport.c. Add a test case.

Bug fixes for corner cases:
- Handle clone of [::1]:/~repo correctly (2e7766655):
  Git should call "ssh ::1 ~repo", not ssh ::1 /~repo
  This was caused by looking at (host !=3D url), which never
  worked for host names with literal IPv6 adresses, embedded by []
  Support for the [] URLs was introduced in 356bece0a.

- Do not tamper local URLs starting with '[' which have a ']'

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
(This does apply on pu, not on master.
 I'm almost sure there are more corner cases, but the
 most important things should be covered)
 Changes since V1: Comments from Eric Sunshine (thanks)
 connect.c        | 47 +++++++++++++++++----------
 connect.h        |  1 +
 t/t5601-clone.sh | 98 ++++++++++++++++++++++++++++++++++++++++++++----=
--------
 transport.c      |  8 -----
 4 files changed, 108 insertions(+), 46 deletions(-)

diff --git a/connect.c b/connect.c
index 06e88b0..d61adc9 100644
--- a/connect.c
+++ b/connect.c
@@ -231,6 +231,7 @@ int server_supports(const char *feature)
 }
=20
 enum protocol {
+	PROTO_LOCAL_OR_SSH =3D 0,
 	PROTO_LOCAL =3D 1,
 	PROTO_SSH,
 	PROTO_GIT
@@ -547,6 +548,15 @@ static char *get_port(char *host)
=20
 static struct child_process no_fork;
=20
+int is_local(const char *url)
+{
+	const char *colon =3D strchr(url, ':');
+	const char *slash =3D strchr(url, '/');
+	return !colon || (slash && slash < colon) ||
+		has_dos_drive_prefix(url);
+}
+
+
 /*
  * This returns a dummy child_process if the transport protocol does n=
ot
  * need fork(2), or a struct child_process object if it does.  Once do=
ne,
@@ -564,9 +574,9 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	char *url;
 	char *host, *path;
 	char *end;
-	int c;
+	int separator;
 	struct child_process *conn =3D &no_fork;
-	enum protocol protocol =3D PROTO_LOCAL;
+	enum protocol protocol =3D PROTO_LOCAL_OR_SSH;
 	int free_path =3D 0;
 	char *port =3D NULL;
 	const char **arg;
@@ -587,20 +597,23 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
 		*host =3D '\0';
 		protocol =3D get_protocol(url);
 		host +=3D 3;
-		c =3D '/';
+		separator =3D '/';
 	} else {
 		host =3D url;
-		c =3D ':';
+		separator =3D ':';
+		if (is_local(url))
+			protocol =3D PROTO_LOCAL;
 	}
=20
 	/*
 	 * Don't do destructive transforms with git:// as that
 	 * protocol code does '[]' unwrapping of its own.
+	 * Don't change local URLs
 	 */
 	if (host[0] =3D=3D '[') {
 		end =3D strchr(host + 1, ']');
 		if (end) {
-			if (protocol !=3D PROTO_GIT) {
+			if (protocol !=3D PROTO_GIT && protocol !=3D PROTO_LOCAL) {
 				*end =3D 0;
 				host++;
 			}
@@ -610,17 +623,17 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
 	} else
 		end =3D host;
=20
-	path =3D strchr(end, c);
-	if (path && !has_dos_drive_prefix(end)) {
-		if (c =3D=3D ':') {
-			if (host !=3D url || path < strchrnul(host, '/')) {
-				protocol =3D PROTO_SSH;
-				*path++ =3D '\0';
-			} else /* '/' in the host part, assume local path */
-				path =3D end;
+	path =3D strchr(end, separator);
+	if (separator =3D=3D ':') {
+		if (path && protocol =3D=3D PROTO_LOCAL_OR_SSH) {
+			/* We have a ':' */
+			protocol =3D PROTO_SSH;
+			*path++ =3D '\0';
+		} else {/* assume local path */
+			protocol =3D PROTO_LOCAL;
+			path =3D end;
 		}
-	} else
-		path =3D end;
+	}
=20
 	if (!path || !*path)
 		die("No path specified. See 'man git-pull' for valid url syntax");
@@ -629,7 +642,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	 * null-terminate hostname and point path to ~ for URL's like this:
 	 *    ssh://host.xz/~user/repo
 	 */
-	if (protocol !=3D PROTO_LOCAL && host !=3D url) {
+	if (protocol !=3D PROTO_LOCAL && separator =3D=3D '/') {
 		char *ptr =3D path;
 		if (path[1] =3D=3D '~')
 			path++;
@@ -644,7 +657,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	/*
 	 * Add support for ssh port: ssh://host.xy:<port>/...
 	 */
-	if (protocol =3D=3D PROTO_SSH && host !=3D url)
+	if (protocol =3D=3D PROTO_SSH && separator =3D=3D '/')
 		port =3D get_port(end);
=20
 	if (protocol =3D=3D PROTO_GIT) {
diff --git a/connect.h b/connect.h
index 64fb7db..fb2de9b 100644
--- a/connect.h
+++ b/connect.h
@@ -5,6 +5,7 @@
 extern struct child_process *git_connect(int fd[2], const char *url, c=
onst char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
+extern int is_local(const char *url);
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *fea=
ture);
 extern const char *server_feature_value(const char *feature, int *len_=
ret);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 1d1c875..a126f08 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -294,39 +294,95 @@ test_expect_success 'setup ssh wrapper' '
 	export TRASH_DIRECTORY
 '
=20
-clear_ssh () {
-	>"$TRASH_DIRECTORY/ssh-output"
-}
-
-expect_ssh () {
+i5601=3D0
+# $1 url
+# $2 none|host
+# $3 path
+test_clone_url () {
+	i5601=3D$(($i5601 + 1))
+	>"$TRASH_DIRECTORY/ssh-output" &&
+	test_might_fail git clone "$1" tmp$i5601 &&
 	{
-		case "$1" in
+		case "$2" in
 		none)
 			;;
 		*)
-			echo "ssh: $1 git-upload-pack '$2'"
+			echo "ssh: $2 git-upload-pack '$3'"
 		esac
 	} >"$TRASH_DIRECTORY/ssh-expect" &&
-	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
+	(
+		cd "$TRASH_DIRECTORY" &&
+		test_cmp ssh-expect ssh-output &&
+		rm -rf ssh-expect ssh-output
+	)
 }
=20
-test_expect_success 'cloning myhost:src uses ssh' '
-	clear_ssh &&
-	git clone myhost:src ssh-clone &&
-	expect_ssh myhost src
-'
-
+# url looks ssh like, and is on disc: should be local
 test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
-	clear_ssh &&
 	cp -R src "foo:bar" &&
-	git clone "./foo:bar" foobar &&
-	expect_ssh none
+	test_clone_url "foo:bar" none &&
+	( cd tmp$i5601 && git log)
+'
+#ip v4
+for repo in rep rep/home/project /~proj 123
+do
+	test_expect_success "cloning host:$repo" '
+		test_clone_url host:$repo host $repo
+	'
+done
+
+#ipv6
+for repo in rep rep/home/project /~proj 123
+do
+	test_expect_success "cloning [::1]:$repo" '
+		test_clone_url [::1]:$repo ::1 $repo
+	'
+done
+
+# Corner cases
+for url in [foo]bar/baz:qux [foo/bar]:baz foo/bar:baz
+do
+	test_expect_success "cloning $url is not ssh" '
+			test_clone_url $url none
+	'
+done
+
+#with ssh:// scheme
+test_expect_success 'ssh://host.xz/home/user/repo' '
+	test_clone_url "ssh://host.xz/home/user/repo" host.xz "/home/user/rep=
o"
 '
=20
-test_expect_success 'bracketed hostnames are still ssh' '
-	clear_ssh &&
-	git clone "[myhost:123]:src" ssh-bracket-clone &&
-	expect_ssh myhost:123 src
+# from home directory
+test_expect_success 'ssh://host.xz/~repo' '
+	test_clone_url "ssh://host.xz/~repo" host.xz "~repo"
+'
+# with port number
+test_expect_success 'ssh://host.xz:22/home/user/repo' '
+	test_clone_url "ssh://host.xz:22/home/user/repo" "-p 22 host.xz" "/ho=
me/user/repo"
+'
+
+# from home directory with port number
+test_expect_success 'ssh://host.xz:22/~repo' '
+	test_clone_url "ssh://host.xz:22/~repo" "-p 22 host.xz" "~repo"
+'
+
+#IPv6
+test_expect_success 'ssh://[::1]/home/user/repo' '
+	test_clone_url "ssh://[::1]/home/user/repo" "::1" "/home/user/repo"
+'
+
+#IPv6 from home directory
+test_expect_success 'ssh://[::1]/~repo' '
+	test_clone_url "ssh://[::1]/~repo" "::1" "~repo"
+'
+
+#IPv6 with port number
+test_expect_success 'ssh://[::1]:22/home/user/repo' '
+	test_clone_url "ssh://[::1]:22/home/user/repo" "-p 22 ::1" "/home/use=
r/repo"
+'
+#IPv6 from home directory with port number
+test_expect_success 'ssh://[::1]:22/~repo' '
+	test_clone_url "ssh://[::1]:22/~repo" "-p 22 ::1" "~repo"
 '
=20
 test_expect_success 'clone from a repository with two identical branch=
es' '
diff --git a/transport.c b/transport.c
index 7202b77..a09ba95 100644
--- a/transport.c
+++ b/transport.c
@@ -885,14 +885,6 @@ void transport_take_over(struct transport *transpo=
rt,
 	transport->cannot_reuse =3D 1;
 }
=20
-static int is_local(const char *url)
-{
-	const char *colon =3D strchr(url, ':');
-	const char *slash =3D strchr(url, '/');
-	return !colon || (slash && slash < colon) ||
-		has_dos_drive_prefix(url);
-}
-
 static int is_file(const char *url)
 {
 	struct stat buf;
--=20
1.8.4.457.g424cb08
