From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] notes: refactor display notes extra refs field
Date: Tue, 29 Mar 2011 16:56:53 -0400
Message-ID: <20110329205653.GC23466@sigill.intra.peff.net>
References: <20110329205307.GA30959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fyG-0003Cw-Fc
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab1C2U44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:56:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48179
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280Ab1C2U4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:56:55 -0400
Received: (qmail 327 invoked by uid 107); 29 Mar 2011 20:57:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 16:57:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 16:56:53 -0400
Content-Disposition: inline
In-Reply-To: <20110329205307.GA30959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170323>

There's no need to use an extra pointer, which just ends up
leaking memory. The fact that the list is empty tells us the
same thing.

Signed-off-by: Jeff King <peff@peff.net>
---
 notes.c    |    4 ++--
 notes.h    |    4 +++-
 revision.c |    4 +---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/notes.c b/notes.c
index f6b9b6a..2ec604c 100644
--- a/notes.c
+++ b/notes.c
@@ -1066,9 +1066,9 @@ void init_display_notes(struct display_notes_opt *opt)
 
 	git_config(notes_display_config, &load_config_refs);
 
-	if (opt && opt->extra_notes_refs) {
+	if (opt) {
 		struct string_list_item *item;
-		for_each_string_list_item(item, opt->extra_notes_refs)
+		for_each_string_list_item(item, &opt->extra_notes_refs)
 			string_list_add_refs_by_glob(&display_notes_refs,
 						     item->string);
 	}
diff --git a/notes.h b/notes.h
index 60bdf28..7ae3eef 100644
--- a/notes.h
+++ b/notes.h
@@ -1,6 +1,8 @@
 #ifndef NOTES_H
 #define NOTES_H
 
+#include "string-list.h"
+
 /*
  * Function type for combining two notes annotating the same object.
  *
@@ -257,7 +259,7 @@ struct string_list;
 
 struct display_notes_opt {
 	unsigned int suppress_default_notes:1;
-	struct string_list *extra_notes_refs;
+	struct string_list extra_notes_refs;
 };
 
 /*
diff --git a/revision.c b/revision.c
index 5826e5d..24b89eb 100644
--- a/revision.c
+++ b/revision.c
@@ -1372,11 +1372,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-		if (!revs->notes_opt.extra_notes_refs)
-			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
 		strbuf_addstr(&buf, arg+13);
 		expand_notes_ref(&buf);
-		string_list_append(revs->notes_opt.extra_notes_refs,
+		string_list_append(&revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
 	} else if (!strcmp(arg, "--no-notes")) {
 		revs->show_notes = 0;
-- 
1.7.4.2.7.g9407
