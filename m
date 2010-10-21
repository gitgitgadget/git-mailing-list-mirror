From: Jeff King <peff@peff.net>
Subject: [PATCH] commit: give advice on empty amend
Date: Thu, 21 Oct 2010 11:08:36 -0400
Message-ID: <20101021150836.GA18535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 17:08:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8wkQ-0002gK-TU
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 17:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223Ab0JUPH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 11:07:56 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47670 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932205Ab0JUPHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 11:07:55 -0400
Received: (qmail 6455 invoked by uid 111); 21 Oct 2010 15:07:54 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 15:07:54 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 11:08:36 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159513>

We generally disallow empty commits with "git commit". The
output produced by the wt_status functions is generally
sufficient to explain what happened.

With --amend commits, however, things are a little more
confusing. We would create an empty commit not if you
actually have staged changes _now_, but if your staged
changes match HEAD^. In this case, it is not immediately
obvious why "git commit" claims no changes, but "git status"
does not. Furthermore, we should point the user in the
direction of git reset, which would eliminate the empty
commit entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
Another re-post from my fall cleaning. I have many more, but I'll make
this the last for today.

Original discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/147980/focus=148521

There were no objections; I think it simply got overlooked.

 builtin/commit.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index ddf77e4..2a106a1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -48,6 +48,11 @@ static const char implicit_ident_advice[] =
 "\n"
 "    git commit --amend --author='Your Name <you@example.com>'\n";
 
+static const char empty_amend_advice[] =
+"You asked to amend the most recent commit, but doing so would make\n"
+"it empty. You can repeat your command with --allow-empty, or you can\n"
+"remove the commit entirely with \"git reset HEAD^\".\n";
+
 static unsigned char head_sha1[20];
 
 static char *use_message_buffer;
@@ -700,6 +705,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (!commitable && !in_merge && !allow_empty &&
 	    !(amend && is_a_merge(head_sha1))) {
 		run_status(stdout, index_file, prefix, 0, s);
+		if (amend)
+			fputs(empty_amend_advice, stderr);
 		return 0;
 	}
 
-- 
1.7.3.1.235.gdd6c0
