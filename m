From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/4] builtin-mailinfo,builtin-mailsplit: use strbufs
Date: Tue,  4 Aug 2009 22:31:57 -0500
Message-ID: <r3l_p2g-BpVHWKE-kMWIR9UKBn9dqjBL2asOE11gruEtEyCyQOOh37zkh5F2bJkihtkN8WUp4d0@cipher.nrlssc.navy.mil>
References: <7vmy6fdxst.fsf@alter.siamese.dyndns.org> <r3l_p2g-BpVHWKE-kMWIRzBGUCnzo9_l7hOHzYLG_4X6oEjXrJ4rJdB10yXPT2jmJJ7ppBmr-x8@cipher.nrlssc.navy.mil> <r3l_p2g-BpVHWKE-kMWIRydJaW0FHLKBpE497REXzOgqPjLUFjPkJ-YKp1tkrIs3CwcppURiH8o@cipher.nrlssc.navy.mil>
Cc: nanako3@lavabit.com, raa.lkml@gmail.com, hpa@zytor.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 05:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXFe-0001ap-7Y
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 05:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933860AbZHEDc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 23:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933444AbZHEDcz
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 23:32:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59683 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933457AbZHEDcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 23:32:53 -0400
Received: by mail.nrlssc.navy.mil id n753WmmB015232; Tue, 4 Aug 2009 22:32:48 -0500
In-Reply-To: <r3l_p2g-BpVHWKE-kMWIRydJaW0FHLKBpE497REXzOgqPjLUFjPkJ-YKp1tkrIs3CwcppURiH8o@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Aug 2009 03:32:48.0335 (UTC) FILETIME=[67668DF0:01CA157D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124843>

From: Brandon Casey <drafnel@gmail.com>

There should be no functional change.  Just the necessary changes and
simplifications associated with calling strbuf_getwholeline() rather
than an internal function or fgets.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin-mailinfo.c  |    8 +-------
 builtin-mailsplit.c |   20 ++++++++------------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 92637ac..b0b5d8f 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -765,7 +765,6 @@ static void handle_filter(struct strbuf *line)
 
 static void handle_body(void)
 {
-	int len = 0;
 	struct strbuf prev = STRBUF_INIT;
 
 	/* Skip up to the first boundary */
@@ -775,8 +774,6 @@ static void handle_body(void)
 	}
 
 	do {
-		strbuf_setlen(&line, line.len + len);
-
 		/* process any boundary lines */
 		if (*content_top && is_multipart_boundary(&line)) {
 			/* flush any leftover */
@@ -832,10 +829,7 @@ static void handle_body(void)
 			handle_filter(&line);
 		}
 
-		strbuf_reset(&line);
-		if (strbuf_avail(&line) < 100)
-			strbuf_grow(&line, 100);
-	} while ((len = read_line_with_nul(line.buf, strbuf_avail(&line), fin)));
+	} while (!strbuf_getwholeline(&line, fin, '\n'));
 
 handle_body_out:
 	strbuf_release(&prev);
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index ad5f6b5..c2ec6ea 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "strbuf.h"
 
 static const char git_mailsplit_usage[] =
 "git mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> [<mbox>|<Maildir>...]";
@@ -42,8 +43,7 @@ static int is_from_line(const char *line, int len)
 	return 1;
 }
 
-/* Could be as small as 64, enough to hold a Unix "From " line. */
-static char buf[4096];
+static struct strbuf buf = STRBUF_INIT;
 
 /* We cannot use fgets() because our lines can contain NULs */
 int read_line_with_nul(char *buf, int size, FILE *in)
@@ -71,10 +71,9 @@ int read_line_with_nul(char *buf, int size, FILE *in)
 static int split_one(FILE *mbox, const char *name, int allow_bare)
 {
 	FILE *output = NULL;
-	int len = strlen(buf);
 	int fd;
 	int status = 0;
-	int is_bare = !is_from_line(buf, len);
+	int is_bare = !is_from_line(buf.buf, buf.len);
 
 	if (is_bare && !allow_bare)
 		goto corrupt;
@@ -88,20 +87,17 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	 * "From " and having something that looks like a date format.
 	 */
 	for (;;) {
-		int is_partial = len && buf[len-1] != '\n';
-
-		if (fwrite(buf, 1, len, output) != len)
+		if (fwrite(buf.buf, 1, buf.len, output) != buf.len)
 			die_errno("cannot write output");
 
-		len = read_line_with_nul(buf, sizeof(buf), mbox);
-		if (len == 0) {
+		if (strbuf_getwholeline(&buf, mbox, '\n')) {
 			if (feof(mbox)) {
 				status = 1;
 				break;
 			}
 			die_errno("cannot read mbox");
 		}
-		if (!is_partial && !is_bare && is_from_line(buf, len))
+		if (!is_bare && is_from_line(buf.buf, buf.len))
 			break; /* done with one message */
 	}
 	fclose(output);
@@ -166,7 +162,7 @@ static int split_maildir(const char *maildir, const char *dir,
 			goto out;
 		}
 
-		if (fgets(buf, sizeof(buf), f) == NULL) {
+		if (strbuf_getwholeline(&buf, f, '\n')) {
 			error("cannot read mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
@@ -203,7 +199,7 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	} while (isspace(peek));
 	ungetc(peek, f);
 
-	if (fgets(buf, sizeof(buf), f) == NULL) {
+	if (strbuf_getwholeline(&buf, f, '\n')) {
 		/* empty stdin is OK */
 		if (f != stdin) {
 			error("cannot read mbox %s", file);
-- 
1.6.4
