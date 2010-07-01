From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2] rerere: fix overeager gc
Date: Thu,  1 Jul 2010 11:36:49 +0200
Message-ID: <1277977009-22780-1-git-send-email-szeder@ira.uka.de>
References: <4C2AE04E.9090901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:37:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUGCl-0004kF-M7
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab0GAJhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 05:37:04 -0400
Received: from francis.fzi.de ([141.21.7.5]:58081 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754620Ab0GAJhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:37:01 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 1 Jul 2010 11:36:58 +0200
X-Mailer: git-send-email 1.7.2.rc0.54.g4d821
In-Reply-To: <4C2AE04E.9090901@viscovery.net>
X-OriginalArrivalTime: 01 Jul 2010 09:36:58.0459 (UTC) FILETIME=[F36862B0:01CB1900]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150020>

'rerere gc' prunes resolutions of conflicted merges that occurred long
time ago, and when doing so it takes the creation time of the
conflicted automerge results into account.  This can cause the loss of
frequently used merge resolutions (e.g. long-living topic branches are
merged into a regularly rebuilt integration branch (think of git's
pu)) when they become old enough to exceed 'rerere gc's threshold.

Prevent the loss of valuable merge resolutions by updating the
timestamp of the conflicted automerge result each time when
encountering the same merge conflict.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On Wed, Jun 30, 2010 at 08:12:30AM +0200, Johannes Sixt wrote:
> Would it be possible to update the timestamp of preimage every time i=
t is
> used (e.g., in rerere.c:merge()), and check for that?

So, how about this?


 builtin/rerere.c  |    4 ++--
 rerere.c          |    8 +++++++-
 t/t4200-rerere.sh |    8 ++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0048f9e..4d4faae 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -13,7 +13,7 @@ static const char git_rerere_usage[] =3D
 static int cutoff_noresolve =3D 15;
 static int cutoff_resolve =3D 60;
=20
-static time_t rerere_created_at(const char *name)
+static time_t rerere_last_checked_at(const char *name)
 {
 	struct stat st;
 	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_=
mtime;
@@ -53,7 +53,7 @@ static void garbage_collect(struct string_list *rr)
 	while ((e =3D readdir(dir))) {
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
-		then =3D rerere_created_at(e->d_name);
+		then =3D rerere_last_checked_at(e->d_name);
 		if (!then)
 			continue;
 		cutoff =3D (has_rerere_resolution(e->d_name)
diff --git a/rerere.c b/rerere.c
index 2197890..1cc7c65 100644
--- a/rerere.c
+++ b/rerere.c
@@ -378,7 +378,13 @@ static int merge(const char *name, const char *pat=
h)
 	}
 	ret =3D ll_merge(&result, path, &base, NULL, &cur, "", &other, "", 0)=
;
 	if (!ret) {
-		FILE *f =3D fopen(path, "w");
+		FILE *f;
+
+		if (utime(rerere_path(name, "preimage"), NULL) < 0)
+			warning("failed utime() on %s: %s",
+					rerere_path(name, "preimage"),
+					strerror(errno));
+		f =3D fopen(path, "w");
 		if (!f)
 			return error("Could not open %s: %s", path,
 				     strerror(errno));
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 70856d0..c01d930 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -144,6 +144,14 @@ test_expect_success 'rerere kicked in' "! grep ^=3D=
=3D=3D=3D=3D=3D=3D$ a1"
=20
 test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
=20
+test_expect_success 'rerere updates preimage timestamp' '
+	git reset --hard &&
+	oldmtime=3D$(test-chmtime -v -42 $rr/preimage |cut -f 1) &&
+	test_must_fail git pull . first &&
+	newmtime=3D$(test-chmtime -v +0 $rr/preimage |cut -f 1) &&
+	test $oldmtime -lt $newmtime
+'
+
 rm $rr/postimage
 echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/MERGE_RR
=20
--=20
1.7.2.rc0.54.g4d821
