From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2 2/3] t5601: add more test cases for IPV6
Date: Sat, 21 Feb 2015 16:53:01 +0100
Message-ID: <54E8A9DD.7090908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, lists@hcf.yourweb.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 16:53:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPCMp-0008Jj-2H
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 16:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbbBUPxP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2015 10:53:15 -0500
Received: from mout.web.de ([212.227.17.12]:51399 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbBUPxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 10:53:05 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LmLgE-1XqPm90Dkg-00ZwAM; Sat, 21 Feb 2015 16:53:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:NYa96E+vGByE3vTN5bgbyOJD+CS0T7HQjzdRbwg7/5hjTZbR46F
 n4mqhEfipP32tv1lOU6bjb+H1Q0/keGTFeZ6HDLKQGqiDdZ4FrIoNNsQf8nrd08lv/fRHVc
 Q4uq1FUwzkT2QXRzhCKVb2VzrUF+R3iQHX4iyZsh9gh1CkFVUIMvqNix00dLjOrv3pWGUFp
 deJVN1ZXjNGfGhn5CFXTw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264218>

Test the parsing of literall IPV6 addresses more systematically:
- with and without brackets (e.g. ::1 [::1])
- with brackets and port number: (e.g. [::1]:22)
- with username (e.g. user@::1)
- with username and brackets:
  Because user@[::1] was not supported on older Git version,
  [user@::1] had to be used as a workaround.
  Test that user@::1 user@[::1] and [user@::1] all do the same.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t5601-clone.sh | 57 +++++++++++++++++++++++++++++++++++++++---------=
--------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index f901b8a..02b40b1 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -301,11 +301,17 @@ expect_ssh () {
 		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
 	' &&
 	{
-		case "$1" in
-		none)
+		case "$#" in
+		1)
 			;;
-		*)
+		2)
 			echo "ssh: $1 git-upload-pack '$2'"
+			;;
+		3)
+			echo "ssh: $1 $2 git-upload-pack '$3'"
+			;;
+		*)
+			echo "ssh: $1 $2 git-upload-pack '$3' $4"
 		esac
 	} >"$TRASH_DIRECTORY/ssh-expect" &&
 	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
@@ -336,7 +342,8 @@ counter=3D0
 test_clone_url () {
 	counter=3D$(($counter + 1))
 	test_might_fail git clone "$1" tmp$counter &&
-	expect_ssh "$2" "$3"
+	shift &&
+	expect_ssh "$@"
 }
=20
 test_expect_success !MINGW 'clone c:temp is ssl' '
@@ -359,7 +366,7 @@ done
 for repo in rep rep/home/project 123
 do
 	test_expect_success "clone [::1]:$repo" '
-		test_clone_url [::1]:$repo ::1 $repo
+		test_clone_url [::1]:$repo ::1 "$repo"
 	'
 done
 #home directory
@@ -400,24 +407,40 @@ test_expect_success 'clone ssh://host.xz:22/~repo=
' '
 '
=20
 #IPv6
-test_expect_success 'clone ssh://[::1]/home/user/repo' '
-	test_clone_url "ssh://[::1]/home/user/repo" "::1" "/home/user/repo"
-'
+for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
+do
+	ehost=3D$(echo $tuah | tr -d "[]")
+	test_expect_success "clone ssh://$tuah/home/user/repo" "
+	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
+	"
+done
=20
 #IPv6 from home directory
-test_expect_success 'clone ssh://[::1]/~repo' '
-	test_clone_url "ssh://[::1]/~repo" "::1" "~repo"
-'
+for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
+do
+	euah=3D$(echo $tuah | tr -d "[]")
+	test_expect_success "clone ssh://$tuah/~repo" "
+	  test_clone_url ssh://$tuah/~repo $euah '~repo'
+	"
+done
=20
 #IPv6 with port number
-test_expect_success 'clone ssh://[::1]:22/home/user/repo' '
-	test_clone_url "ssh://[::1]:22/home/user/repo" "-p 22 ::1" "/home/use=
r/repo"
-'
+for tuah in [::1] user@[::1] [user@::1]
+do
+	euah=3D$(echo $tuah | tr -d "[]")
+	test_expect_success "clone ssh://$tuah:22/home/user/repo" "
+	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/us=
er/repo
+	"
+done
=20
 #IPv6 from home directory with port number
-test_expect_success 'clone ssh://[::1]:22/~repo' '
-	test_clone_url "ssh://[::1]:22/~repo" "-p 22 ::1" "~repo"
-'
+for tuah in [::1] user@[::1] [user@::1]
+do
+	euah=3D$(echo $tuah | tr -d "[]")
+	test_expect_success "clone ssh://$tuah:22/~repo" "
+	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
+	"
+done
=20
 test_expect_success 'clone from a repository with two identical branch=
es' '
=20
--=20
2.2.0.rc1.790.ge19fcd2
