From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] sparse checkout: do not eagerly decide the fate for whole directory
Date: Mon,  2 May 2011 19:47:44 +0700
Message-ID: <1304340464-14829-3-git-send-email-pclouds@gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 14:51:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGsae-0006iB-Uo
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 14:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116Ab1EBMu7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 08:50:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47106 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303Ab1EBMu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 08:50:58 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so3021642pzk.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=+fdbslDznr/OU/QoPog8jFju8tkp5iK4gI8VLBkOkuQ=;
        b=Swx28G9vP+WfHuUrDLX5rc8fBxSEZ8oG9zGXTdh0p1RVj0DLno7Mzp+wGE7pGJHXR9
         blfTa/4H4sRl17HRis3zC9ccid63e+Upqd/D36pYGFP8YVB02JowoLwS8RolWO6DCObg
         s9e7MvXle8Nvf/ts0WNoDjI+0rcyK9RwKuRtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lI2PrZ6zsVdIQL265Ou5gkjedpCqirbBBbnN/fVS3tBIjkdVYvAzKTkYZQNjcNWARY
         KzHRk0+X7QXlGtQ5G3x5plEMagg8vdq6CDE7e/Lh7rwW2+N7TYYJFbO3871J257rdeG4
         tj+c+LUzzTSwWaY6K1Tzh1r3b+bpedbuoNkjU=
Received: by 10.68.66.1 with SMTP id b1mr8277781pbt.217.1304340658178;
        Mon, 02 May 2011 05:50:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.248.91])
        by mx.google.com with ESMTPS id o1sm3802661pbn.54.2011.05.02.05.50.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 05:50:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 02 May 2011 19:48:04 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172581>

Sparse-setting code follows closely how files are excluded in
read_directory(), every entry (including directories) are fed to
excluded_from_list() to decide if the entry is suitable. Directories
are treated no different than files. If a directory is matched (or
not), the whole directory is considered matched (or not) and the
process moves on.

This generally works as long as there are no patterns to exclude parts
of the directory. In case of sparse checkout code, the following patter=
ns

  t
  !t/t0000-basic.sh

will produce a worktree with full directory "t" even if t0000-basic.sh
is requested to stay out.

By the same reasoning, if a directory is to be excluded, any rules to
re-include certain files within that directory will be ignored.

=46ix it by always checking files against patterns. If no pattern can
decide (ie. excluded_from_list() returns -1), those files will be
included/excluded as same as their parent directory.

Noticed-by: <skillzero@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The TODO better be solved once read_directory() fixes the same fault.
 I have a feeling that some code can be shared..

 t/t1011-read-tree-sparse-checkout.sh |   41 ++++++++++++++++++++++
 unpack-trees.c                       |   63 ++++++++++++++++++--------=
-------
 2 files changed, 75 insertions(+), 29 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 3f9d66f..20a50eb 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -106,6 +106,47 @@ test_expect_success 'match directories without tra=
iling slash' '
 	test -f sub/added
 '
=20
+test_expect_success 'match directories with negated patterns' '
+	cat >expected.swt-negation <<\EOF &&
+S init.t
+S sub/added
+H sub/addedtoo
+S subsub/added
+EOF
+
+	cat >.git/info/sparse-checkout <<\EOF &&
+sub
+!sub/added
+EOF
+	git read-tree -m -u HEAD &&
+	git ls-files -t >result &&
+	test_cmp expected.swt-negation result &&
+	test ! -f init.t &&
+	test ! -f sub/added &&
+	test -f sub/addedtoo
+'
+
+test_expect_success 'match directories with negated patterns (2)' '
+	cat >expected.swt-negation2 <<\EOF &&
+H init.t
+H sub/added
+S sub/addedtoo
+H subsub/added
+EOF
+
+	cat >.git/info/sparse-checkout <<\EOF &&
+/*
+!sub
+sub/added
+EOF
+	git read-tree -m -u HEAD &&
+	git ls-files -t >result &&
+	test_cmp expected.swt-negation2 result &&
+	test -f init.t &&
+	test -f sub/added &&
+	test ! -f sub/addedtoo
+'
+
 test_expect_success 'match directory pattern' '
 	echo "s?b" >.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 500ebcf..5b8419c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -814,43 +814,45 @@ static int unpack_callback(int n, unsigned long m=
ask, unsigned long dirmask, str
 	return mask;
 }
=20
+static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+			    char *prefix, int prefix_len,
+			    int select_mask, int clear_mask,
+			    struct exclude_list *el, int defval);
+
 /* Whole directory matching */
 static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 			      char *prefix, int prefix_len,
 			      char *basename,
 			      int select_mask, int clear_mask,
-			      struct exclude_list *el)
+			      struct exclude_list *el, int defval)
 {
-	struct cache_entry **cache_end =3D cache + nr;
+	struct cache_entry **cache_end;
 	int dtype =3D DT_DIR;
 	int ret =3D excluded_from_list(prefix, prefix_len, basename, &dtype, =
el);
=20
 	prefix[prefix_len++] =3D '/';
=20
-	/* included, no clearing for any entries under this directory */
-	if (!ret) {
-		for (; cache !=3D cache_end; cache++) {
-			struct cache_entry *ce =3D *cache;
-			if (strncmp(ce->name, prefix, prefix_len))
-				break;
-		}
-		return nr - (cache_end - cache);
-	}
+	/* If undecided, use parent directory's decision in defval */
+	if (ret < 0)
+		ret =3D defval;
=20
-	/* excluded, clear all selected entries under this directory. */
-	if (ret =3D=3D 1) {
-		for (; cache !=3D cache_end; cache++) {
-			struct cache_entry *ce =3D *cache;
-			if (select_mask && !(ce->ce_flags & select_mask))
-				continue;
-			if (strncmp(ce->name, prefix, prefix_len))
-				break;
-			ce->ce_flags &=3D ~clear_mask;
-		}
-		return nr - (cache_end - cache);
+	for (cache_end =3D cache; cache_end !=3D cache + nr; cache_end++) {
+		struct cache_entry *ce =3D *cache_end;
+		if (strncmp(ce->name, prefix, prefix_len))
+			break;
 	}
=20
-	return 0;
+	/*
+	 * TODO: check el, if there are no patterns that may conflict
+	 * with ret (iow, we know in advance the the incl/excl
+	 * decision for the entire directory), clear flag here without
+	 * calling clear_ce_flags_1(). That function will call
+	 * the expensive excluded_from_list() on every entry.
+	 */
+	return clear_ce_flags_1(cache, cache_end - cache,
+				prefix, prefix_len,
+				select_mask, clear_mask,
+				el, ret);
 }
=20
 /*
@@ -871,7 +873,7 @@ static int clear_ce_flags_dir(struct cache_entry **=
cache, int nr,
 static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			    char *prefix, int prefix_len,
 			    int select_mask, int clear_mask,
-			    struct exclude_list *el)
+			    struct exclude_list *el, int defval)
 {
 	struct cache_entry **cache_end =3D cache + nr;
=20
@@ -882,7 +884,7 @@ static int clear_ce_flags_1(struct cache_entry **ca=
che, int nr,
 	while(cache !=3D cache_end) {
 		struct cache_entry *ce =3D *cache;
 		const char *name, *slash;
-		int len, dtype;
+		int len, dtype, ret;
=20
 		if (select_mask && !(ce->ce_flags & select_mask)) {
 			cache++;
@@ -911,7 +913,7 @@ static int clear_ce_flags_1(struct cache_entry **ca=
che, int nr,
 						       prefix, prefix_len + len,
 						       prefix + prefix_len,
 						       select_mask, clear_mask,
-						       el);
+						       el, defval);
=20
 			/* clear_c_f_dir eats a whole dir already? */
 			if (processed) {
@@ -922,13 +924,16 @@ static int clear_ce_flags_1(struct cache_entry **=
cache, int nr,
 			prefix[prefix_len + len++] =3D '/';
 			cache +=3D clear_ce_flags_1(cache, cache_end - cache,
 						  prefix, prefix_len + len,
-						  select_mask, clear_mask, el);
+						  select_mask, clear_mask, el, defval);
 			continue;
 		}
=20
 		/* Non-directory */
 		dtype =3D ce_to_dtype(ce);
-		if (excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, el) >=
 0)
+		ret =3D excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, e=
l);
+		if (ret < 0)
+			ret =3D defval;
+		if (ret > 0)
 			ce->ce_flags &=3D ~clear_mask;
 		cache++;
 	}
@@ -943,7 +948,7 @@ static int clear_ce_flags(struct cache_entry **cach=
e, int nr,
 	return clear_ce_flags_1(cache, nr,
 				prefix, 0,
 				select_mask, clear_mask,
-				el);
+				el, 0);
 }
=20
 /*
--=20
1.7.4.74.g639db
