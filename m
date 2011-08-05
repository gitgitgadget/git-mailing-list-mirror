From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-export: quote paths in output
Date: Fri, 5 Aug 2011 16:36:22 -0600
Message-ID: <20110805223622.GA5808@sigill.intra.peff.net>
References: <20110805105526.GA22480@sigill.intra.peff.net>
 <4E3BD006.6010005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Gregory <j.gregory@epigenesys.co.uk>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Aug 06 00:36:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpT0K-00015p-4x
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 00:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab1HEWg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 18:36:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34925
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab1HEWg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 18:36:26 -0400
Received: (qmail 32216 invoked by uid 107); 5 Aug 2011 22:37:00 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Aug 2011 18:37:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2011 16:36:22 -0600
Content-Disposition: inline
In-Reply-To: <4E3BD006.6010005@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178816>

On Fri, Aug 05, 2011 at 01:12:06PM +0200, Johannes Sixt wrote:

> Am 8/5/2011 12:55, schrieb Jeff King:
> > +test_expect_success 'fast-export quotes pathnames' '
> > +	git init crazy-paths &&
> > +	(cd crazy-paths &&
> > +	 >"$(printf "path with\\nnewline")" &&
> > +	 >"path with \"quote\"" &&
> > +	 >"path with \\backslash" &&
> > +	 >"path with space" &&
> 
> Please construct the tree object using git-update-index's --cacheinfo or
> --index-info rather than using actual files and git add so that the test
> can pass on filesystems that do not allow newlines, quotes, or
> backslashes(!) in filenames.

Sorry, I should have thought of that myself. Here's an updated version.

-- >8 --
Subject: [PATCH] fast-export: quote paths in output

Many pathnames in a fast-import stream need to be quoted. In
particular:

  1. Pathnames at the end of an "M" or "D" line need quoting
     if they contain a LF or start with double-quote.

  2. Pathnames on a "C" or "R" line need quoting as above,
     but also if they contain spaces.

For (1), we weren't quoting at all. For (2), we put
double-quotes around the paths to handle spaces, but ignored
the possibility that they would need further quoting.

This patch checks whether each pathname needs c-style
quoting, and uses it. This is slightly overkill for (1),
which doesn't actually need to quote many characters that
vanilla c-style quoting does. However, it shouldn't hurt, as
any implementation needs to be ready to handle quoted
strings anyway.

In addition to adding a test, we have to tweak a test which
blindly assumed that case (2) would always use
double-quotes, whether it needed to or not.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c  |   31 ++++++++++++++++++++++++-------
 t/t9350-fast-export.sh |   28 +++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index becef85..9836e6b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "parse-options.h"
+#include "quote.h"
 
 static const char *fast_export_usage[] = {
 	"git fast-export [rev-list-opts]",
@@ -179,6 +180,15 @@ static int depth_first(const void *a_, const void *b_)
 	return (a->status == 'R') - (b->status == 'R');
 }
 
+static void print_path(const char *path)
+{
+	int need_quote = quote_c_style(path, NULL, NULL, 0);
+	if (need_quote)
+		quote_c_style(path, NULL, stdout, 0);
+	else
+		printf("%s", path);
+}
+
 static void show_filemodify(struct diff_queue_struct *q,
 			    struct diff_options *options, void *data)
 {
@@ -196,13 +206,18 @@ static void show_filemodify(struct diff_queue_struct *q,
 
 		switch (q->queue[i]->status) {
 		case DIFF_STATUS_DELETED:
-			printf("D %s\n", spec->path);
+			printf("D ");
+			print_path(spec->path);
+			putchar('\n');
 			break;
 
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
-			printf("%c \"%s\" \"%s\"\n", q->queue[i]->status,
-			       ospec->path, spec->path);
+			printf("%c ", q->queue[i]->status);
+			print_path(ospec->path);
+			putchar(' ');
+			print_path(spec->path);
+			putchar('\n');
 
 			if (!hashcmp(ospec->sha1, spec->sha1) &&
 			    ospec->mode == spec->mode)
@@ -217,13 +232,15 @@ static void show_filemodify(struct diff_queue_struct *q,
 			 * output the SHA-1 verbatim.
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
-				printf("M %06o %s %s\n", spec->mode,
-				       sha1_to_hex(spec->sha1), spec->path);
+				printf("M %06o %s ", spec->mode,
+				       sha1_to_hex(spec->sha1));
 			else {
 				struct object *object = lookup_object(spec->sha1);
-				printf("M %06o :%d %s\n", spec->mode,
-				       get_object_mark(object), spec->path);
+				printf("M %06o :%d ", spec->mode,
+				       get_object_mark(object));
 			}
+			print_path(spec->path);
+			putchar('\n');
 			break;
 
 		default:
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index f823c05..950d0ff 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -228,7 +228,7 @@ test_expect_success 'fast-export -C -C | fast-import' '
 	mkdir new &&
 	git --git-dir=new/.git init &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
-	grep "^C \"file6\" \"file7\"\$" output &&
+	grep "^C file6 file7\$" output &&
 	cat output |
 	(cd new &&
 	 git fast-import &&
@@ -414,4 +414,30 @@ test_expect_success SYMLINKS 'directory becomes symlink'        '
 	(cd result && git show master:foo)
 '
 
+test_expect_success 'fast-export quotes pathnames' '
+	git init crazy-paths &&
+	(cd crazy-paths &&
+	 blob=`echo foo | git hash-object -w --stdin` &&
+	 git update-index --add \
+		--cacheinfo 100644 $blob "$(printf "path with\\nnewline")" \
+		--cacheinfo 100644 $blob "path with \"quote\"" \
+		--cacheinfo 100644 $blob "path with \\backslash" \
+		--cacheinfo 100644 $blob "path with space" &&
+	 git commit -m addition &&
+	 git ls-files -z -s | perl -0pe "s{\\t}{$&subdir/}" >index &&
+	 git read-tree --empty &&
+	 git update-index -z --index-info <index &&
+	 git commit -m rename &&
+	 git read-tree --empty &&
+	 git commit -m deletion &&
+	 git fast-export HEAD >export.out &&
+	 git rev-list HEAD >expect &&
+	 git init result &&
+	 cd result &&
+	 git fast-import <../export.out &&
+	 git rev-list HEAD >actual &&
+	 test_cmp ../expect actual
+	)
+'
+
 test_done
-- 
1.7.6.rc0.36.gd385b.dirty
