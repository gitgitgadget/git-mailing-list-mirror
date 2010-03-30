From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diff: add "fasttextconv" config option
Date: Tue, 30 Mar 2010 12:30:04 -0400
Message-ID: <20100330163004.GC17763@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <20100328145421.GC27970@coredump.intra.peff.net>
 <201003282023.00913.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 18:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NweKe-0004Pp-G4
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 18:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab0C3QaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 12:30:19 -0400
Received: from peff.net ([208.65.91.99]:33259 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab0C3QaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 12:30:17 -0400
Received: (qmail 22589 invoked by uid 107); 30 Mar 2010 16:30:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 12:30:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 12:30:04 -0400
Content-Disposition: inline
In-Reply-To: <201003282023.00913.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143577>

On Sun, Mar 28, 2010 at 08:23:00PM +0200, Johannes Sixt wrote:

> On Sonntag, 28. M=C3=A4rz 2010, Jeff King wrote:
> > +	if (start_command(&child) !=3D 0 ||
> > +	    strbuf_read(&buf, child.out, 0) < 0 ||
> > +	    finish_command(&child) !=3D 0) {
>=20
> This conditional is somewhat dubious. If strbuf_read fails, you do no=
t wait=20
> for the child, and a zombie remains.
>=20
> The have this sequence already in run_textconv().

Ugh. I would blame the author of run_textconv, but that is also me. :)

I doubt it is a big deal in practice, as the read() call is the least
likely to produce an error, and even if we do get a zombie, it will die
along with the diffing process. But it is still worth fixing. Thanks fo=
r
noticing.

Junio, can you apply the patch below to maint?

-- >8 --
Subject: [PATCH] diff: fix textconv error zombies

To make the code simpler, run_textconv lumps all of its
error checking into one conditional. However, the
short-circuit means that an error in reading will prevent us
from calling finish_command, leaving a zombie child.

The cleanup requirements are actually different for each of
the three error checks, so let's just write them out
longhand.

Signed-off-by: Jeff King <peff@peff.net>
---
Yes, there are clever ways to make this shorter, but I think it is
clearer just written out.

 diff.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 0d465fa..c268cfc 100644
--- a/diff.c
+++ b/diff.c
@@ -3875,9 +3875,19 @@ static char *run_textconv(const char *pgm, struc=
t diff_filespec *spec,
 	child.use_shell =3D 1;
 	child.argv =3D argv;
 	child.out =3D -1;
-	if (start_command(&child) !=3D 0 ||
-	    strbuf_read(&buf, child.out, 0) < 0 ||
-	    finish_command(&child) !=3D 0) {
+	if (start_command(&child) !=3D 0) {
+		remove_tempfile();
+		error("error running textconv command '%s'", pgm);
+		return NULL;
+	}
+	if (strbuf_read(&buf, child.out, 0) < 0) {
+		close(child.out);
+		finish_command(&child);
+		remove_tempfile();
+		error("error reading from textconv command '%s'", pgm);
+		return NULL;
+	}
+	if (finish_command(&child) !=3D 0) {
 		close(child.out);
 		strbuf_release(&buf);
 		remove_tempfile();
--=20
1.7.0.3.460.g6f052
