From: Jeff King <peff@peff.net>
Subject: [PATCH 1/9] sha1_file: replace PATH_MAX buffer with strbuf in
 prepare_packed_git_one()
Date: Mon, 30 Jun 2014 12:55:52 -0400
Message-ID: <20140630165551.GA16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:56:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1es1-0008Ok-L1
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbaF3Qzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 12:55:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53639 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754652AbaF3Qzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:55:53 -0400
Received: (qmail 7578 invoked by uid 102); 30 Jun 2014 16:55:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:55:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:55:52 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252683>

=46rom: Ren=C3=A9 Scharfe <l.s.r@web.de>

Instead of using strbuf to create a message string in case a path is
too long for our fixed-size buffer, replace that buffer with a strbuf
and thus get rid of the limitation.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 34d527f..394fa45 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1177,48 +1177,37 @@ static void report_pack_garbage(struct string_l=
ist *list)
=20
 static void prepare_packed_git_one(char *objdir, int local)
 {
-	/* Ensure that this buffer is large enough so that we can
-	   append "/pack/" without clobbering the stack even if
-	   strlen(objdir) were PATH_MAX.  */
-	char path[PATH_MAX + 1 + 4 + 1 + 1];
-	int len;
+	struct strbuf path =3D STRBUF_INIT;
+	size_t dirnamelen;
 	DIR *dir;
 	struct dirent *de;
 	struct string_list garbage =3D STRING_LIST_INIT_DUP;
=20
-	sprintf(path, "%s/pack", objdir);
-	len =3D strlen(path);
-	dir =3D opendir(path);
+	strbuf_addstr(&path, objdir);
+	strbuf_addstr(&path, "/pack");
+	dir =3D opendir(path.buf);
 	if (!dir) {
 		if (errno !=3D ENOENT)
 			error("unable to open object pack directory: %s: %s",
-			      path, strerror(errno));
+			      path.buf, strerror(errno));
+		strbuf_release(&path);
 		return;
 	}
-	path[len++] =3D '/';
+	strbuf_addch(&path, '/');
+	dirnamelen =3D path.len;
 	while ((de =3D readdir(dir)) !=3D NULL) {
-		int namelen =3D strlen(de->d_name);
 		struct packed_git *p;
=20
-		if (len + namelen + 1 > sizeof(path)) {
-			if (report_garbage) {
-				struct strbuf sb =3D STRBUF_INIT;
-				strbuf_addf(&sb, "%.*s/%s", len - 1, path, de->d_name);
-				report_garbage("path too long", sb.buf);
-				strbuf_release(&sb);
-			}
-			continue;
-		}
-
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
=20
-		strcpy(path + len, de->d_name);
+		strbuf_setlen(&path, dirnamelen);
+		strbuf_addstr(&path, de->d_name);
=20
 		if (has_extension(de->d_name, ".idx")) {
 			/* Don't reopen a pack we already have. */
 			for (p =3D packed_git; p; p =3D p->next) {
-				if (!memcmp(path, p->pack_name, len + namelen - 4))
+				if (!memcmp(path.buf, p->pack_name, path.len - 4))
 					break;
 			}
 			if (p =3D=3D NULL &&
@@ -1226,7 +1215,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 			     * See if it really is a valid .idx file with
 			     * corresponding .pack file that we can map.
 			     */
-			    (p =3D add_packed_git(path, len + namelen, local)) !=3D NULL)
+			    (p =3D add_packed_git(path.buf, path.len, local)) !=3D NULL)
 				install_packed_git(p);
 		}
=20
@@ -1237,13 +1226,14 @@ static void prepare_packed_git_one(char *objdir=
, int local)
 		    has_extension(de->d_name, ".pack") ||
 		    has_extension(de->d_name, ".bitmap") ||
 		    has_extension(de->d_name, ".keep"))
-			string_list_append(&garbage, path);
+			string_list_append(&garbage, path.buf);
 		else
-			report_garbage("garbage found", path);
+			report_garbage("garbage found", path.buf);
 	}
 	closedir(dir);
 	report_pack_garbage(&garbage);
 	string_list_clear(&garbage, 0);
+	strbuf_release(&path);
 }
=20
 static int sort_pack(const void *a_, const void *b_)
--=20
2.0.0.566.gfe3e6b2
