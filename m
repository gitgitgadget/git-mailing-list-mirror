From: Jeff King <peff@peff.net>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 13:14:20 -0400
Message-ID: <20090312171420.GA2192@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302> <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com> <fabb9a1e0903120643r3cfefdfej560ff7edda2be6f5@mail.gmail.com> <B9479687-D936-4EE1-A5A4-663968B76EBF@ai.rug.nl> <20090312153738.GA24690@coredump.intra.peff.net> <43d8ce650903120916yb91113fy5485813c512c8108@mail.gmail.com> <20090312163533.GA28205@coredump.intra.peff.net> <EAF5D3F1-32F2-4BF3-9B10-F91C17D06A6A@ai.rug.nl> <20090312165153.GA28401@coredump.intra.peff.net> <43d8ce650903120958n18baf6c0w9d083976b52d6e40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 18:22:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhoVi-0005KC-GM
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 18:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974AbZCLROa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 13:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZCLROa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 13:14:30 -0400
Received: from peff.net ([208.65.91.99]:56936 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbZCLRO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 13:14:29 -0400
Received: (qmail 3277 invoked by uid 107); 12 Mar 2009 17:14:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Mar 2009 13:14:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2009 13:14:20 -0400
Content-Disposition: inline
In-Reply-To: <43d8ce650903120958n18baf6c0w9d083976b52d6e40@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113094>

On Thu, Mar 12, 2009 at 04:58:22PM +0000, John Tapsell wrote:

> > - =C2=A0 =C2=A0 =C2=A0 if (resolve_ref(ref.buf, sha1, 1, NULL)) {
> > + =C2=A0 =C2=A0 =C2=A0 if (dwim_ref(name, strlen(name), sha1, &junk=
)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(junk);
>=20
> Presumably 'junk' is the resolved name?  I wonder if it's worth
> putting this info in the error message?

Hey, I said it was sloppy, right? ;)

Here's your suggestion, plus specifying which situation (existing branc=
h
or ambiguous ref) would occur. It would still need tests. But I'm
curious to hear more opinions on this direction before cleaning it up
much more (at the very least, it needs some tests).

--- a/branch.c
+++ b/branch.c
@@ -133,6 +133,7 @@ void create_branch(const char *head,
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
 	struct strbuf ref =3D STRBUF_INIT;
+	char *existing;
 	int forcing =3D 0;
 	int len;
=20
@@ -146,12 +147,18 @@ void create_branch(const char *head,
 	if (check_ref_format(ref.buf))
 		die("'%s' is not a valid branch name.", name);
=20
-	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
-		if (!force)
-			die("A branch named '%s' already exists.", name);
+	if (dwim_ref(name, strlen(name), sha1, &existing)) {
+		if (!force) {
+			if (!prefixcmp(existing, "refs/heads/"))
+				die("A branch named '%s' already exists.",
+				    name);
+			die("Creating '%s' would be ambiguous with"
+			    " the existing %s", name, existing);
+		}
 		else if (!is_bare_repository() && !strcmp(head, name))
 			die("Cannot force update the current branch.");
 		forcing =3D 1;
+		free(existing);
 	}
=20
 	real_ref =3D NULL;
