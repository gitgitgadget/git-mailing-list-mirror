From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Teach rev-parse the ... syntax.
Date: Tue, 04 Jul 2006 11:02:22 +0200
Message-ID: <873bdhbv4x.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jul 04 11:02:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxgnV-0007qj-2f
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 11:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWGDJCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Jul 2006 05:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWGDJCP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 05:02:15 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:13521 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1750859AbWGDJCO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 05:02:14 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k64817v31987;
	Tue, 4 Jul 2006 10:01:07 +0200
To: Git Mailing List <git@vger.kernel.org>,
	"Junio C. Hamano" <junkio@cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23275>

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---

 I think this time the mail patch is OK, I've tested it.

 builtin-rev-parse.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 5f5ade4..8d2beb2 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -331,14 +331,29 @@ int cmd_rev_parse(int argc, const char *
 			unsigned char end[20];
 			const char *next =3D dotdot + 2;
 			const char *this =3D arg;
+			int symmetric =3D *next =3D=3D '.';
+
 			*dotdot =3D 0;
+			next +=3D symmetric;
+
 			if (!*next)
 				next =3D "HEAD";
 			if (dotdot =3D=3D arg)
 				this =3D "HEAD";
 			if (!get_sha1(this, sha1) && !get_sha1(next, end)) {
 				show_rev(NORMAL, end, next);
-				show_rev(REVERSED, sha1, this);
+				show_rev(symmetric?NORMAL:REVERSED, sha1, this);
+				if (symmetric) {
+				  struct commit *a, *b;
+				  a =3D lookup_commit_reference(sha1);
+				  b =3D lookup_commit_reference(end);
+				  struct commit_list *exclude =3D get_merge_bases(a, b,1);
+				  while (exclude) {
+				    show_rev(REVERSED,
+					     exclude->item->object.sha1,NULL);
+				    exclude =3D exclude->next;
+				  }
+				}
 				continue;
 			}
 			*dotdot =3D '.';
--=20
1.4.1.ge6c0-dirty
