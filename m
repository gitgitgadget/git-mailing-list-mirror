From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pickaxe: hoist empty needle check
Date: Sun, 28 Oct 2012 08:46:28 -0400
Message-ID: <20121028124628.GA24548@sigill.intra.peff.net>
References: <20121028124540.GF11434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 13:46:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSSGI-0002GY-PF
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 13:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab2J1Mqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 08:46:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41329 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2J1Mqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 08:46:30 -0400
Received: (qmail 8412 invoked by uid 107); 28 Oct 2012 12:47:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 08:47:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 08:46:28 -0400
Content-Disposition: inline
In-Reply-To: <20121028124540.GF11434@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208542>

If we are given an empty pickaxe needle like "git log -S ''",
it is impossible for us to find anything (because no matter
what the content, the count will always be 0). We currently
check this at the lowest level of contains(). Let's hoist
the logic much earlier to has_changes(), so that it is
simpler to return our answer before loading any blob data.

Signed-off-by: Jeff King <peff@peff.net>
---
 diffcore-pickaxe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a209376..61f628c 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -163,8 +163,6 @@ static unsigned int contains(struct diff_filespec *one, struct diff_options *o,
 	unsigned int cnt;
 	unsigned long sz;
 	const char *data;
-	if (!o->pickaxe[0])
-		return 0;
 	if (diff_populate_filespec(one, 0))
 		return 0;
 
@@ -206,6 +204,9 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 static int has_changes(struct diff_filepair *p, struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
+	if (!o->pickaxe[0])
+		return 0;
+
 	if (!DIFF_FILE_VALID(p->one)) {
 		if (!DIFF_FILE_VALID(p->two))
 			return 0; /* ignore unmerged */
-- 
1.8.0.3.g3456896
