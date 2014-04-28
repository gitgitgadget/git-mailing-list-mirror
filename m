From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/32] entry.c: update cache_changed if refresh_cache is set in checkout_entry()
Date: Mon, 28 Apr 2014 17:55:36 +0700
Message-ID: <1398682553-11634-16-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:58:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejG6-0004oe-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbaD1K57 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:57:59 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38689 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbaD1Kzy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:54 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2200783pdj.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+cI7mpvjwpbP2g8W+ZIWXoG2Ag6br82r7/pJ79JWtIY=;
        b=X/uMTKt9sdXLaNLekirUNXaSoY7bHhARY+6tmPV2ozwzh4NiEC+KC1ct+4NWn3rloP
         R3TvKBa1AsR+hAqmfweudFuWGgZXpQTDJPHAeX4HSObj39FmALNvQZUR5sRroF0nLNu3
         c5ZaqttBF9vuhV/8DPB52xDo6+zsOcI6elJJ8GFjF2CQCYfdHPhgzgnffM0pcVD31G4H
         kOLbWux+qAaKFQgCrXLAuoUhVJRRyR3PLVWaFWlfHYU3UhCzgzkuvZaN64eYv1qbVXRz
         X2pYq23ioMbSY2js64CvX51w26Ok5XBP2zJIXGyUwhZzgC8+KHQODqnuhgKzVr9pGVKX
         c6UA==
X-Received: by 10.68.233.37 with SMTP id tt5mr2625639pbc.154.1398682553600;
        Mon, 28 Apr 2014 03:55:53 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id ff4sm89612210pad.24.2014.04.28.03.55.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:21 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247297>

Other fill_stat_cache_info() is on new entries, which should set
CE_ENTRY_ADDED in cache_changed, so we're safe.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c          | 8 +++++---
 builtin/checkout-index.c | 1 +
 builtin/checkout.c       | 1 +
 cache.h                  | 1 +
 entry.c                  | 2 ++
 unpack-trees.c           | 1 +
 6 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5e13444..adca035 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3084,13 +3084,15 @@ static void prepare_fn_table(struct patch *patc=
h)
 	}
 }
=20
-static int checkout_target(struct cache_entry *ce, struct stat *st)
+static int checkout_target(struct index_state *istate,
+			   struct cache_entry *ce, struct stat *st)
 {
 	struct checkout costate;
=20
 	memset(&costate, 0, sizeof(costate));
 	costate.base_dir =3D "";
 	costate.refresh_cache =3D 1;
+	costate.istate =3D istate;
 	if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
 		return error(_("cannot checkout %s"), ce->name);
 	return 0;
@@ -3257,7 +3259,7 @@ static int load_current(struct image *image, stru=
ct patch *patch)
 	if (lstat(name, &st)) {
 		if (errno !=3D ENOENT)
 			return error(_("%s: %s"), name, strerror(errno));
-		if (checkout_target(ce, &st))
+		if (checkout_target(&the_index, ce, &st))
 			return -1;
 	}
 	if (verify_index_match(ce, &st))
@@ -3411,7 +3413,7 @@ static int check_preimage(struct patch *patch, st=
ruct cache_entry **ce, struct s
 		}
 		*ce =3D active_cache[pos];
 		if (stat_ret < 0) {
-			if (checkout_target(*ce, st))
+			if (checkout_target(&the_index, *ce, st))
 				return -1;
 		}
 		if (!cached && verify_index_match(*ce, st))
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9e49bf2..05edd9e 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -135,6 +135,7 @@ static int option_parse_u(const struct option *opt,
 	int *newfd =3D opt->value;
=20
 	state.refresh_cache =3D 1;
+	state.istate =3D &the_index;
 	if (*newfd < 0)
 		*newfd =3D hold_locked_index(&lock_file, 1);
 	return 0;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 944a634..146ab91 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -336,6 +336,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 	memset(&state, 0, sizeof(state));
 	state.force =3D 1;
 	state.refresh_cache =3D 1;
+	state.istate =3D &the_index;
 	for (pos =3D 0; pos < active_nr; pos++) {
 		struct cache_entry *ce =3D active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
diff --git a/cache.h b/cache.h
index 4c288e8..9bbebab 100644
--- a/cache.h
+++ b/cache.h
@@ -1063,6 +1063,7 @@ extern int split_ident_line(struct ident_split *,=
 const char *, int);
 extern int ident_cmp(const struct ident_split *, const struct ident_sp=
lit *);
=20
 struct checkout {
+	struct index_state *istate;
 	const char *base_dir;
 	int base_dir_len;
 	unsigned force:1,
diff --git a/entry.c b/entry.c
index 77c6882..d913c1d 100644
--- a/entry.c
+++ b/entry.c
@@ -210,9 +210,11 @@ static int write_entry(struct cache_entry *ce,
=20
 finish:
 	if (state->refresh_cache) {
+		assert(state->istate);
 		if (!fstat_done)
 			lstat(ce->name, &st);
 		fill_stat_cache_info(ce, &st);
+		state->istate->cache_changed |=3D CE_ENTRY_CHANGED;
 	}
 	return 0;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 3beff8a..26f65c7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1029,6 +1029,7 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 	state.force =3D 1;
 	state.quiet =3D 1;
 	state.refresh_cache =3D 1;
+	state.istate =3D &o->result;
=20
 	memset(&el, 0, sizeof(el));
 	if (!core_apply_sparse_checkout || !o->update)
--=20
1.9.1.346.ga2b5940
