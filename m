From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [RFC PATCH] rerere: fix overeager gc
Date: Tue, 29 Jun 2010 13:38:18 +0200
Message-ID: <1277811498-17288-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 13:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTZA1-0001j0-U8
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 13:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab0F2Li2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 07:38:28 -0400
Received: from francis.fzi.de ([141.21.7.5]:16266 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755776Ab0F2LiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 07:38:25 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 29 Jun 2010 13:38:21 +0200
X-Mailer: git-send-email 1.7.2.rc0.42.g400d
X-OriginalArrivalTime: 29 Jun 2010 11:38:22.0014 (UTC) FILETIME=[93EB2DE0:01CB177F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149900>

'rerere gc' prunes resolutions of conflicted merges that occurred long
time ago, and when doing so it takes the creation time of the merge
conflict resolution into account.  This can cause the loss of
frequently used merge resolutions (e.g. long-living topic branches are
merged into a regularly rebuilt integration branch (think of git's
pu)) when they become old enough to exceed 'rerere gc's threshold.

Prevent the loss of valuable merge resolutions by changing 'rerere gc'
to take the time of last usage of the merge resolution into account
when determining whether a merge resolution should be pruned.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

I was wondering that every once in a while when I got a merge conflict
during rebuilding my integration branch then it was usually followed
with a bunch of other conflicts as well, even though nothing really
changed around the conflicting areas.  Until today at last I noticed
that it happens right after doing a 'git gc'...

RFC, because I would not say that I put in too much effort to fully
understand how rerere works internally...  As far as I observed
rerere's behaviour and understood its code, thisimage is always
rewritten each time a merge resolution is used.  But I'm not sure I
can rely on that when gc'ing.

 builtin/rerere.c  |   15 +++++++++++++--
 t/t4200-rerere.sh |   18 +++++++++++++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0048f9e..e095852 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -19,6 +19,12 @@ static time_t rerere_created_at(const char *name)
 	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_=
mtime;
 }
=20
+static time_t rerere_last_used_at(const char *name)
+{
+	struct stat st;
+	return stat(rerere_path(name, "thisimage"), &st) ? (time_t) 0 : st.st=
_mtime;
+}
+
 static void unlink_rr_item(const char *name)
 {
 	unlink(rerere_path(name, "thisimage"));
@@ -56,8 +62,13 @@ static void garbage_collect(struct string_list *rr)
 		then =3D rerere_created_at(e->d_name);
 		if (!then)
 			continue;
-		cutoff =3D (has_rerere_resolution(e->d_name)
-			  ? cutoff_resolve : cutoff_noresolve);
+		if (has_rerere_resolution(e->d_name)) {
+			then =3D rerere_last_used_at(e->d_name);
+			if (!then)
+				continue;
+			cutoff =3D cutoff_resolve;
+		} else
+			cutoff =3D cutoff_noresolve;
 		if (then < now - cutoff * 86400)
 			string_list_append(e->d_name, &to_remove);
 	}
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 70856d0..45c9df8 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -154,33 +154,49 @@ test_expect_success 'clear removed the directory'=
 "test ! -d $rr"
 mkdir $rr
 echo Hello > $rr/preimage
 echo World > $rr/postimage
+echo "!" > $rr/thisimage
=20
 sha2=3D4000000000000000000000000000000000000000
 rr2=3D.git/rr-cache/$sha2
 mkdir $rr2
 echo Hello > $rr2/preimage
=20
+sha3=3Dffffffffffffffffffffffffffffffffffffffff
+rr3=3D.git/rr-cache/$sha3
+mkdir $rr3
+echo Hello > $rr3/preimage
+echo World > $rr3/postimage
+echo "!" > $rr3/thisimage
+
 almost_15_days_ago=3D$((60-15*86400))
 just_over_15_days_ago=3D$((-1-15*86400))
 almost_60_days_ago=3D$((60-60*86400))
 just_over_60_days_ago=3D$((-1-60*86400))
=20
 test-chmtime =3D$almost_60_days_ago $rr/preimage
+test-chmtime =3D$almost_60_days_ago $rr/thisimage
 test-chmtime =3D$almost_15_days_ago $rr2/preimage
+test-chmtime =3D$almost_60_days_ago $rr3/preimage
+test-chmtime =3D$almost_60_days_ago $rr3/thisimage
=20
 test_expect_success 'garbage collection (part1)' 'git rerere gc'
=20
 test_expect_success 'young records still live' \
-	"test -f $rr/preimage && test -f $rr2/preimage"
+	"test -f $rr/preimage && test -f $rr2/preimage && test -f $rr3/preima=
ge"
=20
 test-chmtime =3D$just_over_60_days_ago $rr/preimage
+test-chmtime =3D$just_over_60_days_ago $rr/thisimage
 test-chmtime =3D$just_over_15_days_ago $rr2/preimage
+test-chmtime =3D$just_over_60_days_ago $rr3/preimage
=20
 test_expect_success 'garbage collection (part2)' 'git rerere gc'
=20
 test_expect_success 'old records rest in peace' \
 	"test ! -f $rr/preimage && test ! -f $rr2/preimage"
=20
+test_expect_success 'recently used records are still there' \
+	"test -f $rr3/preimage"
+
 test_expect_success 'file2 added differently in two branches' '
 	git reset --hard &&
 	git checkout -b fourth &&
--=20
1.7.2.rc0.42.g400d
