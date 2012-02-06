From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] Stop producing index version 2
Date: Mon,  6 Feb 2012 12:48:36 +0700
Message-ID: <1328507319-24687-3-git-send-email-pclouds@gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 06:44:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHNB-0002oT-8z
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab2BFFoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 00:44:12 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39009 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab2BFFoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:44:11 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so4687056pbd.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 21:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x7yntUu8NqmB6irJcjHEIaJ38zBjM7395W1lB+pM1p0=;
        b=Hk5ZhmxrJcx/JnvD5pJX5DY+7O0/PtHHFxbUziPKF5SdWMhhfz9dbUwOROkU0bOojP
         lwyT6r8lk7CciJQGXg8csaKxgL7DWi8wbhcVvVH+RRXHLeSxhzsK2jZ7Rp1oeuSC0OWZ
         ePqtNdA7e9eQ9QTXK7obs9gUgvW23OnGwDAA0=
Received: by 10.68.134.35 with SMTP id ph3mr44603555pbb.29.1328507051172;
        Sun, 05 Feb 2012 21:44:11 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id r9sm36755371pbi.6.2012.02.05.21.44.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 21:44:10 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 12:49:02 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190018>

read-cache.c learned to produce version 2 or 3 depending on whether
extended cache entries exist in 06aaaa0 (Extend index to save more flag=
s
- 2008-10-01), first released in 1.6.1. The purpose is to keep
compatibility with older git. It's been more than three years since
then and git has reached 1.7.9. Drop support for older git.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c                          |    8 +++-----
 t/t2104-update-index-skip-worktree.sh |   12 ------------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e9a20b6..fe6b0e0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1532,26 +1532,24 @@ int write_index(struct index_state *istate, int=
 newfd)
 {
 	struct sha1file *f;
 	struct cache_header hdr;
-	int i, err, removed, extended;
+	int i, err, removed;
 	struct cache_entry **cache =3D istate->cache;
 	int entries =3D istate->cache_nr;
 	struct stat st;
=20
-	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
+	for (i =3D removed =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
=20
 		/* reduce extended entries if possible */
 		cache[i]->ce_flags &=3D ~CE_EXTENDED;
 		if (cache[i]->ce_flags & CE_EXTENDED_FLAGS) {
-			extended++;
 			cache[i]->ce_flags |=3D CE_EXTENDED;
 		}
 	}
=20
 	hdr.hdr_signature =3D htonl(CACHE_SIGNATURE);
-	/* for extended format, increase version so older git won't try to re=
ad it */
-	hdr.hdr_version =3D htonl(extended ? 3 : 2);
+	hdr.hdr_version =3D htonl(3);
 	hdr.hdr_entries =3D htonl(entries - removed);
=20
 	f =3D sha1fd(newfd, NULL);
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-ind=
ex-skip-worktree.sh
index 1d0879b..8221ffa 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -28,19 +28,11 @@ test_expect_success 'setup' '
 	git ls-files -t | test_cmp expect.full -
 '
=20
-test_expect_success 'index is at version 2' '
-	test "$(test-index-version < .git/index)" =3D 2
-'
-
 test_expect_success 'update-index --skip-worktree' '
 	git update-index --skip-worktree 1 sub/1 &&
 	git ls-files -t | test_cmp expect.skip -
 '
=20
-test_expect_success 'index is at version 3 after having some skip-work=
tree entries' '
-	test "$(test-index-version < .git/index)" =3D 3
-'
-
 test_expect_success 'ls-files -t' '
 	git ls-files -t | test_cmp expect.skip -
 '
@@ -50,8 +42,4 @@ test_expect_success 'update-index --no-skip-worktree'=
 '
 	git ls-files -t | test_cmp expect.full -
 '
=20
-test_expect_success 'index version is back to 2 when there is no skip-=
worktree entry' '
-	test "$(test-index-version < .git/index)" =3D 2
-'
-
 test_done
--=20
1.7.8.36.g69ee2
