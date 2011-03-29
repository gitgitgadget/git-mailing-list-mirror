From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] notes: refactor display notes default handling
Date: Tue, 29 Mar 2011 16:57:27 -0400
Message-ID: <20110329205727.GD23466@sigill.intra.peff.net>
References: <20110329205307.GA30959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fyo-0003ZH-Tn
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1C2U5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:57:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48183
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab1C2U53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:57:29 -0400
Received: (qmail 333 invoked by uid 107); 29 Mar 2011 20:58:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 16:58:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 16:57:27 -0400
Content-Disposition: inline
In-Reply-To: <20110329205307.GA30959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170324>

This is in preparation for more notes-related revision
command-line options.

The "suppress_default_notes" option is renamed to
"use_default_notes", and is now a tri-state with values less
than one indicating "not set".  If the value is "not set",
then we show default refs if and only if no other refs were
given.

Signed-off-by: Jeff King <peff@peff.net>
---
 notes.c    |    3 ++-
 notes.h    |    2 +-
 revision.c |    9 +++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/notes.c b/notes.c
index 2ec604c..f6ce848 100644
--- a/notes.c
+++ b/notes.c
@@ -1053,7 +1053,8 @@ void init_display_notes(struct display_notes_opt *opt)
 
 	assert(!display_notes_trees);
 
-	if (!opt || !opt->suppress_default_notes) {
+	if (!opt || opt->use_default_notes > 0 ||
+	    (opt->use_default_notes == -1 && !opt->extra_notes_refs.nr)) {
 		string_list_append(&display_notes_refs, default_notes_ref());
 		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
 		if (display_ref_env) {
diff --git a/notes.h b/notes.h
index 7ae3eef..c716694 100644
--- a/notes.h
+++ b/notes.h
@@ -258,7 +258,7 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 struct string_list;
 
 struct display_notes_opt {
-	unsigned int suppress_default_notes:1;
+	int use_default_notes;
 	struct string_list extra_notes_refs;
 };
 
diff --git a/revision.c b/revision.c
index 24b89eb..315a7f4 100644
--- a/revision.c
+++ b/revision.c
@@ -955,6 +955,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
 	}
+
+	revs->notes_opt.use_default_notes = -1;
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -1368,10 +1370,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--show-notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
+		revs->notes_opt.use_default_notes = 1;
 	} else if (!prefixcmp(arg, "--show-notes=")) {
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
+		if (revs->notes_opt.use_default_notes < 0)
+			revs->notes_opt.use_default_notes = 1;
 		strbuf_addstr(&buf, arg+13);
 		expand_notes_ref(&buf);
 		string_list_append(&revs->notes_opt.extra_notes_refs,
@@ -1381,9 +1386,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--standard-notes")) {
 		revs->show_notes_given = 1;
-		revs->notes_opt.suppress_default_notes = 0;
+		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
-		revs->notes_opt.suppress_default_notes = 1;
+		revs->notes_opt.use_default_notes = 0;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
-- 
1.7.4.2.7.g9407
