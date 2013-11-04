From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V4] git clone: is an URL local or ssh
Date: Mon, 4 Nov 2013 22:20:49 +0100
Message-ID: <201311042220.50178.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 04 22:21:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdRa4-0002fM-2f
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 22:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab3KDVU7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Nov 2013 16:20:59 -0500
Received: from mout.web.de ([212.227.15.3]:59644 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab3KDVU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Nov 2013 16:20:59 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0Ld2nY-1W40t72bs8-00iFLU for <git@vger.kernel.org>; Mon,
 04 Nov 2013 22:20:57 +0100
X-Provags-ID: V03:K0:ot5y7oqxSvfbn437pNNyJEJOy3Zy68/hoLWXnGX/vnMDa8rtqtz
 LjefafB7atMh/1kFlihW6fo3q94hFIhrvoShmkoIKoxwbVFb1fRf/DGyDt5mpicNHhWaBti
 Z+28JST416Xm0fRsU1Dbh6H4egy31mrBNYlAZxhKWmtBIuhU+QBdDYZNR7A3hPYXhXb3YqC
 TzJZK3cHelFLHjWeCANXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237305>

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

Bug fix for msygit in t5601 : use $PWD insted of $(pwd)

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Changes since V3:
 - Integrated Peffs suggestions in t5601
   (Remove clear_ssh)
 - Decide early if it is ssl or local in connect.c
 - Use "git fetch" instead of "git clone" in t5601:
   clone use absolute_path() (adding a / before :), fetch does not
 - Add a test for dos_drive "C:temp" for msys
 - Make tests work for msys by using $PWD instead of $(pwd) (file://$PW=
D)

 connect.c        |  50 ++++++++++++++++--------
 connect.h        |   1 +
 t/t5601-clone.sh | 117 ++++++++++++++++++++++++++++++++++++++++++++---=
--------
 transport.c      |   8 ----
 4 files changed, 130 insertions(+), 46 deletions(-)

diff --git a/connect.c b/connect.c
index 06e88b0..022d122 100644
--- a/connect.c
+++ b/connect.c
@@ -547,6 +547,25 @@ static char *get_port(char *host)
=20
 static struct child_process no_fork;
=20
+int is_local(const char *url)
+{
+	const char *colon =3D strchr(url, ':');
+	const char *slash =3D strchr(url, '/');
+	if (has_dos_drive_prefix(url))
+		return 1;
+	if (!colon)
+		return 1;
+	if (slash && slash < colon)
+		return 1;
+	if (url[0] =3D=3D '[') {
+		const char *end =3D strchr(url + 1, ']');
+		if (!end)
+			return 1;
+		return is_local(end);
+	}
+	return 0;
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does n=
ot
  * need fork(2), or a struct child_process object if it does.  Once do=
ne,
@@ -564,7 +583,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	char *url;
 	char *host, *path;
 	char *end;
-	int c;
+	int separator;
 	struct child_process *conn =3D &no_fork;
 	enum protocol protocol =3D PROTO_LOCAL;
 	int free_path =3D 0;
@@ -587,17 +606,19 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
 		*host =3D '\0';
 		protocol =3D get_protocol(url);
 		host +=3D 3;
-		c =3D '/';
+		separator =3D '/';
 	} else {
 		host =3D url;
-		c =3D ':';
+		protocol =3D is_local(url) ? PROTO_LOCAL : PROTO_SSH;
+		separator =3D ':';
 	}
=20
 	/*
 	 * Don't do destructive transforms with git:// as that
 	 * protocol code does '[]' unwrapping of its own.
+	 * Don't change local URLs
 	 */
-	if (host[0] =3D=3D '[') {
+	if (protocol !=3D PROTO_LOCAL && host[0] =3D=3D '[') {
 		end =3D strchr(host + 1, ']');
 		if (end) {
 			if (protocol !=3D PROTO_GIT) {
@@ -610,17 +631,14 @@ struct child_process *git_connect(int fd[2], cons=
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
+		if (path && protocol =3D=3D PROTO_SSH) {
+			*path++ =3D '\0';
+		} else {/* assume local path */
+			path =3D end;
 		}
-	} else
-		path =3D end;
+	}
=20
 	if (!path || !*path)
 		die("No path specified. See 'man git-pull' for valid url syntax");
@@ -629,7 +647,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	 * null-terminate hostname and point path to ~ for URL's like this:
 	 *    ssh://host.xz/~user/repo
 	 */
-	if (protocol !=3D PROTO_LOCAL && host !=3D url) {
+	if (protocol !=3D PROTO_LOCAL && separator =3D=3D '/') {
 		char *ptr =3D path;
 		if (path[1] =3D=3D '~')
 			path++;
@@ -644,7 +662,7 @@ struct child_process *git_connect(int fd[2], const =
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
index 1d1c875..5f2b5a0 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -30,20 +30,20 @@ test_expect_success 'clone with excess parameters (=
1)' '
 test_expect_success 'clone with excess parameters (2)' '
=20
 	rm -fr dst &&
-	test_must_fail git clone -n "file://$(pwd)/src" dst junk
+	test_must_fail git clone -n "file://$PWD/src" dst junk
=20
 '
=20
 test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 	rm -fr dst &&
-	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
+	git clone -n "file://$PWD/src" dst >output 2>&1 &&
 	test $(grep Clon output | wc -l) =3D 1
 '
=20
 test_expect_success 'clone does not keep pack' '
=20
 	rm -fr dst &&
-	git clone -n "file://$(pwd)/src" dst &&
+	git clone -n "file://$PWD/src" dst &&
 	! test -f dst/file &&
 	! (echo dst/.git/objects/pack/pack-* | grep "\.keep")
=20
@@ -172,12 +172,12 @@ test_expect_success 'clone a void' '
 	(
 		cd src-0 && git init
 	) &&
-	git clone "file://$(pwd)/src-0" target-6 2>err-6 &&
+	git clone "file://$PWD/src-0" target-6 2>err-6 &&
 	! grep "fatal:" err-6 &&
 	(
 		cd src-0 && test_commit A
 	) &&
-	git clone "file://$(pwd)/src-0" target-7 2>err-7 &&
+	git clone "file://$PWD/src-0" target-7 2>err-7 &&
 	! grep "fatal:" err-7 &&
 	# There is no reason to insist they are bit-for-bit
 	# identical, but this test should suffice for now.
@@ -291,14 +291,14 @@ test_expect_success 'setup ssh wrapper' '
=20
 	GIT_SSH=3D"$TRASH_DIRECTORY/ssh-wrapper" &&
 	export GIT_SSH &&
-	export TRASH_DIRECTORY
+	export TRASH_DIRECTORY &&
+	>"$TRASH_DIRECTORY"/ssh-output
 '
=20
-clear_ssh () {
-	>"$TRASH_DIRECTORY/ssh-output"
-}
-
 expect_ssh () {
+	test_when_finished '
+	  (cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
+	' &&
 	{
 		case "$1" in
 		none)
@@ -310,23 +310,96 @@ expect_ssh () {
 	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
 }
=20
-test_expect_success 'cloning myhost:src uses ssh' '
-	clear_ssh &&
-	git clone myhost:src ssh-clone &&
-	expect_ssh myhost src
-'
-
 test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
-	clear_ssh &&
 	cp -R src "foo:bar" &&
-	git clone "./foo:bar" foobar &&
+	git clone "foo:bar" foobar &&
+	expect_ssh none
+'
+
+test_expect_success 'clone local path foo2' '
+	cp -R src "foo2" &&
+	git clone "foo2" foobar2 &&
 	expect_ssh none
 '
=20
-test_expect_success 'bracketed hostnames are still ssh' '
-	clear_ssh &&
-	git clone "[myhost:123]:src" ssh-bracket-clone &&
-	expect_ssh myhost:123 src
+counter=3D0
+# $1 url
+# $2 none|host
+# $3 path
+test_fetch_url () {
+	counter=3D$(($counter + 1))
+	test_might_fail git fetch "$1" tmp$counter &&
+	expect_ssh "$2" "$3"
+}
+
+test_expect_success NOT_MINGW 'fetch c:temp is ssl' '
+	test_fetch_url c:temp c temp
+'
+
+test_expect_success MINGW 'fetch c:temp is dos drive' '
+	test_fetch_url c:temp none
+'
+
+#ip v4
+for repo in rep rep/home/project /~proj 123
+do
+	test_expect_success "fetchinghost:$repo" '
+		test_fetch_url host:$repo host $repo
+	'
+done
+
+#ipv6
+for repo in rep rep/home/project /~proj 123
+do
+	test_expect_success "fetching[::1]:$repo" '
+		test_fetch_url [::1]:$repo ::1 $repo
+	'
+done
+
+# Corner cases
+for url in [foo]bar/baz:qux [foo/bar]:baz foo/bar:baz
+do
+	test_expect_success "fetching$url is not ssh" '
+			test_fetch_url $url none
+	'
+done
+
+#with ssh:// scheme
+test_expect_success 'ssh://host.xz/home/user/repo' '
+	test_fetch_url "ssh://host.xz/home/user/repo" host.xz "/home/user/rep=
o"
+'
+
+# from home directory
+test_expect_success 'ssh://host.xz/~repo' '
+	test_fetch_url "ssh://host.xz/~repo" host.xz "~repo"
+'
+# with port number
+test_expect_success 'ssh://host.xz:22/home/user/repo' '
+	test_fetch_url "ssh://host.xz:22/home/user/repo" "-p 22 host.xz" "/ho=
me/user/repo"
+'
+
+# from home directory with port number
+test_expect_success 'ssh://host.xz:22/~repo' '
+	test_fetch_url "ssh://host.xz:22/~repo" "-p 22 host.xz" "~repo"
+'
+
+#IPv6
+test_expect_success 'ssh://[::1]/home/user/repo' '
+	test_fetch_url "ssh://[::1]/home/user/repo" "::1" "/home/user/repo"
+'
+
+#IPv6 from home directory
+test_expect_success 'ssh://[::1]/~repo' '
+	test_fetch_url "ssh://[::1]/~repo" "::1" "~repo"
+'
+
+#IPv6 with port number
+test_expect_success 'ssh://[::1]:22/home/user/repo' '
+	test_fetch_url "ssh://[::1]:22/home/user/repo" "-p 22 ::1" "/home/use=
r/repo"
+'
+#IPv6 from home directory with port number
+test_expect_success 'ssh://[::1]:22/~repo' '
+	test_fetch_url "ssh://[::1]:22/~repo" "-p 22 ::1" "~repo"
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
