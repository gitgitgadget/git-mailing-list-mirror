From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: git mv messed up file mapping if folders contain identical files
Date: Fri, 26 Feb 2016 12:50:00 +0100
Message-ID: <1456487400-31174-1-git-send-email-szeder@ira.uka.de>
References: <CADsr5c9j1ne5K4TKZGMvoFeaNWbQxDs253Y29bfb9BsA+7A0aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>, Kevin Daudt <me@ikke.info>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bill Okara <billokara@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 12:51:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZGvP-0003NH-87
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 12:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbcBZLvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2016 06:51:06 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34541 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883AbcBZLvF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 06:51:05 -0500
Received: from x590ce5eb.dyn.telefonica.de ([89.12.229.235] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZGvD-0004V0-V9; Fri, 26 Feb 2016 12:51:02 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <CADsr5c9j1ne5K4TKZGMvoFeaNWbQxDs253Y29bfb9BsA+7A0aA@mail.gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456487462.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287570>

Hi,

Please don't top-post on this list.

> I guess a bigger concern of this issue is the mess up of history. Tha=
t
> is, even if not doing an merge/update, just doing the 'git mv' will
> messed up the file history, as shown in following:
>=20
>=20
> // Add a new resources/qa/content.txt files with a new commit message=
:
>=20
> > mkdir gitmvtest/resources/qa
> > cp gitmvtest/resources/demo/content.txt gitmvtest/resources/qa/.
> > git add .
> >git commit -m "Add a new QA context.txt"
> [master caba387] Add a new QA context.txt
>  1 file changed, 2 insertions(+)
>=20
> // Do the git mv
>=20
> > git checkout -b branch5
> > git mv gitmvtest/resources gitmvtest/src/main/.
> > git commit -m "Move resources to src/main/resources"
> [branch5 dd44309] Move resources to src/main/resources
>  4 files changed, 0 insertions(+), 0 deletions(-)
>  rename gitmvtest/{resources/qa =3D>
> src/main/resources/demo}/content.txt (100%)    <-- WRONG
>  rename gitmvtest/{resources/prod =3D>
> src/main/resources/dev}/content.txt (100%)    <-- WRONG
>  rename gitmvtest/{resources/dev =3D>
> src/main/resources/prod}/content.txt (100%)    <-- WRONG
>  rename gitmvtest/{resources/demo =3D>
> src/main/resources/qa}/content.txt (100%)   <-- WRONG
>=20
> // WRONG HISTORY
> > git log --follow --oneline  gitmvtest/src/main/resources/demo/conte=
nt.txt   <=3D=3D demo/content.txt points to the new QA history
> dd44309 Move resources to src/main/resources
> caba387 Add a new QA context.txt                <=3D=3D WRONG HISTORY

Git doesn't track copies and renames.

Git only tracks content and infers copies and renames from content
changes.  For example, if a commit removes path 'A' and adds path 'B'
then Git checks whether they both have identical (or very similar)
content, and reports this change as a rename if they do.  This is not
recorded anywhere in the repository, but 'git log --follow <path>'
performs this check upon seeing that the path in question doesn't
exist in the previous commit.

Anyway, diffcore used to handle your case better, and the patch below
restores the original behavior.

 ---- >8 ----

Subject: [PATCH] diffcore: fix iteration order of identical files durin=
g rename detection

If the two paths 'dir/A/file' and 'dir/B/file' have identical content
and the parent directory is renamed, e.g. 'git mv dir other-dir', then
diffcore reports the following exact renames:

    renamed:    dir/B/file -> other-dir/A/file
    renamed:    dir/A/file -> other-dir/B/file

While technically not wrong, this is confusing not only for the user,
but also for git commands that make decisions based on rename
information, e.g. 'git log --follow'.

This behavior is a side effect of commit v2.0.0-rc4~8^2~14
(diffcore-rename.c: simplify finding exact renames, 2013-11-14): the
hashmap storing sources returns entries from the same bucket, i.e.
sources matching the current destination, in LIFO order.  Thus the
iteration first examines 'other-dir/A/file' and 'dir/B/file' and, upon
finding identical content and basename, reports an exact rename.

Restore the original behavior by reversing the order of filling the
hashmap with source entries.

Reported-by: Bill Okara <billokara@gmail.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 diffcore-rename.c      |  6 ++++--
 t/t4001-diff-rename.sh | 11 +++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index af1fe08861e6..69fcf77be02d 100644
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
2.7.2.410.g92cb358
