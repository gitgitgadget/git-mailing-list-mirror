From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/8] vcs-svn: make test-line-buffer input format more flexible
Date: Sun, 2 Jan 2011 18:50:16 -0600
Message-ID: <20110103005016.GB30506@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 01:50:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZYd3-0002rC-MI
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 01:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611Ab1ACAuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 19:50:25 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53209 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1ACAuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 19:50:24 -0500
Received: by gyb11 with SMTP id 11so5037718gyb.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 16:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3ipK9jeAmEJ4b1QpbiGRCAJF5Rl/mVaNohfjpuxSNyM=;
        b=Os7z/d/WQ36W8cG1noYR6Riomk58WJ3gPdUl5yTZd0PUMONX4SJrlZuj2v5AqzD6f9
         CRO9JemCibePrOTiF77c8DGWmWha5muUiEVMU5yA7bWREIvwrhcjMv2Hh1HxBG4XPfmQ
         geaKz1yrIOIRjnJ2KqxG4fZ1BQ+bcN2OX5vSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TZtgIDR96ozncHqebxJSCgxJqTWm6mfrBdaxF7kxdzEqPDNS+ZF3bRMXKQZEmupgBa
         ajhCEIAFOr0PchN1mSczVxuzOEzlKZDVEsu3JC4KLN2dRI8z4Qko2JTXZcV7KkfpXYmr
         r+JD8oPtXSkQ90w1SVVjcksvQ2FB+eXKW8Mlk=
Received: by 10.236.102.166 with SMTP id d26mr2206031yhg.34.1294015824046;
        Sun, 02 Jan 2011 16:50:24 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id g27sm11836637yhd.13.2011.01.02.16.50.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 16:50:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103004900.GA30506@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164431>

Imitate the input format of test-obj-pool to support arbitrary
sequences of commands rather than alternating read/copy.  This should
make it easier to add tests that exercise other line_buffer functions.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0080-vcs-svn.sh |   18 ++++++++--------
 test-line-buffer.c |   56 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
index d3225ad..8be9700 100755
--- a/t/t0080-vcs-svn.sh
+++ b/t/t0080-vcs-svn.sh
@@ -85,40 +85,40 @@ test_expect_success 'line buffer' '
 	printf "%s\n" "" foo >expected6 &&
 
 	test-line-buffer <<-\EOF >actual1 &&
-	5
+	read 5
 	HELLO
 	EOF
 
 	test-line-buffer <<-\EOF >actual2 &&
-	0
+	read 0
 
-	5
+	copy 5
 	HELLO
 	EOF
 
 	q_to_nul <<-\EOF |
-	1
+	read 1
 	Q
 	EOF
 	test-line-buffer >actual3 &&
 
 	q_to_nul <<-\EOF |
-	0
+	read 0
 
-	1
+	copy 1
 	Q
 	EOF
 	test-line-buffer >actual4 &&
 
 	test-line-buffer <<-\EOF >actual5 &&
-	5
+	read 5
 	foo
 	EOF
 
 	test-line-buffer <<-\EOF >actual6 &&
-	0
+	read 0
 
-	5
+	copy 5
 	foo
 	EOF
 
diff --git a/test-line-buffer.c b/test-line-buffer.c
index f9af892..383f35b 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -1,11 +1,5 @@
 /*
  * test-line-buffer.c: code to exercise the svn importer's input helper
- *
- * Input format:
- *	number NL
- *	(number bytes) NL
- *	number NL
- *	...
  */
 
 #include "git-compat-util.h"
@@ -20,28 +14,50 @@ static uint32_t strtouint32(const char *s)
 	return (uint32_t) n;
 }
 
+static void handle_command(const char *command, const char *arg, struct line_buffer *buf)
+{
+	switch (*command) {
+	case 'c':
+		if (!prefixcmp(command, "copy ")) {
+			buffer_copy_bytes(buf, strtouint32(arg) + 1);
+			return;
+		}
+	case 'r':
+		if (!prefixcmp(command, "read ")) {
+			const char *s = buffer_read_string(buf, strtouint32(arg));
+			printf("%s\n", s);
+			buffer_skip_bytes(buf, 1);	/* consume newline */
+			return;
+		}
+	default:
+		die("unrecognized command: %s", command);
+	}
+}
+
+static void handle_line(const char *line, struct line_buffer *stdin_buf)
+{
+	const char *arg = strchr(line, ' ');
+	if (!arg)
+		die("no argument in line: %s", line);
+	handle_command(line, arg + 1, stdin_buf);
+}
+
 int main(int argc, char *argv[])
 {
-	struct line_buffer buf = LINE_BUFFER_INIT;
+	struct line_buffer stdin_buf = LINE_BUFFER_INIT;
 	char *s;
 
 	if (argc != 1)
-		usage("test-line-buffer < input.txt");
-	if (buffer_init(&buf, NULL))
+		usage("test-line-buffer < script");
+
+	if (buffer_init(&stdin_buf, NULL))
 		die_errno("open error");
-	while ((s = buffer_read_line(&buf))) {
-		s = buffer_read_string(&buf, strtouint32(s));
-		fputs(s, stdout);
-		fputc('\n', stdout);
-		buffer_skip_bytes(&buf, 1);
-		if (!(s = buffer_read_line(&buf)))
-			break;
-		buffer_copy_bytes(&buf, strtouint32(s) + 1);
-	}
-	if (buffer_deinit(&buf))
+	while ((s = buffer_read_line(&stdin_buf)))
+		handle_line(s, &stdin_buf);
+	if (buffer_deinit(&stdin_buf))
 		die("input error");
 	if (ferror(stdout))
 		die("output error");
-	buffer_reset(&buf);
+	buffer_reset(&stdin_buf);
 	return 0;
 }
-- 
1.7.4.rc0.580.g89dc.dirty
