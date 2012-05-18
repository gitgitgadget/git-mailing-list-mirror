From: Jeff King <peff@peff.net>
Subject: [PATCH 03/13] fmt-merge-msg: don't use static buffer in record_person
Date: Fri, 18 May 2012 19:10:53 -0400
Message-ID: <20120518231053.GC30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:11:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWKp-0004fo-F3
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946766Ab2ERXLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:11:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48754
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946776Ab2ERXK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:10:56 -0400
Received: (qmail 7632 invoked by uid 107); 18 May 2012 23:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:11:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:10:53 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197985>

The record_person function just parses out the "name" field
of the person line in a commit and adds it to a string_list.
The only reason we need an extra buffer is that the
string_list functions require a NUL-terminated string.

Instead of the static buffer, we can just allocate a
temporary NUL-terminated copy. In addition to removing a
useless limit, this removes the only user of MAX_GITNAME
outside of ident.c.

Signed-off-by: Jeff King <peff@peff.net>
---
This actually introduces an extra malloc() per commit that we analyze. I
doubt we care, but if we do, the right solution IMHO is to introduce
string-list functions which can lookup or add a (buf, len) pair and
avoid the copy altogether.

 builtin/fmt-merge-msg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a517f17..4ee6a88 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -230,7 +230,7 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 static void record_person(int which, struct string_list *people,
 			  struct commit *commit)
 {
-	char name_buf[MAX_GITNAME], *name, *name_end;
+	char *name_buf, *name, *name_end;
 	struct string_list_item *elem;
 	const char *field = (which == 'a') ? "\nauthor " : "\ncommitter ";
 
@@ -243,10 +243,9 @@ static void record_person(int which, struct string_list *people,
 		name_end--;
 	while (isspace(*name_end) && name <= name_end)
 		name_end--;
-	if (name_end < name || name + MAX_GITNAME <= name_end)
+	if (name_end < name)
 		return;
-	memcpy(name_buf, name, name_end - name + 1);
-	name_buf[name_end - name + 1] = '\0';
+	name_buf = xmemdupz(name, name_end - name + 1);
 
 	elem = string_list_lookup(people, name_buf);
 	if (!elem) {
@@ -254,6 +253,7 @@ static void record_person(int which, struct string_list *people,
 		elem->util = (void *)0;
 	}
 	elem->util = (void*)(util_as_integral(elem) + 1);
+	free(name_buf);
 }
 
 static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
-- 
1.7.10.1.16.g53a707b
