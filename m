From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] git-daemon: timeout, eliminate double DWIM
Date: Wed, 19 Oct 2005 11:54:34 -0700
Message-ID: <4356966A.8010401@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020702080209070000010203"
X-From: git-owner@vger.kernel.org Wed Oct 19 20:55:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESJ5a-0004vh-DY
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 20:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVJSSyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 14:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJSSyt
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 14:54:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30912 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751219AbVJSSys
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 14:54:48 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9JIsdrh029251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 11:54:40 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10297>

This is a multi-part message in MIME format.
--------------020702080209070000010203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It turns out that not only did git-daemon do DWIM, but git-upload-pack 
does as well.  This is bad; security checks have to be performed *after* 
canonicalization, not before.

Additionally, the current git-daemon can be trivially DoSed by spewing 
SYNs at the target port.

This patch adds a --strict option to git-upload-pack to disable all 
DWIM, a --timeout option to git-daemon and git-upload-pack, and an 
--init-timeout option to git-daemon (which is typically set to a much 
lower value, since the initial request should come immediately from the 
client.)

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------020702080209070000010203
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -13,7 +13,9 @@
 static int log_syslog;
 static int verbose;
 
-static const char daemon_usage[] = "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all] [directory...]";
+static const char daemon_usage[] =
+"git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
+"           [--timeout=n] [--init-timeout=n] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
@@ -21,6 +23,9 @@ static char **ok_paths = NULL;
 /* If this is set, git-daemon-export-ok is not required */
 static int export_all_trees = 0;
 
+/* Timeout, and initial timeout */
+static unsigned int timeout = 0;
+static unsigned int init_timeout = 0;
 
 static void logreport(int priority, const char *err, va_list params)
 {
@@ -170,6 +175,8 @@ static int upload(char *dir)
 	/* Enough for the longest path above including final null */
 	int buflen = strlen(dir)+10;
 	char *dirbuf = xmalloc(buflen);
+	/* Timeout as string */
+	char timeout_buf[64];
 
 	loginfo("Request for '%s'", dir);
 
@@ -190,8 +197,10 @@ static int upload(char *dir)
 	 */
 	signal(SIGTERM, SIG_IGN);
 
+	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
+
 	/* git-upload-pack only ever reads stuff, so this is safe */
-	execlp("git-upload-pack", "git-upload-pack", ".", NULL);
+	execlp("git-upload-pack", "git-upload-pack", "--strict", timeout_buf, ".", NULL);
 	return -1;
 }
 
@@ -200,7 +209,9 @@ static int execute(void)
 	static char line[1000];
 	int len;
 
+	alarm(init_timeout ? init_timeout : timeout);
 	len = packet_read_line(0, line, sizeof(line));
+	alarm(0);
 
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
@@ -598,6 +609,12 @@ int main(int argc, char **argv)
 			export_all_trees = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--timeout=")) {
+			timeout = atoi(arg+10);
+		}
+		if (!strncmp(arg, "--init-timeout=")) {
+			init_timeout = atoi(arg+15);
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
diff --git a/upload-pack.c b/upload-pack.c
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -4,13 +4,19 @@
 #include "tag.h"
 #include "object.h"
 
-static const char upload_pack_usage[] = "git-upload-pack <dir>";
+static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
-#define MAX_HAS (16)
-#define MAX_NEEDS (256)
+#define MAX_HAS 64
+#define MAX_NEEDS 4096
 static int nr_has = 0, nr_needs = 0;
 static unsigned char has_sha1[MAX_HAS][20];
 static unsigned char needs_sha1[MAX_NEEDS][20];
+static unsigned int timeout = 0;
+
+static void reset_timeout(void)
+{
+	alarm(timeout);
+}
 
 static int strip(char *line, int len)
 {
@@ -100,6 +106,7 @@ static int get_common_commits(void)
 
 	for(;;) {
 		len = packet_read_line(0, line, sizeof(line));
+		reset_timeout();
 
 		if (!len) {
 			packet_write(1, "NAK\n");
@@ -122,6 +129,7 @@ static int get_common_commits(void)
 
 	for (;;) {
 		len = packet_read_line(0, line, sizeof(line));
+		reset_timeout();
 		if (!len)
 			continue;
 		len = strip(line, len);
@@ -145,6 +153,7 @@ static int receive_needs(void)
 	for (;;) {
 		unsigned char dummy[20], *sha1_buf;
 		len = packet_read_line(0, line, sizeof(line));
+		reset_timeout();
 		if (!len)
 			return needs;
 
@@ -179,6 +188,7 @@ static int send_ref(const char *refname,
 
 static int upload_pack(void)
 {
+	reset_timeout();
 	head_ref(send_ref);
 	for_each_ref(send_ref);
 	packet_flush(1);
@@ -193,18 +203,43 @@ static int upload_pack(void)
 int main(int argc, char **argv)
 {
 	const char *dir;
-	if (argc != 2)
+	int i;
+	int strict = 0;
+
+	for (i = 1; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (arg[0] != '-')
+			break;
+		if (!strcmp(arg, "--strict")) {
+			strict = 1;
+			continue;
+		}
+		if (!strncmp(arg, "--timeout=")) {
+			timeout = atoi(arg+10);
+			continue;
+		}
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+	}
+	
+	if (i != argc-1)
 		usage(upload_pack_usage);
-	dir = argv[1];
+	dir = argv[i];
 
 	/* chdir to the directory. If that fails, try appending ".git" */
 	if (chdir(dir) < 0) {
-		if (chdir(mkpath("%s.git", dir)) < 0)
+		if (strict || chdir(mkpath("%s.git", dir)) < 0)
 			die("git-upload-pack unable to chdir to %s", dir);
 	}
-	chdir(".git");
+	if (!strict)
+		chdir(".git");
+
 	if (access("objects", X_OK) || access("refs", X_OK))
 		die("git-upload-pack: %s doesn't seem to be a git archive", dir);
+
 	putenv("GIT_DIR=.");
 	upload_pack();
 	return 0;

--------------020702080209070000010203--
