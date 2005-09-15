From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] rsh.c env and quoting cleanup, take 2
Date: Thu, 15 Sep 2005 12:33:14 -0700
Message-ID: <4329CC7A.8010203@zytor.com>
References: <43290BB8.90501@zytor.com> <7vy85yahjk.fsf@assigned-by-dhcp.cox.net> <4329C11A.1040302@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090300020802050309040406"
X-From: git-owner@vger.kernel.org Thu Sep 15 21:34:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzU8-000648-Mc
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbVIOTd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbVIOTd0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:33:26 -0400
Received: from terminus.zytor.com ([209.128.68.124]:51422 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965272AbVIOTdZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 15:33:25 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8FJXIeG013391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Sep 2005 12:33:19 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <4329C11A.1040302@zytor.com>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8631>

This is a multi-part message in MIME format.
--------------090300020802050309040406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch does proper quoting, and uses "env" to be compatible with 
tcsh.  As a side benefit, I believe the code is a lot cleaner to read.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------090300020802050309040406
Content-Type: text/x-patch;
 name="rsh-quoting-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rsh-quoting-fix.patch"

Use env and proper quoting for all command arguments.

---
commit 11a45ccbd6daee37193934a5863ed29a0fe91ec3
tree 23cd21abe0209ced9cd6f1f5c501546e662bc941
parent 19397b4521bcc27eb224413fb71519223b94290f
author Peter Anvin <hpa@tazenda.sc.orionmulti.com> Thu, 15 Sep 2005 12:30:36 -0700
committer Peter Anvin <hpa@tazenda.sc.orionmulti.com> Thu, 15 Sep 2005 12:30:36 -0700

 rsh.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/rsh.c b/rsh.c
--- a/rsh.c
+++ b/rsh.c
@@ -8,6 +8,71 @@
 
 #define COMMAND_SIZE 4096
 
+/*
+ * Write a shell-quoted version of a string into a buffer, and
+ * return bytes that ought to be output excluding final null.
+ */
+static int shell_quote(char *buf, int nmax, const char *str)
+{
+	char ch;
+	int nq;
+	int oc = 0;
+
+	while ( (ch = *str++) ) {
+		nq = 0;
+		if ( strchr(" !\"#$%&\'()*;<=>?[\\]^`{|}", ch) )
+			nq = 1;
+
+		if ( nq ) {
+			if ( nmax > 1 ) {
+				*buf++ = '\\';
+				nmax--;
+			}
+			oc++;
+		}
+
+		if ( nmax > 1 ) {
+			*buf++ = ch;
+			nmax--;
+		}
+		oc++;
+	}
+
+	if ( nmax )
+		*buf = '\0';
+
+	return oc;
+}
+			
+/*
+ * Append a string to a string buffer, with or without quoting.  Return true
+ * if the buffer overflowed.
+ */
+static int add_to_string(char **ptrp, int *sizep, const char *str, int quote)
+{
+	char *p = *ptrp;
+	int size = *sizep;
+	int oc;
+
+	if ( quote ) {
+		oc = shell_quote(p, size, str);
+	} else {
+		oc = strlen(str);
+		memcpy(p, str, (oc >= size) ? size-1 : oc);
+	}
+
+	if ( oc >= size ) {
+		p[size-1] = '\0';
+		*ptrp += size-1;
+		*sizep = 1;
+		return 1;	/* Overflow, string unusable */
+	}
+
+	*ptrp  += oc;
+	*sizep -= oc;
+	return 0;
+}
+
 int setup_connection(int *fd_in, int *fd_out, const char *remote_prog, 
 		     char *url, int rmt_argc, char **rmt_argv)
 {
@@ -16,6 +81,8 @@ int setup_connection(int *fd_in, int *fd
 	int sv[2];
 	char command[COMMAND_SIZE];
 	char *posn;
+	int sizen;
+	int of;
 	int i;
 
 	if (!strcmp(url, "-")) {
@@ -37,24 +104,30 @@ int setup_connection(int *fd_in, int *fd
 	if (!path) {
 		return error("Bad URL: %s", url);
 	}
-	/* ssh <host> 'cd <path>; stdio-pull <arg...> <commit-id>' */
-	snprintf(command, COMMAND_SIZE, 
-		 "%s='%s' %s",
-		 GIT_DIR_ENVIRONMENT, path, remote_prog);
-	*path = '\0';
-	posn = command + strlen(command);
-	for (i = 0; i < rmt_argc; i++) {
-		*(posn++) = ' ';
-		strncpy(posn, rmt_argv[i], COMMAND_SIZE - (posn - command));
-		posn += strlen(rmt_argv[i]);
-		if (posn - command + 4 >= COMMAND_SIZE) {
-			return error("Command line too long");
-		}
+	/* $GIT_RSH <host> "env GIR_DIR=<path> <remote_prog> <args...>" */
+	sizen = COMMAND_SIZE;
+	posn = command;
+	of = 0;
+	of |= add_to_string(&posn, &sizen, "env ", 0);
+	of |= add_to_string(&posn, &sizen, GIT_DIR_ENVIRONMENT, 0);
+	of |= add_to_string(&posn, &sizen, "=", 0);
+	of |= add_to_string(&posn, &sizen, path, 1);
+	of |= add_to_string(&posn, &sizen, " ", 0);
+	of |= add_to_string(&posn, &sizen, remote_prog, 1);
+
+	for ( i = 0 ; i < rmt_argc ; i++ ) {
+		of |= add_to_string(&posn, &sizen, " ", 0);
+		of |= add_to_string(&posn, &sizen, rmt_argv[i], 1);
 	}
-	strcpy(posn, " -");
-	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv)) {
+
+	of |= add_to_string(&posn, &sizen, " -", 0);
+
+	if ( of )
+		return error("Command line too long");
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv))
 		return error("Couldn't create socket");
-	}
+
 	if (!fork()) {
 		const char *ssh, *ssh_basename;
 		ssh = getenv("GIT_SSH");

--------------090300020802050309040406--
