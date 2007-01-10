From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH] Provide better feedback for the untracked only case in status output
Date: Wed, 10 Jan 2007 08:08:12 +0100
Message-ID: <1168412892113-git-send-email-j.ruehle@bmiag.de>
References: <7vps9pwa3e.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org,
	=?utf-8?q?J=C3=BCrgen_R=C3=BChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Wed Jan 10 08:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4XZi-0000tb-1U
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 08:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbXAJHId (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 02:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbXAJHId
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 02:08:33 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:2555 "HELO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932582AbXAJHIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 02:08:32 -0500
Received: (qmail 17350 invoked by uid 106); 10 Jan 2007 07:08:28 -0000
Received: from eotheod.intranet.kiel.bmiag.de(10.130.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdVI1BE5; Wed Jan 10 08:08:23 2007
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 7772A3ADCA;
	Wed, 10 Jan 2007 08:08:23 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13590-03; Wed, 10 Jan 2007 08:08:20 +0100 (CET)
Received: from localhost.localdomain (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 309373ADC8;
	Wed, 10 Jan 2007 08:08:13 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.g525e
In-Reply-To: <7vps9pwa3e.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36481>

From: =3D?utf-8?q?J=3DC3=3DBCrgen_R=3DC3=3DBChle?=3D <j-r@online.de>

Since 98bf8a47c296f51ea9722fef4bb81dbfb70cd4bb status would claim that
git-commit could be useful even if there are no changes except untracked =
files.

Since wt-status is already computing all the information go the whole way=
 and
separately track the (non-)emptiness of all three sections, unify the cod=
e, and
provide separate messages for each case. This adds a new message for the
untracked only case and adds an explanation for a completely empty workin=
g
directory during initial commit.

This change is effectively reverting 98bf8a47c296f51ea9722fef4bb81dbfb70c=
d4bb
and replacing it by a cleaner version.

Signed-off-by: J=C3=BCrgen R=C3=BChle <j-r@online.de>
---
  Junio C Hamano writes:
   > I think it is Ok to give hints for untracked files -- with
   > experience eyes will learn to ignore them but by then they do
   > not need hints.  Please send in a correction as appropriate.

  This should provide useful feedback for the nothing to commit case in a=
ny
  situation. It is how I should have done it initially. Sorry for wasting=
 your
  time.

  Still missing:

   - Further changes to the header messages (as discussed on the list)

   - Patches to every other file that contains these messages verbatim

     (AFAICS this affects only the git-reset man page, tutorial-2 and the=
 VIM
      syntax highlighting)

 wt-status.c |   21 ++++++++++++---------
 wt-status.h |    6 ++++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c48127d..5190bde 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -47,10 +47,11 @@ void wt_status_prepare(struct wt_status *s)
 	s->reference =3D "HEAD";
 	s->amend =3D 0;
 	s->verbose =3D 0;
-	s->commitable =3D 0;
 	s->untracked =3D 0;
=20
-	s->workdir_clean =3D 1;
+	s->commitable =3D 0;
+	s->workdir_dirty =3D 0;
+	s->workdir_untracked =3D 0;
 }
=20
 static void wt_status_print_cached_header(const char *reference)
@@ -176,7 +177,7 @@ static void wt_status_print_changed_cb(struct diff_qu=
eue_struct *q,
 	struct wt_status *s =3D data;
 	int i;
 	if (q->nr) {
-		s->workdir_clean =3D 0;
+		s->workdir_dirty =3D 1;
 		wt_status_print_header("Changed but not added", use_add_msg);
 	}
 	for (i =3D 0; i < q->nr; i++)
@@ -263,7 +264,7 @@ static void wt_status_print_untracked(struct wt_statu=
s *s)
 				continue;
 		}
 		if (!shown_header) {
-			s->workdir_clean =3D 0;
+			s->workdir_untracked =3D 1;
 			wt_status_print_header("Untracked files", use_add_msg);
 			shown_header =3D 1;
 		}
@@ -311,12 +312,14 @@ void wt_status_print(struct wt_status *s)
 	if (!s->commitable) {
 		if (s->amend)
 			printf("# No changes\n");
-		else if (s->workdir_clean)
-			printf(s->is_initial
-			       ? "nothing to commit\n"
-			       : "nothing to commit (working directory matches HEAD)\n");
-		else
+		else if (s->workdir_dirty)
 			printf("no changes added to commit (use \"git add\" and/or \"git comm=
it [-a|-i|-o]\")\n");
+		else if (s->workdir_untracked)
+			printf("nothing added to commit but untracked files present (use \"gi=
t add\" to track)\n");
+		else if (s->is_initial)
+			printf("nothing to commit (working directory is empty)\n");
+		else
+			printf("nothing to commit (working directory matches HEAD)\n");
 	}
 }
=20
diff --git a/wt-status.h b/wt-status.h
index 892a86c..cfea4ae 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -12,11 +12,13 @@ struct wt_status {
 	int is_initial;
 	char *branch;
 	const char *reference;
-	int commitable;
 	int verbose;
 	int amend;
 	int untracked;
-	int workdir_clean;
+	/* These are computed during processing of the individual sections */
+	int commitable;
+	int workdir_dirty;
+	int workdir_untracked;
 };
=20
 int git_status_config(const char *var, const char *value);
--=20
1.5.0.rc0.g525e
