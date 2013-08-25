From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: handle mailmap blobs without trailing newlines
Date: Sun, 25 Aug 2013 05:11:00 -0400
Message-ID: <20130825091100.GB6089@sigill.intra.peff.net>
References: <20130825084549.GA5912@sigill.intra.peff.net>
 <20130825085500.GA6089@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 11:11:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDWLk-00034Y-Ri
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 11:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab3HYJLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 05:11:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103Ab3HYJLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 05:11:03 -0400
Received: (qmail 25059 invoked by uid 102); 25 Aug 2013 09:11:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 25 Aug 2013 04:11:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Aug 2013 05:11:00 -0400
Content-Disposition: inline
In-Reply-To: <20130825085500.GA6089@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232941>

On Sun, Aug 25, 2013 at 04:55:00AM -0400, Jeff King wrote:

> On Sun, Aug 25, 2013 at 04:45:50AM -0400, Jeff King wrote:
> 
> > This is the minimal fix. Another option would be to switch
> > read_mailmap_buf to read_mailmap_string, and I think we could even get
> > away with avoiding the extra allocation/copy in the loop (because
> > read_mailmap_line seems to cope with newline-or-EOS just fine). But it
> > may be better to save that for 'master'.
> 
> Hmm, actually, this isn't quite true. read_mailmap_line does handle the
> optional trailing newline properly, but the underlying parsing routines
> really do want to see a NUL at the end of each line (because they came
> from code that just calls fgets). So we really do want to tie off each
> line. But given that our only caller is handing us blob contents which
> get immediately freed, we could still do that without an extra
> allocation if:
> 
>   1. We make it clear that the input must be NUL-terminated (i.e., by
>      renaming the function and dropping the len parameter).
> 
>   2. We drop the "const" from the buf parameter so that we can simply
>      terminate each line as we go.
> 
> I'll see what the patch looks like.

I think the end result is actually more readable and easier to follow.
The only downside is that a true "I have a const buffer without NUL
termination" caller would have to make a copy of its buffer. But there
is no such caller currently (and I do not foresee adding one).

Here's the patch directly on top of my other one. I had originally
thought to put the first to 'maint' and then do the refactoring in
'master', but this really didn't end up being any more invasive than the
original fix. So maybe it is worth doing both on 'maint' (or squashing
them together, in which case the rationale in the commit messages need
combined).

-- >8 --
Subject: mailmap: avoid allocation when reading from blob

The read_mailmap_blob function reads the whole blob into a
buffer, then calls read_mailmap_buf to do the heavy lifting.
The latter function ends up making a NUL-terminated copy of
each line of the blob in order to call read_mailmap_line,
which was originally written to handle the line-at-a-time
input from fgets().

We can avoid the extra copy if we simply NUL-terminate each
line in place, and assume that the input buffer is itself
NUL-terminated. Neither of these is a problem, since our
only caller is read_mailmap_blob, which has a non-const
NUL-terminated buffer already.

Signed-off-by: Jeff King <peff@peff.net>
---
 mailmap.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index a635873..caa7c6b 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -187,26 +187,17 @@ static void read_mailmap_buf(struct string_list *map,
 	return 0;
 }
 
-static void read_mailmap_buf(struct string_list *map,
-			     const char *buf, unsigned long len,
-			     char **repo_abbrev)
+static void read_mailmap_string(struct string_list *map, char *buf,
+				char **repo_abbrev)
 {
-	while (len) {
-		const char *end = memchr(buf, '\n', len);
-		unsigned long linelen;
-		char *line;
-
-		if (end)
-			linelen = end - buf + 1;
-		else
-			linelen = len;
+	while (*buf) {
+		char *end = strchrnul(buf, '\n');
 
-		line = xmemdupz(buf, linelen);
-		read_mailmap_line(map, line, repo_abbrev);
+		if (*end)
+			*end++ = '\0';
 
-		free(line);
-		buf += linelen;
-		len -= linelen;
+		read_mailmap_line(map, buf, repo_abbrev);
+		buf = end;
 	}
 }
 
@@ -230,7 +221,7 @@ static int read_mailmap_blob(struct string_list *map,
 	if (type != OBJ_BLOB)
 		return error("mailmap is not a blob: %s", name);
 
-	read_mailmap_buf(map, buf, size, repo_abbrev);
+	read_mailmap_string(map, buf, repo_abbrev);
 
 	free(buf);
 	return 0;
-- 
1.8.4.2.g87d4a77
