From: Alex Riesen <raa.lkml@gmail.com>
Subject: make gitfakemmap standalone to fix linking error in git.c
Date: Mon, 5 Dec 2005 14:19:22 +0100
Message-ID: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19707_6058574.1133788762749"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 14:20:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjGFl-0004su-Ad
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 14:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVLENT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 08:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLENT0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 08:19:26 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:17422 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932417AbVLENTZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 08:19:25 -0500
Received: by nproxy.gmail.com with SMTP id m18so14751nfc
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 05:19:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=kciS3y90MEM6TetqojDViiAvvpkNchauDP+4ZyOaOUjzgp3z01M4ADDQ4sZ20KTcy50lBBsmQZv3/a+TqSYRNE4k0qoZXWV+Axrt92J2QYsm2sFOFntGPROHBbtUjQ6nrZX53/wZsYVaC3e7sF36FXTd35XuBqxuzXQ3fA08PqY=
Received: by 10.48.245.7 with SMTP id s7mr924674nfh;
        Mon, 05 Dec 2005 05:19:22 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 5 Dec 2005 05:19:22 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13212>

------=_Part_19707_6058574.1133788762749
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The patch is to fix linking error because of gitfakemmap referencing
die living in usage.c, and git.c not linking in the file. Instead of
hardcoding usage.o in git.c prerequisites, I separated mmap from the
main sources.

------=_Part_19707_6058574.1133788762749
Content-Type: text/plain; 
	name=0001-make-fakemmap-standalone-to-fix-linking-error-because-of-gitfakemmap.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-make-fakemmap-standalone-to-fix-linking-error-because-of-gitfakemmap.txt"

Subject: [PATCH] make fakemmap standalone to fix linking error because of gitfakemmap
referencing die living in usage.c, and git.c not linking in the file.
Instead of hardcoding usage.o in git.c prerequisites, I separated mmap.

Signed-off-by: Alex Riesen <fork0@gmail.com>


---

 cache.h       |   18 +++---------------
 compat/mmap.c |   11 +++++++----
 compat/mmap.h |   15 +++++++++++++++
 3 files changed, 25 insertions(+), 19 deletions(-)
 create mode 100644 compat/mmap.h

e1e24d29b684d468a7be5d097ba3e1679170e7db
diff --git a/cache.h b/cache.h
index f9b367f..c70a467 100644
--- a/cache.h
+++ b/cache.h
@@ -11,7 +11,9 @@
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
-#ifndef NO_MMAP
+#ifdef NO_MMAP
+#include "compat/mmap.h"
+#else
 #include <sys/mman.h>
 #endif
 #include <sys/param.h>
@@ -373,20 +375,6 @@ extern void packed_object_info_detail(st
 /* Dumb servers support */
 extern int update_server_info(int);
 
-#ifdef NO_MMAP
-
-#ifndef PROT_READ
-#define PROT_READ 1
-#define PROT_WRITE 2
-#define MAP_PRIVATE 1
-#define MAP_FAILED ((void*)-1)
-#endif
-
-extern void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
-extern int gitfakemunmap(void *start, size_t length);
-
-#endif
-
 typedef int (*config_fn_t)(const char *, const char *);
 extern int git_default_config(const char *, const char *);
 extern int git_config_from_file(config_fn_t fn, const char *);
diff --git a/compat/mmap.c b/compat/mmap.c
index a051c47..98cf3cb 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -2,21 +2,24 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
-#include "../cache.h"
+#include <string.h>
+#include "mmap.h"
 
 void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset)
 {
 	int n = 0;
 
-	if (start != NULL || !(flags & MAP_PRIVATE))
-		die("Invalid usage of gitfakemmap.");
+	if (!start || !(flags & MAP_PRIVATE)) {
+		fprintf(stderr, "Invalid usage of gitfakemmap.\n");
+		exit(128); /* see die() in ../usage.c */
+	}
 
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		errno = EINVAL;
 		return MAP_FAILED;
 	}
 
-	start = xmalloc(length);
+	start = malloc(length);
 	if (start == NULL) {
 		errno = ENOMEM;
 		return MAP_FAILED;
diff --git a/compat/mmap.h b/compat/mmap.h
new file mode 100644
index 0000000..08d7f99
--- /dev/null
+++ b/compat/mmap.h
@@ -0,0 +1,15 @@
+#ifndef MMAP_H
+#define MMAP_H
+
+#ifndef PROT_READ
+#define PROT_READ 1
+#define PROT_WRITE 2
+#define MAP_PRIVATE 1
+#define MAP_FAILED ((void*)-1)
+#endif
+
+extern void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
+extern int gitfakemunmap(void *start, size_t length);
+
+#endif
+
-- 
0.99.9.GIT

------=_Part_19707_6058574.1133788762749--
