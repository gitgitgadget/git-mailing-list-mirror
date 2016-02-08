From: Jeff King <peff@peff.net>
Subject: [PATCH] rerere: replace strcpy with xsnprintf
Date: Mon, 8 Feb 2016 17:25:01 -0500
Message-ID: <20160208222501.GA21671@sigill.intra.peff.net>
References: <20160208222155.GA17395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:25:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuFD-00083f-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbcBHWZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 17:25:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:39537 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932472AbcBHWZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 17:25:04 -0500
Received: (qmail 31155 invoked by uid 102); 8 Feb 2016 22:25:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 17:25:03 -0500
Received: (qmail 10267 invoked by uid 107); 8 Feb 2016 22:25:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 17:25:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 17:25:01 -0500
Content-Disposition: inline
In-Reply-To: <20160208222155.GA17395@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285817>

This shouldn't overflow, as we are copying a sha1 hex into a
41-byte buffer. But it does not hurt to use a bound-checking
function, which protects us and makes auditing for overflows
easier.

Signed-off-by: Jeff King <peff@peff.net>
---
These strcpy calls go away in jc/rerere-multi, so I was holding onto
this to see if that graduated. But since that is stalled, I figured it
cannot hurt to post (and the conflict resolution is obviously trivial).

With this and the previous patch, it makes our code base strcpy free.
Yay.

 rerere.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index 403c700..587b7e2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -48,7 +48,7 @@ static int has_rerere_resolution(const struct rerere_id *id)
 static struct rerere_id *new_rerere_id_hex(char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
-	strcpy(id->hex, hex);
+	xsnprintf(id->hex, sizeof(id->hex), "%s", hex);
 	return id;
 }
 
@@ -904,7 +904,7 @@ int rerere_forget(struct pathspec *pathspec)
 static struct rerere_id *dirname_to_id(const char *name)
 {
 	static struct rerere_id id;
-	strcpy(id.hex, name);
+	xsnprintf(id.hex, sizeof(id.hex), "%s", name);
 	return &id;
 }
 
-- 
2.7.1.526.gd04f550
