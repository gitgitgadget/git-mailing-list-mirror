From: Jeff King <peff@peff.net>
Subject: [PATCH v2 10/10] unique_path: fix unlikely heap overflow
Date: Thu, 19 Jun 2014 17:30:26 -0400
Message-ID: <20140619213026.GJ28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxjui-0004mO-4w
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965559AbaFSVa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:30:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:47810 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964833AbaFSVa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:30:28 -0400
Received: (qmail 17320 invoked by uid 102); 19 Jun 2014 21:30:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:30:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:30:26 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252193>

When merge-recursive creates a unique filename, it uses a
template like:

  path~branch_%d

where the final "_%d" is filled by an incrementing counter
until we find a unique name. We allocate 8 characters for
the counter, but there is no logic to limit the size of the
integer.

Of course, this is extremely unlikely, as you would need a
hundred million collisions to trigger the problem.  Even if
an attacker constructed a specialized repo, it is unlikely
that the victim would have the patience to run the merge.

However, we can make it trivially correct (and hopefully
more readable) by using a strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-recursive.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 532a1da..398a734 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -601,25 +601,36 @@ static int remove_file(struct merge_options *o, int clean,
 	return 0;
 }
 
+/* add a string to a strbuf, but converting "/" to "_" */
+static void add_flattened_path(struct strbuf *out, const char *s)
+{
+	size_t i = out->len;
+	strbuf_addstr(out, s);
+	for (; i < out->len; i++)
+		if (out->buf[i] == '/')
+			out->buf[i] = '_';
+}
+
 static char *unique_path(struct merge_options *o, const char *path, const char *branch)
 {
-	char *newpath = xmalloc(strlen(path) + 1 + strlen(branch) + 8 + 1);
+	struct strbuf newpath = STRBUF_INIT;
 	int suffix = 0;
 	struct stat st;
-	char *p = newpath + strlen(path);
-	strcpy(newpath, path);
-	*(p++) = '~';
-	strcpy(p, branch);
-	for (; *p; ++p)
-		if ('/' == *p)
-			*p = '_';
-	while (string_list_has_string(&o->current_file_set, newpath) ||
-	       string_list_has_string(&o->current_directory_set, newpath) ||
-	       lstat(newpath, &st) == 0)
-		sprintf(p, "_%d", suffix++);
-
-	string_list_insert(&o->current_file_set, newpath);
-	return newpath;
+	size_t base_len;
+
+	strbuf_addf(&newpath, "%s~", path);
+	add_flattened_path(&newpath, branch);
+
+	base_len = newpath.len;
+	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
+	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
+	       lstat(newpath.buf, &st) == 0) {
+		strbuf_setlen(&newpath, base_len);
+		strbuf_addf(&newpath, "_%d", suffix++);
+	}
+
+	string_list_insert(&o->current_file_set, newpath.buf);
+	return strbuf_detach(&newpath, NULL);
 }
 
 static int dir_in_way(const char *path, int check_working_copy)
-- 
2.0.0.566.gfe3e6b2
