From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] ls-files: support --max-depth
Date: Fri,  8 Jan 2010 00:07:54 +0700
Message-ID: <1262884076-12293-2-git-send-email-pclouds@gmail.com>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 18:09:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvrJ-0003TN-6L
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab0AGRJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 12:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359Ab0AGRJL
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:09:11 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:63795 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab0AGRJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:09:09 -0500
Received: by ywh6 with SMTP id 6so18630285ywh.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 09:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=29MAGDvAnqqb7hewSKEUkCqENmmV4jUg9HgJb+AZo6I=;
        b=bQQuNXLzj6CKaPaSFwEn/CdcgGZC/SRL5j2g/HiC8Sjnf1P837beSeCH0UuhtnC8OE
         TssBqvm5uUwbcVCi4BHXTsshw7YT2G1sqZWA8spUL+cLtoTUkFoq0K4rH0gm5a+9cQQX
         Hu7E3OOFT9JBTe2/Hxuj1aEbv3nr41f+Z3I9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AqvBplSlbqqOyEsJRnYknO3lQ/znExJYXY0spY1otmBHhErOb/UDeQE6UMRO/ilqvn
         ++1v21CJuNjYDz9EMIwDpeElKNd7lBy1wBXIBodk+qNGwwE3p4Kdw9129fqVemeQDk6p
         3IIpXE1mHEtDWJQ8mbqSkGF91a/89tGU2JPtw=
Received: by 10.90.23.38 with SMTP id 38mr728900agw.57.1262884141518;
        Thu, 07 Jan 2010 09:09:01 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 14sm10783095gxk.10.2010.01.07.09.08.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 09:08:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri,  8 Jan 2010 00:08:12 +0700
X-Mailer: git-send-email 1.6.6.315.g1a406
In-Reply-To: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136361>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 7382157..2bb851a 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -30,6 +30,7 @@ static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
+static int max_depth =3D 0;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -232,6 +233,30 @@ static void prune_cache(const char *prefix)
 	active_nr =3D last;
 }
=20
+/*
+ * It is assumed that prune_cache() as been called before this
+ */
+static void prune_cache_by_depth(const char *prefix, int max_depth)
+{
+	int i =3D active_nr-1;
+
+	while (i >=3D 0) {
+		int slashes =3D 0;
+		const char *entry =3D active_cache[i]->name + prefix_len;
+		while ((entry =3D strchr(entry, '/')) !=3D NULL) {
+			slashes++;
+			if (slashes >=3D max_depth) {
+				memmove(active_cache + i, active_cache + i + 1,
+					(active_nr - i - 1) * sizeof(struct cache_entry *));
+				active_nr--;
+				break;
+			}
+			entry++;
+		}
+		i--;
+	}
+}
+
 static const char *verify_pathspec(const char *prefix)
 {
 	const char **p, *n, *prev;
@@ -476,6 +501,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 			"if any <file> is not in the index, treat this as an error"),
 		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
 			"pretend that paths removed since <tree-ish> are still present"),
+		OPT_INTEGER(0, "max-depth", &max_depth, "max recursive depth"),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -541,6 +567,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
=20
 	if (prefix)
 		prune_cache(prefix);
+
+	if (max_depth)
+		prune_cache_by_depth(prefix, max_depth);
+
 	if (with_tree) {
 		/*
 		 * Basic sanity check; show-stages and show-unmerged
--=20
1.6.6.315.g1a406
