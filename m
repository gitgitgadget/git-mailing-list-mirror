From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Fix regression in fast-import.c due to strbufs.
Date: Fri, 26 Oct 2007 09:59:12 +0200
Message-ID: <20071026075912.GA25365@artemis.corp>
References: <de47e4420710251726nb45a19fk15b3105b735a74f8@mail.gmail.com> <de47e4420710251729j5858481cg69146385a2ed798d@mail.gmail.com> <20071026065301.GL14735@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="opJtzjQTFsWo+cga";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: cpettitt <cpettitt@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 09:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlK6K-0002wp-Pk
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 09:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbXJZH7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 03:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbXJZH7Q
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 03:59:16 -0400
Received: from pan.madism.org ([88.191.52.104]:42015 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbXJZH7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 03:59:15 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DC08D26D34;
	Fri, 26 Oct 2007 09:59:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CEB08FA27; Fri, 26 Oct 2007 09:59:12 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	cpettitt <cpettitt@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071026065301.GL14735@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62401>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Without this strbuf_release, it yields a double free later, the command is
in fact stashed, and this is not a memory leak.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  On Fri, Oct 26, 2007 at 06:53:01AM +0000, Shawn O. Pearce wrote:
  > cpettitt <cpettitt@gmail.com> wrote:
  > > I'm seeing the following errors when I run git-fast-import (on Intel
  > > OSX) with some data from a git-p4 import:
  > ....
  > > I believe these errors started showing up in commit
  > > b449f4cfc972929b638b90d375b8960c37790618. I did a bisect on
  > > fast-import.c and this was the first commit for that file that
  > > exhibits this bug with the input.
  > >=20
  > > I thought I would check with the list to see if this is a known issue
  > > before I spend time trying to dig into it.
  >=20
  > It is a known issue.  Someone else has reported the same thing,
  > and bisecting pointed at the same commit.  But they weren't able
  > to supply their input data for debugging by Pierre or myself as it
  > was a private project and they haven't had a chance to attempt to
  > debug it on their own.
  >=20
  > Any light you can shed on the problem would be most appreciated.

  Wait, I believe I found the problem thanks to the "free" that fails.

  Could you please try that patch ? looking at the diff again, and
  knowing the issue is with an rc->buf (which are old command_buf
  stashed buffers) it looks like I migrated cmd_data improperly.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org
 fast-import.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6f888f6..f93d7d6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1616,6 +1616,7 @@ static void cmd_data(struct strbuf *sb)
 		char *term =3D xstrdup(command_buf.buf + 5 + 2);
 		size_t term_len =3D command_buf.len - 5 - 2;
=20
+		strbuf_detach(&command_buf, NULL);
 		for (;;) {
 			if (strbuf_getline(&command_buf, stdin, '\n') =3D=3D EOF)
 				die("EOF in data (terminator '%s' not found)", term);
--=20
1.5.3.4.1358.gfae55-dirty


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHIZ5QvGr7W6HudhwRAgVIAKCgoescaL+ssUW460n0tNVD+BG4QACgpKMI
gF6HSD7yqGdU8GkeBQRRQHA=
=X+zg
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
