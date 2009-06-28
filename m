From: Jeff King <peff@peff.net>
Subject: Re: whitespace ignoring during diff -M
Date: Sun, 28 Jun 2009 16:02:55 -0400
Message-ID: <20090628200254.GA8828@sigio.peff.net>
References: <4A22E882.8020500@impulze.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Mierswa <impulze@impulze.org>
X-From: git-owner@vger.kernel.org Sun Jun 28 22:01:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML0Yz-0007JO-LP
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 22:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbZF1UBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 16:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZF1UBD
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 16:01:03 -0400
Received: from peff.net ([208.65.91.99]:39755 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbZF1UBC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 16:01:02 -0400
Received: (qmail 8838 invoked by uid 1000); 28 Jun 2009 20:02:55 -0000
Content-Disposition: inline
In-Reply-To: <4A22E882.8020500@impulze.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122420>

[this is a bit of an old message, but I am way behind on git mail,
 and nobody else seems to have responded, so...]

On Sun, May 31, 2009 at 10:28:50PM +0200, Daniel Mierswa wrote:

> I was told to try it here after visiting #git/Freenode
> I want git to think that the diff of two branches where filenames and
> whitespace amount differ are the same.
> The following is a snippet from my terminal with output, is there a
> chance to make git think that those are equal?

Rename detection in git does not respect the "-w" option at all. It
hashes each line of a text file, and then compares the hashes to see how
"similar" the files are.

It already makes some effort to ignore the CR in a CRLF sequence when
calculating the hash. So just running "unix2dos" (or vice versa) on a
file should still allow it to find renames.

This could probably be extended fairly trivially to ignore arbitrary
whitespace when generating the hash (I'm not sure if the feature should
be triggered by "-w" or not; it makes sense to me, but I'm not sure if
there are cases where people would want diff generation to have
different rules than rename detection. We maybe would even want to
ignore whitespace in diff generation _always_, as we always do already
with CRLF. Somebody would need to check the results of the two
approaches against a number of cases).

If you are interested, the relevant code is in hash_chars in
diffcore-delta.c. A trivial implementation would probably look something
like the patch below. I tested it with:

  git init
  cp /usr/share/dict/words words && git add words && git commit -m one
  sed 's/^/  /' <words >munged
  git add munged && git rm words
  git diff --cached --summary

which curious reports 82% similarity. So maybe there is more
investigation to be done. Anyway, patch below.

---

diff --git a/diffcore-delta.c b/diffcore-delta.c
index e670f85..63704da 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -145,6 +145,8 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
 		/* Ignore CR in CRLF sequence if text */
 		if (is_text && c == '\r' && sz && *buf == '\n')
 			continue;
+		if (is_text && (c == ' ' || c == '\t'))
+			continue;
 
 		accum1 = (accum1 << 7) ^ (accum2 >> 25);
 		accum2 = (accum2 << 7) ^ (old_1 >> 25);
