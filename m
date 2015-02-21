From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2 1/3] connect.c: allow ssh://user@[2001:db8::1]/repo.git
Date: Sat, 21 Feb 2015 16:52:48 +0100
Message-ID: <54E8A9D0.30108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, lists@hcf.yourweb.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 16:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPCMU-00089R-RF
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 16:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbbBUPwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2015 10:52:54 -0500
Received: from mout.web.de ([212.227.17.11]:62752 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbbBUPwv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 10:52:51 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MhDgb-1YCMIj3c3N-00MNSe; Sat, 21 Feb 2015 16:52:49
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:gRFW1oKCppgIbwlAvb6eiZGwEsxP3JqKq6yMmkCKvCBmEHkG9V7
 k+BRqbTpPKQqqfQdoVtPd1maEjqBguQXkBd2arpwlwfV632dZmGg8YkM4V6zsSKakixnOMB
 oYz6ECxL2WF7q1Dd0ax3Jj05aUmo36OtxJVa9AH4ZfLjYk/cqmVh0Kh9V3/73QYuGA+q54t
 /ZucVIlW4Ly+UL8mKOZ0Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264216>

The ssh:// syntax was added in 2386d65822c91, it accepted
ssh://user@2001:db8::1/repo.git, which is now legacy.

Over the years the parser was improved to support [] and port numbers,
but the combination of ssh://user@[2001:db8::1]:222/repo.git did
never work.

The only only way to use a user name, a literall IPV6 address and a por=
t
number was ssh://[user@2001:db8::1]:222/repo.git

(Thanks to Christian Taube <lists@hcf.yourweb.de> for reporting this lo=
ng
standing issue)

New users would use ssh://user@[2001:db8::1]:222/repo.git,
so change the parser to handle it correctly.

Support the old legacy URL's as well, to be backwards compatible,
and avoid regressions for users which upgrade an existing installation
to a later Git version.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Thanks for the reviews
I hope the intention of being backward compatible is a little bit clear=
er now,
as well as the intention to accept URL's conforming to the RFC


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
2.2.0.rc1.790.ge19fcd2
