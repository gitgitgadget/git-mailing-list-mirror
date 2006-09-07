From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 3/4] git-archive: wire up ZIP format.
Date: Thu,  7 Sep 2006 15:12:04 +0200
Message-ID: <1157634725573-git-send-email-vagabon.xyz@gmail.com>
References: <450019C3.4030001@innova-card.com>
Cc: rene.scharfe@lsrfire.ath.cx, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 15:12:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLJfm-0007SI-NR
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 15:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWIGNL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 09:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWIGNL6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 09:11:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:52278 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751802AbWIGNLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 09:11:55 -0400
Received: by nf-out-0910.google.com with SMTP id o25so434645nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 06:11:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DKrOkm0iac9wBBjqStX9jJ8pvyA9mEuS2P34VyyZSwlVE/CAe3GhkMmjU5Y4fCxbe1GaAgqcMW25C6tkUou6WH1n4c0GVt3Jpyj54E/weTxtuXn3wEtwtAee4mptAzQDuoywBUSf8byZR9pCAYnMDmSP4Ve3sqV1gLq/LqbB+Hc=
Received: by 10.49.8.10 with SMTP id l10mr2482316nfi;
        Thu, 07 Sep 2006 06:11:53 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.gmail.com with ESMTP id m15sm2384090nfc.2006.09.07.06.11.52;
        Thu, 07 Sep 2006 06:11:52 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 0AA6C23F76F; Thu,  7 Sep 2006 15:12:06 +0200 (CEST)
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2
In-Reply-To: <450019C3.4030001@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26636>

From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 archive.h          |    1 +
 builtin-archive.c  |    1 +
 builtin-zip-tree.c |   28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/archive.h b/archive.h
index 3690c53..760776d 100644
--- a/archive.h
+++ b/archive.h
@@ -41,5 +41,6 @@ extern void parse_pathspec_arg(const cha
  *
  */
 extern int write_tar_archive(struct archiver_args *);
+extern int write_zip_archive(struct archiver_args *);
 
 #endif	/* ARCHIVE_H */
diff --git a/builtin-archive.c b/builtin-archive.c
index 214ec5d..fd53e9a 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -17,6 +17,7 @@ static const char archive_usage[] = \
 
 struct archiver archivers[] = {
 	{ .name = "tar", .write_archive = write_tar_archive },
+	{ .name = "zip", .write_archive = write_zip_archive },
 };
 
 
diff --git a/builtin-zip-tree.c b/builtin-zip-tree.c
index a5b834d..788317c 100644
--- a/builtin-zip-tree.c
+++ b/builtin-zip-tree.c
@@ -8,6 +8,7 @@ #include "blob.h"
 #include "tree.h"
 #include "quote.h"
 #include "builtin.h"
+#include "archive.h"
 
 static const char zip_tree_usage[] =
 "git-zip-tree [-0|...|-9] <tree-ish> [ <base> ]";
@@ -351,3 +352,30 @@ int cmd_zip_tree(int argc, const char **
 
 	return 0;
 }
+
+int write_zip_archive(struct archiver_args *args)
+{
+	int plen = strlen(args->base);
+
+	dos_time(&args->time, &zip_date, &zip_time);
+
+	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
+	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
+
+	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
+		char *base = strdup(args->base);
+		int baselen = strlen(base);
+
+		while (baselen > 0 && base[baselen - 1] == '/')
+			base[--baselen] = '\0';
+		write_zip_entry(args->tree->object.sha1, "", 0, base, 040777, 0);
+		free(base);
+	}
+	read_tree_recursive(args->tree, args->base, plen, 0,
+			    args->pathspec, write_zip_entry);
+	write_zip_trailer(args->commit_sha1);
+
+	free(zip_dir);
+
+	return 0;
+}
-- 
1.4.2
