From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [RFC 2/8] Messages in locale.
Date: Wed, 13 May 2009 00:50:25 +0200
Message-ID: <1242168631-30753-3-git-send-email-robin.rosenberg@dewire.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:51:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40oJ-0000Sx-69
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbZELWup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:50:45 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZELWun
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:50:43 -0400
Received: from mail.dewire.com ([83.140.172.130]:19392 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbZELWuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:50:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4F0AD145A58C;
	Wed, 13 May 2009 00:50:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5cHVZE65qoCL; Wed, 13 May 2009 00:50:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id C16FF145A58D;
	Wed, 13 May 2009 00:50:32 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118965>

---
 builtin-cat-file.c    |    6 +++++-
 builtin-commit-tree.c |    9 ++++++---
 git-rebase.sh         |    1 +
 log-tree.c            |    4 +++-
 refs.c                |   11 ++++++++---
 t/t-utf-msg.sh        |   43 +++++++++++++++++++++++++++++++++++++++++=
++
 6 files changed, 66 insertions(+), 8 deletions(-)
 create mode 100755 t/t-utf-msg.sh

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 6c16bfa..ff275bf 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -145,6 +145,10 @@ int cmd_cat_file(int argc, const char **argv, cons=
t char *prefix)
 	if (!buf)
 		die("git-cat-file %s: bad file", argv[2]);
=20
-	write_or_die(1, buf, size);
+	size_t localsize =3D locallen(buf,size);
+	char *localbuf =3D xcalloc(localsize+1,1);
+	localcpy(localbuf, buf, size+1);
+	write_or_die(1, localbuf, localsize);
+	free(localbuf);
 	return 0;
 }
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index e2e690a..8d87ec7 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -23,16 +23,19 @@ static void init_buffer(char **bufp, unsigned int *=
sizep)
 static void add_buffer(char **bufp, unsigned int *sizep, const char *f=
mt, ...)
 {
 	char one_line[2048];
+	char one_line_utf[2048];
 	va_list args;
-	int len;
+	int len,len_utf;
 	unsigned long alloc, size, newsize;
 	char *buf;
=20
 	va_start(args, fmt);
 	len =3D vsnprintf(one_line, sizeof(one_line), fmt, args);
 	va_end(args);
+	utfcpy(one_line_utf, one_line, len + 1);
+	len_utf =3D strlen(one_line_utf);
 	size =3D *sizep;
-	newsize =3D size + len;
+	newsize =3D size + len_utf;
 	alloc =3D (size + 32767) & ~32767;
 	buf =3D *bufp;
 	if (newsize > alloc) {
@@ -41,7 +44,7 @@ static void add_buffer(char **bufp, unsigned int *siz=
ep, const char *fmt, ...)
 		*bufp =3D buf;
 	}
 	*sizep =3D newsize;
-	memcpy(buf + size, one_line, len);
+	memcpy(buf + size, one_line_utf, len_utf);
 }
=20
 static void check_valid(unsigned char *sha1, const char *expect)
diff --git a/git-rebase.sh b/git-rebase.sh
index 546fa44..939ac40 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -296,6 +296,7 @@ fi
=20
 if test -z "$do_merge"
 then
+	LC_CTYPE=3Dsv_SE.UTF-8 \
 	git-format-patch -k --stdout --full-index --ignore-if-in-upstream "$u=
pstream"..ORIG_HEAD |
 	git am --binary -3 -k --resolvemsg=3D"$RESOLVEMSG" \
 		--reflog-action=3Drebase
diff --git a/log-tree.c b/log-tree.c
index fbe1399..7c2564d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -104,6 +104,7 @@ static int append_signoff(char *buf, int buf_sz, in=
t at, const char *signoff)
 void show_log(struct rev_info *opt, const char *sep)
 {
 	static char this_header[16384];
+	static char this_header_local[16384];
 	struct log_info *log =3D opt->loginfo;
 	struct commit *commit =3D log->commit, *parent =3D log->parent;
 	int abbrev =3D opt->diffopt.abbrev;
@@ -217,7 +218,8 @@ void show_log(struct rev_info *opt, const char *sep=
)
 	if (opt->add_signoff)
 		len =3D append_signoff(this_header, sizeof(this_header), len,
 				     opt->add_signoff);
-	printf("%s%s%s", this_header, extra, sep);
+	localcpy(this_header_local, this_header, len+1);
+	printf("%s%s%s", this_header_local, extra, sep);
 }
=20
 int log_tree_diff_flush(struct rev_info *opt)
diff --git a/refs.c b/refs.c
index 98327d7..cfe2704 100644
--- a/refs.c
+++ b/refs.c
@@ -363,8 +363,9 @@ static int log_ref_write(struct ref_lock *lock,
 	const unsigned char *sha1, const char *msg)
 {
 	int logfd, written, oflags =3D O_APPEND | O_WRONLY;
-	unsigned maxlen, len;
+	unsigned maxlen, len, len_utf;
 	char *logrec;
+	char *logrec_utf;
 	const char *committer;
=20
 	if (log_all_ref_updates) {
@@ -400,10 +401,14 @@ static int log_ref_write(struct ref_lock *lock,
 			sha1_to_hex(sha1),
 			committer);
 	}
-	written =3D len <=3D maxlen ? write(logfd, logrec, len) : -1;
+	logrec_utf =3D xmalloc(len*6);
+	utfcpy(logrec_utf, logrec, len + 1);
+	len_utf =3D strlen(logrec_utf);
+	written =3D len_utf <=3D maxlen ? write(logfd, logrec_utf, len_utf) :=
 -1;
 	free(logrec);
+	free(logrec_utf);
 	close(logfd);
-	if (written !=3D len)
+	if (written !=3D len_utf)
 		return error("Unable to append to %s", lock->log_file);
 	return 0;
 }
diff --git a/t/t-utf-msg.sh b/t/t-utf-msg.sh
new file mode 100755
index 0000000..727d497
--- /dev/null
+++ b/t/t-utf-msg.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description=3D'Test charset management.
+
+This assumes normal tests works fine
+and concentrates commit messages and other
+descriptive data.'
+
+. ./test-lib.sh
+
+export GIT_AUTHOR_NAME=3D'P=E4r N=F6rdsson'
+export GIT_COMMITTER_NAME=3D'P=E4r N=F6rdsson'
+export GIT_AUTHOR_DATE=3D'Thu Sep 14 22:54:30 2006 +0000'
+export GIT_COMMITTER_DATE=3D'Thu Sep 14 22:54:30 2006 +0000'
+
+test_expect_success \
+    'add simple text file' \
+    'echo hej >aland.txt &&
+    git-add aland.txt &&
+    git-commit -a -m "=C4ndrad" &&
+    echo test $(git-ls-files) =3D "aland.txt\"" &&
+    LC_CTYPE=3Dsv_SE.UTF-8 echo test $(git-ls-files) =3D "aland.txt\""
+    '
+
+cat >>expected <<EOF
+commit 6905219c78beda5d5efd2a5fe4fbe0a8757bb355
+Author: P=E4r N=F6rdsson <author@example.com>
+Date:   Thu Sep 14 22:54:30 2006 +0000
+
+    =C4ndrad
+EOF
+
+test_expect_success \
+    'log' \
+    '
+    git log >actual &&
+    diff -u actual expected
+    '
+
+# todo: git-cat-file commit xxxxxxxxxxxxx
+
+test_done
+
--=20
1.6.3.dirty
