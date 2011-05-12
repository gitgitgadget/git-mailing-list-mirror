From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] revert: allow reverting a root commit
Date: Thu, 12 May 2011 07:09:55 -0400
Message-ID: <20110512110955.GB5292@sigill.intra.peff.net>
References: <20110512110855.GA5240@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 13:10:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKTmM-0006Wh-MV
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 13:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab1ELLJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 07:09:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53677
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791Ab1ELLJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 07:09:56 -0400
Received: (qmail 12744 invoked by uid 107); 12 May 2011 11:11:55 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 May 2011 07:11:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2011 07:09:55 -0400
Content-Disposition: inline
In-Reply-To: <20110512110855.GA5240@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173459>

Although it is probably an uncommon operation, there is no
reason to disallow it, as it works just fine. It is the
reverse of a cherry-pick of a root commit, which is already
allowed.

We do have to tweak one check on whether we have a merge
commit, which assumed we had at least one parent.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/revert.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f697e66..1f27c63 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -408,8 +408,6 @@ static int do_pick_commit(void)
 	discard_cache();
 
 	if (!commit->parents) {
-		if (action == REVERT)
-			die (_("Cannot revert a root commit"));
 		parent = NULL;
 	}
 	else if (commit->parents->next) {
@@ -467,7 +465,7 @@ static int do_pick_commit(void)
 		strbuf_addstr(&msgbuf, "\"\n\nThis reverts commit ");
 		strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 
-		if (commit->parents->next) {
+		if (commit->parents && commit->parents->next) {
 			strbuf_addstr(&msgbuf, ", reversing\nchanges made to ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(parent->object.sha1));
 		}
-- 
1.7.5.1.12.ga7abed
