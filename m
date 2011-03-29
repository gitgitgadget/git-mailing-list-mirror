From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] revision.c: support --notes command-line option
Date: Tue, 29 Mar 2011 16:57:47 -0400
Message-ID: <20110329205747.GE23466@sigill.intra.peff.net>
References: <20110329205307.GA30959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:58:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fz7-0003jN-VH
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab1C2U5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:57:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48187
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483Ab1C2U5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:57:49 -0400
Received: (qmail 339 invoked by uid 107); 29 Mar 2011 20:58:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 16:58:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 16:57:47 -0400
Content-Disposition: inline
In-Reply-To: <20110329205307.GA30959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170325>

We already have --show-notes, but it has a few shortcomings:

  1. Using --show-notes=<ref> implies that we should also
     show the default notes. Which means you also need to
     use --no-standard-notes if you want to suppress them.

  2. It is negated by --no-notes, which doesn't match.

  3. It's too long to type. :)

This patch introduces --notes, which behaves exactly like
--show-notes, except that using "--notes=<ref>" does not
imply showing the default notes.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c       |   15 ++++++++++-----
 t/t3301-notes.sh |   22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 315a7f4..c4ffee4 100644
--- a/revision.c
+++ b/revision.c
@@ -1367,17 +1367,22 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
-	} else if (!strcmp(arg, "--show-notes")) {
+	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
-	} else if (!prefixcmp(arg, "--show-notes=")) {
+	} else if (!prefixcmp(arg, "--show-notes=") ||
+		   !prefixcmp(arg, "--notes=")) {
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-		if (revs->notes_opt.use_default_notes < 0)
-			revs->notes_opt.use_default_notes = 1;
-		strbuf_addstr(&buf, arg+13);
+		if (!prefixcmp(arg, "--show-notes")) {
+			if (revs->notes_opt.use_default_notes < 0)
+				revs->notes_opt.use_default_notes = 1;
+			strbuf_addstr(&buf, arg+13);
+		}
+		else
+			strbuf_addstr(&buf, arg+8);
 		expand_notes_ref(&buf);
 		string_list_append(&revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 1921ca3..f0e7a58 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -247,6 +247,28 @@ do
 	'
 done
 
+test_expect_success 'setup alternate notes ref' '
+	git notes --ref=alternate add -m alternate
+'
+
+test_expect_success 'git log --notes shows default notes' '
+	git log -1 --notes >output &&
+	grep xyzzy output &&
+	! grep alternate output
+'
+
+test_expect_success 'git log --notes=X shows only X' '
+	git log -1 --notes=alternate >output &&
+	! grep xyzzy output &&
+	grep alternate output
+'
+
+test_expect_success 'git log --notes --notes=X shows both' '
+	git log -1 --notes --notes=alternate >output &&
+	grep xyzzy output &&
+	grep alternate output
+'
+
 test_expect_success 'create -m notes (setup)' '
 	: > a5 &&
 	git add a5 &&
-- 
1.7.4.2.7.g9407
