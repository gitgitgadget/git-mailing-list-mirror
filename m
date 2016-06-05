From: Eric Wong <e@80x24.org>
Subject: [PATCH v2 2/3] mailsplit: support unescaping mboxrd messages
Date: Sun,  5 Jun 2016 04:46:40 +0000
Message-ID: <20160605044641.9221-3-e@80x24.org>
References: <20160605044641.9221-1-e@80x24.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 06:46:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9Pxh-0006df-FN
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 06:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbcFEEqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 00:46:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35404 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbcFEEqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 00:46:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6C211FE6F;
	Sun,  5 Jun 2016 04:46:45 +0000 (UTC)
In-Reply-To: <20160605044641.9221-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296462>

This will allow us to parse the output of --pretty=mboxrd
and the output of other mboxrd generators.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/git-mailsplit.txt |  7 ++++++-
 builtin/mailsplit.c             | 18 ++++++++++++++++++
 t/t5100-mailinfo.sh             | 31 +++++++++++++++++++++++++++++++
 t/t5100/0001mboxrd              |  4 ++++
 t/t5100/0002mboxrd              |  5 +++++
 t/t5100/sample.mboxrd           | 19 +++++++++++++++++++
 6 files changed, 83 insertions(+), 1 deletion(-)
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
index 4859ede..3068168 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -45,6 +45,19 @@ static int is_from_line(const char *line, int len)
 
 static struct strbuf buf = STRBUF_INIT;
 static int keep_cr;
+static int mboxrd;
+
+static int is_gtfrom(const struct strbuf *buf)
+{
+	size_t min = strlen(">From ");
+	size_t ngt;
+
+	if (buf->len < min)
+		return 0;
+
+	ngt = strspn(buf->buf, ">");
+	return ngt && starts_with(buf->buf + ngt, "From ");
+}
 
 /* Called with the first line (potentially partial)
  * already in buf[] -- normally that should begin with
@@ -77,6 +90,9 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 			strbuf_addch(&buf, '\n');
 		}
 
+		if (mboxrd && is_gtfrom(&buf))
+			strbuf_remove(&buf, 0, 1);
+
 		if (fwrite(buf.buf, 1, buf.len, output) != buf.len)
 			die_errno("cannot write output");
 
@@ -271,6 +287,8 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			keep_cr = 1;
 		} else if ( arg[1] == 'o' && arg[2] ) {
 			dir = arg+2;
+		} else if (!strcmp(arg, "--mboxrd")) {
+			mboxrd = 1;
 		} else if ( arg[1] == '-' && !arg[2] ) {
 			argp++;	/* -- marks end of options */
 			break;
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 85b3df5..1a5a546 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -111,4 +111,35 @@ test_expect_success 'mailinfo on message with quoted >From' '
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
+	done &&
+	sp=" " &&
+	echo "From " >expect &&
+	echo "From " >>expect &&
+	echo >> expect &&
+	cat >sp <<-INPUT_END &&
+	From mboxrd Mon Sep 17 00:00:00 2001
+	From: trailing spacer <sp@example.com>
+	Subject: [PATCH] a commit with trailing space
+
+	From$sp
+	>From$sp
+
+	INPUT_END
+
+	git mailsplit -f2 -omboxrd --mboxrd <sp >last &&
+	test x"$(cat last)" = x1 &&
+	git mailinfo mboxrd/msg mboxrd/patch <mboxrd/0003 &&
+	test_cmp expect mboxrd/msg
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
index 0000000..71343d4
--- /dev/null
+++ b/t/t5100/0002mboxrd
@@ -0,0 +1,5 @@
+ >From unchanged
+ From also unchanged
+no trailing space, no escaping necessary and '>' was intended:
+>From
+
diff --git a/t/t5100/sample.mboxrd b/t/t5100/sample.mboxrd
new file mode 100644
index 0000000..79ad5ae
--- /dev/null
+++ b/t/t5100/sample.mboxrd
@@ -0,0 +1,19 @@
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
+no trailing space, no escaping necessary and '>' was intended:
+>From
+
