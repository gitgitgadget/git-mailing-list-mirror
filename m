From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2] connect.c: Ignore extra colon after hostname
Date: Tue, 07 Apr 2015 22:03:25 +0200
Message-ID: <5524380D.4020306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, reidw@rawsound.com, mackyle@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 22:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfZih-0004qS-Av
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 22:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbbDGUDb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 16:03:31 -0400
Received: from mout.web.de ([212.227.17.12]:56309 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbDGUDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 16:03:30 -0400
Received: from [192.168.2.107] ([79.223.100.247]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MGABv-1YarAO0SeN-00F9cS; Tue, 07 Apr 2015 22:03:27
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Provags-ID: V03:K0:Tz0ANW/9CjlX9YD7TbRM3APAaUdmG4mGHOfEsvlRbm6WtWcYNJc
 QCOoa7fNBZBFuN6StcKKBv6OyKvytDa+cSb9nFXha1LVLRLa1cuUUu/2zDOzOrM+hIDwj1V
 961tKE4BDq2pkqlEci/uuYd9z3ko59PB8AqJ5QaWoI9gZozQngLDbXI/CXoOh616k8y77Ph
 wUptWq9B56NJC/0WrBljQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266938>

Ignore an extra ':' at the end of the hostname in URL's like
"ssh://example.com:/path/to/repo"

The colon is meant to separate a port number from the hostname.
If the port is empty, the colon should be ignored, see RFC 3986.

It had been working for URLs with ssh:// scheme, but was unintentionall=
y
broken in 86ceb3, "allow ssh://user@[2001:db8::1]/repo.git"

Reported-by: Reid Woodbury Jr. <reidw@rawsound.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v1 (Thanks to Eric Sunshine)
- typo: s/ment/meant/
- remove wrong test_done

 connect.c             |  2 ++
 t/t5500-fetch-pack.sh | 17 ++++++++++-------
 t/t5601-clone.sh      | 21 ++++++++++++---------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/connect.c b/connect.c
index ce0e121..14c924b 100644
--- a/connect.c
+++ b/connect.c
@@ -310,6 +310,8 @@ static void get_host_and_port(char **host, const ch=
ar **port)
 		if (end !=3D colon + 1 && *end =3D=3D '\0' && 0 <=3D portnr && portn=
r < 65536) {
 			*colon =3D 0;
 			*port =3D colon + 1;
+		} else if (!colon[1]) {
+			*colon =3D 0;
 		}
 	}
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 692d717..3a9b775 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -576,13 +576,16 @@ do
 	do
 		for h in host user@host user@[::1] user@::1
 		do
-			test_expect_success "fetch-pack --diag-url $p://$h/$r" '
-				check_prot_host_port_path $p://$h/$r $p "$h" NONE "/$r"
-			'
-			# "/~" -> "~" conversion
-			test_expect_success "fetch-pack --diag-url $p://$h/~$r" '
-				check_prot_host_port_path $p://$h/~$r $p "$h" NONE "~$r"
-			'
+			for c in "" :
+			do
+				test_expect_success "fetch-pack --diag-url $p://$h$c/$r" '
+					check_prot_host_port_path $p://$h/$r $p "$h" NONE "/$r"
+				'
+				# "/~" -> "~" conversion
+				test_expect_success "fetch-pack --diag-url $p://$h$c/~$r" '
+					check_prot_host_port_path $p://$h/~$r $p "$h" NONE "~$r"
+				'
+			done
 		done
 		for h in host User@host User@[::1]
 		do
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 02b40b1..1befc45 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -387,14 +387,17 @@ do
 done
=20
 #with ssh:// scheme
-test_expect_success 'clone ssh://host.xz/home/user/repo' '
-	test_clone_url "ssh://host.xz/home/user/repo" host.xz "/home/user/rep=
o"
-'
-
-# from home directory
-test_expect_success 'clone ssh://host.xz/~repo' '
-	test_clone_url "ssh://host.xz/~repo" host.xz "~repo"
+#ignore trailing colon
+for tcol in "" :
+do
+	test_expect_success "clone ssh://host.xz$tcol/home/user/repo" '
+		test_clone_url "ssh://host.xz$tcol/home/user/repo" host.xz /home/use=
r/repo
+	'
+	# from home directory
+	test_expect_success "clone ssh://host.xz$tcol/~repo" '
+	test_clone_url "ssh://host.xz$tcol/~repo" host.xz "~repo"
 '
+done
=20
 # with port number
 test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
@@ -407,9 +410,9 @@ test_expect_success 'clone ssh://host.xz:22/~repo' =
'
 '
=20
 #IPv6
-for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
+for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1=
] [user@::1]:
 do
-	ehost=3D$(echo $tuah | tr -d "[]")
+	ehost=3D$(echo $tuah | sed -e "s/1]:/1]/ "| tr -d "[]")
 	test_expect_success "clone ssh://$tuah/home/user/repo" "
 	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
 	"
--=20
2.2.0.rc1.790.ge19fcd2
