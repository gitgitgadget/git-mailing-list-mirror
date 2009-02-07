From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 7 Feb 2009 06:26:14 -0500
Message-ID: <20090207112613.GA18079@coredump.intra.peff.net>
References: <20090205204436.GA6072@diku.dk> <20090206191511.GD19494@coredump.intra.peff.net> <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com> <20090207071056.GB14856@coredump.intra.peff.net> <7vprhuzoxm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 12:27:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVlLd-0005qn-Ib
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 12:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZBGL0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 06:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbZBGL0S
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 06:26:18 -0500
Received: from peff.net ([208.65.91.99]:52849 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbZBGL0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 06:26:17 -0500
Received: (qmail 20463 invoked by uid 107); 7 Feb 2009 11:26:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 06:26:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 06:26:14 -0500
Content-Disposition: inline
In-Reply-To: <7vprhuzoxm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108840>

On Fri, Feb 06, 2009 at 11:28:05PM -0800, Junio C Hamano wrote:

> It has been quite a while since I did the "show previous" feature of
> "git-blame --porcelain" that has been forever queued in 'next'; if I
> remember correctly, it implemented (2).
> 
> The reason why it never graduated from 'next' is exactly this issue.  By
> definition, there is no "previous" line number (if there were such a thing
> that says "This line was at line N in the parent of the blamed commit",
> then the commit wouldn't have taken the blame but would have passed it
> down to the parent), and we need to come up with a reasonable heuristics.
> 
> So perhaps this discussion would motivate somebody to finish that part
> off, and tig and other Porcelains can just read the necessary line number
> from the git-blame output.

Do we actually have heuristics that are better than "this was the line
in the original source file?" (i.e., (2) as I described). Because we
already have that in the first number that comes from "blame
--incremental". So perhaps we should start using it and see how well it
works in practice (because like all heuristics, getting a good one is
likely to be a lot of guess and check on what works in practice).

Of course I say "we" and I mean "Jonas". ;) I worked up a small tig
patch below which seems to work, but:

  1. the "jump to this new line number on refresh" code is very hack-ish
     (read: it is now broken for every view except blame), and I'm not
     sure of the most tig-ish way of fixing it

  2. I'm very unsure of the line number parsing. The parse_number
     function confusingly parses " 123 456" as "456". So perhaps there
     is some invariant of the parsing strategy that I don't understand
     (like our pointer is supposed to be at the last character of the
     previous token and _not_ on the space). So the parsing in
     parse_blame_commit is a bit hack-ish.

  3. Nothing in tig records the file that the source line came from. So
     we could be jumping to an arbitrary line number that really came
     from some other file.

Anyway, here it is.

---
diff --git a/tig.c b/tig.c
index 97794b0..faec056 100644
--- a/tig.c
+++ b/tig.c
@@ -38,6 +38,7 @@
 #include <unistd.h>
 #include <time.h>
 #include <fcntl.h>
+#include <limits.h>
 
 #include <regex.h>
 
@@ -2574,7 +2575,7 @@ reset_view(struct view *view)
 
 	view->p_offset = view->offset;
 	view->p_yoffset = view->yoffset;
-	view->p_lineno = view->lineno;
+	/* view->p_lineno = view->lineno; */
 
 	view->line = NULL;
 	view->offset = 0;
@@ -4180,6 +4181,7 @@ struct blame_commit {
 
 struct blame {
 	struct blame_commit *commit;
+	int lineno;
 	char text[1];
 };
 
@@ -4243,14 +4245,16 @@ parse_blame_commit(struct view *view, const char *text, int *blamed)
 {
 	struct blame_commit *commit;
 	struct blame *blame;
-	const char *pos = text + SIZEOF_REV - 1;
+	const char *pos = text + SIZEOF_REV - 2;
 	size_t lineno;
 	size_t group;
+	size_t orig_lineno;
 
-	if (strlen(text) <= SIZEOF_REV || *pos != ' ')
+	if (strlen(text) <= SIZEOF_REV || pos[1] != ' ')
 		return NULL;
 
-	if (!parse_number(&pos, &lineno, 1, view->lines) ||
+	if (!parse_number(&pos, &orig_lineno, 1, INT_MAX) ||
+	    !parse_number(&pos, &lineno, 1, view->lines) ||
 	    !parse_number(&pos, &group, 1, view->lines - lineno + 1))
 		return NULL;
 
@@ -4264,6 +4268,7 @@ parse_blame_commit(struct view *view, const char *text, int *blamed)
 
 		blame = line->data;
 		blame->commit = commit;
+		blame->lineno = orig_lineno + group - 1;
 		line->dirty = 1;
 	}
 
@@ -4425,8 +4430,10 @@ blame_request(struct view *view, enum request request, struct line *line)
 
 	case REQ_PARENT:
 		if (check_blame_commit(blame) &&
-		    select_commit_parent(blame->commit->id, opt_ref))
+		    select_commit_parent(blame->commit->id, opt_ref)) {
+			view->p_lineno = blame->lineno;
 			open_view(view, REQ_VIEW_BLAME, OPEN_REFRESH);
+		}
 		break;
 
 	case REQ_ENTER:
