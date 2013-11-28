From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 07/10] git fetch: support host:/~repo
Date: Thu, 28 Nov 2013 20:49:38 +0100
Message-ID: <201311282049.39434.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:49:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7aw-00033Z-36
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759461Ab3K1Ttq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:49:46 -0500
Received: from mout.web.de ([212.227.15.14]:55370 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759458Ab3K1Ttp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:49:45 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MNcMo-1VjLMz1QqY-007GTC for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:49:43 +0100
X-Provags-ID: V03:K0:SJLPkhVmhcdhGdpCDk5GM0Pkj+lnkF9L1nJIDhWG2Y3Xz3pwdQJ
 MmLRcBId9CPlDaESNZn7Mkm0jgXdjPAoqgz/FxFhDrKaL7XGar1Ty5Hvb3tOrlJNerrT8Dn
 kBR+y1ZNrIot1Shiegf4TYBD+A0sq28Uu54Z0trsNdp2xuqUxU1+6f37n/pVxXhxaIjM7Nq
 wOvKK5n/j7/zHUQADvzqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238509>

The documentation (in urls.txt) says that
"ssh://host:/~repo",
"host:/~repo" or
"host:~repo"
specifiy the repository "repo" in the home directory at "host".

This has not been working for "host:/~repo".

=46ix a minor regression:
Before commit 356bec "Support [address] in URLs"
the comparison url !=3D hostname could be used to determine if
the URL had a scheme or not: "ssh://host/host" !=3D "host".
After 356bec "[::1]" was converted into "::1", yielding
url !=3D hostname as well.
Solution:
Don't use "if (url !=3D hostname)", but look at the separator instead.
Rename the variable "c" into separator.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 connect.c             | 14 +++++++-------
 t/t5500-fetch-pack.sh | 24 ++++++++++++++++++++++++
 t/t5601-clone.sh      | 12 ++----------
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/connect.c b/connect.c
index a16bdaf..7e5f608 100644
--- a/connect.c
+++ b/connect.c
@@ -567,7 +567,7 @@ static enum protocol parse_connect_url(const char *=
url_orig, char **ret_host,
 	char *url;
 	char *host, *path;
 	char *end;
-	int c;
+	int separator;
 	enum protocol protocol =3D PROTO_LOCAL;
 	int free_path =3D 0;
 	char *port =3D NULL;
@@ -582,10 +582,10 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
 		*host =3D '\0';
 		protocol =3D get_protocol(url);
 		host +=3D 3;
-		c =3D '/';
+		separator =3D '/';
 	} else {
 		host =3D url;
-		c =3D ':';
+		separator =3D ':';
 	}
=20
 	/*
@@ -605,9 +605,9 @@ static enum protocol parse_connect_url(const char *=
url_orig, char **ret_host,
 	} else
 		end =3D host;
=20
-	path =3D strchr(end, c);
+	path =3D strchr(end, separator);
 	if (path && !has_dos_drive_prefix(end)) {
-		if (c =3D=3D ':') {
+		if (separator =3D=3D ':') {
 			if (host !=3D url || path < strchrnul(host, '/')) {
 				protocol =3D PROTO_SSH;
 				*path++ =3D '\0';
@@ -624,7 +624,7 @@ static enum protocol parse_connect_url(const char *=
url_orig, char **ret_host,
 	 * null-terminate hostname and point path to ~ for URL's like this:
 	 *    ssh://host.xz/~user/repo
 	 */
-	if (protocol !=3D PROTO_LOCAL && host !=3D url) {
+	if (protocol !=3D PROTO_LOCAL) {
 		char *ptr =3D path;
 		if (path[1] =3D=3D '~')
 			path++;
@@ -639,7 +639,7 @@ static enum protocol parse_connect_url(const char *=
url_orig, char **ret_host,
 	/*
 	 * Add support for ssh port: ssh://host.xy:<port>/...
 	 */
-	if (protocol =3D=3D PROTO_SSH && host !=3D url)
+	if (protocol =3D=3D PROTO_SSH && separator =3D=3D '/')
 		port =3D get_port(end);
=20
 	*ret_host =3D xstrdup(host);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index a2b37af..2d3cdaa 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -589,6 +589,30 @@ do
 			check_prot_path $p://$h/~$r $p "/~$r"
 		'
 	done
+	# file without scheme
+	for h in nohost nohost:12 [::1] [::1]:23 [ [:aa
+	do
+		test_expect_success "fetch-pack --diag-url ./$h:$r" '
+			check_prot_path ./$h:$r $p "./$h:$r"
+		'
+		# No "/~" -> "~" conversion for file
+		test_expect_success "fetch-pack --diag-url ./$p:$h/~$r" '
+		check_prot_path ./$p:$h/~$r $p "./$p:$h/~$r"
+		'
+	done
+	#ssh without scheme
+	p=3Dssh
+	for h in host [::1]
+	do
+		hh=3D$(echo $h | tr -d "[]")
+		test_expect_success "fetch-pack --diag-url $h:$r" '
+			check_prot_path $h:$r $p "$r"
+		'
+		# Do "/~" -> "~" conversion
+		test_expect_success "fetch-pack --diag-url $h:/~$r" '
+			check_prot_host_path $h:/~$r $p "$hh" "~$r"
+		'
+	done
 done
=20
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index ba99972..4db0c0b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -348,7 +348,7 @@ test_expect_success MINGW 'clone c:temp is dos driv=
e' '
 '
=20
 #ip v4
-for repo in rep rep/home/project /~proj 123
+for repo in rep rep/home/project 123
 do
 	test_expect_success "clone host:$repo" '
 		test_clone_url host:$repo host $repo
@@ -356,14 +356,6 @@ do
 done
=20
 #ipv6
-# failing
-for repo in /~proj
-do
-	test_expect_failure "clone [::1]:$repo" '
-		test_clone_url [::1]:$repo ::1 $repo
-	'
-done
-
 for repo in rep rep/home/project 123
 do
 	test_expect_success "clone [::1]:$repo" '
@@ -373,7 +365,7 @@ done
=20
 # Corner cases
 # failing
-for repo in [foo]bar/baz:qux [foo/bar]:baz
+for url in [foo]bar/baz:qux [foo/bar]:baz
 do
 	test_expect_failure "clone $url is not ssh" '
 		test_clone_url $url none
--=20
1.8.5.rc0.23.gaa27064
