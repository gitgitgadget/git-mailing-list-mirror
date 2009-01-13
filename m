From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <tavestbo@trolltech.com>
Subject: [PATCH next] git-notes: fix printing of multi-line notes
Date: Tue, 13 Jan 2009 20:57:16 +0100
Message-ID: <496CF21C.2050500@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, junio@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 20:54:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpL0-0004gE-3T
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 20:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbZAMTwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 14:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbZAMTwp
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 14:52:45 -0500
Received: from hoat.troll.no ([62.70.27.150]:47645 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbZAMTwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 14:52:45 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 7CFD320F0B;
	Tue, 13 Jan 2009 20:52:39 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 7521E20F06;
	Tue, 13 Jan 2009 20:52:39 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n0DJqcAp019073;
	Tue, 13 Jan 2009 20:52:38 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Tue, 13 Jan 2009 20:52:37 +0100 (CET)
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105524>

The line length was read from the same position every time,
causing mangled output when printing notes with multiple lines.

Also, adding new-line manually for each line ensures that we
get a new-line between commits, matching git-log for commits
without notes.

Signed-off-by: Tor Arne Vestb=F8 <tavestbo@trolltech.com>
---

This approach uses a msg pointer, but I started out with just using
msg + msgoffset all over the place, so if that's a preferred way
to do things I'm happy to provide an alternate patch.

Also, I'm guessing this printing should go into pretty.c at some
point, so you can reference the notes as part of a custom pretty
format. If so, this code could be converted to use helpers such
as get_one_line().

This is my first patch to Git, so sorry if I messed something up :)

notes.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

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
--=20
1.6.0.2.GIT
