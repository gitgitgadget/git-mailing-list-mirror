From: =?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
Subject: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Thu, 23 Aug 2007 22:58:31 +0300
Message-ID: <11878991123605-git-send-email-v@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 21:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOIqI-0005EV-8F
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 21:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbXHWT7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 15:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbXHWT7Q
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 15:59:16 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:37615 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbXHWT7P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 15:59:15 -0400
Received: from localhost.localdomain (GYKMMMCCXVII.dsl.saunalahti.fi [85.77.38.118])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 8F28C1511E7;
	Thu, 23 Aug 2007 22:59:09 +0300 (EEST)
X-Mailer: git-send-email 1.5.3.rc6.17.g1911-dirty
Message-Id: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With this flag, the user can choose to filter untracked files from the
status output. This can be used to either speed up the status output, a=
s
the untracked files are not fetched at all, or to just cleanup the
output without using gitignore.

Signed-off-by: V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 <v@pp.inet.fi>
---
 builtin-runstatus.c |    4 +++-
 git-commit.sh       |   11 +++++++++--
 wt-status.c         |    8 +++++++-
 wt-status.h         |    1 +
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 2db25c8..2121762 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -5,7 +5,7 @@
 extern int wt_status_use_color;
=20
 static const char runstatus_usage[] =3D
-"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked]=
";
+"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked]=
" "[--only-tracked]";
=20
 int cmd_runstatus(int argc, const char **argv, const char *prefix)
 {
@@ -28,6 +28,8 @@ int cmd_runstatus(int argc, const char **argv, const =
char *prefix)
 			s.verbose =3D 1;
 		else if (!strcmp(argv[i], "--untracked"))
 			s.untracked =3D 1;
+		else if (!strcmp(argv[i], "--only-tracked"))
+			s.only_tracked =3D 1;
 		else
 			usage(runstatus_usage);
 	}
diff --git a/git-commit.sh b/git-commit.sh
index d7e7028..0ef50d9 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
=20
-USAGE=3D'[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | =
-F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>=
] [--template <file>] [[-i | -o] <path>...]'
+USAGE=3D'[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | =
-F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>=
] [--template <file>] [--only-tracked] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=3DYes
 . git-sh-setup
 require_work_tree
@@ -56,7 +56,8 @@ run_status () {
 	git runstatus ${color} \
 		${verbose:+--verbose} \
 		${amend:+--amend} \
-		${untracked_files:+--untracked}
+		${untracked_files:+--untracked} \
+		${only_tracked:+--only-tracked}
 }
=20
 trap '
@@ -87,6 +88,7 @@ signoff=3D
 force_author=3D
 only_include_assumed=3D
 untracked_files=3D
+only_tracked=3D
 templatefile=3D"`git config commit.template`"
 while case "$#" in 0) break;; esac
 do
@@ -269,6 +271,11 @@ $1"
 		untracked_files=3Dt
 		shift
 		;;
+    --only-|--only-t|--only-tr|--only-tra|--only-trac|--only-track|\
+    --only-tracke|--only-tracked)
+        only_tracked=3Dt
+        shift
+        ;;
 	--)
 		shift
 		break
diff --git a/wt-status.c b/wt-status.c
index 5205420..7c2c468 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -331,7 +331,13 @@ void wt_status_print(struct wt_status *s)
 	}
=20
 	wt_status_print_changed(s);
-	wt_status_print_untracked(s);
+
+	if (!s->only_tracked) {
+		wt_status_print_untracked(s);
+	}
+	else {
+		printf("# Untracked files were filtered by \"--only-tracked\"\n");
+	}
=20
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
diff --git a/wt-status.h b/wt-status.h
index cfea4ae..45b7e09 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -15,6 +15,7 @@ struct wt_status {
 	int verbose;
 	int amend;
 	int untracked;
+	int only_tracked;
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
--=20
1.5.3.rc6.17.g1911-dirty
