From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Mon, 19 Jan 2015 18:21:24 +0100
Message-ID: <54BD3D14.90309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, lists@hcf.yourweb.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 18:22:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDG1g-0003uZ-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 18:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbASRV5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2015 12:21:57 -0500
Received: from mout.web.de ([212.227.17.11]:58482 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbbASRVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 12:21:32 -0500
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LsQTc-1Xkp6n0BNg-011yhU; Mon, 19 Jan 2015 18:21:30
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:nqvsu+JrSYx8u1fhMh32rC5YgM013CYX/rNpi93XHUvfxY2lFl7
 V4RW7iKj2+q0gGdz+lRwaHtBLJ9qAUxqGNbU6HcY9WyThqA60F4KLKq5Wm9up/uOqangVzy
 oY85QFks/POfS0V1T3PWvc4Am9b1/jXYUFZGQtOxBrI4N5O0hu6KTge/duTg93Kkgh4QUyn
 VHi5w+mcK+T34aPz1x3vQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262639>

When parsing an URL, older Git versions did handle
URLs like ssh://2001:db8::1/repo.git the same way as
ssh://[2001:db8::1]/repo.git

Commit 83b058 broke the parsing of IPV6 adresses without "[]":
It was written in mind that the fist ':' in a URL was the beginning of =
a
port number, while the old code was more clever:
Literal IPV6 addresses have always at least two ':'.
When the "hostandport" had a ':' and the rest of the hostandport string
could be parsed into an integer between 0 and 65536, then it was used
as a port number, like "host:22".
Otherwise the first ':' was assumed to be part of a literal IPV6 addres=
s,
like "ssh://[2001:db8::1]/repo.git" or "ssh://[::1]/repo.git".

Re-introduce the old parsing in get_host_and_port().

Improve the parsing to handle URLs which have a user name and a literal
IPV6 like "ssh://user@[2001:db8::1]/repo.git".
(Thanks to Christian Taube <lists@hcf.yourweb.de> for reporting this lo=
ng
standing issue)

Another regression was introduced in 83b058:
A non-RFC conform URL like "[localhost:222]" could be used in older ver=
sions
of Git to connect to run "ssh -p 222 localhost".
The new stricter parsing did not allow this any more.
See even 8d3d28f5dba why "[localhost:222]" should be declared a feature=
=2E

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Unfortunatly my attemps to improve connect.c introduced some
regressions:
- "git clone ssh://::1/repo" did not work anymore (for some reason I as=
sumed
  that literall IPV6 addresses always should have brackets, but that wa=
s wrong)
- "ssh://host:2222/repo" written in the "unofficial short form"
  "[host:2222]:repo did not work anymore. I think that should be
  an "unoffical feature", because it worked in older Git versions

On top of that, the combination of ssh://username@[host] had never
be handled correctly, so fix that as well.
Thanks to Christian Taube for reporting it.


Comments and an extra pair of critical eyes are welcome.


 connect.c        | 63 ++++++++++++++++++++++++++++++++++--------------=
--------
 t/t5601-clone.sh |  2 +-
 2 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/connect.c b/connect.c
index d47d0ec..b608976 100644
--- a/connect.c
+++ b/connect.c
@@ -274,28 +274,44 @@ static enum protocol get_protocol(const char *nam=
e)
 	die("I don't handle protocol '%s'", name);
 }
=20
+static char *host_end(char **hoststart, int removebrackets)
+{
+	char *host =3D *hoststart;
+	char *end;
+	char *start =3D strstr(host, "@[");
+	if (start)
+		start++; /* Jump over '@' */
+	else
+		start =3D host;
+	if (start[0] =3D=3D '[') {
+		end =3D strchr(start + 1, ']');
+		if (end) {
+			if (removebrackets) {
+				*end =3D 0;
+				memmove(start, start + 1, end - start);
+				end++;
+			}
+		} else
+			end =3D host;
+	} else
+		end =3D host;
+	return end;
+}
+
 #define STR_(s)	# s
 #define STR(s)	STR_(s)
=20
 static void get_host_and_port(char **host, const char **port)
 {
 	char *colon, *end;
-
-	if (*host[0] =3D=3D '[') {
-		end =3D strchr(*host + 1, ']');
-		if (end) {
-			*end =3D 0;
-			end++;
-			(*host)++;
-		} else
-			end =3D *host;
-	} else
-		end =3D *host;
+	end =3D host_end(host, 1);
 	colon =3D strchr(end, ':');
-
 	if (colon) {
-		*colon =3D 0;
-		*port =3D colon + 1;
+		long portnr =3D strtol(colon + 1, &end, 10);
+		if (end !=3D colon + 1 && *end =3D=3D '\0' && 0 <=3D portnr && portn=
r < 65536) {
+			*colon =3D 0;
+			*port =3D colon + 1;
+		}
 	}
 }
=20
@@ -547,13 +563,16 @@ static struct child_process *git_proxy_connect(in=
t fd[2], char *host)
 	return proxy;
 }
=20
-static const char *get_port_numeric(const char *p)
+static char *get_port(char *host)
 {
 	char *end;
+	char *p =3D strchr(host, ':');
+
 	if (p) {
 		long port =3D strtol(p + 1, &end, 10);
 		if (end !=3D p + 1 && *end =3D=3D '\0' && 0 <=3D port && port < 6553=
6) {
-			return p;
+			*p =3D '\0';
+			return p+1;
 		}
 	}
=20
@@ -595,14 +614,7 @@ static enum protocol parse_connect_url(const char =
*url_orig, char **ret_host,
 	 * Don't do destructive transforms as protocol code does
 	 * '[]' unwrapping in get_host_and_port()
 	 */
-	if (host[0] =3D=3D '[') {
-		end =3D strchr(host + 1, ']');
-		if (end) {
-			end++;
-		} else
-			end =3D host;
-	} else
-		end =3D host;
+	end =3D host_end(&host, 0);
=20
 	if (protocol =3D=3D PROTO_LOCAL)
 		path =3D end;
@@ -705,7 +717,8 @@ struct child_process *git_connect(int fd[2], const =
char *url,
 			char *ssh_host =3D hostandport;
 			const char *port =3D NULL;
 			get_host_and_port(&ssh_host, &port);
-			port =3D get_port_numeric(port);
+			if (!port)
+				port =3D get_port(ssh_host);
=20
 			if (!ssh) ssh =3D "ssh";
=20
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index e4f10c0..f901b8a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -326,7 +326,7 @@ test_expect_success !MINGW,!CYGWIN 'clone local pat=
h foo:bar' '
=20
 test_expect_success 'bracketed hostnames are still ssh' '
 	git clone "[myhost:123]:src" ssh-bracket-clone &&
-	expect_ssh myhost:123 src
+	expect_ssh myhost '-p 123' src
 '
=20
 counter=3D0
--=20
2.2.0.rc1.26.g3e3a70d
