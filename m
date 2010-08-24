From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/32] commit: add narrow's commit_tree version
Date: Wed, 25 Aug 2010 08:20:11 +1000
Message-ID: <1282688422-7738-22-git-send-email-pclouds@gmail.com>
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
	id 1Oo1uN-00030j-Jo
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab0HXWXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab0HXWXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:13 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lRmOAf97uLm5hZK11td43Gktc3iHfoiCghaXqHKCSgY=;
        b=EAmkKXPJq8IZID4Q80Curiv4BjQAfH+ecwduGzQdA6gnLHoILu9eKocUQu8TFPvSSA
         ANn9tLUsvG+yOC9tQje7rClXSy0Hw4TZWLRlYDIRIvtI65ELrUljkBuiA7ykaESrJ1p3
         PhGVapYd3DUHNtPea9AZQxUtxqwR1azZXU7B8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZgmE+bhBFTR2gZkCmr5Z2hIhzADpFiRBC2sKKIl9nv6BWd4fViM1QXP6ZqHsHROPaY
         uq1AQGeRIe5XEzaYjDHcP0dr0SCNwNgKIGpx8Y4+/8cr7i8IoEWdtQEmWGbO5NwDc2Uf
         4AeUn4UQoPp1VovPmHX14nPJADnz9B/q5Pzgs=
Received: by 10.142.222.8 with SMTP id u8mr5835902wfg.214.1282688593458;
        Tue, 24 Aug 2010 15:23:13 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id y16sm644694wff.2.2010.08.24.15.23.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:23:12 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:07 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154364>

The narrow version uses join_narrow_tree() to recreate a full tree
from a base toplevel tree (typically commit parent's tree) and a tree
created from index.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c |   21 +++++++++++++++++++++
 commit.h |    5 +++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 0094ec1..77ed9fd 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "narrow-tree.h"
=20
 int save_commit_buffer =3D 1;
=20
@@ -864,3 +865,23 @@ int commit_tree(const char *msg, unsigned char *tr=
ee,
 	strbuf_release(&buffer);
 	return result;
 }
+
+int commit_narrow_tree(const char *msg, unsigned char *tree,
+		       const unsigned char *narrow_base,
+		       struct commit_list *parents, unsigned char *ret,
+		       const char *author)
+{
+	unsigned char result_tree[20];
+
+	if (get_narrow_prefix()) {
+		unsigned char sha1[20];
+
+		if (!find_tree(tree, sha1, get_narrow_prefix()))
+			die("Narrow tree %s not found", get_narrow_prefix());
+		if (join_narrow_tree(narrow_base, result_tree, sha1,
+				     get_narrow_prefix()))
+			die("Failed to join tree");
+		tree =3D result_tree;
+	}
+	return commit_tree(msg, tree, parents, ret, author);
+}
diff --git a/commit.h b/commit.h
index 9113bbe..c718439 100644
--- a/commit.h
+++ b/commit.h
@@ -170,5 +170,10 @@ struct commit_list *reduce_heads(struct commit_lis=
t *heads);
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
+extern int commit_narrow_tree(const char *msg, unsigned char *tree,
+			      const unsigned char *narrow_base,
+			      struct commit_list *parents,
+			      unsigned char *ret,
+			      const char *author);
=20
 #endif /* COMMIT_H */
--=20
1.7.1.rc1.69.g24c2f7
