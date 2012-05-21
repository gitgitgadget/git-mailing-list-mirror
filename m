From: Jeff King <peff@peff.net>
Subject: [PATCHv2 03/15] fmt-merge-msg: don't use static buffer in
 record_person
Date: Mon, 21 May 2012 19:09:51 -0400
Message-ID: <20120521230951.GC10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:09:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbjh-00075M-MG
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab2EUXJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:09:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51203
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401Ab2EUXJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:09:53 -0400
Received: (qmail 7720 invoked by uid 107); 21 May 2012 23:10:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:09:51 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198147>

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
1.7.10.1.19.g711d603
