From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] rerere: remove duplicated functions
Date: Sat, 14 Feb 2009 17:18:04 +0100
Message-ID: <1234628284-4246-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 17:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYNF3-0002Cu-7p
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 17:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbZBNQSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 11:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbZBNQSL
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 11:18:11 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:64287 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZBNQSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 11:18:10 -0500
Received: from [127.0.1.1] (p5B130271.dip0.t-ipconnect.de [91.19.2.113])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1LYNDQ2pb5-0007TO; Sat, 14 Feb 2009 17:18:06 +0100
X-Mailer: git-send-email 1.6.2.rc0.111.g246ed
X-Provags-ID: V01U2FsdGVkX183YswyRsvSRBH/TkenhL8aRXMLAs+qGKW1qzy
 t5cADShCClHvbfGPR5sIgN7rK6MSTLaMAR/Dyi/NcQxXYq1VEs
 X8kJG3aa/JO3Ar5R0xGkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109876>

Both rerere.c and builtin-rerere.c define the static functions
rr_path() and has_resolution() the exact same way.  To eliminate this
code duplication this patch turns the functions in rerere.c
non-static, and makes builtin-rerere.c use them.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 builtin-rerere.c |   11 -----------
 rerere.c         |    4 ++--
 rerere.h         |    2 ++
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index bd8fc77..b175334 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -13,23 +13,12 @@ static const char git_rerere_usage[] =3D
 static int cutoff_noresolve =3D 15;
 static int cutoff_resolve =3D 60;
=20
-static const char *rr_path(const char *name, const char *file)
-{
-	return git_path("rr-cache/%s/%s", name, file);
-}
-
 static time_t rerere_created_at(const char *name)
 {
 	struct stat st;
 	return stat(rr_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtim=
e;
 }
=20
-static int has_resolution(const char *name)
-{
-	struct stat st;
-	return !stat(rr_path(name, "postimage"), &st);
-}
-
 static void unlink_rr_item(const char *name)
 {
 	unlink(rr_path(name, "thisimage"));
diff --git a/rerere.c b/rerere.c
index 3518207..ac89b80 100644
--- a/rerere.c
+++ b/rerere.c
@@ -12,12 +12,12 @@ static int rerere_autoupdate;
=20
 static char *merge_rr_path;
=20
-static const char *rr_path(const char *name, const char *file)
+const char *rr_path(const char *name, const char *file)
 {
 	return git_path("rr-cache/%s/%s", name, file);
 }
=20
-static int has_resolution(const char *name)
+int has_resolution(const char *name)
 {
 	struct stat st;
 	return !stat(rr_path(name, "postimage"), &st);
diff --git a/rerere.h b/rerere.h
index f9b0386..45b5087 100644
--- a/rerere.h
+++ b/rerere.h
@@ -5,5 +5,7 @@
=20
 extern int setup_rerere(struct string_list *);
 extern int rerere(void);
+extern const char *rr_path(const char *name, const char *file);
+extern int has_resolution(const char *name);
=20
 #endif
--=20
1.6.2.rc0.111.g246ed
