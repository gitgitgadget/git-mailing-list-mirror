From: Jeff King <peff@peff.net>
Subject: [PATCHv2 08/10] remote-curl: pass buffer straight to get_remote_heads
Date: Mon, 18 Feb 2013 04:29:05 -0500
Message-ID: <20130218092905.GH5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7N2X-0004I2-4F
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205Ab3BRJ3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:29:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51693 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756720Ab3BRJ3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:29:08 -0500
Received: (qmail 17730 invoked by uid 107); 18 Feb 2013 09:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:30:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:29:05 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216454>

Until recently, get_remote_heads only knew how to read refs
from a file descriptor. To hack around this, we spawned a
thread (or forked a process) to write the buffer back to us.

Now that we can just pass it our buffer directly, we don't
have to use this hack anymore.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't know that this code was hurting anything, but it has always
struck me as ugly and a possible source of error. And now it's gone.

 remote-curl.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6e43463..f049da2 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -173,33 +173,11 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
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
1.8.1.20.g7078b03
