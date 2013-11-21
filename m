From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 10/10] git fetch: support host:/~repo
Date: Thu, 21 Nov 2013 21:42:10 +0100
Message-ID: <201311212142.11216.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:42:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb4w-0001KP-0c
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418Ab3KUUmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:42:18 -0500
Received: from mout.web.de ([212.227.15.4]:64591 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339Ab3KUUmS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:42:18 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MKrU4-1Vjb4q02fA-00034G for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:42:16 +0100
X-Provags-ID: V03:K0:RZXprmfeLcFu6jiIM+ORYPQwzAIM/l9YslWCQi2vAKGnDsLo+hz
 4sEPy0txCLZYi+uWMoiagRgbDhOEfgfFRhAb+e8rYDE1bc3IuPG+MnJUd2dn4Vq94J6jjhW
 femUjjz66iLxieuUbGgMBCnNc3RXhDWgfoofHgotKLv9iLqmK95LEHeBTmNvbDsFzTYy3/O
 BoiICTNal31IeR/6Xa5nw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238152>

Since commit faea9ccb URLs host:~repo or ssh://host:/~repo
reach the home directory.
In 356bece0 support for [] was introduced, and as a side
effect, [host]:/~repo was the same as [host]:~repo.
The side effect was removed in c01049ae, "connect.c: Corner case for IPv6".

Re-reading the documentation (in urls.txt) we find that
"ssh://host:/~repo",
"host:/~repo" or
"host:~repo"
specifiy the repository "repo" in the home directory at "host".

So make the handling of "host:/~repo" (or "[host]:/~repo") a feature,
and revert the possible regression introduced in c01049ae.
---
 connect.c             |  3 +--
 t/t5500-fetch-pack.sh |  4 ++--
 t/t5601-clone.sh      | 12 ++++++++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 95568ac..2cad296 100644
--- a/connect.c
+++ b/connect.c
@@ -625,8 +625,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	end = path; /* Need to \0 terminate host here */
 	if (separator == ':')
 		path++; /* path starts after ':' */
-	if ((protocol == PROTO_GIT) ||
-			(protocol == PROTO_SSH && separator == '/')) {
+	if (protocol == PROTO_GIT || protocol == PROTO_SSH) {
 		if (path[1] == '~')
 			path++;
 	}
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 69a2110..7d9f18c 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -601,9 +601,9 @@ do
 		test_expect_success "fetch-pack --diag-url $h:$r" '
 			check_prot_path $h:$r $p "$r"
 		'
-		# No "/~" -> "~" conversion
+		# Do the "/~" -> "~" conversion
 		test_expect_success "fetch-pack --diag-url $h:/~$r" '
-			check_prot_host_path $h:/~$r $p "$h" "/~$r"
+			check_prot_host_path $h:/~$r $p "$h" "~$r"
 		'
 	done
 done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index bd1bfd3..62fbd7e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -348,7 +348,7 @@ test_expect_success MINGW 'clone c:temp is dos drive' '
 '
 
 #ip v4
-for repo in rep rep/home/project /~proj 123
+for repo in rep rep/home/project 123
 do
 	test_expect_success "clone host:$repo" '
 		test_clone_url host:$repo host $repo
@@ -356,12 +356,20 @@ do
 done
 
 #ipv6
-for repo in rep rep/home/project 123 /~proj
+for repo in rep rep/home/project 123
 do
 	test_expect_success "clone [::1]:$repo" '
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
 
 # Corner cases
 for url in foo/bar:baz [foo]bar/baz:qux [foo/bar]:baz
-- 
1.8.4.457.g424cb08
