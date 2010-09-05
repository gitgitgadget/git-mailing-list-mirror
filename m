From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/17] unpack-trees: split traverse_trees() code into a separate function
Date: Sun,  5 Sep 2010 16:47:34 +1000
Message-ID: <1283669264-15759-8-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:49:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os92e-00086x-Ht
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab0IEGtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:49:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35545 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0IEGtS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:49:18 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so717333pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qmKExbez17GIkZRiW5ajnptKibLKY8QktSIs3z0401c=;
        b=lO2oGifxwZl0/sbGOOdIPEKtoN6pmx1Px/I0DURj7nig6LrQr4GtmvBUrIZMF8weTq
         CWTTxz7Yptizhlfqdn4uhp2Ts/enahDzGmJdUSkRLnnqa7308P0FRVgAyNaUCIIMzQcw
         OvDFOl1fQk6I1vCCf454cQZmE88oVTbyT3m9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=edk8IZRdCw00niBiDoDjeUa5C17vpOT4LL1fu8yTwDsEWzD06/ebv1ALd62XuLimX7
         21TRT5qChGyI1EvYd/7SjeXozsKNE0Ay8pjKmIGphMeY8b4Dz2OakGcAzb4nnf4PWKj6
         qaneNw3VQvBwhT2mjFAnQJ/xED17UTuKbQ9Rk=
Received: by 10.142.47.5 with SMTP id u5mr44205wfu.28.1283669358524;
        Sat, 04 Sep 2010 23:49:18 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id d39sm8038334wam.4.2010.09.04.23.49.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:49:17 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:49:10 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155433>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   64 ++++++++++++++++++++++++++++++------------------=
-------
 1 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3c7a7c9..4889e24 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -792,6 +792,39 @@ static int unpack_callback(int n, unsigned long ma=
sk, unsigned long dirmask, str
 	return mask;
 }
=20
+static int unpack_traverse(unsigned len, struct tree_desc *t, struct u=
npack_trees_options *o)
+{
+	const char *prefix =3D o->prefix ? o->prefix : "";
+	struct traverse_info info;
+
+	if (!len)
+		return 0;
+
+	setup_traverse_info(&info, prefix);
+	info.fn =3D unpack_callback;
+	info.data =3D o;
+	info.show_all_errors =3D o->show_all_errors;
+
+	if (o->prefix) {
+		/*
+		 * Unpack existing index entries that sort before the
+		 * prefix the tree is spliced into.  Note that o->merge
+		 * is always true in this case.
+		 */
+		while (1) {
+			struct cache_entry *ce =3D next_cache_entry(o);
+			if (!ce)
+				break;
+			if (ce_in_traverse_path(ce, &info))
+				break;
+			if (unpack_index_entry(ce, o) < 0)
+				return 1;
+		}
+	}
+
+	return traverse_trees(len, t, &info) < 0;
+}
+
 /*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to ma=
nipulate the
  * resulting index, -2 on failure to reflect the changes to the work t=
ree.
@@ -831,35 +864,8 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 		dfc =3D xcalloc(1, cache_entry_size(0));
 	o->df_conflict_entry =3D dfc;
=20
-	if (len) {
-		const char *prefix =3D o->prefix ? o->prefix : "";
-		struct traverse_info info;
-
-		setup_traverse_info(&info, prefix);
-		info.fn =3D unpack_callback;
-		info.data =3D o;
-		info.show_all_errors =3D o->show_all_errors;
-
-		if (o->prefix) {
-			/*
-			 * Unpack existing index entries that sort before the
-			 * prefix the tree is spliced into.  Note that o->merge
-			 * is always true in this case.
-			 */
-			while (1) {
-				struct cache_entry *ce =3D next_cache_entry(o);
-				if (!ce)
-					break;
-				if (ce_in_traverse_path(ce, &info))
-					break;
-				if (unpack_index_entry(ce, o) < 0)
-					goto return_failed;
-			}
-		}
-
-		if (traverse_trees(len, t, &info) < 0)
-			goto return_failed;
-	}
+	if (unpack_traverse(len, t, o))
+		goto return_failed;
=20
 	/* Any left-over entries in the index? */
 	if (o->merge) {
--=20
1.7.1.rc1.69.g24c2f7
