From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/32] tree-diff: add narrow versions of diff_{root_,}tree_sha1
Date: Wed, 25 Aug 2010 08:20:07 +1000
Message-ID: <1282688422-7738-18-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:23:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uL-00030j-0p
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab0HXWWu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab0HXWWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:48 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YwvbvPbC6vxSdl27RvQ+aR+OlEE7GntKhYorxn3bRYA=;
        b=GS1+jvAvze6YYexOAU6hEyRfR7AdSouVlHCIsh8A83jdLT5KW4luly0yvaxOzVirtx
         zMcbMfgLyQVbJqzkV26cvyuIQnGG1G3HDfz49Wxp2+4bY7KqIOESS4Ln5YkRCX+dr0Zz
         aprI71dvssjdvrhBzW0KVDabpZBLEM0l4vRmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RcOZPUIN1xswjWZHiCyQyUfIyb/yPMkpfXvMwhWKoda9ofIuX2rK5dz5uTfuVtjWBq
         oX4uVgNcSTE6YmdHwiPRjCqC1qFyK19RIJXmEm3nuqU4tBEhKp6FN2LzbMAj1tIiiKZA
         HdrAixIok3UowJQdDmQYnpOMtTWqy1LbqbxZU=
Received: by 10.142.170.19 with SMTP id s19mr6382169wfe.97.1282688568197;
        Tue, 24 Aug 2010 15:22:48 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id y16sm644261wff.2.2010.08.24.15.22.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:47 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:42 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154361>

These versions assume that the given trees for diff are toplevel
trees. They simply go down to find $GIT_DIR/narrow subtree and do diff
on those trees instead. diff_tree_sha1 callers must be adapted to use
this version to support narrow repos.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.h      |    5 ++++
 tree-diff.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/diff.h b/diff.h
index d43da9d..13b4f10 100644
--- a/diff.h
+++ b/diff.h
@@ -171,6 +171,11 @@ extern int diff_tree_sha1(const unsigned char *old=
, const unsigned char *new,
 extern int diff_root_tree_sha1(const unsigned char *new, const char *b=
ase,
                                struct diff_options *opt);
=20
+extern int narrow_diff_tree_sha1(const unsigned char *old, const unsig=
ned char *new,
+				 const char *base, struct diff_options *opt);
+extern int narrow_diff_root_tree_sha1(const unsigned char *new, const =
char *base,
+				      struct diff_options *opt);
+
 struct combine_diff_path {
 	struct combine_diff_path *next;
 	int len;
diff --git a/tree-diff.c b/tree-diff.c
index cd659c6..31b0842 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -433,6 +433,45 @@ int diff_tree_sha1(const unsigned char *old, const=
 unsigned char *new, const cha
 	return retval;
 }
=20
+int narrow_diff_tree_sha1(const unsigned char *old, const unsigned cha=
r *new, const char *base, struct diff_options *opt)
+{
+	unsigned char old2[20], new2[20];
+	char *new_base =3D NULL;
+	int retval;
+
+	if (get_narrow_prefix()) {
+		int len1 =3D strlen(get_narrow_prefix());
+		int len2 =3D base ? strlen(base) : 0;
+		unsigned long size;
+		unsigned char deref_sha1[20];
+
+		if (len2 && !strncmp(base, get_narrow_prefix(), len1) &&
+		    (base[len1] =3D=3D '/' || base[len1] =3D=3D '\0'))
+			;	/* good */
+		else {
+			new_base =3D xmalloc(len1 + 1 + len2 + 1);
+			memcpy(new_base, get_narrow_prefix, len1+1);
+			if (len2) {
+				new_base[len1] =3D '/';
+				memcpy(new_base+len1+1, base, len2+1);
+			}
+			base =3D new_base;
+		}
+
+		free(read_object_with_reference(old, tree_type, &size, deref_sha1));
+		if (!find_tree(deref_sha1, old2, get_narrow_prefix()))
+			hashcpy(old2, (const unsigned char *)EMPTY_TREE_SHA1_BIN);
+		old =3D old2;
+		free(read_object_with_reference(new, tree_type, &size, deref_sha1));
+		if (!find_tree(deref_sha1, new2, get_narrow_prefix()))
+			hashcpy(new2, (const unsigned char *)EMPTY_TREE_SHA1_BIN);
+		new =3D new2;
+	}
+	retval =3D diff_tree_sha1(old, new, base, opt);
+	free(new_base);
+	return retval;
+}
+
 int diff_root_tree_sha1(const unsigned char *new, const char *base, st=
ruct diff_options *opt)
 {
 	int retval;
@@ -451,6 +490,41 @@ int diff_root_tree_sha1(const unsigned char *new, =
const char *base, struct diff_
 	return retval;
 }
=20
+int narrow_diff_root_tree_sha1(const unsigned char *new, const char *b=
ase, struct diff_options *opt)
+{
+	unsigned char new2[20];
+	char *new_base =3D NULL;
+	int retval;
+
+	if (get_narrow_prefix()) {
+		int len1 =3D strlen(get_narrow_prefix());
+		int len2 =3D base ? strlen(base) : 0;
+		unsigned long size;
+		unsigned char deref_sha1[20];
+
+		if (len2 && !strncmp(base, get_narrow_prefix(), len1) &&
+		    (base[len1] =3D=3D '/' || base[len1] =3D=3D '\0'))
+			;	/* good */
+		else {
+			new_base =3D xmalloc(len1 + 1 + len2 + 1);
+			memcpy(new_base, get_narrow_prefix, len1+1);
+			if (len2) {
+				new_base[len1] =3D '/';
+				memcpy(new_base+len1+1, base, len2+1);
+			}
+			base =3D new_base;
+		}
+
+		free(read_object_with_reference(new, tree_type, &size, deref_sha1));
+		if (!find_tree(deref_sha1, new2, get_narrow_prefix()))
+			hashcpy(new2, (const unsigned char *)EMPTY_TREE_SHA1_BIN);
+		new =3D new2;
+	}
+	retval =3D diff_root_tree_sha1(new, base, opt);
+	free(new_base);
+	return retval;
+}
+
 static int count_paths(const char **paths)
 {
 	int i =3D 0;
--=20
1.7.1.rc1.69.g24c2f7
