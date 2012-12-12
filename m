From: Jeff King <peff@peff.net>
Subject: [PATCH 3/2] mailmap: clean up read_mailmap error handling
Date: Wed, 12 Dec 2012 06:18:02 -0500
Message-ID: <20121212111802.GA19625@sigill.intra.peff.net>
References: <20121212105822.GA15842@sigill.intra.peff.net>
 <20121212110404.GB19653@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 12:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TikKY-0007IK-GA
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab2LLLSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 06:18:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42774 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270Ab2LLLSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 06:18:07 -0500
Received: (qmail 22766 invoked by uid 107); 12 Dec 2012 11:19:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 06:19:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 06:18:02 -0500
Content-Disposition: inline
In-Reply-To: <20121212110404.GB19653@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211339>

On Wed, Dec 12, 2012 at 06:04:04AM -0500, Jeff King wrote:

> The error-return convention from read_mailmap is really wonky, but I
> didn't change it here. It will return "1" for error, and will do so only
> if no mailmap sources could be read (including if they simply don't
> exist). But it's perfectly OK not to have a mailmap at all.  However,
> nobody actually seems to check the return code, so nobody has cared.
> 
> A more sane convention would probably be:
> 
>   1. If ENOENT (or no such blob), silently return success.
> 
>   2. Otherwise, return -1 and print a message to stderr indicating that
>      there is a mailmap file, but it is broken or otherwise could not be
>      opened.

Maybe like this:

-- >8 --
Subject: [PATCH] mailmap: clean up read_mailmap error handling

The error handling for the read_mailmap function is odd. It
returns 1 on error, rather than -1. And it treats a
non-existent mailmap as an error, even though there is no
reason that one needs to exist. Unless some other mailmap
source loads successfully, in which case the original error
is completely masked.

This does not cause any bugs, however, because no caller
bothers to check the return value, anyway. Let's make this a
little more robust to real errors and less surprising for
future callers that do check the error code:

  1. Return -1 on errors.

  2. Treat a missing entry (e.g., no mailmap.file given),
     ENOENT, or a non-existent blob (for mailmap.blob) as
     "no error".

  3. Complain loudly when a real error (e.g., a transient
     I/O error, no permission to open the mailmap file,
     missing or corrupted blob object, etc) occurs.

Signed-off-by: Jeff King <peff@peff.net>
---
 mailmap.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 2f9c691..5ffe48a 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -168,10 +168,19 @@ static int read_mailmap_file(struct string_list *map, const char *filename,
 			     char **repo_abbrev)
 {
 	char buffer[1024];
-	FILE *f = (filename == NULL ? NULL : fopen(filename, "r"));
+	FILE *f;
+
+	if (!filename)
+		return 0;
+
+	f = fopen(filename, "r");
+	if (!f) {
+		if (errno == ENOENT)
+			return 0;
+		return error("unable to open mailmap at %s: %s",
+			     filename, strerror(errno));
+	}
 
-	if (f == NULL)
-		return 1;
 	while (fgets(buffer, sizeof(buffer), f) != NULL)
 		read_mailmap_line(map, buffer, repo_abbrev);
 	fclose(f);
@@ -205,15 +214,15 @@ static int read_mailmap_blob(struct string_list *map,
 	enum object_type type;
 
 	if (!name)
-		return 1;
+		return 0;
 	if (get_sha1(name, sha1) < 0)
-		return 1;
+		return 0;
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		return 1;
+		return error("unable to read mailmap object at %s", name);
 	if (type != OBJ_BLOB)
-		return 1;
+		return error("mailmap is not a blob: %s", name);
 
 	read_mailmap_buf(map, buf, size, repo_abbrev);
 
@@ -223,11 +232,12 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 
 int read_mailmap(struct string_list *map, char **repo_abbrev)
 {
+	int err = 0;
 	map->strdup_strings = 1;
-	/* each failure returns 1, so >2 means all calls failed */
-	return read_mailmap_file(map, ".mailmap", repo_abbrev) +
-	       read_mailmap_blob(map, git_mailmap_blob, repo_abbrev) +
-	       read_mailmap_file(map, git_mailmap_file, repo_abbrev) > 2;
+	err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
+	err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
+	err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);
+	return err;
 }
 
 void clear_mailmap(struct string_list *map)
-- 
1.8.0.2.4.g59402aa
