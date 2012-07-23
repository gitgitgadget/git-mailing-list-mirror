From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] commit: give a hint when a commit message has been
 abandoned
Date: Mon, 23 Jul 2012 14:52:18 -0400
Message-ID: <20120723185218.GC27588@sigill.intra.peff.net>
References: <20120723184634.GA31905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramana Kumar <ramana@member.fsf.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNk3-0003YS-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab2GWSwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:52:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59070 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab2GWSwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:52:21 -0400
Received: (qmail 5748 invoked by uid 107); 23 Jul 2012 18:52:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jul 2012 14:52:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2012 14:52:18 -0400
Content-Disposition: inline
In-Reply-To: <20120723184634.GA31905@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201960>

If we launch an editor for the user to create a commit
message, they may put significant work into doing so.
Typically we try to check common mistakes that could cause
the commit to fail early, so that we die before the user
goes to the trouble.

We may still experience some errors afterwards, though; in
this case, the user is given no hint that their commit
message has been saved. Let's tell them where it is.

Signed-off-by: Jeff King <peff@peff.net>
---
I did not bother protecting this with advice.* config, as it is unlikely
to come up regularly. If somebody cares, they are welcome to add it on
top.

 builtin/commit.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 20cef95..149e07d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -116,6 +116,16 @@ static enum {
 	STATUS_FORMAT_PORCELAIN
 } status_format = STATUS_FORMAT_LONG;
 
+static int mention_abandoned_message;
+static void maybe_mention_abandoned_message(void)
+{
+	if (!mention_abandoned_message)
+		return;
+	advise(_("Your commit message has been saved in '%s' and will be\n"
+		 "overwritten by the next invocation of \"git commit\"."),
+	       git_path(commit_editmsg));
+}
+
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
 	struct strbuf *buf = opt->value;
@@ -848,6 +858,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
 		}
+		atexit(maybe_mention_abandoned_message);
+		mention_abandoned_message = 1;
 	}
 
 	if (!no_verify &&
@@ -1532,11 +1544,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (template_untouched(&sb) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
+		mention_abandoned_message = 0;
 		exit(1);
 	}
 	if (message_is_empty(&sb) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
+		mention_abandoned_message = 0;
 		exit(1);
 	}
 
@@ -1579,6 +1593,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die(_("cannot update HEAD ref"));
 	}
 
+	mention_abandoned_message = 0;
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
 	unlink(git_path("MERGE_HEAD"));
-- 
1.7.10.5.40.g059818d
