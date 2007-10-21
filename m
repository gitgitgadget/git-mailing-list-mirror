From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] Correct some sizeof(size_t) != sizeof(unsigned long)
 typing errors
Date: Sun, 21 Oct 2007 11:23:49 +0200
Message-ID: <471B1AA5.8070009@lsrfire.ath.cx>
References: <20071021052537.GB31927@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 11:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjX2e-0001rM-SY
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 11:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbXJUJYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 05:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbXJUJYF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 05:24:05 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:38712
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272AbXJUJYD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2007 05:24:03 -0400
Received: from [10.0.1.201] (p57B7FC02.dip.t-dialin.net [87.183.252.2])
	by neapel230.server4you.de (Postfix) with ESMTP id 1932E873BA;
	Sun, 21 Oct 2007 11:24:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071021052537.GB31927@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61892>

Fix size_t vs. unsigned long pointer mismatch warnings introduced
with the addition of strbuf_detach().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Shawn O. Pearce schrieb:
> On at least one system I've used recently sizeof(size_t) == 4
> and sizeof(unsigned long) == 8.  Trying to pass a pointer to an 8
> byte value into strbuf_detach() causes problems as the function is
> expecting an address for a 4 byte result location.  Writing only 4
> bytes here will leave the other 4 bytes unitialized and may cause
> problems when the caller evalutes the result.
> 
> I am introducing strbuf_detach_ul() as a variant that takes its
> size as an unsigned long rather than as a size_t.  This approach is
> shorter than fixing all of the callers to use their own temporary
> size_t value for the call.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  builtin-apply.c   |    2 +-
>  builtin-archive.c |    2 +-
>  diff.c            |    4 ++--
>  entry.c           |    2 +-
>  strbuf.h          |    8 +++++++-
>  test-delta.c      |    3 ++-
>  6 files changed, 14 insertions(+), 7 deletions(-)

I have a feeling this is going in then wrong direction.  Shouldn't
we rather use size_t everywhere?  malloc() takes a size_t, and it's
the basis of strbuf and also of the file content functions.

The following patch is shorter, though it adds one more line than
your's.  The result is slightly uglier, but it's a good reminder to
use size_t in more places.

That said, I realize that converting read_sha1_file() et al. would
be quite painful.  Maybe too painful?

 builtin-apply.c   |    2 +-
 builtin-archive.c |    4 +++-
 diff.c            |    8 ++++++--
 entry.c           |    4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 047a60d..541a6f4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -152,7 +152,7 @@ struct patch {
 	unsigned int is_rename:1;
 	struct fragment *fragments;
 	char *result;
-	unsigned long resultsize;
+	size_t resultsize;
 	char old_sha1_prefix[41];
 	char new_sha1_prefix[41];
 	struct patch *next;
diff --git a/builtin-archive.c b/builtin-archive.c
index 04385de..6f29c2f 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -148,12 +148,14 @@ void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
 	buffer = read_sha1_file(sha1, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf;
+		size_t size = 0;
 
 		strbuf_init(&buf, 0);
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
 		convert_to_working_tree(path, buf.buf, buf.len, &buf);
 		convert_to_archive(path, buf.buf, buf.len, &buf, commit);
-		buffer = strbuf_detach(&buf, sizep);
+		buffer = strbuf_detach(&buf, &size);
+		*sizep = size;
 	}
 
 	return buffer;
diff --git a/diff.c b/diff.c
index 0bd7e24..df82ed6 100644
--- a/diff.c
+++ b/diff.c
@@ -1512,6 +1512,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 static int populate_from_stdin(struct diff_filespec *s)
 {
 	struct strbuf buf;
+	size_t size = 0;
 
 	strbuf_init(&buf, 0);
 	if (strbuf_read(&buf, 0, 0) < 0)
@@ -1519,7 +1520,8 @@ static int populate_from_stdin(struct diff_filespec *s)
 				     strerror(errno));
 
 	s->should_munmap = 0;
-	s->data = strbuf_detach(&buf, &s->size);
+	s->data = strbuf_detach(&buf, &size);
+	s->size = size;
 	s->should_free = 1;
 	return 0;
 }
@@ -1609,9 +1611,11 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		 */
 		strbuf_init(&buf, 0);
 		if (convert_to_git(s->path, s->data, s->size, &buf)) {
+			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
-			s->data = strbuf_detach(&buf, &s->size);
+			s->data = strbuf_detach(&buf, &size);
+			s->size = size;
 			s->should_free = 1;
 		}
 	}
diff --git a/entry.c b/entry.c
index 98f5f6d..cfadc6a 100644
--- a/entry.c
+++ b/entry.c
@@ -119,8 +119,10 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		 */
 		strbuf_init(&buf, 0);
 		if (convert_to_working_tree(ce->name, new, size, &buf)) {
+			size_t newsize = 0;
 			free(new);
-			new = strbuf_detach(&buf, &size);
+			new = strbuf_detach(&buf, &newsize);
+			size = newsize;
 		}
 
 		if (to_tempfile) {
