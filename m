From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 2/2] strbuf: use strbuf_addchars() for adding a char multiple
 times
Date: Sun, 07 Sep 2014 09:06:42 +0200
Message-ID: <540C0402.3060103@web.de>
References: <540C0344.9060002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 09:07:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQWZ6-0002Jy-F4
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 09:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbaIGHHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 03:07:05 -0400
Received: from mout.web.de ([212.227.15.14]:62623 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaIGHHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 03:07:04 -0400
Received: from [192.168.178.27] ([79.250.174.198]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M8hdL-1YMlyj2NQx-00wDxK; Sun, 07 Sep 2014 09:06:58
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <540C0344.9060002@web.de>
X-Provags-ID: V03:K0:I0lHNDGn7rVvur+2Kro7KOXXvAXijTKmUtoT3XC9WCB1w9zdou3
 A4yxRw4FC4OQyuzWR/RfUH00v48y+BVLrRBxu+vcYc4Pe8XVuzuX0fS3k5xj8XtA6bp1HwX
 xZy01mQcbSABt3S7j85ku2xo/Y7YetdqVrOsbK3zNDM8/ftE63lbxAa8OdvjlooklmFa3jD
 2IOMxy9/QIuUdeS2V31OQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256613>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 graph.c           |  5 ++---
 merge-recursive.c |  4 +---
 pretty.c          | 10 +++-------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/graph.c b/graph.c
index 6404331..dfb99f6 100644
--- a/graph.c
+++ b/graph.c
@@ -1145,7 +1145,7 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 {
-	int i, j;
+	int i;
 
 	if (graph->state != GRAPH_COMMIT) {
 		graph_next_line(graph, sb);
@@ -1169,8 +1169,7 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 				strbuf_addch(sb, ' ');
 			else {
 				int num_spaces = ((graph->num_parents - 2) * 2);
-				for (j = 0; j < num_spaces; j++)
-					strbuf_addch(sb, ' ');
+				strbuf_addchars(sb, ' ', num_spaces);
 			}
 		} else {
 			strbuf_write_column(sb, col, '|');
diff --git a/merge-recursive.c b/merge-recursive.c
index 1d332b8..dd657e6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -163,9 +163,7 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 	if (!show(o, v))
 		return;
 
-	strbuf_grow(&o->obuf, o->call_depth * 2 + 2);
-	memset(o->obuf.buf + o->obuf.len, ' ', o->call_depth * 2);
-	strbuf_setlen(&o->obuf, o->obuf.len + o->call_depth * 2);
+	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&o->obuf, fmt, ap);
diff --git a/pretty.c b/pretty.c
index 44b9f64..5971415 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1395,9 +1395,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		 * convert it back to chars
 		 */
 		padding = padding - len + local_sb.len;
-		strbuf_grow(sb, padding);
-		strbuf_setlen(sb, sb_len + padding);
-		memset(sb->buf + sb_len, ' ', sb->len - sb_len);
+		strbuf_addchars(sb, ' ', padding);
 		memcpy(sb->buf + sb_len + offset, local_sb.buf,
 		       local_sb.len);
 	}
@@ -1672,10 +1670,8 @@ void pp_remainder(struct pretty_print_context *pp,
 		first = 0;
 
 		strbuf_grow(sb, linelen + indent + 20);
-		if (indent) {
-			memset(sb->buf + sb->len, ' ', indent);
-			strbuf_setlen(sb, sb->len + indent);
-		}
+		if (indent)
+			strbuf_addchars(sb, ' ', indent);
 		strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
 	}
-- 
2.1.0
