From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/32] merge: refuse to merge if narrow bases are different
Date: Wed, 25 Aug 2010 08:20:14 +1000
Message-ID: <1282688422-7738-25-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uR-00030j-0B
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149Ab0HXWXi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:38 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56379 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab0HXWXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:32 -0400
Received: by pwi7 with SMTP id 7so50883pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jp8OnV/al1vr1DUfSKxHQteujW80u2hNkdiv0mGZi4s=;
        b=kq8rfibi0tVlzk+EOrUC8Z3waSEYZnDjufLJcxauOOgj4hNVRPTsi+x4I1eLYxQktQ
         0pvIUDqUULZBOtnKgyD3tFJKq9U98DkmVtYJSMxHeQU92PoET+aFEV3O4WaF9ujzNxho
         7v5Kvr143XYnGAB2VpxpOSFHe2TezX8XUcFrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pQVoAydnDXfTVwp2oQBzMS2993eynm44/RBNMb788IqPRYOWU3EpJKMO6ZgucXb8ew
         FJNkY3wKhQSWt8ttdAbM9YyvsnrsK7vceugwrqCRHFoisHzWFWqT84pr8U+iky2gNSmc
         8WN37nQROsZd5mCXy+ZcLmuz8Qd98SzY3hRPE=
Received: by 10.114.73.12 with SMTP id v12mr8520625waa.61.1282688612005;
        Tue, 24 Aug 2010 15:23:32 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id c24sm943192wam.19.2010.08.24.15.23.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:23:30 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:26 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154369>

commit_narrow_tree() works with a single narrow base. Unfortunately a
merge may have more than one parent. If all parents have the same
trees outside $GIT_DIR/narrow tree, then it's actually "a single
narrow base".

Other than that, refuse to merge. A merge in such case will need
server support because narrow repos do not have enough trees to
perform merge locally.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |   18 ++++++++++++++++++
 narrow-tree.c   |   55 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 narrow-tree.h   |    1 +
 3 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..c70d39d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -25,6 +25,7 @@
 #include "help.h"
 #include "merge-recursive.h"
 #include "resolve-undo.h"
+#include "narrow-tree.h"
=20
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -1048,6 +1049,23 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 			allow_trivial =3D 0;
 	}
=20
+	if (get_narrow_prefix()) {
+		struct commit_list *item =3D remoteheads;
+		struct commit *head_commit =3D lookup_commit(head);
+
+		parse_commit(head_commit);
+		while (item) {
+			parse_commit(item->item);
+			if (!same_narrow_base(head_commit->tree->object.sha1,
+					      item->item->tree->object.sha1,
+					      get_narrow_prefix()))
+				break;
+			item =3D item->next;
+		}
+		if (item)
+			die("Different narrow base, couldn't do merge (yet)");
+	}
+
 	if (!remoteheads->next)
 		common =3D get_merge_bases(lookup_commit(head),
 				remoteheads->item, 1);
diff --git a/narrow-tree.c b/narrow-tree.c
index 73d4f22..4a16647 100644
--- a/narrow-tree.c
+++ b/narrow-tree.c
@@ -95,3 +95,58 @@ int join_narrow_tree(const unsigned char *base,
 	strbuf_release(&buffer);
 	return 0;
 }
+
+int same_narrow_base(const unsigned char *t1, const unsigned char *t2,=
 const char *prefix)
+{
+	struct tree_desc desc1, desc2;
+	struct name_entry entry1, entry2;
+	char *buf1, *buf2;
+	enum object_type type;
+	unsigned long size;
+	const char *slash;
+	int prefix_len;
+
+	slash =3D strchr(prefix, '/');
+	prefix_len =3D slash ? slash - prefix : strlen(prefix);
+
+	buf1 =3D read_sha1_file(t1, &type, &size);
+	if (type !=3D OBJ_TREE)
+		die("Bad tree %s", sha1_to_hex(t1));
+	init_tree_desc(&desc1, buf1, size);
+
+	buf2 =3D read_sha1_file(t2, &type, &size);
+	if (type !=3D OBJ_TREE)
+		die("Bad tree %s", sha1_to_hex(t2));
+	init_tree_desc(&desc2, buf2, size);
+
+	while (tree_entry(&desc1, &entry1) && tree_entry(&desc2, &entry2)) {
+		if (strcmp(entry1.path, entry2.path) ||
+		    entry1.mode !=3D entry2.mode) {
+			free(buf1);
+			free(buf2);
+			return 0;
+		}
+
+		if (!hashcmp(entry1.sha1, entry2.sha1))
+			continue;
+
+		if (S_ISDIR(entry1.mode) &&
+		    !strncmp(entry1.path, prefix, prefix_len) &&
+		    entry1.path[prefix_len] =3D=3D '\0') {
+
+			/* This is subtree, SHA-1 does not matter */
+			if (!slash)
+				continue;
+
+			if (same_narrow_base(entry1.sha1, entry2.sha1, slash+1))
+				continue;
+		}
+
+		free(buf1);
+		free(buf2);
+		return 0;
+	}
+	free(buf1);
+	free(buf2);
+	return !desc1.size && !desc2.size;
+}
diff --git a/narrow-tree.h b/narrow-tree.h
index ecb3ded..8756094 100644
--- a/narrow-tree.h
+++ b/narrow-tree.h
@@ -1,3 +1,4 @@
 extern int check_narrow_prefix();
 extern int join_narrow_tree(const unsigned char *base, unsigned char *=
newsha1,
 			    const unsigned char *subtree_sha1, const char *prefix);
+int same_narrow_base(const unsigned char *t1, const unsigned char *t2,=
 const char *prefix);
--=20
1.7.1.rc1.69.g24c2f7
