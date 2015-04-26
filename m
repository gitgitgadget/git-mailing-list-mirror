From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 3/3] connect: improve check for plink to reduce false positives
Date: Sun, 26 Apr 2015 20:30:12 +0000
Message-ID: <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 22:30:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmTCD-000729-9d
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 22:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbbDZUa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 16:30:26 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48892 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788AbbDZUaX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 16:30:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7711E282A8;
	Sun, 26 Apr 2015 20:30:21 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267837>

The git_connect function has code to handle plink and tortoiseplink
specially, as they require different command line arguments from
OpenSSH (-P instead of -p for ports; tortoiseplink additionally requires
-batch).  However, the match was done by checking for "plink" anywhere
in the string, which led to a GIT_SSH value containing "uplink" being
treated as an invocation of putty's plink.

Improve the check by looking for "plink" or "tortoiseplink" (or those
names suffixed with ".exe") only in the final component of the path.
This has the downside that a program such as "plink-0.63" would no
longer be recognized, but the increased robustness is likely worth it.
Add tests to cover these cases to avoid regressions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c        | 18 +++++++++++++++---
 t/t5601-clone.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 749a07b..c0144d8 100644
--- a/connect.c
+++ b/connect.c
@@ -724,7 +724,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
-			int putty;
+			int putty, tortoiseplink = 0;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			get_host_and_port(&ssh_host, &port);
@@ -750,14 +750,26 @@ struct child_process *git_connect(int fd[2], const char *url,
 				conn->use_shell = 1;
 				putty = 0;
 			} else {
+				const char *base;
+				char *ssh_dup;
+
 				ssh = getenv("GIT_SSH");
 				if (!ssh)
 					ssh = "ssh";
-				putty = !!strcasestr(ssh, "plink");
+
+				ssh_dup = xstrdup(ssh);
+				base = basename(ssh_dup);
+
+				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
+					!strcasecmp(base, "tortoiseplink.exe");
+				putty = !strcasecmp(base, "plink") ||
+					!strcasecmp(base, "plink.exe") || tortoiseplink;
+
+				free(ssh_dup);
 			}
 
 			argv_array_push(&conn->args, ssh);
-			if (putty && !strcasestr(ssh, "tortoiseplink"))
+			if (tortoiseplink)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
 				/* P is for PuTTY, p is for OpenSSH */
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index aae2324..bfdaf75 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -296,6 +296,12 @@ setup_ssh_wrapper () {
 	'
 }
 
+copy_ssh_wrapper_as () {
+	cp "$TRASH_DIRECTORY/ssh-wrapper" "$1" &&
+	GIT_SSH="$1" &&
+	export GIT_SSH
+}
+
 expect_ssh () {
 	test_when_finished '
 		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
@@ -335,6 +341,33 @@ test_expect_success 'bracketed hostnames are still ssh' '
 	expect_ssh "-p 123" myhost src
 '
 
+test_expect_success 'uplink is not treated as putty' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
+	git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
+	expect_ssh "-p 123" myhost src
+'
+
+test_expect_success 'plink is treated specially (as putty)' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
+	git clone "[myhost:123]:src" ssh-bracket-clone-plink-0 &&
+	expect_ssh "-P 123" myhost src
+'
+
+test_expect_success 'plink.exe is treated specially (as putty)' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
+	git clone "[myhost:123]:src" ssh-bracket-clone-plink-1 &&
+	expect_ssh "-P 123" myhost src
+'
+
+test_expect_success 'tortoiseplink is like putty, with extra arguments' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/tortoiseplink" &&
+	git clone "[myhost:123]:src" ssh-bracket-clone-plink-2 &&
+	expect_ssh "-batch -P 123" myhost src
+'
+
+# Reset the GIT_SSH environment variable for clone tests.
+setup_ssh_wrapper
+
 counter=0
 # $1 url
 # $2 none|host
-- 
2.3.5
