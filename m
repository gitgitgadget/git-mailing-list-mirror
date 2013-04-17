From: Jeff King <peff@peff.net>
Subject: [PATCH] cat-file: print tags raw for "cat-file -p"
Date: Wed, 17 Apr 2013 17:00:48 -0400
Message-ID: <20130417210048.GA635@sigill.intra.peff.net>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx>
 <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx>
 <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
 <7vli8hhgmn.fsf@alter.siamese.dyndns.org>
 <20130417063942.GA27703@sigill.intra.peff.net>
 <516EE300.7020200@lsrfire.ath.cx>
 <20130417180248.GA1839@sigill.intra.peff.net>
 <516EF2AD.9090403@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 17 23:00:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USZTM-0003Xf-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 23:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966553Ab3DQVAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 17:00:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50284 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755527Ab3DQVAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 17:00:51 -0400
Received: (qmail 4659 invoked by uid 107); 17 Apr 2013 21:02:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Apr 2013 17:02:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Apr 2013 17:00:48 -0400
Content-Disposition: inline
In-Reply-To: <516EF2AD.9090403@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221571>

On Wed, Apr 17, 2013 at 09:06:21PM +0200, Ren=C3=A9 Scharfe wrote:

> Am 17.04.2013 20:02, schrieb Jeff King:
> >I think we also need to do something about "git cat-file -p", which =
does
> >not use the split_ident_line parser (but has its own problems with t=
he
> >home-grown parser).
>=20
> Ah, while it prints commit object contents verbatim, it formats the d=
ate
> of tags.  And it does it without help from tag.c (or ident.c), which =
in
> turn does its own parsing as well.  So it looks like we have two more
> candidates for conversion to split_ident_line() here.

I think we should apply the patch below to just drop the date formattin=
g
from cat-file, along with your two patches.  This is the 4/4 from the
series I posted in February:

  http://thread.gmane.org/gmane.comp.version-control.git/216870/focus=3D=
217081

but there I claimed that "git tag -v" might be affected. Upon looking
closer, it is not; we accidentally dropped the pretty-printing of the
date from it many years ago (and nobody seemed to care).

The other patches from that series aren't necessary. The 1/4 is replace=
d
by your patches (which do roughly the same thing, but add nice tests an=
d
seem to refactor a bit more). The 2/4 and 3/4 patches were about adding
new fsck checks for tags, but I think there is some refactoring
necessary there. They can wait for now.

-- >8 --
Subject: [PATCH] cat-file: print tags raw for "cat-file -p"

When "cat-file -p" prints commits, it shows them in their
raw format, since git's format is already human-readable.
=46or tags, however, we print the whole thing raw except for
one thing: we convert the timestamp on the tagger line into a
human-readable date.

This dates all the way back to a0f15fa (Pretty-print tagger
dates, 2006-03-01). At that time there was no other way to
pretty-print a tag.  These days, however, neither of those
matters much. The normal way to pretty-print a tag is with
"git show", which is much more flexible than "cat-file -p".

Commit a0f15fa also built "verify-tag --verbose" (and
subsequently "tag -v") around the "cat-file -p" output.
However, that behavior was lost in commit 62e09ce (Make git
tag a builtin, 2007-07-20), and we went back to printing
the raw tag contents. Nobody seems to have noticed the bug
since then (and it is arguably a saner behavior anyway, as
it shows the actual bytes for which we verified the
signature).

Let's drop the tagger-date formatting for "cat-file -p". It
makes us more consistent with cat-file's commit
pretty-printer, and as a bonus, we can drop the hand-rolled
tag parsing code in cat-file (which happened to behave
inconsistently with the tag pretty-printing code elsewhere).

This is a change of output format, so it's possible that
some callers could considered this a regression. However,
the original behavior was arguably a bug (due to the
inconsistency with commits), likely nobody was relying on it
(even we do not use it ourselves these days), and anyone
relying on the "-p" pretty-printer should be able to expect
a change in the output format (i.e., while "cat-file" is
plumbing, the output format of "-p" was never guaranteed to
be stable).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c  | 71 ---------------------------------------------=
--------
 t/t1006-cat-file.sh |  5 +---
 2 files changed, 1 insertion(+), 75 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 40f87b4..045cee7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,73 +16,6 @@
 #define BATCH 1
 #define BATCH_CHECK 2
=20
-static void pprint_tag(const unsigned char *sha1, const char *buf, uns=
igned long size)
-{
-	/* the parser in tag.c is useless here. */
-	const char *endp =3D buf + size;
-	const char *cp =3D buf;
-
-	while (cp < endp) {
-		char c =3D *cp++;
-		if (c !=3D '\n')
-			continue;
-		if (7 <=3D endp - cp && !memcmp("tagger ", cp, 7)) {
-			const char *tagger =3D cp;
-
-			/* Found the tagger line.  Copy out the contents
-			 * of the buffer so far.
-			 */
-			write_or_die(1, buf, cp - buf);
-
-			/*
-			 * Do something intelligent, like pretty-printing
-			 * the date.
-			 */
-			while (cp < endp) {
-				if (*cp++ =3D=3D '\n') {
-					/* tagger to cp is a line
-					 * that has ident and time.
-					 */
-					const char *sp =3D tagger;
-					char *ep;
-					unsigned long date;
-					long tz;
-					while (sp < cp && *sp !=3D '>')
-						sp++;
-					if (sp =3D=3D cp) {
-						/* give up */
-						write_or_die(1, tagger,
-							     cp - tagger);
-						break;
-					}
-					while (sp < cp &&
-					       !('0' <=3D *sp && *sp <=3D '9'))
-						sp++;
-					write_or_die(1, tagger, sp - tagger);
-					date =3D strtoul(sp, &ep, 10);
-					tz =3D strtol(ep, NULL, 10);
-					sp =3D show_date(date, tz, 0);
-					write_or_die(1, sp, strlen(sp));
-					xwrite(1, "\n", 1);
-					break;
-				}
-			}
-			break;
-		}
-		if (cp < endp && *cp =3D=3D '\n')
-			/* end of header */
-			break;
-	}
-	/* At this point, we have copied out the header up to the end of
-	 * the tagger line and cp points at one past \n.  It could be the
-	 * next header line after the tagger line, or it could be another
-	 * \n that marks the end of the headers.  We need to copy out the
-	 * remainder as is.
-	 */
-	if (cp < endp)
-		write_or_die(1, cp, endp - cp);
-}
-
 static int cat_one_file(int opt, const char *exp_type, const char *obj=
_name)
 {
 	unsigned char sha1[20];
@@ -133,10 +66,6 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name)
 		buf =3D read_sha1_file(sha1, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
-		if (type =3D=3D OBJ_TAG) {
-			pprint_tag(sha1, buf, size);
-			return 0;
-		}
=20
 		/* otherwise just spit out the data */
 		break;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 9820f70..9cc5c6b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -135,14 +135,11 @@ tag_size=3D$(strlen "$tag_content")
 tag_content=3D"$tag_header_without_timestamp 0000000000 +0000
=20
 $tag_description"
-tag_pretty_content=3D"$tag_header_without_timestamp Thu Jan 1 00:00:00=
 1970 +0000
-
-$tag_description"
=20
 tag_sha1=3D$(echo_without_newline "$tag_content" | git mktag)
 tag_size=3D$(strlen "$tag_content")
=20
-run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_pretty_conten=
t" 1
+run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
=20
 test_expect_success \
     "Reach a blob from a tag pointing to it" \
--=20
1.8.2.11.g42401f0
