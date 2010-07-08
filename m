From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v4] rerere: fix overeager gc
Date: Thu,  8 Jul 2010 16:35:58 +0200
Message-ID: <1278599758-18962-1-git-send-email-szeder@ira.uka.de>
References: <4C31757A.1000207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 16:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWsDC-0000uO-2r
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 16:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab0GHOgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 10:36:12 -0400
Received: from francis.fzi.de ([141.21.7.5]:31616 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754820Ab0GHOgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 10:36:11 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 8 Jul 2010 16:36:07 +0200
X-Mailer: git-send-email 1.7.2.rc2.42.gfe876
In-Reply-To: <4C31757A.1000207@viscovery.net>
X-OriginalArrivalTime: 08 Jul 2010 14:36:07.0667 (UTC) FILETIME=[E6DC6C30:01CB1EAA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150580>

'rerere gc' prunes resolutions of conflicted merges that occurred long
time ago, and when doing so it takes the creation time of the
conflicted automerge results into account.  This can cause the loss of
frequently used merge resolutions (e.g. long-living topic branches are
merged into a regularly rebuilt integration branch (think of git's
pu)) when they become old enough to exceed 'rerere gc's threshold.

To prevent the loss of valuable merge resolutions 'rerere' will (1)
write 'thisimage' into a temporary file and then rename it into its
final destination, thereby updating the directory timestamp each time
when encountering the same merge conflict, and (2) take the directory
timestamp, i.e. the time of the last usage into account when gc'ing.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On Mon, Jul 05, 2010 at 08:02:34AM +0200, Johannes Sixt wrote:
> Am 7/2/2010 19:25, schrieb Junio C Hamano:
> > If we for whatever reason trust placing an extra timestamp on a reg=
ular
> > file more than using directory timestamp (which I think may be a va=
lid
> > concern from portability point of view),
>=20
> Windows behaves well in this regard. Writing of thisimage must be
> converted to lockfile infrastructure, of course.

So, here is the next take with the tmpfile-rename stuff to update the
directory timestamp.  If there are any portability issues wrt directory
timestamp updating, the new test should catch them early.

 builtin/rerere.c  |    6 +++---
 rerere.c          |   19 +++++++++++++++++--
 t/t4200-rerere.sh |   16 ++++++++++++----
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 980d542..bede3eb 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -13,10 +13,10 @@ static const char git_rerere_usage[] =3D
 static int cutoff_noresolve =3D 15;
 static int cutoff_resolve =3D 60;
=20
-static time_t rerere_created_at(const char *name)
+static time_t rerere_last_used_at(const char *name)
 {
 	struct stat st;
-	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_=
mtime;
+	return stat(rerere_path(name, "."), &st) ? (time_t) 0 : st.st_mtime;
 }
=20
 static void unlink_rr_item(const char *name)
@@ -53,7 +53,7 @@ static void garbage_collect(struct string_list *rr)
 	while ((e =3D readdir(dir))) {
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
-		then =3D rerere_created_at(e->d_name);
+		then =3D rerere_last_used_at(e->d_name);
 		if (!then)
 			continue;
 		cutoff =3D (has_rerere_resolution(e->d_name)
diff --git a/rerere.c b/rerere.c
index d03a696..e415f54 100644
--- a/rerere.c
+++ b/rerere.c
@@ -363,13 +363,28 @@ static int find_conflict(struct string_list *conf=
lict)
=20
 static int merge(const char *name, const char *path)
 {
-	int ret;
+	int fd, ret;
 	mmfile_t cur =3D {NULL, 0}, base =3D {NULL, 0}, other =3D {NULL, 0};
 	mmbuffer_t result =3D {NULL, 0};
+	char *tmpfile;
+
+	tmpfile =3D xstrdup(rerere_path(name, "tmp_thisimage_XXXXXX"));
+	fd =3D git_mkstemp_mode(tmpfile, 0600);
+	if (fd < 0) {
+		error("unable to create temporary file %s for rerere: %s\n",
+				tmpfile, strerror(errno));
+		return 1;
+	}
+	close(fd);
=20
-	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
+	if (handle_file(path, NULL, tmpfile) < 0)
 		return 1;
=20
+	if (move_temp_to_file(tmpfile, rerere_path(name, "thisimage")) < 0)
+		return 1;
+
+	free(tmpfile);
+
 	if (read_mmfile(&cur, rerere_path(name, "thisimage")) ||
 			read_mmfile(&base, rerere_path(name, "preimage")) ||
 			read_mmfile(&other, rerere_path(name, "postimage"))) {
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 70856d0..a425329 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -144,6 +144,14 @@ test_expect_success 'rerere kicked in' "! grep ^=3D=
=3D=3D=3D=3D=3D=3D$ a1"
=20
 test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
=20
+test_expect_success 'rerere updates directory timestamp' '
+	git reset --hard &&
+	oldmtime=3D$(test-chmtime -v -42 $rr |cut -f 1) &&
+	test_must_fail git pull . first &&
+	newmtime=3D$(test-chmtime -v +0 $rr |cut -f 1) &&
+	test $oldmtime -lt $newmtime
+'
+
 rm $rr/postimage
 echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/MERGE_RR
=20
@@ -165,16 +173,16 @@ just_over_15_days_ago=3D$((-1-15*86400))
 almost_60_days_ago=3D$((60-60*86400))
 just_over_60_days_ago=3D$((-1-60*86400))
=20
-test-chmtime =3D$almost_60_days_ago $rr/preimage
-test-chmtime =3D$almost_15_days_ago $rr2/preimage
+test-chmtime =3D$almost_60_days_ago $rr
+test-chmtime =3D$almost_15_days_ago $rr2
=20
 test_expect_success 'garbage collection (part1)' 'git rerere gc'
=20
 test_expect_success 'young records still live' \
 	"test -f $rr/preimage && test -f $rr2/preimage"
=20
-test-chmtime =3D$just_over_60_days_ago $rr/preimage
-test-chmtime =3D$just_over_15_days_ago $rr2/preimage
+test-chmtime =3D$just_over_60_days_ago $rr
+test-chmtime =3D$just_over_15_days_ago $rr2
=20
 test_expect_success 'garbage collection (part2)' 'git rerere gc'
=20
--=20
1.7.2.rc2.42.gfe876
