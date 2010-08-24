From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/32] narrow-tree: add join_narrow_tree to do tree fixup for commits
Date: Wed, 25 Aug 2010 08:20:10 +1000
Message-ID: <1282688422-7738-21-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uN-00030j-3H
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352Ab0HXWXK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58634 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab0HXWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:07 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2825136pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KsxlExPK+tuAnTt0OCX+d3EWRILwt8jnUvFF8xmH5lU=;
        b=QjStK4QszyAqduGe9Vnk4sbCQqchPEQAryMV3FE9Mz7a4cZTXgP1BXTlN3ze508Kvv
         X44jIjmuO2JYLyu3IJjuPSBLJd4eLaRr59h6raGz9DC5usYiHFePTqkv/YzJslhGvOmo
         yz+pE7dBbOEnXooZBYUDnlB6ToH8YaBXnG65o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DpSOKVcbJMOiDSxHnqppBGuffp/Q8LMCFSdAddrXOJHk8WmCDHYajE19xrEyWpm7h6
         TpSLQTnmUd9PKYX4fobzOte44HANjhWodPv4vwBeNFhVkTsbqZJ3DJtFDqFS86HYnUEK
         SpsGY+0mlHQ4NaHMWLWtfHA+YMq1Tyz9awSi4=
Received: by 10.114.133.18 with SMTP id g18mr8495460wad.48.1282688587126;
        Tue, 24 Aug 2010 15:23:07 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id c10sm947354wam.13.2010.08.24.15.23.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:23:06 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:01 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154365>

As stated somewhere, the index in narrow repo is also narrowed. When a
users are done with his changes and about to commit, the new narrow
tree created from index will be grafted back to a base toplevel tree
(usually from parent commit). The result is a new toplevel tree with
user's changes and suitable for commits.

This function does exactly that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 narrow-tree.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 narrow-tree.h |    2 +
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/narrow-tree.c b/narrow-tree.c
index 46e913d..73d4f22 100644
--- a/narrow-tree.c
+++ b/narrow-tree.c
@@ -1,4 +1,14 @@
 #include "cache.h"
+#include "commit.h"
+#include "tree.h"
+#include "diff.h"
+#include "revision.h"
+#include "refs.h"
+#include "tag.h"
+#include "progress.h"
+#include "pack.h"
+#include "sha1-lookup.h"
+#include "csum-file.h"
 #include "narrow-tree.h"
=20
 static const char *narrow_prefix;
@@ -29,3 +39,59 @@ const char *get_narrow_prefix()
 {
 	return narrow_prefix;
 }
+
+/*
+ * The opposite of narrow_tree(). Put the subtree back to the original=
 tree.
+ */
+int join_narrow_tree(const unsigned char *base,
+		     unsigned char *newsha1,
+		     const unsigned char *subtree_sha1,
+		     const char *prefix)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct strbuf buffer;
+	enum object_type type;
+	const char *slash;
+	char *buf;
+	int subtree_len;
+	unsigned long size;
+
+	slash =3D strchr(prefix, '/');
+	subtree_len =3D slash ? slash - prefix : strlen(prefix);
+
+	buf =3D read_sha1_file(base, &type, &size);
+	if (!buf || type !=3D OBJ_TREE)
+		die("Bad tree %s", sha1_to_hex(base));
+
+	init_tree_desc(&desc, buf, size);
+	strbuf_init(&buffer, 8192);
+	while (tree_entry(&desc, &entry)) {
+		strbuf_addf(&buffer, "%o %.*s%c", entry.mode, strlen(entry.path), en=
try.path, '\0');
+
+		if (S_ISDIR(entry.mode) &&
+		    subtree_len =3D=3D strlen(entry.path) &&
+		    !strncmp(entry.path, prefix, subtree_len)) {
+			if (slash && slash[1]) /* trailing slash does not count */
+				join_narrow_tree(entry.sha1, newsha1,
+						 subtree_sha1, slash+1);
+			else
+				memcpy(newsha1, subtree_sha1, 20); /* replace the tree */
+
+			/* FIXME, what if placeholder tree does not exist? */
+
+			strbuf_add(&buffer, newsha1, 20);
+		}
+		else
+			strbuf_add(&buffer, entry.sha1, 20);
+	}
+
+	free(buf);
+	if (write_sha1_file(buffer.buf, buffer.len, tree_type, newsha1)) {
+		error("Could not write replaced tree for %s", sha1_to_hex(subtree_sh=
a1));
+		strbuf_release(&buffer);
+		return 1;
+	}
+	strbuf_release(&buffer);
+	return 0;
+}
diff --git a/narrow-tree.h b/narrow-tree.h
index aa8c94f..ecb3ded 100644
--- a/narrow-tree.h
+++ b/narrow-tree.h
@@ -1 +1,3 @@
 extern int check_narrow_prefix();
+extern int join_narrow_tree(const unsigned char *base, unsigned char *=
newsha1,
+			    const unsigned char *subtree_sha1, const char *prefix);
--=20
1.7.1.rc1.69.g24c2f7
