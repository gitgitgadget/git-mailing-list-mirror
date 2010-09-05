From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/17] index: make narrow index incompatible with older git
Date: Sun,  5 Sep 2010 16:47:31 +1000
Message-ID: <1283669264-15759-5-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:49:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os92G-0007yI-Lk
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab0IEGsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:48:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36326 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0IEGsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:48:50 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so649695pxi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZAhvMXCHknXN2vaZb7tatD6syUImx/yL9oitWcPQStA=;
        b=vhsRll5jWoQRvkcjSwg/K9kzQ+YTis6W7CSf/cZ4XIq7ZBDd7VkQv+wt8T+RX5ugj8
         q44xj0Aqi+4uKdUEO4OIG9ibFma1z7g8dsmZ6C7JTKZ4k6xmsEqdLbo36zQ9tUMwXoE6
         w50hFuBCkGQVr46x6/k5sZS3AYUqxHISYJLow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OJeElatz5APIaFpOZUpp5Q+rx/FKxPNDdojZ9Ly/rufICtbbX/kTMocPXui4tAk8dF
         eVytCld7tNrp9xkCEFe/kCyDiLWAGmpkVy9i2InKr59hmJ6FTrViOO9AGsBP6KYCetAw
         w+py6l95uHbZSdBGI48CMWP8RfJAG5olQh2C8=
Received: by 10.114.121.18 with SMTP id t18mr1558914wac.136.1283669329962;
        Sat, 04 Sep 2010 23:48:49 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id r37sm8038506wak.23.2010.09.04.23.48.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:48:48 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:48:40 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155431>

Index in narrow repos is also narrowed and should not be used to
create commits straight away (to be explained later on). On the other
hand, while normal index can still be used in narrow repos, it should
be narrowed when the repo becomes narrow. Disallow that case too.

Add non-optional extension "narw" so that older git will refuse to
read it. Also check narrow prefix in index against $GIT_DIR/narrow,
just in case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h                |    1 +
 read-cache.c           |   32 ++++++++++++++++++++++++++++++--
 t/t0063-narrow-repo.sh |   28 ++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d09c4fc..88a2ec6 100644
--- a/cache.h
+++ b/cache.h
@@ -292,6 +292,7 @@ struct index_state {
 	struct string_list *resolve_undo;
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
+	char *narrow_prefix;
 	void *alloc;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
diff --git a/read-cache.c b/read-cache.c
index 1f42473..250013c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -12,6 +12,7 @@
 #include "commit.h"
 #include "blob.h"
 #include "resolve-undo.h"
+#include "narrow-tree.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,=
 int really);
=20
@@ -25,8 +26,9 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
  */
=20
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
-#define CACHE_EXT_TREE 0x54524545	/* "TREE" */
-#define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_TREE		0x54524545	/* "TREE" */
+#define CACHE_EXT_RESOLVE_UNDO	0x52455543	/* "REUC" */
+#define CACHE_EXT_NARROW	0x6e617277	/* "narw" */
=20
 struct index_state the_index;
=20
@@ -1188,6 +1190,9 @@ static int read_index_extension(struct index_stat=
e *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_NARROW:
+		istate->narrow_prefix =3D xstrdup(data);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1352,6 +1357,18 @@ int read_index_from(struct index_state *istate, =
const char *path)
 		src_offset +=3D extsize;
 	}
 	munmap(mmap, mmap_size);
+
+	if ((!get_narrow_prefix() && !istate->narrow_prefix))
+		;		/* good */
+	else if (get_narrow_prefix() && istate->narrow_prefix) {
+		char *buf =3D get_narrow_string();
+		if (strcmp(buf, istate->narrow_prefix))
+			die("Invalid index, narrow prefix does not match $GIT_DIR/narrow");
+		free(buf);
+	}
+	else
+		die("Invalid index, not suitable for narrow repository");
+
 	return istate->cache_nr;
=20
 unmap:
@@ -1378,6 +1395,8 @@ int discard_index(struct index_state *istate)
 	free(istate->alloc);
 	istate->alloc =3D NULL;
 	istate->initialized =3D 0;
+	free(istate->narrow_prefix);
+	istate->narrow_prefix =3D NULL;
=20
 	/* no need to throw away allocated active_cache */
 	return 0;
@@ -1607,6 +1626,15 @@ int write_index(struct index_state *istate, int =
newfd)
 		if (err)
 			return -1;
 	}
+	if (get_narrow_prefix()) {
+		char *buf =3D get_narrow_string();
+		int len =3D strlen(buf)+1;
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_NARROW, len) < 0=
 ||
+			ce_write(&c, newfd, buf, len) < 0;
+		free(buf);
+		if (err)
+			return -1;
+	}
=20
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
diff --git a/t/t0063-narrow-repo.sh b/t/t0063-narrow-repo.sh
index 51b753d..926802c 100755
--- a/t/t0063-narrow-repo.sh
+++ b/t/t0063-narrow-repo.sh
@@ -43,4 +43,32 @@ test_expect_success 'unsorted multiple prefix' '
 	test_must_fail git rev-parse --narrow-prefix
 '
=20
+test_expect_success 'create narrow index' '
+	echo a >.git/narrow &&
+	: >foo
+	git add foo &&
+	test -f .git/index
+'
+
+test_expect_success '$GIT_DIR/narrow and index do not match' '
+	echo b >.git/narrow &&
+	test_must_fail git add foo
+'
+
+test_expect_success 'narrow index and normal repo' '
+	rm .git/narrow &&
+	test_must_fail git add foo
+'
+
+test_expect_success 'turn to normal index again' '
+	rm .git/index &&
+	git add foo &&
+	test -f .git/index
+'
+
+test_expect_success 'normal index and narrow repo' '
+	echo a >.git/narrow &&
+	test_must_fail git add foo
+'
+
 test_done
--=20
1.7.1.rc1.69.g24c2f7
