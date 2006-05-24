From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Builtin git-cat-file
Date: Wed, 24 May 2006 14:08:46 +0300
Message-ID: <20060524140846.38316176.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 13:07:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FirCg-0000Mv-A2
	for gcvg-git@gmane.org; Wed, 24 May 2006 13:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWEXLG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 07:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWEXLG5
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 07:06:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:28725 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932677AbWEXLG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 07:06:56 -0400
Received: by nf-out-0910.google.com with SMTP id x4so68289nfb
        for <git@vger.kernel.org>; Wed, 24 May 2006 04:06:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mJjrSveIkNMhxRDX5ZvNbhfNRYt0SZeQ4zHh9rwW76QqB2F6vOnF56qXGR7rHCMN3qzvIaI9YzAZkjdRfA3An8TeybSZsV78P7dGB+bSGxcUNVWVEYp6ND/AoQPIqShJ8yqOSbPmKf/0gj4T91CJHpYRh/itsxJ2fjZ4XPUazMI=
Received: by 10.49.68.20 with SMTP id v20mr5586007nfk;
        Wed, 24 May 2006 04:06:54 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id q28sm2176769nfc.2006.05.24.04.06.52;
        Wed, 24 May 2006 04:06:52 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20678>


Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

Not huge disc space savings but avoids fork+exec.

95174d93a8fb39b907f4f7359a381b9ad5757e5d
 Makefile                         |    6 +++---
 cat-file.c => builtin-cat-file.c |    3 ++-
 builtin.h                        |    1 +
 git.c                            |    1 +
 4 files changed, 7 insertions(+), 4 deletions(-)
 rename cat-file.c => builtin-cat-file.c (98%)

95174d93a8fb39b907f4f7359a381b9ad5757e5d
diff --git a/Makefile b/Makefile
index 5423b7a..faab3f9 100644
--- a/Makefile
+++ b/Makefile
@@ -149,7 +149,7 @@ SIMPLE_PROGRAMS = \
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
-	git-apply$X git-cat-file$X \
+	git-apply$X \
 	git-checkout-index$X git-clone-pack$X git-commit-tree$X \
 	git-convert-objects$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X \
@@ -171,7 +171,7 @@ PROGRAMS = \
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
-	git-init-db$X
+	git-init-db$X git-cat-file$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -220,7 +220,7 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
-	builtin-init-db.o
+	builtin-init-db.o builtin-cat-file.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/cat-file.c b/builtin-cat-file.c
similarity index 98%
rename from cat-file.c
rename to builtin-cat-file.c
index 7413fee..8ab136e 100644
--- a/cat-file.c
+++ b/builtin-cat-file.c
@@ -7,6 +7,7 @@ #include "cache.h"
 #include "exec_cmd.h"
 #include "tag.h"
 #include "tree.h"
+#include "builtin.h"
 
 static void flush_buffer(const char *buf, unsigned long size)
 {
@@ -93,7 +94,7 @@ static int pprint_tag(const unsigned cha
 	return 0;
 }
 
-int main(int argc, char **argv)
+int cmd_cat_file(int argc, const char **argv, char **envp)
 {
 	unsigned char sha1[20];
 	char type[20];
diff --git a/builtin.h b/builtin.h
index 6054126..01f2eec 100644
--- a/builtin.h
+++ b/builtin.h
@@ -27,5 +27,6 @@ extern int cmd_grep(int argc, const char
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
 extern int cmd_init_db(int argc, const char **argv, char **envp);
+extern int cmd_cat_file(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 3216d31..6df0902 100644
--- a/git.c
+++ b/git.c
@@ -52,6 +52,7 @@ static void handle_internal_command(int 
 		{ "grep", cmd_grep },
 		{ "rev-list", cmd_rev_list },
 		{ "init-db", cmd_init_db },
+		{ "cat-file", cmd_cat_file },
 		{ "check-ref-format", cmd_check_ref_format }
 	};
 	int i;
-- 
1.3.3.g40505-dirty
