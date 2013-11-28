From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 02/10] t5601: Add tests for ssh
Date: Thu, 28 Nov 2013 20:48:22 +0100
Message-ID: <201311282048.23226.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:48:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7Zs-0002GO-2R
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759391Ab3K1Tsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:48:40 -0500
Received: from mout.web.de ([212.227.15.4]:63445 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759364Ab3K1Tsj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:48:39 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MZlZK-1W4K9T2QnO-00La9M for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:48:37 +0100
X-Provags-ID: V03:K0:WF2PnThQsLl0pIYOYoRbh6DaAA2y2sV+KFCly03vwR11FuJ8YJf
 qbLPyp7exDKqkwHEXBdDfE+FzbqVjzSkbrXZq1ihsXsuvCWIOzMyR0glY/R1yJ+v6jvN6Jl
 ept1CSES4Fd/+GbDF+qKFiaxcYaw12RZaY5a6QeZ7xCvSI3gfcrX1N88olF0qTmoqY/CDA5
 Un3o34e7WDqjfNZsJGtNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238504>

Add more tests testing all the combinations:
 -IPv4 or IPv6
 -path starting with "/" or with "/~"
 -with and without the ssh:// scheme

Some test fail, they need updates in connect.c

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t5601-clone.sh | 100 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index c634f77..ba99972 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -313,7 +313,7 @@ expect_ssh () {
=20
 setup_ssh_wrapper
=20
-test_expect_success 'cloning myhost:src uses ssh' '
+test_expect_success 'clone myhost:src uses ssh' '
 	git clone myhost:src ssh-clone &&
 	expect_ssh myhost src
 '
@@ -329,6 +329,104 @@ test_expect_success 'bracketed hostnames are stil=
l ssh' '
 	expect_ssh myhost:123 src
 '
=20
+counter=3D0
+# $1 url
+# $2 none|host
+# $3 path
+test_clone_url () {
+	counter=3D$(($counter + 1))
+	test_might_fail git clone "$1" tmp$counter &&
+	expect_ssh "$2" "$3"
+}
+
+test_expect_success NOT_MINGW 'clone c:temp is ssl' '
+	test_clone_url c:temp c temp
+'
+
+test_expect_success MINGW 'clone c:temp is dos drive' '
+	test_clone_url c:temp none
+'
+
+#ip v4
+for repo in rep rep/home/project /~proj 123
+do
+	test_expect_success "clone host:$repo" '
+		test_clone_url host:$repo host $repo
+	'
+done
+
+#ipv6
+# failing
+for repo in /~proj
+do
+	test_expect_failure "clone [::1]:$repo" '
+		test_clone_url [::1]:$repo ::1 $repo
+	'
+done
+
+for repo in rep rep/home/project 123
+do
+	test_expect_success "clone [::1]:$repo" '
+		test_clone_url [::1]:$repo ::1 $repo
+	'
+done
+
+# Corner cases
+# failing
+for repo in [foo]bar/baz:qux [foo/bar]:baz
+do
+	test_expect_failure "clone $url is not ssh" '
+		test_clone_url $url none
+	'
+done
+
+for url in foo/bar:baz
+do
+	test_expect_success "clone $url is not ssh" '
+		test_clone_url $url none
+	'
+done
+
+#with ssh:// scheme
+test_expect_success 'clone ssh://host.xz/home/user/repo' '
+	test_clone_url "ssh://host.xz/home/user/repo" host.xz "/home/user/rep=
o"
+'
+
+# from home directory
+test_expect_success 'clone ssh://host.xz/~repo' '
+	test_clone_url "ssh://host.xz/~repo" host.xz "~repo"
+'
+
+# with port number
+test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
+	test_clone_url "ssh://host.xz:22/home/user/repo" "-p 22 host.xz" "/ho=
me/user/repo"
+'
+
+# from home directory with port number
+test_expect_success 'clone ssh://host.xz:22/~repo' '
+	test_clone_url "ssh://host.xz:22/~repo" "-p 22 host.xz" "~repo"
+'
+
+#IPv6
+test_expect_success 'clone ssh://[::1]/home/user/repo' '
+	test_clone_url "ssh://[::1]/home/user/repo" "::1" "/home/user/repo"
+'
+
+#IPv6 from home directory
+test_expect_success 'clone ssh://[::1]/~repo' '
+	test_clone_url "ssh://[::1]/~repo" "::1" "~repo"
+'
+
+#IPv6 with port number
+test_expect_success 'clone ssh://[::1]:22/home/user/repo' '
+	test_clone_url "ssh://[::1]:22/home/user/repo" "-p 22 ::1" "/home/use=
r/repo"
+'
+
+#IPv6 from home directory with port number
+test_expect_success 'clone ssh://[::1]:22/~repo' '
+	test_clone_url "ssh://[::1]:22/~repo" "-p 22 ::1" "~repo"
+'
+
 test_expect_success 'clone from a repository with two identical branch=
es' '
=20
 	(
--=20
1.8.5.rc0.23.gaa27064
