From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 2/4] git-archive: wire up TAR format.
Date: Thu,  7 Sep 2006 15:12:03 +0200
Message-ID: <11576347252834-git-send-email-vagabon.xyz@gmail.com>
References: <450019C3.4030001@innova-card.com>
Cc: rene.scharfe@lsrfire.ath.cx, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 15:12:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLJfl-0007SI-Fj
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 15:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWIGNL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 09:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWIGNL4
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 09:11:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:6711 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751796AbWIGNLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 09:11:55 -0400
Received: by nf-out-0910.google.com with SMTP id l35so446676nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 06:11:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K+BtmuqIL5vIswtSEewuGH6fvgxnHy6zGD57zTlY+D8n7336MH5dzZKAPhrfd0fQKm22+ZNEjY2HQ4i+0dNJTepagDJolzP2sl1ZhoxaluBeytt5QAhLEtLQ889efE4ENrNzEHNuspgX6u2ZLVffWTTt0zUGoWlyCuG+fKVcku0=
Received: by 10.49.10.3 with SMTP id n3mr2500989nfi;
        Thu, 07 Sep 2006 06:11:53 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.gmail.com with ESMTP id p20sm3373655nfc.2006.09.07.06.11.52;
        Thu, 07 Sep 2006 06:11:52 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id CC3C223F759; Thu,  7 Sep 2006 15:12:05 +0200 (CEST)
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2
In-Reply-To: <450019C3.4030001@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26635>

From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 archive.h          |    4 +++
 builtin-archive.c  |    4 ++-
 builtin-tar-tree.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/archive.h b/archive.h
index f33398e..3690c53 100644
--- a/archive.h
+++ b/archive.h
@@ -37,5 +37,9 @@ extern void parse_treeish_arg(const char
 
 extern void parse_pathspec_arg(const char **pathspec,
 			       struct archiver_args *args);
+/*
+ *
+ */
+extern int write_tar_archive(struct archiver_args *);
 
 #endif	/* ARCHIVE_H */
diff --git a/builtin-archive.c b/builtin-archive.c
index 6064358..214ec5d 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -15,7 +15,9 @@ static const char archive_usage[] = \
 "git-archive --format=<fmt> [--prefix=<prefix>/] [<extra>] <tree-ish> [path...]";
 
 
-struct archiver archivers[] = { };
+struct archiver archivers[] = {
+	{ .name = "tar", .write_archive = write_tar_archive },
+};
 
 
 static int run_remote_archiver(struct archiver *ar, int argc,
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 61a4135..1134730 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -9,6 +9,7 @@ #include "strbuf.h"
 #include "tar.h"
 #include "builtin.h"
 #include "pkt-line.h"
+#include "archive.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
@@ -338,6 +339,72 @@ static int generate_tar(int argc, const 
 	return 0;
 }
 
+static int write_tar_entry(const unsigned char *sha1,
+                           const char *base, int baselen,
+                           const char *filename, unsigned mode, int stage)
+{
+	static struct strbuf path;
+	int filenamelen = strlen(filename);
+	void *buffer;
+	char type[20];
+	unsigned long size;
+
+	if (!path.alloc) {
+		path.buf = xmalloc(PATH_MAX);
+		path.alloc = PATH_MAX;
+		path.len = path.eof = 0;
+	}
+	if (path.alloc < baselen + filenamelen) {
+		free(path.buf);
+		path.buf = xmalloc(baselen + filenamelen);
+		path.alloc = baselen + filenamelen;
+	}
+	memcpy(path.buf, base, baselen);
+	memcpy(path.buf + baselen, filename, filenamelen);
+	path.len = baselen + filenamelen;
+	if (S_ISDIR(mode)) {
+		strbuf_append_string(&path, "/");
+		buffer = NULL;
+		size = 0;
+	} else {
+		buffer = read_sha1_file(sha1, type, &size);
+		if (!buffer)
+			die("cannot read %s", sha1_to_hex(sha1));
+	}
+
+	write_entry(sha1, &path, mode, buffer, size);
+	free(buffer);
+
+	return READ_TREE_RECURSIVE;
+}
+
+int write_tar_archive(struct archiver_args *args)
+{
+	int plen = strlen(args->base);
+
+	git_config(git_tar_config);
+
+	archive_time = args->time;
+
+	if (args->commit_sha1)
+		write_global_extended_header(args->commit_sha1);
+
+	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
+		char *base = strdup(args->base);
+		int baselen = strlen(base);
+
+		while (baselen > 0 && base[baselen - 1] == '/')
+			base[--baselen] = '\0';
+		write_tar_entry(args->tree->object.sha1, "", 0, base, 040777, 0);
+		free(base);
+	}
+	read_tree_recursive(args->tree, args->base, plen, 0,
+			    args->pathspec, write_tar_entry);
+	write_trailer();
+
+	return 0;
+}
+
 static const char *exec = "git-upload-tar";
 
 static int remote_tar(int argc, const char **argv)
-- 
1.4.2
