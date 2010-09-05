From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/17] tree.c: add path_to_sha1()
Date: Sun,  5 Sep 2010 16:47:29 +1000
Message-ID: <1283669264-15759-3-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:48:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os920-0007rI-W5
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134Ab0IEGsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:48:31 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36326 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0IEGsa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:48:30 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so649695pxi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PAlOFDuuwIscnqKyADI6ozV63L+YTzR2NILc5vx9AHI=;
        b=nCkxhfj5cTyFKBm8P+Cn7iZKAhjBueWCldTxTIY1wj+gzMGFrtqCrFYz+YAfG/XrX1
         Ynw7mqPoKeScBN6tCETTgvR5EobFGB9ck2HbXvSoVPHgU3HedAJoHTFDkK7UVOAkwH/G
         m8dm92PtkDUEAV9vzzejLjLOf37YWW7tcRNXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FglDsZzxmyfBB5hP0QN6FKYOV0UkzVz12WYMiOeXjLYmQq5PtSCw80s1EXniSUq2zy
         OewHPlBqQV3BNSOd2aTv8uU8kaSEssASv0R0lbfomHNdK/Ewx7KszYRtfXruRoOEuoph
         fl2+KZKGK6CG36+xbH/oN/84w4wcgcVv2rtYw=
Received: by 10.142.213.3 with SMTP id l3mr1123570wfg.6.1283669310343;
        Sat, 04 Sep 2010 23:48:30 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id n36sm1971663wfa.4.2010.09.04.23.48.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:48:29 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:48:22 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155428>

Given a tree and a path, it will traverse down the tree, follow the
path and return sha1 of the path.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree.c |   35 +++++++++++++++++++++++++++++++++++
 tree.h |    2 ++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/tree.c b/tree.c
index 5ab90af..2c7ae45 100644
--- a/tree.c
+++ b/tree.c
@@ -284,3 +284,38 @@ struct tree *parse_tree_indirect(const unsigned ch=
ar *sha1)
 			parse_object(obj->sha1);
 	} while (1);
 }
+
+int path_to_tree_sha1(unsigned char *newsha1, const unsigned char *sha=
1, const char *path)
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
+				return path_to_tree_sha1(newsha1, entry.sha1, slash+1);
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
index 2ff01a4..d246a6c 100644
--- a/tree.h
+++ b/tree.h
@@ -30,4 +30,6 @@ extern int read_tree_recursive(struct tree *tree,
=20
 extern int read_tree(struct tree *tree, int stage, const char **paths)=
;
=20
+extern int path_to_tree_sha1(unsigned char *newsha1, const unsigned ch=
ar *sha1, const char *path);
+
 #endif /* TREE_H */
--=20
1.7.1.rc1.69.g24c2f7
