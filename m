From: =?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
Subject: [RFC/PATCH v3] tag: display original sha1 of deleted/overwritten tag
Date: Thu, 10 Dec 2009 14:58:57 +0100
Message-ID: <1260453537-6156-1-git-send-email-zfuzesi@eaglet.hu>
References: <1260451579-4400-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jari.aalto@cante.net,
	=?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 15:00:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIjYQ-0002LD-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 14:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760808AbZLJN6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 08:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760584AbZLJN6Y
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 08:58:24 -0500
Received: from mail.icell.hu ([80.99.238.252]:52130 "EHLO mail.icell.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759394AbZLJN6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 08:58:21 -0500
Received: from source.ifleet (unknown [10.1.1.250])
	by mail.icell.hu (Postfix) with ESMTP id 9ABD21A7;
	Thu, 10 Dec 2009 15:01:23 +0100 (CET)
Received: from fuge by source.ifleet with local (Exim 4.69)
	(envelope-from <zoltan.fuzesi@icell.hu>)
	id 1NIjXl-0001bq-J7; Thu, 10 Dec 2009 14:58:57 +0100
X-Mailer: git-send-email 1.6.6.rc2
In-Reply-To: <1260451579-4400-1-git-send-email-zfuzesi@eaglet.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135028>

It makes possible to undo accidental tag deletion and overwriting.

Signed-off-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
---
This patch was created in response to this feature request:
http://article.gmane.org/gmane.comp.version-control.git/135016
I named it "RFC" because of the overwriting part.

v3: works when tag object is created (I should slow down...)

 builtin-tag.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index c479018..1404a0e 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -140,7 +140,7 @@ static int delete_tag(const char *name, const char =
*ref,
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
-	printf("Deleted tag '%s'\n", name);
+	printf("Deleted tag '%s' %s\n", name, sha1_to_hex(sha1));
 	return 0;
 }
=20
@@ -363,7 +363,7 @@ static int parse_msg_arg(const struct option *opt, =
const char *arg, int unset)
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf =3D STRBUF_INIT;
-	unsigned char object[20], prev[20];
+	unsigned char object[20], prev[20], tag_object[20];
 	char ref[PATH_MAX];
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
@@ -472,13 +472,15 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (annotate)
 		create_tag(object, tag, &buf, msg.given || msgfile,
-			   sign, prev, object);
+			   sign, prev, tag_object);
=20
 	lock =3D lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
 		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, object, NULL) < 0)
+	if (write_ref_sha1(lock, annotate ? tag_object : object, NULL) < 0)
 		die("%s: cannot update the ref", ref);
+	else if (force && hashcmp(object, prev))
+		printf("Overwritten tag '%s' (%s)\n", ref, sha1_to_hex(prev));
=20
 	strbuf_release(&buf);
 	return 0;
--=20
1.6.6.rc2
