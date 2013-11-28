From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 09/10] connect.c: Refactor url parsing
Date: Thu, 28 Nov 2013 20:50:03 +0100
Message-ID: <201311282050.04266.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7bK-0003NB-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759465Ab3K1TuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:50:10 -0500
Received: from mout.web.de ([212.227.15.3]:49289 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994Ab3K1TuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:50:09 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MUnYm-1W9ID61O8q-00Y7f7 for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:50:08 +0100
X-Provags-ID: V03:K0:BcAuypeTqSdXM6qPcjE6ED9dybl7UZLfLjEUUsYMz8Ib0tsEDsn
 KNMaPl88VDc9t8Ab9JqDOPniz8polswqCLzWNqCqIAoa1EV7auUr5mN/ywGx2/zSbcxsQsB
 YpNng3lVX0flq+vn7lE1ApznWZ1/g8aTN7Yv5OdhPgthLJO2S9oPb84+g46ZLRV1KGlW6jl
 sJvz431MSVAZN1U51wryg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238511>

Make the function is_local() from transport.c public, rename it into
url_is_local_not_ssh() and use it in both transport.c and connect.c

Use a protocol "local" for URLs for the local file system.

One note about using file:// under Windows:
The (absolute) path on Unix like system typically starts with "/".
When the host is empty, it can be omitted, so that a shell scriptlet
url=3Dfile://$pwd
will give a URL like "file:///home/user/repo".

Windows does not have the same concept of a root directory located in "=
/".
When parsing the URL allow "file://C:/user/repo"
(even if RFC1738 indicates that "file:///C:/user/repo" should be used).

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 connect.c             | 57 +++++++++++++++++++++++++++----------------=
--------
 connect.h             |  1 +
 t/t5500-fetch-pack.sh |  7 +++++++
 t/t5601-clone.sh      |  8 ++++++++
 transport.c           | 12 ++---------
 5 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/connect.c b/connect.c
index 7874530..04093c4 100644
--- a/connect.c
+++ b/connect.c
@@ -232,14 +232,24 @@ int server_supports(const char *feature)
=20
 enum protocol {
 	PROTO_LOCAL =3D 1,
+	PROTO_FILE,
 	PROTO_SSH,
 	PROTO_GIT
 };
=20
+int url_is_local_not_ssh(const char *url)
+{
+	const char *colon =3D strchr(url, ':');
+	const char *slash =3D strchr(url, '/');
+	return !colon || (slash && slash < colon) ||
+		has_dos_drive_prefix(url);
+}
+
 static const char *prot_name(enum protocol protocol)
 {
 	switch (protocol) {
 		case PROTO_LOCAL:
+		case PROTO_FILE:
 			return "file";
 		case PROTO_SSH:
 			return "ssh";
@@ -261,7 +271,7 @@ static enum protocol get_protocol(const char *name)
 	if (!strcmp(name, "ssh+git"))
 		return PROTO_SSH;
 	if (!strcmp(name, "file"))
-		return PROTO_LOCAL;
+		return PROTO_FILE;
 	die("I don't handle protocol '%s'", name);
 }
=20
@@ -564,9 +574,8 @@ static enum protocol parse_connect_url(const char *=
url_orig, char **ret_host,
 	char *url;
 	char *host, *path;
 	char *end;
-	int separator;
+	int separator =3D '/';
 	enum protocol protocol =3D PROTO_LOCAL;
-	int free_path =3D 0;
=20
 	if (is_url(url_orig))
 		url =3D url_decode(url_orig);
@@ -578,10 +587,12 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
 		*host =3D '\0';
 		protocol =3D get_protocol(url);
 		host +=3D 3;
-		separator =3D '/';
 	} else {
 		host =3D url;
-		separator =3D ':';
+		if (!url_is_local_not_ssh(url)) {
+			protocol =3D PROTO_SSH;
+			separator =3D ':';
+		}
 	}
=20
 	/*
@@ -597,17 +608,12 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
 	} else
 		end =3D host;
=20
-	path =3D strchr(end, separator);
-	if (path && !has_dos_drive_prefix(end)) {
-		if (separator =3D=3D ':') {
-			if (host !=3D url || path < strchrnul(host, '/')) {
-				protocol =3D PROTO_SSH;
-				*path++ =3D '\0';
-			} else /* '/' in the host part, assume local path */
-				path =3D end;
-		}
-	} else
+	if (protocol =3D=3D PROTO_LOCAL)
 		path =3D end;
+	else if (protocol =3D=3D PROTO_FILE && has_dos_drive_prefix(end))
+		path =3D end; /* "file://$(pwd)" may be "file://C:/projects/repo" */
+	else
+		path =3D strchr(end, separator);
=20
 	if (!path || !*path)
 		die("No path specified. See 'man git-pull' for valid url syntax");
@@ -616,23 +622,20 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
 	 * null-terminate hostname and point path to ~ for URL's like this:
 	 *    ssh://host.xz/~user/repo
 	 */
-	if (protocol !=3D PROTO_LOCAL) {
-		char *ptr =3D path;
+
+	end =3D path; /* Need to \0 terminate host here */
+	if (separator =3D=3D ':')
+		path++; /* path starts after ':' */
+	if (protocol =3D=3D PROTO_GIT || protocol =3D=3D PROTO_SSH) {
 		if (path[1] =3D=3D '~')
 			path++;
-		else {
-			path =3D xstrdup(ptr);
-			free_path =3D 1;
-		}
-
-		*ptr =3D '\0';
 	}
=20
+	path =3D xstrdup(path);
+	*end =3D '\0';
+
 	*ret_host =3D xstrdup(host);
-	if (free_path)
-		*ret_path =3D path;
-	else
-		*ret_path =3D xstrdup(path);
+	*ret_path =3D path;
 	free(url);
 	return protocol;
 }
diff --git a/connect.h b/connect.h
index 527d58a..c41a685 100644
--- a/connect.h
+++ b/connect.h
@@ -9,5 +9,6 @@ extern int git_connection_is_socket(struct child_proces=
s *conn);
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *fea=
ture);
 extern const char *server_feature_value(const char *feature, int *len_=
ret);
+extern int url_is_local_not_ssh(const char *url);
=20
 #endif
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f4a2a38..5ad3505 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -612,4 +612,11 @@ do
 	done
 done
=20
+test_expect_success MINGW 'fetch-pack --diag-url file://c:/repo' '
+	check_prot_path file://c:/repo file c:/repo
+'
+test_expect_success MINGW 'fetch-pack --diag-url c:repo' '
+	check_prot_path c:repo file c:repo
+'
+
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 53a1de9..62fbd7e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -362,6 +362,14 @@ do
 		test_clone_url [::1]:$repo ::1 $repo
 	'
 done
+#home directory
+test_expect_success "clone host:/~repo" '
+	test_clone_url host:/~repo host "~repo"
+'
+
+test_expect_success "clone [::1]:/~repo" '
+	test_clone_url [::1]:/~repo ::1 "~repo"
+'
=20
 # Corner cases
 for url in foo/bar:baz [foo]bar/baz:qux [foo/bar]:baz
diff --git a/transport.c b/transport.c
index 7202b77..5485e2a 100644
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
@@ -941,7 +933,7 @@ struct transport *transport_get(struct remote *remo=
te, const char *url)
 		ret->fetch =3D fetch_objs_via_rsync;
 		ret->push =3D rsync_transport_push;
 		ret->smart_options =3D NULL;
-	} else if (is_local(url) && is_file(url) && is_bundle(url, 1)) {
+	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url=
, 1)) {
 		struct bundle_transport_data *data =3D xcalloc(1, sizeof(*data));
 		ret->data =3D data;
 		ret->get_refs_list =3D get_refs_from_bundle;
@@ -1297,7 +1289,7 @@ char *transport_anonymize_url(const char *url)
 	size_t anon_len, prefix_len =3D 0;
=20
 	anon_part =3D strchr(url, '@');
-	if (is_local(url) || !anon_part)
+	if (url_is_local_not_ssh(url) || !anon_part)
 		goto literal_copy;
=20
 	anon_len =3D strlen(++anon_part);
--=20
1.8.5.rc0.23.gaa27064
