From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] merge-recursive: move the global obuf to struct merge_options
Date: Wed,  3 Sep 2008 02:39:09 +0200
Message-ID: <1220402349-7181-1-git-send-email-vmiklos@frugalware.org>
References: <7vk5dui34q.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KagQ5-0005Az-Cr
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYICAjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYICAjO
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:39:14 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38284 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYICAjN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:39:13 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id B49FB1DDC5B;
	Wed,  3 Sep 2008 02:39:11 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B6F6084CA; Wed,  3 Sep 2008 02:39:09 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <7vk5dui34q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94751>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Sep 02, 2008 at 03:39:33PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Shouldn't strbuf obuf be part of the merge_options structure that
> describes the current call status?

It can be done, see below. :-)

BTW, there are 3 leftovers: make_virtual_commit()'s virtual_id and the
global current_file_set/current_directory_set. I guess all of them could
be moved to merge_options as well. (I don't have more time today to do
so, but I can do it tomorrow, unless you see some fundamental problem
with it.)

 merge-recursive.c |   37 ++++++++++++++++++-------------------
 merge-recursive.h |    1 +
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c426589..d4f12d0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -80,18 +80,16 @@ struct stage_data
 static struct string_list current_file_set = {NULL, 0, 0, 1};
 static struct string_list current_directory_set = {NULL, 0, 0, 1};
 
-static struct strbuf obuf = STRBUF_INIT;
-
 static int show(struct merge_options *o, int v)
 {
 	return (!o->call_depth && o->verbosity >= v) || o->verbosity >= 5;
 }
 
-static void flush_output(void)
+static void flush_output(struct merge_options *o)
 {
-	if (obuf.len) {
-		fputs(obuf.buf, stdout);
-		strbuf_reset(&obuf);
+	if (o->obuf.len) {
+		fputs(o->obuf.buf, stdout);
+		strbuf_reset(&o->obuf);
 	}
 }
 
@@ -103,35 +101,35 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 	if (!show(o, v))
 		return;
 
-	strbuf_grow(&obuf, o->call_depth * 2 + 2);
-	memset(obuf.buf + obuf.len, ' ', o->call_depth * 2);
-	strbuf_setlen(&obuf, obuf.len + o->call_depth * 2);
+	strbuf_grow(&o->obuf, o->call_depth * 2 + 2);
+	memset(o->obuf.buf + o->obuf.len, ' ', o->call_depth * 2);
+	strbuf_setlen(&o->obuf, o->obuf.len + o->call_depth * 2);
 
 	va_start(ap, fmt);
-	len = vsnprintf(obuf.buf + obuf.len, strbuf_avail(&obuf), fmt, ap);
+	len = vsnprintf(o->obuf.buf + o->obuf.len, strbuf_avail(&o->obuf), fmt, ap);
 	va_end(ap);
 
 	if (len < 0)
 		len = 0;
-	if (len >= strbuf_avail(&obuf)) {
-		strbuf_grow(&obuf, len + 2);
+	if (len >= strbuf_avail(&o->obuf)) {
+		strbuf_grow(&o->obuf, len + 2);
 		va_start(ap, fmt);
-		len = vsnprintf(obuf.buf + obuf.len, strbuf_avail(&obuf), fmt, ap);
+		len = vsnprintf(o->obuf.buf + o->obuf.len, strbuf_avail(&o->obuf), fmt, ap);
 		va_end(ap);
-		if (len >= strbuf_avail(&obuf)) {
+		if (len >= strbuf_avail(&o->obuf)) {
 			die("this should not happen, your snprintf is broken");
 		}
 	}
-	strbuf_setlen(&obuf, obuf.len + len);
-	strbuf_add(&obuf, "\n", 1);
+	strbuf_setlen(&o->obuf, o->obuf.len + len);
+	strbuf_add(&o->obuf, "\n", 1);
 	if (!o->buffer_output)
-		flush_output();
+		flush_output(o);
 }
 
 static void output_commit_title(struct merge_options *o, struct commit *commit)
 {
 	int i;
-	flush_output();
+	flush_output(o);
 	for (i = o->call_depth; i--;)
 		fputs("  ", stdout);
 	if (commit->util)
@@ -1289,7 +1287,7 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output();
+	flush_output(o);
 	return clean;
 }
 
@@ -1375,4 +1373,5 @@ void init_merge_options(struct merge_options *o)
 			strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
 	if (o->verbosity >= 5)
 		o->buffer_output = 0;
+	strbuf_init(&o->obuf, 0);
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index 4f55374..be84d9b 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -10,6 +10,7 @@ struct merge_options {
 	int diff_rename_limit;
 	int merge_rename_limit;
 	int call_depth;
+	struct strbuf obuf;
 };
 
 /* merge_trees() but with recursive ancestor consolidation */
-- 
1.6.0.1
