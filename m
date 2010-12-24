From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] sha1_name: move interpret_nth_prior_checkout closer to interpret_branch_name
Date: Fri, 24 Dec 2010 21:07:47 +0700
Message-ID: <1293199669-19016-4-git-send-email-pclouds@gmail.com>
References: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kevin@sb.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 15:09:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW8L2-000736-QF
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 15:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab0LXOJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 09:09:32 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61411 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0LXOJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 09:09:31 -0500
Received: by pva4 with SMTP id 4so1330022pva.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 06:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GY6ydclfbjgMreh7M9v/KyX0SBenuqZp7wMyovtbOxI=;
        b=mCcsXuKftPhVaQA48+1u6QYyRAFI76ijZUSo+onfGx/cL5H88Z0aDNVXR9MDyLY38G
         /YGkXCNSVW2rSUdilWHGerFz7O5Ptxm/2QsWLn1UbYCtEvAwI7EGZdQEL/xu/cgecTp9
         p0c63q7GRrJVEmKcJzpmR1rTGh1hr/Waq8cJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HUijftQmcm0JbGUGrmFxqQ2rFQ1TMOMii7VmZ8V/66tN7FQl23RBVClBY5bHLvdi0S
         HwVaOH3PkL36b4HdQievjDF6/LDBGXw1BP8xbNyHExne3qYZ96Di7/SNEzKPMx88Ul3U
         qDGn2CBRwdP/0y6d7wlzUmwn6CLFEmfxGdHBI=
Received: by 10.142.234.10 with SMTP id g10mr7563593wfh.436.1293199770713;
        Fri, 24 Dec 2010 06:09:30 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id q13sm12365379wfc.17.2010.12.24.06.09.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 06:09:29 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Dec 2010 21:08:13 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1293199669-19016-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164156>

interpret_nth_prior_checkout() is a subfunction of
interpret_branch_name(). So it's better to let them be close together
(i.e. not letting get_sha1_mb() stays in between).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_name.c |   84 +++++++++++++++++++++++++++++----------------------=
-------
 1 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3a98a50..dcdf1e6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -883,6 +883,48 @@ static int grab_nth_branch_switch(unsigned char *o=
sha1, unsigned char *nsha1,
 	return 0;
 }
=20
+int get_sha1_mb(const char *name, unsigned char *sha1)
+{
+	struct commit *one, *two;
+	struct commit_list *mbs;
+	unsigned char sha1_tmp[20];
+	const char *dots;
+	int st;
+
+	dots =3D strstr(name, "...");
+	if (!dots)
+		return get_sha1(name, sha1);
+	if (dots =3D=3D name)
+		st =3D get_sha1("HEAD", sha1_tmp);
+	else {
+		struct strbuf sb;
+		strbuf_init(&sb, dots - name);
+		strbuf_add(&sb, name, dots - name);
+		st =3D get_sha1(sb.buf, sha1_tmp);
+		strbuf_release(&sb);
+	}
+	if (st)
+		return st;
+	one =3D lookup_commit_reference_gently(sha1_tmp, 0);
+	if (!one)
+		return -1;
+
+	if (get_sha1(dots[3] ? (dots + 3) : "HEAD", sha1_tmp))
+		return -1;
+	two =3D lookup_commit_reference_gently(sha1_tmp, 0);
+	if (!two)
+		return -1;
+	mbs =3D get_merge_bases(one, two, 1);
+	if (!mbs || mbs->next)
+		st =3D -1;
+	else {
+		st =3D 0;
+		hashcpy(sha1, mbs->item->object.sha1);
+	}
+	free_commit_list(mbs);
+	return st;
+}
+
 /*
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
@@ -931,48 +973,6 @@ release_return:
 	return retval;
 }
=20
-int get_sha1_mb(const char *name, unsigned char *sha1)
-{
-	struct commit *one, *two;
-	struct commit_list *mbs;
-	unsigned char sha1_tmp[20];
-	const char *dots;
-	int st;
-
-	dots =3D strstr(name, "...");
-	if (!dots)
-		return get_sha1(name, sha1);
-	if (dots =3D=3D name)
-		st =3D get_sha1("HEAD", sha1_tmp);
-	else {
-		struct strbuf sb;
-		strbuf_init(&sb, dots - name);
-		strbuf_add(&sb, name, dots - name);
-		st =3D get_sha1(sb.buf, sha1_tmp);
-		strbuf_release(&sb);
-	}
-	if (st)
-		return st;
-	one =3D lookup_commit_reference_gently(sha1_tmp, 0);
-	if (!one)
-		return -1;
-
-	if (get_sha1(dots[3] ? (dots + 3) : "HEAD", sha1_tmp))
-		return -1;
-	two =3D lookup_commit_reference_gently(sha1_tmp, 0);
-	if (!two)
-		return -1;
-	mbs =3D get_merge_bases(one, two, 1);
-	if (!mbs || mbs->next)
-		st =3D -1;
-	else {
-		st =3D 0;
-		hashcpy(sha1, mbs->item->object.sha1);
-	}
-	free_commit_list(mbs);
-	return st;
-}
-
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
--=20
1.7.3.3.476.g10a82
