From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] revision.c: make --no-notes reset --notes list
Date: Tue, 29 Mar 2011 16:59:42 -0400
Message-ID: <20110329205942.GF23466@sigill.intra.peff.net>
References: <20110329205307.GA30959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:59:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4g0z-0004ab-OM
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab1C2U7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:59:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48192
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab1C2U7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:59:44 -0400
Received: (qmail 353 invoked by uid 107); 29 Mar 2011 21:00:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 17:00:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 16:59:42 -0400
Content-Disposition: inline
In-Reply-To: <20110329205307.GA30959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170326>

With most command line options, later instances of an option
override earlier ones. With cumulative options like
"--notes", however, there is no way to say "forget the
--notes I gave you before".

Let's have --no-notes trigger this forgetting, so that:

  git log --notes=foo --no-notes --notes=bar

will show only the "bar" notes.

Signed-off-by: Jeff King <peff@peff.net>
---
Technically this is a regression for:

  git log --show-notes=foo --no-notes --show-notes=bar

which used to show both. But I consider that behavior useless and crazy,
and since the --no-notes actually did nothing there, why would anyone
have been using it?

 revision.c       |    6 ++++++
 t/t3301-notes.sh |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index c4ffee4..541f09e 100644
--- a/revision.c
+++ b/revision.c
@@ -1389,6 +1389,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--no-notes")) {
 		revs->show_notes = 0;
 		revs->show_notes_given = 1;
+		revs->notes_opt.use_default_notes = -1;
+		/* we have been strdup'ing ourselves, so trick
+		 * string_list into free()ing strings */
+		revs->notes_opt.extra_notes_refs.strdup_strings = 1;
+		string_list_clear(&revs->notes_opt.extra_notes_refs, 0);
+		revs->notes_opt.extra_notes_refs.strdup_strings = 0;
 	} else if (!strcmp(arg, "--standard-notes")) {
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index f0e7a58..8600db7 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -269,6 +269,22 @@ test_expect_success 'git log --notes --notes=X shows both' '
 	grep alternate output
 '
 
+test_expect_success 'git log --no-notes resets default state' '
+	git log -1 --notes --notes=alternate \
+		--no-notes --notes=alternate \
+		>output &&
+	! grep xyzzy output &&
+	grep alternate output
+'
+
+test_expect_success 'git log --no-notes resets ref list' '
+	git log -1 --notes --notes=alternate \
+		--no-notes --notes \
+		>output &&
+	grep xyzzy output &&
+	! grep alternate output
+'
+
 test_expect_success 'create -m notes (setup)' '
 	: > a5 &&
 	git add a5 &&
-- 
1.7.4.2.7.g9407
