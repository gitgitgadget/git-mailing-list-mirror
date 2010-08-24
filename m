From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/32] tree.c: Add {set,clear}_tree_marks
Date: Wed, 25 Aug 2010 08:19:56 +1000
Message-ID: <1282688422-7738-7-git-send-email-pclouds@gmail.com>
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
	id 1Oo1sw-0001Xh-DB
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323Ab0HXWVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:47 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43052 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab0HXWVk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:21:40 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so50255pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5xpu57DR5Ltoi8P6pKhi5KHWLqkaLaAUyACFB3K0iFQ=;
        b=SQZY77DljjpVVxdXuPi27bF0CuWlgf/34xQgYqSrear3ZPBembYCh6un/Y4EXhgdP0
         nA3vGbg0OnGOSBoBN5DqUfourcQlLdSHDkUsrjePCDdrqme/6RmhvgTdkJDeH4tznKXm
         HE4SniGK0RVLEsKBGFlqqB5WE9solcpaKU/fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dz0xekrLtYM4MJKIRsTraevZxwH4uyABA13OujSjVSTj6zYPPt0x31XEI4Z5/A3SMg
         91VVvghnSlERzXZbM1diXPjBd4+s4pCUHvCnPEZaaQzNHOlMdgy45VhJ7Z/vwfY5MojJ
         YBeavo2fAJO8xPk4SxxkYgRmCmQXF+slksh8M=
Received: by 10.142.154.5 with SMTP id b5mr6316013wfe.157.1282688496878;
        Tue, 24 Aug 2010 15:21:36 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id v13sm640942wfv.5.2010.08.24.15.21.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:21:35 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:21:31 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154350>

These function traverse the given tree and set/clear object.flags

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 tree.h |    3 +++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/tree.c b/tree.c
index 5ab90af..434bf56 100644
--- a/tree.c
+++ b/tree.c
@@ -284,3 +284,47 @@ struct tree *parse_tree_indirect(const unsigned ch=
ar *sha1)
 			parse_object(obj->sha1);
 	} while (1);
 }
+
+void set_tree_marks(struct tree *tree, unsigned mark)
+{
+	struct name_entry entry;
+	struct tree_desc desc;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+
+	tree->object.flags |=3D mark;
+
+	buffer =3D read_sha1_file(tree->object.sha1, &type, &size);
+	if (!buffer || type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(tree->object.sha1));
+
+	init_tree_desc(&desc, buffer, size);
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode))
+			set_tree_marks(lookup_tree(entry.sha1), mark);
+	}
+	free(buffer);
+}
+
+void clear_tree_marks(struct tree *tree, unsigned mark)
+{
+	struct name_entry entry;
+	struct tree_desc desc;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+
+	tree->object.flags &=3D ~mark;
+
+	buffer =3D read_sha1_file(tree->object.sha1, &type, &size);
+	if (!buffer || type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(tree->object.sha1));
+
+	init_tree_desc(&desc, buffer, size);
+	while (tree_entry(&desc, &entry)) {
+		if (S_ISDIR(entry.mode))
+			clear_tree_marks(lookup_tree(entry.sha1), mark);
+	}
+	free(buffer);
+}
diff --git a/tree.h b/tree.h
index 2ff01a4..4376a3a 100644
--- a/tree.h
+++ b/tree.h
@@ -30,4 +30,7 @@ extern int read_tree_recursive(struct tree *tree,
=20
 extern int read_tree(struct tree *tree, int stage, const char **paths)=
;
=20
+extern void set_tree_marks(struct tree *tree, unsigned mark);
+extern void clear_tree_marks(struct tree *tree, unsigned mark);
+
 #endif /* TREE_H */
--=20
1.7.1.rc1.69.g24c2f7
