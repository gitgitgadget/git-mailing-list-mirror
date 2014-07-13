From: Jeff King <peff@peff.net>
Subject: [PATCH v2 8/8] diff-tree: avoid lookup_unknown_object
Date: Sun, 13 Jul 2014 02:42:17 -0400
Message-ID: <20140713064217.GH4852@sigill.intra.peff.net>
References: <20140713064116.GA4768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:42:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6DUO-0000NN-VY
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 08:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbaGMGmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 02:42:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:32950 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752926AbaGMGmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 02:42:19 -0400
Received: (qmail 30982 invoked by uid 102); 13 Jul 2014 06:42:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 01:42:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 02:42:17 -0400
Content-Disposition: inline
In-Reply-To: <20140713064116.GA4768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253443>

We generally want to avoid lookup_unknown_object, because it
results in allocating more memory for the object than may be
strictly necessary.

In this case, it is used to check whether we have an
already-parsed object before calling parse_object, to save
us from reading the object from disk. Using lookup_object
would be fine for that purpose, but we can take it a step
further. Since this code was written, parse_object already
learned the "check lookup_object" optimization, so we can
simply call parse_object directly.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index ce0e019..1c4ad62 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -68,9 +68,7 @@ static int diff_tree_stdin(char *line)
 	line[len-1] = 0;
 	if (get_sha1_hex(line, sha1))
 		return -1;
-	obj = lookup_unknown_object(sha1);
-	if (!obj || !obj->parsed)
-		obj = parse_object(sha1);
+	obj = parse_object(sha1);
 	if (!obj)
 		return -1;
 	if (obj->type == OBJ_COMMIT)
-- 
2.0.0.566.gfe3e6b2
