From: Eric Wong <e@80x24.org>
Subject: [PATCH 2/3] mailsplit: support unescaping mboxrd messages
Date: Mon, 30 May 2016 23:21:41 +0000
Message-ID: <20160530232142.21098-3-e@80x24.org>
References: <20160530232142.21098-1-e@80x24.org>
Cc: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 01:22:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7WVW-0005Hg-CZ
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 01:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161986AbcE3XV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 19:21:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34842 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161857AbcE3XVz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 19:21:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8ED1FE33;
	Mon, 30 May 2016 23:21:48 +0000 (UTC)
In-Reply-To: <20160530232142.21098-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295942>

This will allow us to parse the output of --pretty=mboxrd
and the output of other mboxrd generators.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/git-mailsplit.txt |  7 ++++++-
 builtin/mailsplit.c             | 23 +++++++++++++++++++++++
 t/t5100-mailinfo.sh             | 13 +++++++++++++
 t/t5100/0001mboxrd              |  4 ++++
 t/t5100/0002mboxrd              |  3 +++
 t/t5100/sample.mboxrd           | 17 +++++++++++++++++
 6 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 t/t5100/0001mboxrd
 create mode 100644 t/t5100/0002mboxrd
 create mode 100644 t/t5100/sample.mboxrd

diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 4d1b871..e3b2a88 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -8,7 +8,8 @@ git-mailsplit - Simple UNIX mbox splitter program
 SYNOPSIS
 --------
 [verse]
-'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--] [(<mbox>|<Maildir>)...]
+'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] [--mboxrd]
+		-o<directory> [--] [(<mbox>|<Maildir>)...]
 
 DESCRIPTION
 -----------
@@ -47,6 +48,10 @@ OPTIONS
 --keep-cr::
 	Do not remove `\r` from lines ending with `\r\n`.
 
+--mboxrd::
+	Input is of the "mboxrd" format and "^>+From " line escaping is
+	reversed.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 4859ede..fad871d 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -45,6 +45,7 @@ static int is_from_line(const char *line, int len)
 
 static struct strbuf buf = STRBUF_INIT;
 static int keep_cr;
+static regex_t *gtfrom;
 
 /* Called with the first line (potentially partial)
  * already in buf[] -- normally that should begin with
@@ -77,6 +78,10 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 			strbuf_addch(&buf, '\n');
 		}
 
+		if (gtfrom && buf.len > (sizeof(">From ") - 1) &&
+				!regexec(gtfrom, buf.buf, 0, 0, 0))
+			strbuf_remove(&buf, 0, 1);
+
 		if (fwrite(buf.buf, 1, buf.len, output) != buf.len)
 			die_errno("cannot write output");
 
@@ -242,6 +247,22 @@ out:
 	return ret;
 }
 
+static regex_t *gtfrom_prepare(void)
+{
+	static regex_t preg;
+	const char re[] = "^>+From ";
+	int err = regcomp(&preg, re, REG_NOSUB | REG_EXTENDED);
+
+	if (err) {
+		char errbuf[1024];
+		regerror(err, &preg, errbuf, sizeof(errbuf));
+		regfree(&preg);
+		die("Cannot prepare regexp `%s': %s", re, errbuf);
+	}
+
+	return &preg;
+}
+
 int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 {
 	int nr = 0, nr_prec = 4, num = 0;
@@ -271,6 +292,8 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			keep_cr = 1;
 		} else if ( arg[1] == 'o' && arg[2] ) {
 			dir = arg+2;
+		} else if (!strcmp(arg, "--mboxrd")) {
+			gtfrom = gtfrom_prepare();
 		} else if ( arg[1] == '-' && !arg[2] ) {
 			argp++;	/* -- marks end of options */
 			break;
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 85b3df5..62b442c 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -111,4 +111,17 @@ test_expect_success 'mailinfo on message with quoted >From' '
 	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.expect quoted-from/msg
 '
 
+test_expect_success 'mailinfo unescapes with --mboxrd' '
+	mkdir mboxrd &&
+	git mailsplit -omboxrd --mboxrd \
+		"$TEST_DIRECTORY"/t5100/sample.mboxrd >last &&
+	test x"$(cat last)" = x2 &&
+	for i in 0001 0002
+	do
+		git mailinfo mboxrd/msg mboxrd/patch \
+		  <mboxrd/$i >mboxrd/out &&
+		test_cmp "$TEST_DIRECTORY"/t5100/${i}mboxrd mboxrd/msg
+	done
+'
+
 test_done
diff --git a/t/t5100/0001mboxrd b/t/t5100/0001mboxrd
new file mode 100644
index 0000000..494ec55
--- /dev/null
+++ b/t/t5100/0001mboxrd
@@ -0,0 +1,4 @@
+From the beginning, mbox should have been mboxrd
+>From escaped
+From not mangled but this line should have been escaped
+
diff --git a/t/t5100/0002mboxrd b/t/t5100/0002mboxrd
new file mode 100644
index 0000000..3c30b0b
--- /dev/null
+++ b/t/t5100/0002mboxrd
@@ -0,0 +1,3 @@
+ >From unchanged
+ From also unchanged
+
diff --git a/t/t5100/sample.mboxrd b/t/t5100/sample.mboxrd
new file mode 100644
index 0000000..75de6dd
--- /dev/null
+++ b/t/t5100/sample.mboxrd
@@ -0,0 +1,17 @@
+From mboxrd Mon Sep 17 00:00:00 2001
+From: mboxrd writer <mboxrd@example.com>
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+Subject: [PATCH] a commit with escaped From lines
+
+>From the beginning, mbox should have been mboxrd
+>>From escaped
+From not mangled but this line should have been escaped
+
+From mboxrd Mon Sep 17 00:00:00 2001
+From: mboxrd writer <mboxrd@example.com>
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+Subject: [PATCH 2/2] another with fake From lines
+
+ >From unchanged
+ From also unchanged
+
