From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] cat-file: print tags raw for "cat-file -p"
Date: Mon, 25 Feb 2013 13:50:58 -0500
Message-ID: <20130225185058.GD14438@sigill.intra.peff.net>
References: <20130225183009.GB13912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:51:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA399-0007Jw-4E
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167Ab3BYSvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:51:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60104 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3BYSvB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:51:01 -0500
Received: (qmail 25727 invoked by uid 107); 25 Feb 2013 18:52:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 13:52:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 13:50:58 -0500
Content-Disposition: inline
In-Reply-To: <20130225183009.GB13912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217081>

When "cat-file -p" prints commits, it shows them in their
raw format, since git's format is already human-readable.
For tags, however, we print the whole thing raw except for
one thing: we convert the timestamp on the tagger line into a
human-readable date.

This dates all the way back to a0f15fa (Pretty-print tagger
dates, 2006-03-01). At that time there was no way to
pretty-print a tag. These days "git show" does this already,
and is the normal tool for showing a pretty-printed output
("cat-file tag $tag" remains the preferred method for
showing porcelain output).

Let's drop this. It makes us more consistent with cat-file's
commit pretty-printer, and it means we can drop a whole
bunch of hand-rolled tag parsing code (which happened to
behave inconsistently with the tag pretty-printing code
elsewhere).

Note that "git verify-tag" and "git tag -v" depend on
"cat-file -p" to show the tag. This means they will start
showing the raw timestamp. We may want to adjust them to
use the pretty-printing code from "git show".

Signed-off-by: Jeff King <peff@peff.net>
---
I don't use "git tag -v" much, so I'm not sure what is sane there. But
this seems like it would be a regression for people who want to check
the human-readable date given by GPG against the date in the tag object.

I still think dropping this hand-rolled parsing is a good thing. The
most sane thing to me would be to move the parsing from "git show" into
the pretty-print code, then have both it and "verify-tag" use it.
Probably "for-each-ref" could stand to use it as well, as it has its own
home-grown parser.

 builtin/cat-file.c  | 71 -----------------------------------------------------
 t/t1006-cat-file.sh |  5 +---
 2 files changed, 1 insertion(+), 75 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 00528dd..b195edf 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,73 +16,6 @@
 #define BATCH 1
 #define BATCH_CHECK 2
 
-static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long size)
-{
-	/* the parser in tag.c is useless here. */
-	const char *endp = buf + size;
-	const char *cp = buf;
-
-	while (cp < endp) {
-		char c = *cp++;
-		if (c != '\n')
-			continue;
-		if (7 <= endp - cp && !memcmp("tagger ", cp, 7)) {
-			const char *tagger = cp;
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
-				if (*cp++ == '\n') {
-					/* tagger to cp is a line
-					 * that has ident and time.
-					 */
-					const char *sp = tagger;
-					char *ep;
-					unsigned long date;
-					long tz;
-					while (sp < cp && *sp != '>')
-						sp++;
-					if (sp == cp) {
-						/* give up */
-						write_or_die(1, tagger,
-							     cp - tagger);
-						break;
-					}
-					while (sp < cp &&
-					       !('0' <= *sp && *sp <= '9'))
-						sp++;
-					write_or_die(1, tagger, sp - tagger);
-					date = strtoul(sp, &ep, 10);
-					tz = strtol(ep, NULL, 10);
-					sp = show_date(date, tz, 0);
-					write_or_die(1, sp, strlen(sp));
-					xwrite(1, "\n", 1);
-					break;
-				}
-			}
-			break;
-		}
-		if (cp < endp && *cp == '\n')
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
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 {
 	unsigned char sha1[20];
@@ -133,10 +66,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		buf = read_sha1_file(sha1, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
-		if (type == OBJ_TAG) {
-			pprint_tag(sha1, buf, size);
-			return 0;
-		}
 
 		/* otherwise just spit out the data */
 		break;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d8b7f2f..da4ffbb 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -135,14 +135,11 @@ tag_size=$(strlen "$tag_content")
 tag_content="$tag_header_without_timestamp 0000000000 +0000
 
 $tag_description"
-tag_pretty_content="$tag_header_without_timestamp Thu Jan 1 00:00:00 1970 +0000
-
-$tag_description"
 
 tag_sha1=$(echo_without_newline "$tag_content" | git mktag)
 tag_size=$(strlen "$tag_content")
 
-run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_pretty_content" 1
+run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
 
 test_expect_success \
     "Reach a blob from a tag pointing to it" \
-- 
1.8.1.4.4.g265d2fa
