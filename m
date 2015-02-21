From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2 3/3] t5500: show user name and host in diag-url
Date: Sat, 21 Feb 2015 16:52:55 +0100
Message-ID: <54E8A9D7.4050702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, lists@hcf.yourweb.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 16:53:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPCMa-0008AU-L0
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 16:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbBUPxB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2015 10:53:01 -0500
Received: from mout.web.de ([212.227.17.12]:62816 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbbBUPw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 10:52:58 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lvjiy-1XSoLz2kHs-017Rym; Sat, 21 Feb 2015 16:52:55
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:EcG5RL5wCAEX9N2hwJQZUwZ9wDTrsXxkAYaVg/5ujiZ17NvZgyM
 meuiKhAiT0tNucwT+a647lVm54fOHPQOBgMIBHK+fJJx131H8ey6513w6EZEx/GEUYiJrv4
 +Ok5Ockm4/RKmOpBDw2zRujpaW3H7QnERNGPFqfN/rho+vVJLGgCsSq2E/IqPaJ1lweXMah
 ryIJrOTMsYu25nASjUcxg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264217>

The URL for ssh may have include a username before the hostname,
like ssh://user@host/repo.
When literal IPV6 addresses are used together with a username,
the substring "user@[::1]" must be converted into "user@::1".

Make that conversion visible for the user, and write userandhost
in the diagnostics

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 connect.c             | 35 +++++++++++++++++++++++------------
 t/t5500-fetch-pack.sh | 51 +++++++++++++++++++++++++++++++++----------=
--------
 2 files changed, 56 insertions(+), 30 deletions(-)

diff --git a/connect.c b/connect.c
index b608976..84f8156 100644
--- a/connect.c
+++ b/connect.c
@@ -675,7 +675,7 @@ struct child_process *git_connect(int fd[2], const =
char *url,
 	signal(SIGCHLD, SIG_DFL);
=20
 	protocol =3D parse_connect_url(url, &hostandport, &path);
-	if (flags & CONNECT_DIAG_URL) {
+	if ((flags & CONNECT_DIAG_URL) && (protocol !=3D PROTO_SSH)) {
 		printf("Diag: url=3D%s\n", url ? url : "NULL");
 		printf("Diag: protocol=3D%s\n", prot_name(protocol));
 		printf("Diag: hostandport=3D%s\n", hostandport ? hostandport : "NULL=
");
@@ -719,18 +719,29 @@ struct child_process *git_connect(int fd[2], cons=
t char *url,
 			get_host_and_port(&ssh_host, &port);
 			if (!port)
 				port =3D get_port(ssh_host);
-
-			if (!ssh) ssh =3D "ssh";
-
-			argv_array_push(&conn->args, ssh);
-			if (putty && !strcasestr(ssh, "tortoiseplink"))
-				argv_array_push(&conn->args, "-batch");
-			if (port) {
-				/* P is for PuTTY, p is for OpenSSH */
-				argv_array_push(&conn->args, putty ? "-P" : "-p");
-				argv_array_push(&conn->args, port);
+			if (flags & CONNECT_DIAG_URL) {
+				printf("Diag: url=3D%s\n", url ? url : "NULL");
+				printf("Diag: protocol=3D%s\n", prot_name(protocol));
+				printf("Diag: userandhost=3D%s\n", ssh_host ? ssh_host : "NULL");
+				printf("Diag: port=3D%s\n", port ? port : "NONE");
+				printf("Diag: path=3D%s\n", path ? path : "NULL");
+
+				free(hostandport);
+				free(path);
+				return NULL;
+			} else {
+				if (!ssh) ssh =3D "ssh";
+
+				argv_array_push(&conn->args, ssh);
+				if (putty && !strcasestr(ssh, "tortoiseplink"))
+					argv_array_push(&conn->args, "-batch");
+				if (port) {
+					/* P is for PuTTY, p is for OpenSSH */
+					argv_array_push(&conn->args, putty ? "-P" : "-p");
+					argv_array_push(&conn->args, port);
+				}
+				argv_array_push(&conn->args, ssh_host);
 			}
-			argv_array_push(&conn->args, ssh_host);
 		} else {
 			/* remove repo-local variables from the environment */
 			conn->env =3D local_repo_env;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 5b2b1c2..bd37f04 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -541,13 +541,30 @@ check_prot_path () {
 	test_cmp expected actual
 }
=20
-check_prot_host_path () {
-	cat >expected <<-EOF &&
+check_prot_host_port_path () {
+	local diagport
+	case "$2" in
+		*ssh*)
+		pp=3Dssh
+		uah=3Duserandhost
+		ehost=3D$(echo $3 | tr -d "[]")
+		diagport=3D"Diag: port=3D$4"
+		;;
+		*)
+		pp=3D$p
+		uah=3Dhostandport
+		ehost=3D$(echo $3$4 | sed -e "s/22$/:22/" -e "s/NONE//")
+		diagport=3D""
+		;;
+	esac
+	cat >exp <<-EOF &&
 	Diag: url=3D$1
-	Diag: protocol=3D$2
-	Diag: hostandport=3D$3
-	Diag: path=3D$4
+	Diag: protocol=3D$pp
+	Diag: $uah=3D$ehost
+	$diagport
+	Diag: path=3D$5
 	EOF
+	grep -v "^$" exp >expected
 	git fetch-pack --diag-url "$1" >actual &&
 	test_cmp expected actual
 }
@@ -557,22 +574,20 @@ do
 	# git or ssh with scheme
 	for p in "ssh+git" "git+ssh" git ssh
 	do
-		for h in host host:12 [::1] [::1]:23
+		for h in host user@host user@[::1] user@::1
 		do
-			case "$p" in
-			*ssh*)
-				pp=3Dssh
-				;;
-			*)
-				pp=3D$p
-			;;
-			esac
 			test_expect_success "fetch-pack --diag-url $p://$h/$r" '
-				check_prot_host_path $p://$h/$r $pp "$h" "/$r"
+				check_prot_host_port_path $p://$h/$r $p "$h" NONE "/$r"
 			'
 			# "/~" -> "~" conversion
 			test_expect_success "fetch-pack --diag-url $p://$h/~$r" '
-				check_prot_host_path $p://$h/~$r $pp "$h" "~$r"
+				check_prot_host_port_path $p://$h/~$r $p "$h" NONE "~$r"
+			'
+		done
+		for h in host User@host User@[::1]
+		do
+			test_expect_success "fetch-pack --diag-url $p://$h:22/$r" '
+				check_prot_host_port_path $p://$h:22/$r $p "$h" 22 "/$r"
 			'
 		done
 	done
@@ -603,11 +618,11 @@ do
 	for h in host [::1]
 	do
 		test_expect_success "fetch-pack --diag-url $h:$r" '
-			check_prot_path $h:$r $p "$r"
+			check_prot_host_port_path $h:$r $p "$h" NONE "$r"
 		'
 		# Do "/~" -> "~" conversion
 		test_expect_success "fetch-pack --diag-url $h:/~$r" '
-			check_prot_host_path $h:/~$r $p "$h" "~$r"
+			check_prot_host_port_path $h:/~$r $p "$h" NONE "~$r"
 		'
 	done
 done
--=20
2.2.0.rc1.790.ge19fcd2
