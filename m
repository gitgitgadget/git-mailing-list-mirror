From: Jeff King <peff@peff.net>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 2 Apr 2013 13:15:57 -0400
Message-ID: <20130402171557.GA24698@sigill.intra.peff.net>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
 <7vtxnogbft.fsf@alter.siamese.dyndns.org>
 <20130402163034.GA19252@sigill.intra.peff.net>
 <7vhajog9xp.fsf@alter.siamese.dyndns.org>
 <20130402165128.GA19712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Larres <jan@majutsushi.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4oy-00086F-8f
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761938Ab3DBRQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:16:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52337 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761172Ab3DBRQB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:16:01 -0400
Received: (qmail 11462 invoked by uid 107); 2 Apr 2013 17:17:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 13:17:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 13:15:57 -0400
Content-Disposition: inline
In-Reply-To: <20130402165128.GA19712@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219806>

On Tue, Apr 02, 2013 at 12:51:28PM -0400, Jeff King wrote:

> But let's take a step back. I think Jan is trying to do a very
> reasonable thing: come up with the same set of paths that git-archive
> would. What's the best way to solve that? Recursive application of
> attributes is one way, but is there another way we could help with
> solving that?
> 
> Using:
> 
>   git ls-tree --name-only -zrt HEAD |
>   git check-attr --stdin -z export-ignore
> 
> means we can find out that "foo/" is ignored. But he would have to
> manually post-process the output to see that "foo/bar" is below "foo".
> Not impossible, but I just wonder if git can be more helpful in figuring
> this out.

One way to solve the problem is something like the patch below, which
allows "git archive --format=lstree" to give an lstree-like listing, but
with export-ignore attributes applied.

It feels weirdly specific, though, like there should be a more general
solution.

---
 Makefile         |  1 +
 archive-lstree.c | 43 +++++++++++++++++++++++++++++++++++
 archive.c        |  1 +
 archive.h        |  1 +
 quote.c          |  4 ++--
 quote.h          |  1 +
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e9749ca..5e63d72 100644
--- a/Makefile
+++ b/Makefile
@@ -772,6 +772,7 @@ LIB_OBJS += archive.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
 LIB_OBJS += archive.o
+LIB_OBJS += archive-lstree.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += argv-array.o
diff --git a/archive-lstree.c b/archive-lstree.c
new file mode 100644
index 0000000..5ca1bbc
--- /dev/null
+++ b/archive-lstree.c
@@ -0,0 +1,43 @@
+#include "cache.h"
+#include "archive.h"
+#include "quote.h"
+#include "commit.h"
+#include "blob.h"
+
+static int write_lstree_entry(struct archiver_args *args,
+			      const unsigned char *sha1,
+			      const char *path, size_t pathlen,
+			      unsigned int mode)
+{
+	const char *type;
+
+	if (S_ISDIR(mode))
+		return 0;
+	else if (S_ISGITLINK(mode))
+		type = commit_type;
+	else
+		type = blob_type;
+
+	printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
+	quote_c_style_counted(path, pathlen, NULL, stdout, 0);
+	printf("\n");
+
+	return 0;
+}
+
+static int write_lstree_archive(const struct archiver *ar,
+				struct archiver_args *args)
+{
+	return write_archive_entries(args, write_lstree_entry);
+}
+
+static struct archiver lstree_archiver = {
+	"lstree",
+	write_lstree_archive,
+	ARCHIVER_REMOTE
+};
+
+void init_lstree_archiver(void)
+{
+	register_archiver(&lstree_archiver);
+}
diff --git a/archive.c b/archive.c
index 3f00da6..4966db7 100644
--- a/archive.c
+++ b/archive.c
@@ -420,6 +420,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	git_config(git_default_config, NULL);
 	init_tar_archiver();
 	init_zip_archiver();
+	init_lstree_archiver();
 
 	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
 	if (nongit) {
diff --git a/archive.h b/archive.h
index 895afcd..1428fc4 100644
--- a/archive.h
+++ b/archive.h
@@ -27,6 +27,7 @@ extern void init_zip_archiver(void);
 
 extern void init_tar_archiver(void);
 extern void init_zip_archiver(void);
+extern void init_lstree_archiver(void);
 
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					const unsigned char *sha1,
diff --git a/quote.c b/quote.c
index 911229f..da6b7e4 100644
--- a/quote.c
+++ b/quote.c
@@ -206,8 +206,8 @@ static size_t next_quote_pos(const char *s, ssize_t maxlen)
  *     of name, enclosed with double quotes if asked and needed only.
  *     Return value is the same as in (1).
  */
-static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
-                                    struct strbuf *sb, FILE *fp, int no_dq)
+size_t quote_c_style_counted(const char *name, ssize_t maxlen,
+			     struct strbuf *sb, FILE *fp, int no_dq)
 {
 #undef EMIT
 #define EMIT(c)                                 \
diff --git a/quote.h b/quote.h
index 133155a..f2b8acb 100644
--- a/quote.h
+++ b/quote.h
@@ -55,6 +55,7 @@ extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq
 
 extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
+extern size_t quote_c_style_counted(const char *name, ssize_t len, struct strbuf *, FILE *, int no_dq);
 extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
 
 extern void write_name_quoted(const char *name, FILE *, int terminator);
