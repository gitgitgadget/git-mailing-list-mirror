From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5] lockfile.c: store absolute path
Date: Sun,  2 Nov 2014 07:24:37 +0100
Message-ID: <1414909477-20030-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 07:25:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xkob1-0003ZC-UO
	for gcvg-git-2@plane.gmane.org; Sun, 02 Nov 2014 07:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbaKBGYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2014 01:24:46 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62802 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763AbaKBGYp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2014 01:24:45 -0500
X-AuditID: 12074414-f79f06d000000daf-2a-5455ce2c0a80
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 00.6D.03503.C2EC5545; Sun,  2 Nov 2014 01:24:45 -0500 (EST)
Received: from michael.fritz.box (p4FC976D4.dip0.t-ipconnect.de [79.201.118.212])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sA26OeeI022453
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 2 Nov 2014 01:24:42 -0500
X-Mailer: git-send-email 2.1.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqKt7LjTE4G6CRdeVbiaLht4rzBZP
	5t5ltri9Yj6zRfeUt4wWu6ctYLNo23mEyYHd4+/7D0weO2fdZfd4+KqL3ePiJWWPxxNPsHp8
	3iQXwBbFbZOUWFIWnJmep2+XwJ0x8dBmtoJJkhUXTz1mamC8LtLFyMkhIWAicfXfHDYIW0zi
	wr31QDYXh5DAZUaJ+W0XmSCcE0wS/f/mMYFUsQnoSizqaQazRQTUJCa2HWIBKWIWWMQksWRx
	F1hCWMBY4tiGmexdjBwcLAKqEhMvB4OEeQVcJK6eusQEsU1OYu/k1SwQcUGJkzOfsICUMwuo
	S6yfJwQSZhaQl2jeOpt5AiPfLCRVsxCqZiGpWsDIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI
	10IvN7NELzWldBMjJJhFdjAeOSl3iFGAg1GJhzfhRGiIEGtiWXFl7iFGSQ4mJVFel9lAIb6k
	/JTKjMTijPii0pzU4kOMEhzMSiK8hblAOd6UxMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2amp
	BalFMFkZDg4lCV7Gs0CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aC4iy8GRh5I
	igdoLydIO29xQWIuUBSi9RSjopQ4r/oZoIQASCKjNA9uLCxFvWIUB/pSmFccpJ0HmN7gul8B
	DWYCGuzYFQIyuCQRISXVwDgvMCsugVmUm0381LFwhfMsSne0tMrWnr56YM6ms1Palm863xy5
	X1lUuS3VXXG99sSC7efnn24qrTs//ZWIr7JBiJvy4sR1BXefRdcKn8/5O2mOWMrJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Locked paths can be saved in a linked list so that if something wrong
happens, *.lock are removed. For relative paths, this works fine if we
keep cwd the same, which is true 99% of time except:

- update-index and read-tree hold the lock on $GIT_DIR/index really
  early, then later on may call setup_work_tree() to move cwd.

- Suppose a lock is being held (e.g. by "git add") then somewhere
  down the line, somebody calls real_path (e.g. "link_alt_odb_entry"),
  which temporarily moves cwd away and back.

During that time when cwd is moved (either permanently or temporarily)
and we decide to die(), attempts to remove relative *.lock will fail,
and the next operation will complain that some files are still locked.

Avoid this case by turning relative paths to absolute before storing
the path in "filename" field.

Reported-by: Yue Lin Ho <yuelinho777@gmail.com>
Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Adapted-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This is a re-roll onto master to resolve conflicts with other changes
that have been merged since v4 [1]:

* The length of path is now available, so use strbuf_add() instead of
  strbuf_addstr().

* LOCK_NODEREF has been renamed to LOCK_NO_DEREF.

[1] http://thread.gmane.org/gmane.comp.version-control.git/255069/focus=
=3D256584

 lockfile.c                    | 14 +++++++++++---
 t/t2107-update-index-basic.sh | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 4f16ee7..9889277 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -128,9 +128,17 @@ static int lock_file(struct lock_file *lk, const c=
har *path, int flags)
 		    path);
 	}
=20
-	strbuf_add(&lk->filename, path, pathlen);
-	if (!(flags & LOCK_NO_DEREF))
-		resolve_symlink(&lk->filename);
+	if (flags & LOCK_NO_DEREF) {
+		strbuf_add_absolute_path(&lk->filename, path);
+	} else {
+		struct strbuf resolved_path =3D STRBUF_INIT;
+
+		strbuf_add(&resolved_path, path, pathlen);
+		resolve_symlink(&resolved_path);
+		strbuf_add_absolute_path(&lk->filename, resolved_path.buf);
+		strbuf_release(&resolved_path);
+	}
+
 	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
 	lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic=
=2Esh
index 1bafb90..dfe02f4 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -65,4 +65,19 @@ test_expect_success '--cacheinfo mode,sha1,path (new=
 syntax)' '
 	test_cmp expect actual
 '
=20
+test_expect_success '.lock files cleaned up' '
+	mkdir cleanup &&
+	(
+	cd cleanup &&
+	mkdir worktree &&
+	git init repo &&
+	cd repo &&
+	git config core.worktree ../../worktree &&
+	# --refresh triggers late setup_work_tree,
+	# active_cache_changed is zero, rollback_lock_file fails
+	git update-index --refresh &&
+	! test -f .git/index.lock
+	)
+'
+
 test_done
--=20
2.1.1
