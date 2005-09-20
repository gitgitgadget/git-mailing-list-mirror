From: Linus Torvalds <torvalds@osdl.org>
Subject: Teach "git-rev-parse" about date-based cut-offs
Date: Tue, 20 Sep 2005 14:13:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509201406190.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Sep 20 23:15:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHpQl-0007s3-RU
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 23:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVITVNd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 17:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVITVNd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 17:13:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965115AbVITVNc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 17:13:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8KLDQBo014609
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 14:13:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8KLDPSs006523;
	Tue, 20 Sep 2005 14:13:25 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9022>


This adds the options "--since=date" and "--before=date" to git-rev-parse, 
which knows how to translate them into seconds since the epoch for 
git-rev-list.

With this, you can do

	git log --since="2 weeks ago"

or

	git log --until=yesterday

to show the commits that have happened in the last two weeks or are 
older than 24 hours, respectively.

The flags "--after=" and "--before" are synonyms for --since and --until, 
and you can combine them, so

	git log --after="Aug 5" --before="Aug 10"

is a valid (but strange) thing to do. 

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "refs.h"
+#include "quote.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -125,6 +126,30 @@ static int show_reference(const char *re
 	return 0;
 }
 
+static void show_datestring(const char *flag, const char *datestr)
+{
+	FILE *date;
+	static char buffer[100];
+	static char cmd[1000];
+	int len;
+
+	/* date handling requires both flags and revs */
+	if ((filter & (DO_FLAGS | DO_REVS)) != (DO_FLAGS | DO_REVS))
+		return;
+	len = strlen(flag);
+	memcpy(buffer, flag, len);
+
+	snprintf(cmd, sizeof(cmd), "date --date=%s +%%s", sq_quote(datestr));
+	date = popen(cmd, "r");
+	if (!date || !fgets(buffer + len, sizeof(buffer) - len, date))
+		die("git-rev-list: bad date string");
+	pclose(date);
+	len = strlen(buffer);
+	if (buffer[len-1] == '\n')
+		buffer[--len] = 0;
+	show(buffer);
+}
+
 int main(int argc, char **argv)
 {
 	int i, as_is = 0, verify = 0;
@@ -207,6 +232,22 @@ int main(int argc, char **argv)
 				printf("%s/.git\n", cwd);
 				continue;
 			}
+			if (!strncmp(arg, "--since=", 8)) {
+				show_datestring("--max-age=", arg+8);
+				continue;
+			}
+			if (!strncmp(arg, "--after=", 8)) {
+				show_datestring("--max-age=", arg+8);
+				continue;
+			}
+			if (!strncmp(arg, "--before=", 9)) {
+				show_datestring("--min-age=", arg+9);
+				continue;
+			}
+			if (!strncmp(arg, "--until=", 8)) {
+				show_datestring("--min-age=", arg+8);
+				continue;
+			}
 			if (verify)
 				die("Needed a single revision");
 			show_flag(arg);
