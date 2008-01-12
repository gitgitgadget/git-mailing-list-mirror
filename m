From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 04:04:32 -0500
Message-ID: <20080112090432.GA6134@coredump.intra.peff.net>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Sat Jan 12 10:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDcIq-0008Df-FJ
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 10:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYALJEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 04:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYALJEh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 04:04:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1202 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbYALJEf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 04:04:35 -0500
Received: (qmail 5386 invoked by uid 111); 12 Jan 2008 09:04:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 12 Jan 2008 04:04:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2008 04:04:32 -0500
Content-Disposition: inline
In-Reply-To: <200801120947.48602.ismail@pardus.org.tr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70299>

On Sat, Jan 12, 2008 at 09:47:48AM +0200, Ismail D=F6nmez wrote:

> So looks like tests no longer work as root, so I run make test as nor=
mal user=20
> and I now see t7300-clean.sh fail, this time a real failure:
>=20
> Removing part3.c
> ./test-lib.sh: line 193: 19413 Aborted                 git-clean
> * FAIL 5: git-clean with prefix

I couldn't reproduce this just running the test, but running it under
valgrind showed a memory access error. Fix is below.

Junio, can you please sanity check this fix (it stops the valgrind
error, but I want to make sure my assumptions about match_pathspec are
right).

-- >8 --
git-clean: fix off-by-one memory access when given no arguments

The "seen" variable is used by match_pathspec, and must have
as many elements as there are in the given pathspec. We
create the pathspec either from the command line arguments
_or_ from just the current prefix.

Thus allocating "seen" based upon just argc is wrong, since
if argc =3D=3D 0, then we still have one pathspec, the prefix,
but we don't allocate any space in "seen".

Signed-off-by: Jeff King <peff@peff.net>
---
It might be more readable to actually set a variable pathspec_size and
use that.

 builtin-clean.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 6cad8ea..eb853a3 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -90,7 +90,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 	strbuf_init(&directory, 0);
=20
 	if (pathspec)
-		seen =3D xmalloc(argc);
+		seen =3D xmalloc(argc > 0 ? argc : 1);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
@@ -125,7 +125,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			continue;
=20
 		if (pathspec) {
-			memset(seen, 0, argc);
+			memset(seen, 0, argc > 0 ? argc : 1);
 			matches =3D match_pathspec(pathspec, ent->name, ent->len,
 						 baselen, seen);
 		} else {
--=20
1.5.4.rc3-dirty
