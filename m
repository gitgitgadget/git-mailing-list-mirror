From: Jeff King <peff@peff.net>
Subject: [PATCH v3 17/19] remote-curl: pass buffer straight to
 get_remote_heads
Date: Wed, 20 Feb 2013 15:07:02 -0500
Message-ID: <20130220200702.GQ25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:07:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Fx3-00086v-3V
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935354Ab3BTUHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:07:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54692 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935215Ab3BTUHF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:07:05 -0500
Received: (qmail 17918 invoked by uid 107); 20 Feb 2013 20:08:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:08:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:07:02 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216732>

Until recently, get_remote_heads only knew how to read refs
from a file descriptor. To hack around this, we spawned a
thread (or forked a process) to write the buffer back to us.

Now that we can just pass it our buffer directly, we don't
have to use this hack anymore.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 3bc6cb5..e07f654 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -170,33 +170,11 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 	return last;
 }
 
-static int write_discovery(int in, int out, void *data)
-{
-	struct discovery *heads = data;
-	int err = 0;
-	if (write_in_full(out, heads->buf, heads->len) != heads->len)
-		err = 1;
-	close(out);
-	return err;
-}
-
 static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 {
 	struct ref *list = NULL;
-	struct async async;
-
-	memset(&async, 0, sizeof(async));
-	async.proc = write_discovery;
-	async.data = heads;
-	async.out = -1;
-
-	if (start_async(&async))
-		die("cannot start thread to parse advertised refs");
-	get_remote_heads(async.out, NULL, 0, &list,
-			for_push ? REF_NORMAL : 0, NULL);
-	close(async.out);
-	if (finish_async(&async))
-		die("ref parsing thread failed");
+	get_remote_heads(-1, heads->buf, heads->len, &list,
+			 for_push ? REF_NORMAL : 0, NULL);
 	return list;
 }
 
-- 
1.8.2.rc0.9.g352092c
