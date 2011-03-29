From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] fast-export: Introduce --inline-blobs
Date: Tue, 29 Mar 2011 23:43:09 +0530
Message-ID: <1301422392-21177-3-git-send-email-artagnon@gmail.com>
References: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Cc: Peter Baumann <waste.manager@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:14:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dRQ-0000U5-1R
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab1C2SOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:14:50 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43841 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1C2SOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:14:49 -0400
Received: by gxk21 with SMTP id 21so188898gxk.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=365HAVGBljIKjA+6iDOLMA/eLDbBLz8JPs72kdxoalM=;
        b=NSumZ/eRxmqH8tu71US0kWGAIqQw4WWYZBlUkzusaaaT6OSv7Sw8U4EBN/Xy3s3ddF
         BryDnFpkM89x8NuRO3oI2vwqDmUXpaRuhul0xoXmGWGIPjAORFSv0PMzWpfGvpapNdSu
         DHgLr7TulV5YutQ/lxwywzA48mUbFXzUa1zBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kOMJDk/eSXguykOhcN160VP5l/tgf7e5hh3t2r7+X56Ylh7hvmbujHcop8+UVT7LmW
         st2QxOMMPlh6dEBMRrvrhadZB0OBTx47TopTwf/6v5+WfgoeG/saL6LSFd6nSOoeob8j
         0MpqhHgC023UccyX+sfw0cdGDGI5vcIhVnuFA=
Received: by 10.151.117.12 with SMTP id u12mr485261ybm.142.1301422488351;
        Tue, 29 Mar 2011 11:14:48 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o2sm1971669ybn.21.2011.03.29.11.14.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 11:14:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170292>

Introduce a new command-line option --inline-blobs that always inlines
blobs instead of referring to them via marks or their original SHA-1
hash.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fast-export.txt |    5 +++++
 builtin/fast-export.c             |   23 +++++++++++++++++++++--
 contrib/svn-fe/.gitignore         |    1 +
 contrib/svn-fe/Makefile           |   23 +++++++++++++++++++++--
 contrib/svn-fe/svn-fi.c           |   16 ++++++++++++++++
 contrib/svn-fe/svn-fi.txt         |   28 ++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 4 deletions(-)
 create mode 100644 contrib/svn-fe/svn-fi.c
 create mode 100644 contrib/svn-fe/svn-fi.txt

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 781bd6e..363e768 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -90,6 +90,11 @@ marks the same across runs.
 	resulting stream can only be used by a repository which
 	already contains the necessary objects.
 
+--inline-blobs::
+	Inline all blobs, instead of referring to them via marks or
+	their original SHA-1 hash.  This is useful to parsers, as they
+	don't need to persist blobs.
+
 --full-tree::
 	This option will cause fast-export to issue a "deleteall"
 	directive for each commit followed by a full list of all files
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index daf1945..891ad5c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -27,6 +27,7 @@ static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
 static int no_data;
+static int inline_blobs;
 static int full_tree;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -118,7 +119,7 @@ static void handle_object(const unsigned char *sha1)
 	char *buf;
 	struct object *object;
 
-	if (no_data)
+	if (no_data || inline_blobs)
 		return;
 
 	if (is_null_sha1(sha1))
@@ -218,7 +219,23 @@ static void show_filemodify(struct diff_queue_struct *q,
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s %s\n", spec->mode,
 				       sha1_to_hex(spec->sha1), spec->path);
-			else {
+			else if (inline_blobs) {
+				unsigned long size;
+				enum object_type type;
+				char *buf;
+
+				buf = read_sha1_file(spec->sha1, &type, &size);
+				if (!buf)
+					die("Could not read blob %s",
+						sha1_to_hex(spec->sha1));
+				printf("M %06o inline %s\n", spec->mode, spec->path);
+				printf("data %lu\n", size);
+				if (size && fwrite(buf, size, 1, stdout) != 1)
+					die_errno("Could not write blob '%s'",
+						sha1_to_hex(spec->sha1));
+				printf("\n");
+
+			} else {
 				struct object *object = lookup_object(spec->sha1);
 				printf("M %06o :%d %s\n", spec->mode,
 				       get_object_mark(object), spec->path);
@@ -627,6 +644,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Fake a tagger when tags lack one"),
 		OPT_BOOLEAN(0, "full-tree", &full_tree,
 			     "Output full tree for each commit"),
+		OPT_BOOLEAN(0, "inline-blobs", &inline_blobs,
+			     "Output all blobs inline"),
 		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
 			"Skip output of blob data",
 			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
diff --git a/contrib/svn-fe/.gitignore b/contrib/svn-fe/.gitignore
index 02a7791..35f205d 100644
--- a/contrib/svn-fe/.gitignore
+++ b/contrib/svn-fe/.gitignore
@@ -2,3 +2,4 @@
 /*.1
 /*.html
 /svn-fe
+/svn-fi
diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..555a8ff 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -37,7 +37,7 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
 		$(ALL_LDFLAGS) $(LIBS)
 
-svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
+svn-fe.o: svn-fe.c ../../vcs-svn/svnload.h
 	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
@@ -51,6 +51,24 @@ svn-fe.1: svn-fe.txt
 		../contrib/svn-fe/$@
 	$(MV) ../../Documentation/svn-fe.1 .
 
+svn-fi$X: svn-fi.o $(VCSSVN_LIB) $(GIT_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fi.o \
+		$(ALL_LDFLAGS) $(LIBS)
+
+svn-fi.o: svn-fi.c ../../vcs-svn/svnload.h
+	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
+
+svn-fi.html: svn-fi.txt
+	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/svn-fe/svn-fi.txt \
+		../contrib/svn-fe/$@
+
+svn-fi.1: svn-fi.txt
+	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/svn-fe/svn-fi.txt \
+		../contrib/svn-fe/$@
+	$(MV) ../../Documentation/svn-fi.1 .
+
 ../../vcs-svn/lib.a: FORCE
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
 
@@ -58,6 +76,7 @@ svn-fe.1: svn-fe.txt
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
 
 clean:
-	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
+	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1 \
+	svn-fi$X svn-fi.o svn-fi.html svn-fi.xml svn-fi.1
 
 .PHONY: all clean FORCE
diff --git a/contrib/svn-fe/svn-fi.c b/contrib/svn-fe/svn-fi.c
new file mode 100644
index 0000000..81347b0
--- /dev/null
+++ b/contrib/svn-fe/svn-fi.c
@@ -0,0 +1,16 @@
+/*
+ * This file is in the public domain.
+ * You may freely use, modify, distribute, and relicense it.
+ */
+
+#include <stdlib.h>
+#include "svnload.h"
+
+int main(int argc, char **argv)
+{
+	if (svnload_init(NULL))
+		return 1;
+	svnload_read();
+	svnload_deinit();
+	return 0;
+}
diff --git a/contrib/svn-fe/svn-fi.txt b/contrib/svn-fe/svn-fi.txt
new file mode 100644
index 0000000..996a175
--- /dev/null
+++ b/contrib/svn-fe/svn-fi.txt
@@ -0,0 +1,28 @@
+svn-fe(1)
+=========
+
+NAME
+----
+svn-fi - convert fast-import stream to an SVN "dumpfile"
+
+SYNOPSIS
+--------
+[verse]
+svn-fi
+
+DESCRIPTION
+-----------
+
+Converts a git-fast-import(1) stream into a Subversion dumpfile.
+
+INPUT FORMAT
+-------------
+The fast-import format is documented by the git-fast-import(1)
+manual page.
+
+OUTPUT FORMAT
+------------
+Subversion's repository dump format is documented in full in
+`notes/dump-load-format.txt` from the Subversion source tree.
+Files in this format can be generated using the 'svnadmin dump' or
+'svk admin dump' command.
-- 
1.7.4.rc1.7.g2cf08.dirty
