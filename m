From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] xdiff: implement a zealous diff3
Date: Wed,  6 Mar 2013 21:36:42 +0100
Message-ID: <1362602202-29749-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20130306200347.GA20312@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de, Antoine Pelisse <apelisse@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 21:37:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDL5Q-00054v-6n
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 21:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab3CFUgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 15:36:49 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45344 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab3CFUgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 15:36:48 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDL4v-0007Oq-Dc; Wed, 06 Mar 2013 21:36:45 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDL4v-0007kk-C6; Wed, 06 Mar 2013 21:36:45 +0100
X-Mailer: git-send-email 1.8.2.rc2
In-Reply-To: <20130306200347.GA20312@sigill.intra.peff.net>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217541>

"zdiff3" is identical to ordinary diff3, only it allows more aggressive
compaction than diff3. This way the displayed base isn't necessary
technically correct, but still this mode might help resolving merge
conflicts between two near identical additions.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch implements what I want. Thanks to Jeff for pointing me to th=
e
right code to modify.

Best regards
Uwe

 builtin/merge-file.c                   | 2 ++
 contrib/completion/git-completion.bash | 2 +-
 xdiff-interface.c                      | 2 ++
 xdiff/xdiff.h                          | 1 +
 xdiff/xmerge.c                         | 8 +++++++-
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c0570f2..4ef86aa 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -32,6 +32,8 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 	struct option options[] =3D {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, N_("send results to standard =
output")),
 		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), X=
DL_MERGE_DIFF3),
+		OPT_SET_INT(0, "zdiff3", &xmp.style, N_("use a zealous diff3 based m=
erge"),
+				XDL_MERGE_ZEALOUS_DIFF3),
 		OPT_SET_INT(0, "ours", &xmp.favor, N_("for conflicts, use our versio=
n"),
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &xmp.favor, N_("for conflicts, use their ve=
rsion"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index b62bec0..a0d887e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1091,7 +1091,7 @@ _git_checkout ()
=20
 	case "$cur" in
 	--conflict=3D*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=3D}"
 		;;
 	--*)
 		__gitcomp "
diff --git a/xdiff-interface.c b/xdiff-interface.c
index ecfa05f..a911c25 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -308,6 +308,8 @@ int git_xmerge_config(const char *var, const char *=
value, void *cb)
 			die("'%s' is not a boolean", var);
 		if (!strcmp(value, "diff3"))
 			git_xmerge_style =3D XDL_MERGE_DIFF3;
+		else if (!strcmp(value, "zdiff3"))
+			git_xmerge_style =3D XDL_MERGE_ZEALOUS_DIFF3;
 		else if (!strcmp(value, "merge"))
 			git_xmerge_style =3D 0;
 		else
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 219a3bb..9730c63 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -64,6 +64,7 @@ extern "C" {
=20
 /* merge output styles */
 #define XDL_MERGE_DIFF3 1
+#define XDL_MERGE_ZEALOUS_DIFF3 2
=20
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 9e13b25..4772707 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -177,7 +177,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const =
char *name1,
 	size +=3D xdl_recs_copy(xe1, m->i1, m->chg1, 1,
 			      dest ? dest + size : NULL);
=20
-	if (style =3D=3D XDL_MERGE_DIFF3) {
+	if (style =3D=3D XDL_MERGE_DIFF3 || style =3D=3D XDL_MERGE_ZEALOUS_DI=
=46F3) {
 		/* Shared preimage */
 		if (!dest) {
 			size +=3D marker_size + 1 + marker3_size;
@@ -420,6 +420,12 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t =
*xscr1,
 	int style =3D xmp->style;
 	int favor =3D xmp->favor;
=20
+	/*
+	 * This is the only change between XDL_MERGE_DIFF3 and
+	 * XDL_MERGE_ZEALOUS_DIFF3. "zdiff3" isn't 100% technically correct (=
as
+	 * the base might be considerably simplified), but still it might hel=
p
+	 * interpreting conflicts between two big and near identical addition=
s.
+	 */
 	if (style =3D=3D XDL_MERGE_DIFF3) {
 		/*
 		 * "diff3 -m" output does not make sense for anything
--=20
1.8.2.rc2
