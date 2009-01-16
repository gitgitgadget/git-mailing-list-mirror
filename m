From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <tavestbo@trolltech.com>
Subject: [PATCH next v4] git-notes: fix printing of multi-line notes
Date: Fri, 16 Jan 2009 14:06:12 +0100
Message-ID: <49708644.7040809@trolltech.com>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNoLS-0002UH-9c
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759507AbZAPNBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 08:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758907AbZAPNBS
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:01:18 -0500
Received: from hoat.troll.no ([62.70.27.150]:55724 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757018AbZAPNBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:01:17 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 1668D20FE4;
	Fri, 16 Jan 2009 14:01:11 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 00F6F20F6D;
	Fri, 16 Jan 2009 14:01:11 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n0GD1AAE004765;
	Fri, 16 Jan 2009 14:01:10 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Fri, 16 Jan 2009 14:01:10 +0100 (CET)
In-Reply-To: <alpine.DEB.1.00.0901142209570.3586@pacific.mpi-cbg.de>
References: <496E51A3.8050908@gmail.com>
References: <alpine.DEB.1.00.0901142209570.3586@pacific.mpi-cbg.de>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105951>

The line length was read from the same position every time,
causing mangled output when printing notes with multiple lines.

Also, adding new-line manually for each line ensures that we
get a new-line between commits, matching git-log for commits
without notes.

Test case added to t3301-notes.sh.

Signed-off-by: Tor Arne Vestb=F8 <tavestbo@trolltech.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Sorry about the delay. Here's a squashed patch.

 notes.c          |   13 +++++++------
 t/t3301-notes.sh |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/notes.c b/notes.c
index ad43a2e..bd73784 100644
--- a/notes.c
+++ b/notes.c
@@ -110,8 +110,8 @@ void get_commit_notes(const struct commit *commit, =
struct strbuf *sb,
 {
 	static const char *utf8 =3D "utf-8";
 	unsigned char *sha1;
-	char *msg;
-	unsigned long msgoffset, msglen;
+	char *msg, *msg_p;
+	unsigned long linelen, msglen;
 	enum object_type type;
=20
 	if (!initialized) {
@@ -148,12 +148,13 @@ void get_commit_notes(const struct commit *commit=
, struct strbuf *sb,
=20
 	strbuf_addstr(sb, "\nNotes:\n");
=20
-	for (msgoffset =3D 0; msgoffset < msglen;) {
-		int linelen =3D strchrnul(msg, '\n') - msg;
+	for (msg_p =3D msg; msg_p < msg + msglen; msg_p +=3D linelen + 1) {
+		linelen =3D strchrnul(msg_p, '\n') - msg_p;
=20
 		strbuf_addstr(sb, "    ");
-		strbuf_add(sb, msg + msgoffset, linelen);
-		msgoffset +=3D linelen;
+		strbuf_add(sb, msg_p, linelen);
+		strbuf_addch(sb, '\n');
 	}
+
 	free(msg);
 }
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index ba42c45..9393a25 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -59,7 +59,37 @@ EOF
 test_expect_success 'show notes' '
 	! (git cat-file commit HEAD | grep b1) &&
 	git log -1 > output &&
-	git diff expect output
+	test_cmp expect output
+'
+test_expect_success 'create multi-line notes (setup)' '
+	: > a3 &&
+	git add a3 &&
+	test_tick &&
+	git commit -m 3rd &&
+	MSG=3D"b3
+c3c3c3c3
+d3d3d3" git notes edit
+'
+
+cat > expect-multiline << EOF
+commit 1584215f1d29c65e99c6c6848626553fdd07fd75
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes:
+    b3
+    c3c3c3c3
+    d3d3d3
+EOF
+
+printf "\n" >> expect-multiline
+cat expect >> expect-multiline
+
+test_expect_success 'show multi-line notes' '
+	git log -2 > output &&
+	test_cmp expect-multiline output
 '
=20
 test_done
--=20
1.6.0.2.GIT
