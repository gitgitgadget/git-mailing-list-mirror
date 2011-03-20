From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] checkout: tweak detached-orphan warning format
Date: Sun, 20 Mar 2011 05:19:01 -0400
Message-ID: <20110320091900.GC15948@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 10:19:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1En1-0000RD-4s
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 10:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab1CTJTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 05:19:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46760
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab1CTJTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 05:19:05 -0400
Received: (qmail 24824 invoked by uid 107); 20 Mar 2011 09:19:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Mar 2011 05:19:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2011 05:19:01 -0400
Content-Disposition: inline
In-Reply-To: <20110320090111.GA15641@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169496>

When orphaning a commit on a detached HEAD, the warning
currently looks like:

  Warning: you are leaving 3 commits behind, not connected to
  any of your branches:

   - commit subject 1
   - commit subject 2
   - commit subject 3

  If you want to keep them by creating a new branch, this
  may be a good time to do so with:

     git branch new_branch_name 933a615ab0bc566dcfd8c01ec8af159f770d3fe5

Instead of using the "-" list, let's provide a more
traditional oneline format, with the abbreviated sha1 before
each subject. Users are accustomed to seeing commits in this
format, and having the sha1 of each commit can be useful if
you want to cherry-pick instead of creating a new branch.

The new format looks like:

  Warning: you are leaving 3 commits behind, not connected to
  any of your branches:

    933a615 commit subject 1
    824fcde commit subject 2
    fa49b1a commit subject 3

Signed-off-by: Jeff King <peff@peff.net>
---
Other thoughts I had but didn't do were:

  - abbreviate the sha1 in the example "git branch" command; it looks
    very long to me.

  - colorize the oneline list in the usual way. This helps makes the
    subjects stand out, but it's a little weird since the rest of the
    warning is not colorized at all.

  - an advice.detachedOrphan option. I'm not sure what it should look
    like exactly (just shorten the message, remove the orphan check
    entirely, etc) so I figured we'd wait until somebody actually is
    annoyed by the verbosity of the message and see what we would want
    then.

  - when we don't detect an orphan commit, we still print the old
    "Previous HEAD was..." message. The point of that was to mention the
    tip in case it was important. Where I think important could be one
    of:

      1. you are orphaning some commits

      2. you might want to remember how to get back to some interesting
         spot in history

    We've already checked that (1) is not the case. There is perhaps
    still some value to (2), but I don't know that I've ever used it.
    And you can always pull the answer from the HEAD reflog (technically
    you can do that for (1), too, of course, but I think the warning is
    more appropriate in that instance).

    So we could perhaps get rid of that message entirely, and print
    nothing when leaving a detached HEAD that is not being orphaned.

 builtin/checkout.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f88d2c8..686d0ff 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -619,7 +619,10 @@ static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 	struct pretty_print_context ctx = { 0 };
 
 	parse_commit(commit);
-	strbuf_addstr(sb, " - ");
+	strbuf_addstr(sb, "  ");
+	strbuf_addstr(sb,
+		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+	strbuf_addch(sb, ' ');
 	pretty_print_commit(CMIT_FMT_ONELINE, commit, sb, &ctx);
 	strbuf_addch(sb, '\n');
 }
-- 
1.7.2.5.10.g62fe7
