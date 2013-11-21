From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 02/10] t5601: Add tests for ssh
Date: Thu, 21 Nov 2013 21:39:39 +0100
Message-ID: <201311212139.39942.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:39:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb2V-0008JA-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876Ab3KUUjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:39:47 -0500
Received: from mout.web.de ([212.227.15.4]:61200 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab3KUUjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:39:47 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MAMli-1VpbKN2pYo-00BdJx for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:39:45 +0100
X-Provags-ID: V03:K0:GuCCY6chK33u1OwZRPMOxCMXGlGVIWZfGb3aGWM72ZB+EudOhZW
 UkHjDofKLqmO4c+kLzRL7LYKkfti7WsZSYlIBUJ/8FNRzCbQ4wwiQ4+Qc2O0W0ujXUejDnz
 G4f+9fhfYhe4H95D4Z5Tjc9Bi7AKmtplP39RBqBzTOCVTWISNGygZjhu3k6K5l/shWMXXgZ
 3TOIlUUtdJfSIOiDa2+vw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238143>

Add more tests testing all the combinations:
 -IPv4 or IPv6
 -path starting with "/" or with "/~"
 -with and without the ssh:// scheme

Some test fail, they need updates in connect.c
---
 t/t5601-clone.sh | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 83b21f5..ba99972 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -298,7 +298,7 @@ setup_ssh_wrapper () {
 
 expect_ssh () {
 	test_when_finished '
-	  (cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
+		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
 	' &&
 	{
 		case "$1" in
@@ -313,7 +313,7 @@ expect_ssh () {
 
 setup_ssh_wrapper
 
-test_expect_success 'cloning myhost:src uses ssh' '
+test_expect_success 'clone myhost:src uses ssh' '
 	git clone myhost:src ssh-clone &&
 	expect_ssh myhost src
 '
@@ -329,6 +329,104 @@ test_expect_success 'bracketed hostnames are still ssh' '
 	expect_ssh myhost:123 src
 '
 
+counter=0
+# $1 url
+# $2 none|host
+# $3 path
+test_clone_url () {
+	counter=$(($counter + 1))
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
+	test_clone_url "ssh://host.xz/home/user/repo" host.xz "/home/user/repo"
+'
+
+# from home directory
+test_expect_success 'clone ssh://host.xz/~repo' '
+	test_clone_url "ssh://host.xz/~repo" host.xz "~repo"
+'
+
+# with port number
+test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
+	test_clone_url "ssh://host.xz:22/home/user/repo" "-p 22 host.xz" "/home/user/repo"
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
+	test_clone_url "ssh://[::1]:22/home/user/repo" "-p 22 ::1" "/home/user/repo"
+'
+
+#IPv6 from home directory with port number
+test_expect_success 'clone ssh://[::1]:22/~repo' '
+	test_clone_url "ssh://[::1]:22/~repo" "-p 22 ::1" "~repo"
+'
+
 test_expect_success 'clone from a repository with two identical branches' '
 
 	(
-- 
1.8.4.457.g424cb08
