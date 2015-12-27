From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/6] nd/ita-cleanup updates
Date: Sun, 27 Dec 2015 08:51:26 +0700
Message-ID: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 02:52:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD0VF-0006Cl-Do
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 02:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbbL0Bva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 20:51:30 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33485 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbbL0Bv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 20:51:29 -0500
Received: by mail-pa0-f46.google.com with SMTP id cy9so93272882pac.0
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 17:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=7xWDSGdICFYnUzDXA05wUen4kX+HEmIcRJ0CSENOApI=;
        b=e1GFNutraGsm6segXPTiCPVNQDt60SN7Le7QSA7He+gG3UZQQ6EswqoKtCyXO6Jcxj
         sE3uYXKE+WxDrCcgKRw2cKV8LI6S9no55lxD+cMmNv/d2ryzcoTigKRj/eSsSxGAADfr
         JeC08No2x7IigYVdNzYs4dYIXboMg8Lm0R7vLRMZgINDVHmhP2IE2PCKtw0J4VpUraId
         mah6xYc3ocxx9SFL83Ay1533lM6/sOeD2RJ1Ev2YaKzTgeXtv31egvu2gk0kZPSJiizp
         0gFKqPjTPBy5OxI7YfOgbSPq0NlLR+lgbwrdbRDkxDi58e6z3cUNxx5MC/NiOEtBK8uR
         edyQ==
X-Received: by 10.66.140.14 with SMTP id rc14mr27152729pab.65.1451181088719;
        Sat, 26 Dec 2015 17:51:28 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id w23sm44785389pfa.24.2015.12.26.17.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 17:51:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 08:51:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283001>

Most of the updates are in commit message (see the old thread [1]). I
give up on adding new tests for git-apply, finally admitting I don't
know that command that well. Code change from 'pu' version is entirely
in 5/6:

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 687c82e..d9fe8f4 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -48,6 +48,7 @@ static int checkout_file(const char *name, const char=
 *prefix)
 	int pos =3D cache_name_pos(name, namelen);
 	int has_same_name =3D 0;
 	int did_checkout =3D 0;
+	int has_intent_to_add =3D 0;
 	int errs =3D 0;
=20
 	if (pos < 0)
@@ -56,9 +57,11 @@ static int checkout_file(const char *name, const cha=
r *prefix)
 	while (pos < active_nr) {
 		struct cache_entry *ce =3D active_cache[pos];
 		if (ce_namelen(ce) !=3D namelen ||
-		    memcmp(ce->name, name, namelen) ||
-		    ce_intent_to_add(ce))
+		    memcmp(ce->name, name, namelen)) {
+			if (ce_intent_to_add(ce))
+				has_intent_to_add =3D 1;
 			break;
+		}
 		has_same_name =3D 1;
 		pos++;
 		if (ce_stage(ce) !=3D checkout_stage
@@ -78,7 +81,9 @@ static int checkout_file(const char *name, const char=
 *prefix)
=20
 	if (!state.quiet) {
 		fprintf(stderr, "git checkout-index: %s ", name);
-		if (!has_same_name)
+		if (has_intent_to_add)
+			fprintf(stderr, "is not yet in the cache");
+		else if (!has_same_name)
 			fprintf(stderr, "is not in the cache");
 		else if (checkout_stage)
 			fprintf(stderr, "does not exist at stage %d",
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6d198b3..ac37d92 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -300,8 +300,6 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 			 * anything to this entry at all.
 			 */
 			continue;
-		if (ce_intent_to_add(ce))
-			continue;
 		/*
 		 * Either this entry came from the tree-ish we are
 		 * checking the paths out of, or we are checking out
@@ -330,12 +328,15 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
 	if (opts->merge)
 		unmerge_marked_index(&the_index);
=20
-	/* Any unmerged paths? */
 	for (pos =3D 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce =3D active_cache[pos];
+		struct cache_entry *ce =3D active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
-			if (!ce_stage(ce))
+			if (!ce_stage(ce)) {
+				if (ce_intent_to_add(ce))
+					ce->ce_flags &=3D ~CE_MATCHED;
 				continue;
+			}
+			/* Unmerged paths */
 			if (opts->force) {
 				warning(_("path '%s' is unmerged"), ce->name);
 			} else if (opts->writeout_stage) {
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index d0f36a4..52e9f7f 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -117,7 +117,7 @@ test_expect_success 'checkout ignores i-t-a' '
 		cd checkout &&
 		echo data >file &&
 		git add -N file &&
-		test_must_fail git checkout -- file &&
+		git checkout -- file &&
 		echo data >expected &&
 		test_cmp expected file
 	)

[1] http://thread.gmane.org/gmane.comp.version-control.git/272363/focus=
=3D276352

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  blame: remove obsolete comment
  Add and use convenient macro ce_intent_to_add()
  apply: fix adding new files on i-t-a entries
  apply: make sure check_preimage() does not leave empty file on error
  checkout(-index): do not checkout i-t-a entries
  grep: make it clear i-t-a entries are ignored

 builtin/apply.c          | 13 +++++-----
 builtin/blame.c          |  5 ----
 builtin/checkout-index.c | 12 +++++++--
 builtin/checkout.c       |  9 ++++---
 builtin/grep.c           |  2 +-
 builtin/rm.c             |  2 +-
 cache-tree.c             |  2 +-
 cache.h                  |  1 +
 read-cache.c             |  4 +--
 t/t2203-add-intent.sh    | 63 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 10 files changed, 92 insertions(+), 21 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
