From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/23] Teach commit to respect skip-worktree bit
Date: Mon, 14 Dec 2009 17:30:51 +0700
Message-ID: <1260786666-8405-9-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FJ-0007wL-57
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbZLNKdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbZLNKci
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:38 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:62201 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbZLNKce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:34 -0500
Received: by pxi4 with SMTP id 4so1691169pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MNh6D3PxBNS8ku6/1SCy8jSU2tFt8/EX0EV2CEEhhz0=;
        b=wkjngx6Bp3BrgmdsvDO59Ax7XRrvS7nkPbTay6N0V1TuHV0IhwQdtGob51OJwzOiOG
         e+85UOV1nkUmwUFgaRAHr/MRl0F9SNNOnyCqt1IFF67zmrxNWML+IDeDTVrL+IPtJeqP
         h3Q33YqXKgYbpGdR9sz/IX5MUvc4rRLAqcKEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ezB6G8WFBtuFC59a5B11QsJ4Z7yG1eac2wTJqr9DO0QSegJk3uapoe2wzt04jHQ424
         clw3Fg1vif4aD8FGRP8lHMMdkcYia2BjF7ZXe6UXnwfvaixyyk8oj0cza7oSnkrp2/kU
         QMYsr8/6tXLSGuuXCk4EXQtMNeF0ZSAMfeRVg=
Received: by 10.140.58.1 with SMTP id g1mr3191901rva.179.1260786754542;
        Mon, 14 Dec 2009 02:32:34 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4910300pzk.12.2009.12.14.02.32.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:34 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:53 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135175>

There is nothing much to do when the index is committed as-is. But
when partial commit is used, the index will be reset to HEAD. This
leads to loss of skip-worktree bits in the original index. Those bits
are kept (for committed paths only) so git-commit will know which
paths to ignore later on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-commit.c                 |   11 +++++++++--
 t/t7011-skip-worktree-reading.sh |   12 ++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 4bcce06..9fe5c25 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -152,7 +152,7 @@ static int commit_index_files(void)
 static int list_paths(struct string_list *list, const char *with_tree,
 		      const char *prefix, const char **pattern)
 {
-	int i;
+	static int i;
 	char *m;
=20
 	for (i =3D 0; pattern[i]; i++)
@@ -164,11 +164,15 @@ static int list_paths(struct string_list *list, c=
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
+			item->util =3D &i; /* better a valid pointer than a fake one */
 	}
=20
 	return report_path_error(m, pattern, prefix ? strlen(prefix) : 0);
@@ -181,6 +185,9 @@ static void add_remove_files(struct string_list *li=
st)
 		struct stat st;
 		struct string_list_item *p =3D &(list->items[i]);
=20
+		if (p->util)
+			continue;
+
 		if (!lstat(p->string, &st)) {
 			if (add_to_cache(p->string, &st, 0))
 				die("updating files failed");
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-r=
eading.sh
index 2ec677a..5cf2cb8 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -143,4 +143,16 @@ test_expect_success 'diff-files does not examine s=
kip-worktree dirty entries' '
 	test -z "$(git diff-files -- one)"
 '
=20
+test_expect_success 'commit on skip-worktree absent entries' '
+	git reset &&
+	setup_absent &&
+	test_must_fail git commit -m null 1
+'
+
+test_expect_success 'commit on skip-worktree dirty entries' '
+	git reset &&
+	setup_dirty &&
+	test_must_fail git commit -m null 1
+'
+
 test_done
--=20
1.6.5.2.216.g9c1ec
