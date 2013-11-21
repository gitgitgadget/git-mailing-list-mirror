From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 07/10] connect.c: Corner case for IPv6
Date: Thu, 21 Nov 2013 21:41:10 +0100
Message-ID: <201311212141.10690.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:41:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb3x-0000mm-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab3KUUlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:41:18 -0500
Received: from mout.web.de ([212.227.15.4]:50909 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab3KUUlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:41:17 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MDP6H-1Vtjvy17D3-00GrJX for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:41:16 +0100
X-Provags-ID: V03:K0:pVYR5rwatgP7naF3yIXKy91nH5SbW766M5OKGqstdWPOPnKv8NJ
 /J2cKAHFAOqgAuj723+0x+iNWyxGefgSVOdpSWOg43DoYbD4j32pUvaCDUoylLutxYUhtwY
 vLpNNEgn1w98qUarExl0QxEwg9kkq82XnLptacq1tf9Qe+AspOnrm6LdxWkSF9pYM84JTNa
 Lknsvtr0FY29fLwdMiGyw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238148>

Commit faea9ccbadf75128 introduced "user-relative paths":
"ssh://host.xz/~junio/repo" is the same as "host.xz:~junio/repo".

Commit 356bece0a27258181 "Support [address] in URLs" introduced a regression:
When an URL like "[::1]:/~repo" is used, the replacement of "/~"
with "~" was enabled for IPv6 host names, and "[::1]:/~repo" is
converted into "[::1]:~repo".

Solution:
Don't use "if (url != hostname)", but look at the separator instead.
Rename the variable "c" into separator.
---
 connect.c             | 14 +++++++-------
 t/t5500-fetch-pack.sh | 16 ++++------------
 t/t5601-clone.sh      | 12 ++----------
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/connect.c b/connect.c
index 1b93b4d..0cb88b8 100644
--- a/connect.c
+++ b/connect.c
@@ -566,7 +566,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	char *url;
 	char *host, *path;
 	char *end;
-	int c;
+	int separator;
 	enum protocol protocol = PROTO_LOCAL;
 	int free_path = 0;
 	char *port = NULL;
@@ -581,10 +581,10 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 		*host = '\0';
 		protocol = get_protocol(url);
 		host += 3;
-		c = '/';
+		separator = '/';
 	} else {
 		host = url;
-		c = ':';
+		separator = ':';
 	}
 
 	/*
@@ -604,9 +604,9 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	} else
 		end = host;
 
-	path = strchr(end, c);
+	path = strchr(end, separator);
 	if (path && !has_dos_drive_prefix(end)) {
-		if (c == ':') {
+		if (separator == ':') {
 			if (host != url || path < strchrnul(host, '/')) {
 				protocol = PROTO_SSH;
 				*path++ = '\0';
@@ -623,7 +623,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	 * null-terminate hostname and point path to ~ for URL's like this:
 	 *    ssh://host.xz/~user/repo
 	 */
-	if (protocol != PROTO_LOCAL && host != url) {
+	if (protocol != PROTO_LOCAL && separator == '/') {
 		char *ptr = path;
 		if (path[1] == '~')
 			path++;
@@ -638,7 +638,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	/*
 	 * Add support for ssh port: ssh://host.xy:<port>/...
 	 */
-	if (protocol == PROTO_SSH && host != url)
+	if (protocol == PROTO_SSH && separator == '/')
 		port = get_port(end);
 
 	*ret_host = xstrdup(host);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 7f55b95..ac5b08b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -604,19 +604,11 @@ do
 		test_expect_success "fetch-pack --diag-url $h:$r" '
 			check_prot_path $h:$r $p "$r"
 		'
+		# No "/~" -> "~" conversion
+		test_expect_success "fetch-pack --diag-url $h:/~$r" '
+			check_prot_host_path $h:/~$r $p "$hh" "/~$r"
+		'
 	done
-	h=host
-	hh=host
-	# "/~" -> "~" conversion
-	test_expect_failure "fetch-pack --diag-url $h:/~$r" '
-		check_prot_host_path $h:/~$r $p "$hh" "~$r"
-	'
-	h=[::1]
-	hh=$(echo $h | tr -d "[]")
-	# "/~" -> "~" conversion
-	test_expect_success "fetch-pack --diag-url $h:/~$r" '
-		check_prot_host_path $h:/~$r $p "$hh" "~$r"
-	'
 done
 
 test_expect_success MINGW 'fetch-pack --diag-url file://c:/repo' '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index ba99972..57234c0 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -356,15 +356,7 @@ do
 done
 
 #ipv6
-# failing
-for repo in /~proj
-do
-	test_expect_failure "clone [::1]:$repo" '
-		test_clone_url [::1]:$repo ::1 $repo
-	'
-done
-
-for repo in rep rep/home/project 123
+for repo in rep rep/home/project 123 /~proj
 do
 	test_expect_success "clone [::1]:$repo" '
 		test_clone_url [::1]:$repo ::1 $repo
@@ -373,7 +365,7 @@ done
 
 # Corner cases
 # failing
-for repo in [foo]bar/baz:qux [foo/bar]:baz
+for url in [foo]bar/baz:qux [foo/bar]:baz
 do
 	test_expect_failure "clone $url is not ssh" '
 		test_clone_url $url none
-- 
1.8.4.457.g424cb08
