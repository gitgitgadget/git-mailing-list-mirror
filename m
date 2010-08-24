From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/32] tree.c: find_subtree() to search for a tree
Date: Wed, 25 Aug 2010 08:19:57 +1000
Message-ID: <1282688422-7738-8-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1sv-0001Xh-T2
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322Ab0HXWVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47096 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097Ab0HXWVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:21:43 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2824689pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=iR4/dD1/054vwYGMbz7jCcdybbwWaB4ChPrlzIF2P00=;
        b=cUJqj6YgBGBAQVO1KN1TbTM1I0jqtih3WFwnIcuPvUcHWZbhvlYu78QJzhkhdySzCP
         O9OO0tTByFk4bWYY/uaUKG7iCKDcNa+eu5FF6rWeRDVAQeWCr4ZTrcw2rjNgYBfaQ57J
         AbLyKvLx/++H5iIb5MyOlCtqBovkYU2tap5QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eL/3aipshladJr8ixZk1MzmWlwaWXJMMQcmObbyH49xUcXtHRxxbGZH5kOMK8PTIUy
         YkTjtlwrqs+pR3ktd73F3EjFje9dOxVAgMop3g1vzXXODpTSilF5vvPp3fodVm1vjLNw
         C2FOivgDvE0BLoHQgdtPNxP5ApVM5TIZsV2EI=
Received: by 10.143.43.11 with SMTP id v11mr5886776wfj.86.1282688503029;
        Tue, 24 Aug 2010 15:21:43 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id y16sm637251wff.14.2010.08.24.15.21.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:21:42 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:21:37 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154349>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree.c |   35 +++++++++++++++++++++++++++++++++++
 tree.h |    1 +
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/tree.c b/tree.c
index 434bf56..684afb5 100644
--- a/tree.c
+++ b/tree.c
@@ -328,3 +328,38 @@ void clear_tree_marks(struct tree *tree, unsigned =
mark)
 	}
 	free(buffer);
 }
+
+int find_tree(const unsigned char *sha1, unsigned char *newsha1, const=
 char *path)
+{
+	struct name_entry entry;
+	struct tree_desc desc;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	const char *slash;
+	int len;
+
+	buffer =3D read_sha1_file(sha1, &type, &size);
+	if (!buffer || type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(sha1));
+
+	slash =3D strchr(path, '/');
+	len =3D slash ? slash - path : strlen(path);
+
+	init_tree_desc(&desc, buffer, size);
+	while (tree_entry(&desc, &entry)) {
+		if (!S_ISDIR(entry.mode))
+			continue;
+		if (!strncmp(entry.path, path, len)) {
+			free(buffer);
+			if (slash)
+				return find_tree(entry.sha1, newsha1, slash+1);
+			else {
+				hashcpy(newsha1, entry.sha1);
+				return 1;
+			}
+		}
+	}
+	free(buffer);
+	return 0;
+}
diff --git a/tree.h b/tree.h
index 4376a3a..6ba1034 100644
--- a/tree.h
+++ b/tree.h
@@ -32,5 +32,6 @@ extern int read_tree(struct tree *tree, int stage, co=
nst char **paths);
=20
 extern void set_tree_marks(struct tree *tree, unsigned mark);
 extern void clear_tree_marks(struct tree *tree, unsigned mark);
+extern int find_tree(const unsigned char *sha1, unsigned char *newsha1=
, const char *path);
=20
 #endif /* TREE_H */
--=20
1.7.1.rc1.69.g24c2f7
