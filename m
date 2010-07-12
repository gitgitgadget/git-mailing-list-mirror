From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] rerere: fix overeager gc
Date: Tue, 13 Jul 2010 01:42:04 +0200
Message-ID: <1278978124-3035-2-git-send-email-szeder@ira.uka.de>
References: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 01:42:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYSeF-0000b5-UB
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 01:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209Ab0GLXmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 19:42:51 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:64234 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab0GLXmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 19:42:50 -0400
Received: from [127.0.1.1] (p5B130E72.dip0.t-ipconnect.de [91.19.14.114])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M1RJx-1PMhsZ2rjV-00tyGg; Tue, 13 Jul 2010 01:42:35 +0200
X-Mailer: git-send-email 1.7.2.rc2.37.g5e8ef
In-Reply-To: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:0Ss9Ppam9mZaOWmOcjMr2lFn+YwZN7+OTGd66WdxsYd
 rEbPBcIpw1Kvok5obtAh3ATBli6RL21zwHGIrdyKPwq9EA7+ge
 dMC9B1MGXM3XUtAOV1rc1A2jRoI3kaNT7kmo9qBizmWslXzVvL
 II9oHCTot7i9xdR4y4NFJcONlVnec9NriZPUhbt0NtA/bNkhqw
 hG0S93iMnE/ss/Ce7j7AQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150854>

'rerere gc' prunes resolutions of conflicted merges that occurred long
time ago, and when doing so it takes the creation time of the
conflicted automerge results into account.  This can cause the loss of
frequently used conflict resolutions (e.g. long-living topic branches
are merged into a regularly rebuilt integration branch (think of git's
pu)) when they become old enough to exceed 'rerere gc's threshold.

To prevent the loss of valuable merge resolutions 'rerere' will (1)
update the timestamp of the recorded conflict resolution (i.e.
'postimage') each time when encountering and resolving the same merge
conflict, and (2) take this timestamp, i.e. the time of the last usage
into account when gc'ing.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On Thu, Jul 08, 2010 at 05:06:49PM -0700, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>=20
> > Am 7/2/2010 19:25, schrieb Junio C Hamano:
> >
> >> I'd rather see "preimage"
> >> timestamp to keep track of the time when we _first_ encountered th=
e
> >> particular conflict, and "postimage" used for recording the time w=
hen we
> >> saw the conflict most recently.
> >
> > That would be fine, too.
>=20
> Ok, then let's make it so ;-)

Here it is.  Now you have it all, take your pick (;

 builtin/rerere.c  |   15 +++++++++++++--
 rerere.c          |    8 +++++++-
 t/t4200-rerere.sh |   14 +++++++++++---
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 980d542..52e4b64 100644
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
+	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st=
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
 			string_list_append(&to_remove, e->d_name);
 	}
diff --git a/rerere.c b/rerere.c
index d03a696..1d95161 100644
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
+		if (utime(rerere_path(name, "postimage"), NULL) < 0)
+			warning("failed utime() on %s: %s",
+					rerere_path(name, "postimage"),
+					strerror(errno));
+		f =3D fopen(path, "w");
 		if (!f)
 			return error("Could not open %s: %s", path,
 				     strerror(errno));
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 70856d0..093b138 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -132,6 +132,8 @@ test_expect_success 'commit succeeds' \
=20
 test_expect_success 'recorded postimage' "test -f $rr/postimage"
=20
+oldmtimepost=3D$(test-chmtime -v -60 $rr/postimage |cut -f 1)
+
 test_expect_success 'another conflicting merge' '
 	git checkout -b third master &&
 	git show second^:a1 | sed "s/To die: t/To die! T/" > a1 &&
@@ -144,6 +146,11 @@ test_expect_success 'rerere kicked in' "! grep ^=3D=
=3D=3D=3D=3D=3D=3D$ a1"
=20
 test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
=20
+test_expect_success 'rerere updates postimage timestamp' '
+	newmtimepost=3D$(test-chmtime -v +0 $rr/postimage |cut -f 1) &&
+	test $oldmtimepost -lt $newmtimepost
+'
+
 rm $rr/postimage
 echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/MERGE_RR
=20
@@ -165,15 +172,16 @@ just_over_15_days_ago=3D$((-1-15*86400))
 almost_60_days_ago=3D$((60-60*86400))
 just_over_60_days_ago=3D$((-1-60*86400))
=20
-test-chmtime =3D$almost_60_days_ago $rr/preimage
+test-chmtime =3D$just_over_60_days_ago $rr/preimage
+test-chmtime =3D$almost_60_days_ago $rr/postimage
 test-chmtime =3D$almost_15_days_ago $rr2/preimage
=20
 test_expect_success 'garbage collection (part1)' 'git rerere gc'
=20
-test_expect_success 'young records still live' \
+test_expect_success 'young or recently used records still live' \
 	"test -f $rr/preimage && test -f $rr2/preimage"
=20
-test-chmtime =3D$just_over_60_days_ago $rr/preimage
+test-chmtime =3D$just_over_60_days_ago $rr/postimage
 test-chmtime =3D$just_over_15_days_ago $rr2/preimage
=20
 test_expect_success 'garbage collection (part2)' 'git rerere gc'
--=20
1.7.2.rc2.37.g5e8ef
