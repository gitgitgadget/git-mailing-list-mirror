From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] diffcore: fix iteration order of identical files during rename detection
Date: Wed, 30 Mar 2016 10:35:07 +0200
Message-ID: <1459326907-16179-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>,
	Bill Okara <billokara@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 10:39:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alBbh-0000fW-LS
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 10:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758747AbcC3If7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 04:35:59 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34764 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752901AbcC3If5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 04:35:57 -0400
Received: from x4db1c097.dyn.telefonica.de ([77.177.192.151] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1alBbL-0006YE-Pb; Wed, 30 Mar 2016 10:35:49 +0200
X-Mailer: git-send-email 2.8.0.46.gb821760
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1459326949.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290278>

If the two paths 'dir/A/file' and 'dir/B/file' have identical content
and the parent directory is renamed, e.g. 'git mv dir other-dir', then
diffcore reports the following exact renames:

    renamed:    dir/B/file -> other-dir/A/file
    renamed:    dir/A/file -> other-dir/B/file

While technically not wrong, this is confusing not only for the user,
but also for git commands that make decisions based on rename
information, e.g. 'git log --follow other-dir/A/file' follows
'dir/B/file' past the rename.

This behavior is a side effect of commit v2.0.0-rc4~8^2~14
(diffcore-rename.c: simplify finding exact renames, 2013-11-14): the
hashmap storing sources returns entries from the same bucket, i.e.
sources matching the current destination, in LIFO order.  Thus the
iteration first examines 'other-dir/A/file' and 'dir/B/file' and, upon
finding identical content and basename, reports an exact rename.

Other hashmap users are apparently happy with the current iteration
order over the entries of a bucket.  Changing the iteration order
would risk upsetting other hashmap users and would increase the memory
footprint of each bucket by a pointer to the tail element.

=46ill the hashmap with source entries in reverse order to restore the
original exact rename detection behavior.

Reported-by: Bill Okara <billokara@gmail.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

Resend of the patch, with a slightly updated commit message, included
in

  http://thread.gmane.org/gmane.comp.version-control.git/287281/focus=3D=
287570

Being embedded with scissors in an email without Junio among the
recipients on the day the first -rc was tagged...  no wonder it flew
below the radar.

 diffcore-rename.c      |  6 ++++--
 t/t4001-diff-rename.sh | 11 +++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3b3c1ed535e7..7f03eb5a0404 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -340,9 +340,11 @@ static int find_exact_renames(struct diff_options =
*options)
 	int i, renames =3D 0;
 	struct hashmap file_table;
=20
-	/* Add all sources to the hash table */
+	/* Add all sources to the hash table in reverse order, because
+	 * later on they will be retrieved in LIFO order.
+	 */
 	hashmap_init(&file_table, NULL, rename_src_nr);
-	for (i =3D 0; i < rename_src_nr; i++)
+	for (i =3D rename_src_nr-1; i >=3D 0; i--)
 		insert_file_table(&file_table, i, rename_src[i].p->one);
=20
 	/* Walk the destinations and find best source match */
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2f327b749588..ed90c6c6f984 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -77,6 +77,17 @@ test_expect_success 'favour same basenames even with=
 minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
 	git status | test_i18ngrep "renamed: .*path1 -> subdir/path1"'
=20
+test_expect_success 'two files with same basename and same content' '
+	git reset --hard &&
+	mkdir -p dir/A dir/B &&
+	cp path1 dir/A/file &&
+	cp path1 dir/B/file &&
+	git add dir &&
+	git commit -m 2 &&
+	git mv dir other-dir &&
+	git status | test_i18ngrep "renamed: .*dir/A/file -> other-dir/A/file=
"
+'
+
 test_expect_success 'setup for many rename source candidates' '
 	git reset --hard &&
 	for i in 0 1 2 3 4 5 6 7 8 9;
--=20
2.8.0.46.gb821760
