From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] rev-parse: better error message for ambiguous arguments
Date: Tue, 25 Apr 2006 10:00:03 +1000
Message-ID: <17485.26243.520304.408507@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Apr 25 02:00:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYAyW-0005Bc-86
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 02:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWDYAAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 20:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWDYAAM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 20:00:12 -0400
Received: from ozlabs.org ([203.10.76.45]:50084 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932136AbWDYAAL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 20:00:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5CD24679FF; Tue, 25 Apr 2006 10:00:10 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19118>

Currently, if git-rev-parse encounters an argument that is neither a
recognizable revision name nor the name of an existing file or
directory, and it hasn't encountered a "--" argument, it prints an
error message saying "No such file or directory".  This can be
confusing for users, including users of programs such as gitk that
use git-rev-parse, who may then think that they can't ask about the
history of files that no longer exist.

This makes it print a better error message, one that points out the
ambiguity and tells the user what to do to fix it.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/rev-parse.c b/rev-parse.c
index e956cd5..7f66ae2 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -160,6 +160,14 @@ static int show_file(const char *arg)
 	return 0;
 }
 
+static void die_badfile(const char *arg)
+{
+	if (errno != ENOENT)
+		die("'%s': %s", arg, strerror(errno));
+	die("'%s' is ambiguous - revision name or file/directory name?\n"
+	    "Please put '--' before the list of filenames.", arg);
+}
+
 int main(int argc, char **argv)
 {
 	int i, as_is = 0, verify = 0;
@@ -176,7 +184,7 @@ int main(int argc, char **argv)
 		if (as_is) {
 			if (show_file(arg) && as_is < 2)
 				if (lstat(arg, &st) < 0)
-					die("'%s': %s", arg, strerror(errno));
+					die_badfile(arg);
 			continue;
 		}
 		if (!strcmp(arg,"-n")) {
@@ -343,7 +351,7 @@ int main(int argc, char **argv)
 		if (verify)
 			die("Needed a single revision");
 		if (lstat(arg, &st) < 0)
-			die("'%s': %s", arg, strerror(errno));
+			die_badfile(arg);
 	}
 	show_default();
 	if (verify && revs_count != 1)
