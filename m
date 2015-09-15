From: Jeff King <peff@peff.net>
Subject: [PATCH 62/67] convert strncpy to memcpy
Date: Tue, 15 Sep 2015 12:13:41 -0400
Message-ID: <20150915161340.GJ29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsrc-00082l-PF
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbbIOQNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:13:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:59471 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754512AbbIOQNn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:13:43 -0400
Received: (qmail 14598 invoked by uid 102); 15 Sep 2015 16:13:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:13:43 -0500
Received: (qmail 7989 invoked by uid 107); 15 Sep 2015 16:13:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:13:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:13:41 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277967>

strncpy is known to be a confusing function because of its
termination semantics.  These calls are all correct, but it
takes some examination to see why. In particular, every one
of them expects to copy up to the length limit, and then
makes some arrangement for terminating the result.

We can just use memcpy, along with noting explicitly how the
result is terminated (if it is not already obvious). That
should make it more clear to a reader that we are doing the
right thing.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/help.c | 4 ++--
 fast-import.c  | 2 +-
 tag.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index e1650ab..1cd0c1e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -176,7 +176,7 @@ static void add_man_viewer(const char *name)
 	while (*p)
 		p = &((*p)->next);
 	*p = xcalloc(1, (sizeof(**p) + len + 1));
-	strncpy((*p)->name, name, len);
+	memcpy((*p)->name, name, len); /* NUL-terminated by xcalloc */
 }
 
 static int supported_man_viewer(const char *name, size_t len)
@@ -192,7 +192,7 @@ static void do_add_man_viewer_info(const char *name,
 {
 	struct man_viewer_info_list *new = xcalloc(1, sizeof(*new) + len + 1);
 
-	strncpy(new->name, name, len);
+	memcpy(new->name, name, len); /* NUL-terminated by xcalloc */
 	new->info = xstrdup(value);
 	new->next = man_viewer_info_list;
 	man_viewer_info_list = new;
diff --git a/fast-import.c b/fast-import.c
index cf6d8bc..4d01efc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -703,7 +703,7 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
 
 	c = pool_alloc(sizeof(struct atom_str) + len + 1);
 	c->str_len = len;
-	strncpy(c->str_dat, s, len);
+	memcpy(c->str_dat, s, len);
 	c->str_dat[len] = 0;
 	c->next_atom = atom_table[hc];
 	atom_table[hc] = c;
diff --git a/tag.c b/tag.c
index 5b0ac62..5b2a06d 100644
--- a/tag.c
+++ b/tag.c
@@ -82,7 +82,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	nl = memchr(bufptr, '\n', tail - bufptr);
 	if (!nl || sizeof(type) <= (nl - bufptr))
 		return -1;
-	strncpy(type, bufptr, nl - bufptr);
+	memcpy(type, bufptr, nl - bufptr);
 	type[nl - bufptr] = '\0';
 	bufptr = nl + 1;
 
-- 
2.6.0.rc2.408.ga2926b9
