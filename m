From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/23] unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
Date: Mon, 14 Dec 2009 17:31:02 +0700
Message-ID: <1260786666-8405-20-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FN-0007wL-AI
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbZLNKdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756229AbZLNKdi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:38 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:56204 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189AbZLNKd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:26 -0500
Received: by pzk1 with SMTP id 1so2178509pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=VaEv6tGL2NyxNofMF1KQpSmqNLwqvVY0WuO/drNVTTM=;
        b=cdH0mOho9AmENoqCuX158pG8GOKCsHZ32913/3bmHJW+oBDWo1mvPGD0Gie+zbWcD7
         cmak9pXqc/t+LN4pW80Na9y8l5oIej7eF3UEn3tfEH3MkwKtQsBRLlpGi2YbwlL7a/px
         c5t+mrHFQkK64d384MayvGq0y8GonQgTNTNGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fl185YoQb+hJQazZo6L71vIqYvt6cf1aLJt2DhuPbZ8yo47jHQ4/Xm5lkwTFXx56Qd
         uZ5J/IVMlQ4+kTTO0lru0V6ceb54Bm5QTfI2Z1bqB0xyrks+7YZsUfpsjTyFLyxLtHR3
         FWp/NAxU0MGoGvhyyvf2RcY16IWxgFp5b88tU=
Received: by 10.114.165.20 with SMTP id n20mr3126360wae.6.1260786806077;
        Mon, 14 Dec 2009 02:33:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4917031pzk.0.2009.12.14.02.33.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:44 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135178>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 unpack-trees.h |    2 +
 2 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 56f1a30..6288385 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -32,6 +32,12 @@ static struct unpack_trees_error_msgs unpack_plumbin=
g_errors =3D {
=20
 	/* bind_overlap */
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
+
+	/* sparse_not_uptodate_file */
+	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+
+	/* would_lose_orphaned */
+	"Working tree file '%s' would be %s by sparse checkout update.",
 };
=20
 #define ERRORMSG(o,fld) \
@@ -125,6 +131,57 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
 	return errs !=3D 0;
 }
=20
+static int verify_uptodate_sparse(struct cache_entry *ce, struct unpac=
k_trees_options *o);
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion, struct unpack_trees_options *o);
+
+static int will_have_skip_worktree(const struct cache_entry *ce, struc=
t unpack_trees_options *o)
+{
+	const char *basename;
+
+	if (ce_stage(ce))
+		return 0;
+
+	basename =3D strrchr(ce->name, '/');
+	basename =3D basename ? basename+1 : ce->name;
+	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, o=
->el) <=3D 0;
+}
+
+static int apply_sparse_checkout(struct cache_entry *ce, struct unpack=
_trees_options *o)
+{
+	int was_skip_worktree =3D ce_skip_worktree(ce);
+
+	if (will_have_skip_worktree(ce, o))
+		ce->ce_flags |=3D CE_SKIP_WORKTREE;
+	else
+		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
+
+	/*
+	 * We only care about files getting into the checkout area
+	 * If merge strategies want to remove some, go ahead, this
+	 * flag will be removed eventually in unpack_trees() if it's
+	 * outside checkout area.
+	 */
+	if (ce->ce_flags & CE_REMOVE)
+		return 0;
+
+	if (!was_skip_worktree && ce_skip_worktree(ce)) {
+		/*
+		 * If CE_UPDATE is set, verify_uptodate() must be called already
+		 * also stat info may have lost after merged_entry() so calling
+		 * verify_uptodate() again may fail
+		 */
+		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
+			return -1;
+		ce->ce_flags |=3D CE_WT_REMOVE;
+	}
+	if (was_skip_worktree && !ce_skip_worktree(ce)) {
+		if (verify_absent_sparse(ce, "overwritten", o))
+			return -1;
+		ce->ce_flags |=3D CE_UPDATE;
+	}
+	return 0;
+}
+
 static inline int call_unpack_fn(struct cache_entry **src, struct unpa=
ck_trees_options *o)
 {
 	int ret =3D o->fn(src, o);
@@ -376,7 +433,7 @@ static int unpack_failed(struct unpack_trees_option=
s *o, const char *message)
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_tree=
s_options *o)
 {
-	int ret;
+	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
=20
@@ -440,6 +497,17 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 		goto done;
 	}
=20
+	if (!o->skip_sparse_checkout) {
+		for (i =3D 0;i < o->result.cache_nr;i++) {
+			struct cache_entry *ce =3D o->result.cache[i];
+
+			if (apply_sparse_checkout(ce, o)) {
+				ret =3D -1;
+				goto done;
+			}
+		}
+	}
+
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -512,6 +580,12 @@ static int verify_uptodate(struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
 }
=20
+static int verify_uptodate_sparse(struct cache_entry *ce,
+				  struct unpack_trees_options *o)
+{
+	return verify_uptodate_1(ce, o, ERRORMSG(o, sparse_not_uptodate_file)=
);
+}
+
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_t=
rees_options *o)
 {
 	if (ce)
@@ -705,6 +779,12 @@ static int verify_absent(struct cache_entry *ce, c=
onst char *action,
 	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracke=
d));
 }
=20
+static int verify_absent_sparse(struct cache_entry *ce, const char *ac=
tion,
+			 struct unpack_trees_options *o)
+{
+	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_orphaned=
));
+}
+
 static int merged_entry(struct cache_entry *merge, struct cache_entry =
*old,
 		struct unpack_trees_options *o)
 {
diff --git a/unpack-trees.h b/unpack-trees.h
index 5c9e98a..95ff36c 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -15,6 +15,8 @@ struct unpack_trees_error_msgs {
 	const char *not_uptodate_dir;
 	const char *would_lose_untracked;
 	const char *bind_overlap;
+	const char *sparse_not_uptodate_file;
+	const char *would_lose_orphaned;
 };
=20
 struct unpack_trees_options {
--=20
1.6.5.2.216.g9c1ec
