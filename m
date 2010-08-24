From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/32] narrow-tree: add oldest_narrow_base()
Date: Wed, 25 Aug 2010 08:20:18 +1000
Message-ID: <1282688422-7738-29-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:25:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1vd-0004Dg-VS
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166Ab0HXWYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:24:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab0HXWYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:24:04 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vu9o/yX5sfTZlRC79m0N49B+fD2MKl64bPT1P6xH3YQ=;
        b=wsjAcK/Bcd5K35LIdc91L84ZJiqPKc7nnrdnKhzNpGETk+78SehRep3BA69iUeKP82
         7Ip0Km+edyDXY/ginTIY7vL+U5Kk86V26pgM5Vr0liHyQn4PmUGv+7hzQn4OdiewrhWF
         KjDFl6CNAv2prCRh6gnMRa+EBbm1tRb6GmC2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Knv9H+KYDFRdrIdydKdRaGxz1vbbmpCtF5VxRkSHw/KohJKK5m9wzofZ6KP3Ozh0vP
         7KWEnvqbthb441onjvsucjMEJRdn0IcOlHACr4e8VPpCgX2v26nc3aTX7QuEtdZlw2Xt
         JXla1Z9P+qTMu7I/UFzslfo3ftYIPf07VHw8o=
Received: by 10.114.47.4 with SMTP id u4mr8463946wau.128.1282688644691;
        Tue, 24 Aug 2010 15:24:04 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id c24sm943898wam.19.2010.08.24.15.23.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:24:02 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:54 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154375>

This function helps solve another problem at client. Because
upload-narrow-base receives commits. What if they don't have those
commits because they are created locally?

The solution is to find the oldest commits that still have the same
narrow base (trees outside narrow tree) and use those commits with
hope that the server side also have them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 narrow-tree.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 narrow-tree.h |    1 +
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/narrow-tree.c b/narrow-tree.c
index 4a16647..f1b8902 100644
--- a/narrow-tree.c
+++ b/narrow-tree.c
@@ -150,3 +150,51 @@ int same_narrow_base(const unsigned char *t1, cons=
t unsigned char *t2, const cha
 	free(buf2);
 	return !desc1.size && !desc2.size;
 }
+
+int oldest_narrow_base(const unsigned char *sha1, unsigned char *newsh=
a1)
+{
+	enum object_type type;
+	unsigned long size;
+	char *buf, *bufptr;
+	unsigned char base[20], newbase[20], parent[20];
+
+	buf =3D read_sha1_file(sha1, &type, &size);
+	if (!buf || type !=3D OBJ_COMMIT) {
+		if (buf)
+			free(buf);
+		error("Not a commit %s", sha1_to_hex(sha1));
+		return 1;
+	}
+	get_sha1_hex(buf+5, base);
+	hashcpy(newsha1, sha1);
+
+	while (1) {
+		bufptr =3D buf + 46;	/* "tree " + "hex sha1" + "\n" */
+		if (!memcmp(bufptr, "parent ", 7)) {
+
+			/* more than one parent, a merge */
+			if (!memcmp(bufptr + 48, "parent ", 7))
+				break;
+
+			free(buf);
+			get_sha1_hex(bufptr + 7, parent);
+			buf =3D read_sha1_file(parent, &type, &size);
+			if (!buf ||type !=3D OBJ_COMMIT) {
+				if (buf)
+					free(buf);
+				error("Not a commit %s", sha1_to_hex(sha1));
+				return 1;
+			}
+			get_sha1_hex(buf+5, newbase);
+			if (!same_narrow_base(base, newbase, get_narrow_prefix()))
+				break;
+
+			hashcpy(newsha1, parent);
+			/* keep searching */
+		}
+		else		/* root commit */
+			break;
+	}
+	free(buf);
+	return 0;
+}
diff --git a/narrow-tree.h b/narrow-tree.h
index 8756094..78d6f39 100644
--- a/narrow-tree.h
+++ b/narrow-tree.h
@@ -2,3 +2,4 @@ extern int check_narrow_prefix();
 extern int join_narrow_tree(const unsigned char *base, unsigned char *=
newsha1,
 			    const unsigned char *subtree_sha1, const char *prefix);
 int same_narrow_base(const unsigned char *t1, const unsigned char *t2,=
 const char *prefix);
+int oldest_narrow_base(const unsigned char *sha1, unsigned char *newsh=
a1);
--=20
1.7.1.rc1.69.g24c2f7
