From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] commit: check committer identity more strictly
Date: Mon, 23 Jul 2012 14:50:35 -0400
Message-ID: <20120723185035.GB27588@sigill.intra.peff.net>
References: <20120723184634.GA31905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramana Kumar <ramana@member.fsf.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:50:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNiO-0002D8-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab2GWSuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:50:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59065 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324Ab2GWSui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:50:38 -0400
Received: (qmail 5714 invoked by uid 107); 23 Jul 2012 18:50:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jul 2012 14:50:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jul 2012 14:50:35 -0400
Content-Disposition: inline
In-Reply-To: <20120723184634.GA31905@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201959>

The identity of the committer will ultimately be pulled from
the ident code by commit_tree(). However, we make an attempt
to check the author and committer identity early, before the
user has done any manual work like inputting a commit
message. That lets us abort without them having to worry
about salvaging the work from .git/COMMIT_EDITMSG.

The early check for committer ident does not use the
IDENT_STRICT flag, meaning that it would not find an empty
name field. The motivation was presumably because we did not
want to be too restrictive, as later calls might be more lax
(for example, when we create the reflog entry, we do not
care too much about a real name). However, because
commit_tree will always get a strict identity to put in the
commit object itself, there is no point in being lax only to
die later (and in fact it is harmful, because the user will
have wasted time typing their commit message).

Incidentally, this bug was masked prior to 060d4bb, as the
initial loose call would taint the later strict call. So the
commit would succeed (albeit with a bogus committer line in
the commit object), and nobody noticed that our early check
did not match the later one.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 95eeab1..20cef95 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -725,7 +725,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	strbuf_release(&sb);
 
 	/* This checks if committer ident is explicitly given */
-	strbuf_addstr(&committer_ident, git_committer_info(0));
+	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
 	if (use_editor && include_status) {
 		char *ai_tmp, *ci_tmp;
 		if (whence != FROM_COMMIT)
-- 
1.7.10.5.40.g059818d
