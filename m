From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] sparse: Fix errors and silence warnings
Date: Sun,  3 Apr 2011 00:06:54 -0700
Message-ID: <1301814414-11368-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 09:07:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6HPN-00018n-D7
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 09:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab1DCHHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 03:07:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab1DCHHX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 03:07:23 -0400
Received: by iwn34 with SMTP id 34so4796986iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=aGGwbCSzlOTcrb86QaGlhRAyeeFaNR3P3OnW1n+C1Mk=;
        b=qyksm8U9XU21Nc9gNQNInihObvCUcfBCOstmE5oaSvyIZEhNvItjJd+Xz97MMKsFzf
         JcUsZ4XY6JMUvbTZjkMbqaZGFt6qtnI00+qtlQa75D57biiI1M4uQU2k3L80BigOLdxV
         XsiDEPA1TMxLvId5WHBmXaiEO9J95dMKOd3yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=X/FR0mOXab0kloA5pruRnIJ8uOE60VAPwhCVQT/RBZq4nKAg346mbUzbn8nxpSmuFX
         EUGbSedtvCJmRGn7s5Y8++gf/TriSGYWKC8j1cW9mTC6XKg7Jk4VwxuoXGfPWQGRwZph
         JyJo7a5GbKC9MvL0dpE05Q7/N7HBMUV2OdmvI=
Received: by 10.231.23.145 with SMTP id r17mr5947089ibb.26.1301814442429;
        Sun, 03 Apr 2011 00:07:22 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id he40sm2786095ibb.16.2011.04.03.00.07.15
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 00:07:21 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 Apr 2011 00:06:54 -0700
X-Mailer: git-send-email 1.7.5.rc0.96.gc4b2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170682>

 * load_file() returns a void pointer but is using 0 for the return
   value

 * builtin/receive-pack.c forgot to include builtin.h

 * packet_trace_prefix can be marked static

 * ll_merge takes a pointer for its last argument, not an int

 * crc32 expects a pointer as the second argument but Z_NULL is defined
   to be 0 (see 38f4d13 sparse fix: Using plain integer as NULL pointer,
   2006-11-18 for more info)

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin/grep.c         |    6 +++---
 builtin/index-pack.c   |    2 +-
 builtin/receive-pack.c |    2 +-
 csum-file.c            |    2 +-
 pack-check.c           |    2 +-
 pkt-line.c             |    2 +-
 rerere.c               |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 891e5ea..10a1f65 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -414,10 +414,10 @@ static void *load_file(const char *filename, size_t *sz)
 	err_ret:
 		if (errno != ENOENT)
 			error(_("'%s': %s"), filename, strerror(errno));
-		return 0;
+		return NULL;
 	}
 	if (!S_ISREG(st.st_mode))
-		return 0;
+		return NULL;
 	*sz = xsize_t(st.st_size);
 	i = open(filename, O_RDONLY);
 	if (i < 0)
@@ -427,7 +427,7 @@ static void *load_file(const char *filename, size_t *sz)
 		error(_("'%s': short read %s"), filename, strerror(errno));
 		close(i);
 		free(data);
-		return 0;
+		return NULL;
 	}
 	close(i);
 	data[*sz] = 0;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5a67c81..31f001f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -294,7 +294,7 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 	void *data;
 
 	obj->idx.offset = consumed_bytes;
-	input_crc32 = crc32(0, Z_NULL, 0);
+	input_crc32 = crc32(0, NULL, 0);
 
 	p = fill(1);
 	c = *p;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 27050e7..e1ba4dc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/csum-file.c b/csum-file.c
index 4d50cc5..be49d5f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -116,7 +116,7 @@ struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp
 
 void crc32_begin(struct sha1file *f)
 {
-	f->crc32 = crc32(0, Z_NULL, 0);
+	f->crc32 = crc32(0, NULL, 0);
 	f->do_crc = 1;
 }
 
diff --git a/pack-check.c b/pack-check.c
index c3bf21d..a1a5216 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -23,7 +23,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 		   off_t offset, off_t len, unsigned int nr)
 {
 	const uint32_t *index_crc;
-	uint32_t data_crc = crc32(0, Z_NULL, 0);
+	uint32_t data_crc = crc32(0, NULL, 0);
 
 	do {
 		unsigned int avail;
diff --git a/pkt-line.c b/pkt-line.c
index cd1bd26..5a04984 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "pkt-line.h"
 
-const char *packet_trace_prefix = "git";
+static const char *packet_trace_prefix = "git";
 static const char trace_key[] = "GIT_TRACE_PACKET";
 
 void packet_trace_identity(const char *prog)
diff --git a/rerere.c b/rerere.c
index 3d00a71..22dfc84 100644
--- a/rerere.c
+++ b/rerere.c
@@ -438,7 +438,7 @@ static int merge(const char *name, const char *path)
 		ret = 1;
 		goto out;
 	}
-	ret = ll_merge(&result, path, &base, NULL, &cur, "", &other, "", 0);
+	ret = ll_merge(&result, path, &base, NULL, &cur, "", &other, "", NULL);
 	if (!ret) {
 		FILE *f;
 
-- 
1.7.5.rc0.96.gc4b2c
