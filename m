From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] commit: correctly respect skip-worktree bit
Date: Mon, 14 Dec 2009 18:43:59 +0700
Message-ID: <1260791039-12316-2-git-send-email-pclouds@gmail.com>
References: <1260791039-12316-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Dec 14 12:45:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK9MK-0003QU-Oc
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 12:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995AbZLNLoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 06:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756993AbZLNLoy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 06:44:54 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:58796 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756987AbZLNLox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 06:44:53 -0500
Received: by pzk1 with SMTP id 1so2212996pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 03:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=x/T6HbE9IrS01xoNkkukDh0BkfwqtTi9NtfhpZOtEUI=;
        b=N6wPmA8Xe3brXETe4pr9lEGWJuZ0KDKmJt2tCARAecTLLPE6SSmCo52pFZc5MSjSjK
         V9ZdQ8FIlvJtVYZYR/gOz4PZFe8t84SelXLxnBj2ccC+hdHMdNoRTzgPuPH8rfdNGWBO
         AN+b4E03ZyYNXE0TThr/+Tnk9VIIxZyl5G97I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=f6kTYvY9U3hShE0qu56/VTvPZ+pZpVYaQMqNhBv+bGWg+LhuMPQTXmF4du5ILHWMDw
         junyDg3Ou/Y84mh/JcbAVdJfo6KtYmRefLvNfiDAmM5iA86M30DOif/s4Zja1WUoQOGJ
         C+2/3skZejRk0Zlj/OO17Xkymi/6JCERf+vFI=
Received: by 10.141.15.10 with SMTP id s10mr3258777rvi.218.1260791092606;
        Mon, 14 Dec 2009 03:44:52 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4965193pzk.0.2009.12.14.03.44.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 03:44:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 18:44:10 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260791039-12316-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135204>

Commit b4d1690 (Teach Git to respect skip-worktree bit (reading part))
fails to make "git commit -- a b c" respect skip-worktree
(i.e. not committing paths that are skip-worktree). This is because
when the index is reset back to HEAD, all skip-worktree information is
gone.

This patch saves skip-worktree information in the string list of
committed paths, then reuse it later on to skip skip-worktree paths.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-commit.c                 |   11 +++++++----
 t/t7011-skip-worktree-reading.sh |    4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index a11e585..6e368f0 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -180,11 +180,15 @@ static int list_paths(struct string_list *list, c=
onst char *with_tree,
=20
 	for (i =3D 0; i < active_nr; i++) {
 		struct cache_entry *ce =3D active_cache[i];
+		struct string_list_item *item;
+
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
 		if (!match_pathspec(pattern, ce->name, ce_namelen(ce), 0, m))
 			continue;
-		string_list_insert(ce->name, list);
+		item =3D string_list_insert(ce->name, list);
+		if (ce_skip_worktree(ce))
+			item->util =3D item; /* better a valid pointer than a fake one */
 	}
=20
 	return report_path_error(m, pattern, prefix ? strlen(prefix) : 0);
@@ -196,10 +200,9 @@ static void add_remove_files(struct string_list *l=
ist)
 	for (i =3D 0; i < list->nr; i++) {
 		struct stat st;
 		struct string_list_item *p =3D &(list->items[i]);
-		int pos =3D index_name_pos(&the_index, p->string, strlen(p->string))=
;
-		struct cache_entry *ce =3D pos < 0 ? NULL : active_cache[pos];
=20
-		if (ce && ce_skip_worktree(ce))
+		/* p->util is skip-worktree */
+		if (p->util)
 			continue;
=20
 		if (!lstat(p->string, &st)) {
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-r=
eading.sh
index e996928..bb4066f 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -148,13 +148,13 @@ test_expect_success 'git-rm succeeds on skip-work=
tree absent entries' '
 	git rm 1
 '
=20
-test_expect_failure 'commit on skip-worktree absent entries' '
+test_expect_success 'commit on skip-worktree absent entries' '
 	git reset &&
 	setup_absent &&
 	test_must_fail git commit -m null 1
 '
=20
-test_expect_failure 'commit on skip-worktree dirty entries' '
+test_expect_success 'commit on skip-worktree dirty entries' '
 	git reset &&
 	setup_dirty &&
 	test_must_fail git commit -m null 1
--=20
1.6.5.2.216.g9c1ec
