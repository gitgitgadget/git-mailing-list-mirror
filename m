From: Jeff King <peff@peff.net>
Subject: [PATCH 8/9] verify-pack: use strbuf_strip_suffix
Date: Mon, 30 Jun 2014 13:02:05 -0400
Message-ID: <20140630170205.GH16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:02:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1ey4-0003E3-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 19:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbaF3RCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 13:02:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:53674 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754195AbaF3RCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 13:02:07 -0400
Received: (qmail 7966 invoked by uid 102); 30 Jun 2014 17:02:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 12:02:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 13:02:05 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252690>

In this code, we try to convert both "foo.idx" and "foo"
into "foo.pack". By stripping the suffix, we can avoid a
confusing use of strbuf_splice, and make it clear that both
cases are adding ".pack" to the end.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/verify-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 2fd29ce..972579f 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -27,10 +27,9 @@ static int verify_one_pack(const char *path, unsigned int flags)
 	 * normalize these forms to "foo.pack" for "index-pack --verify".
 	 */
 	strbuf_addstr(&arg, path);
-	if (ends_with(arg.buf, ".idx"))
-		strbuf_splice(&arg, arg.len - 3, 3, "pack", 4);
-	else if (!ends_with(arg.buf, ".pack"))
-		strbuf_add(&arg, ".pack", 5);
+	if (strbuf_strip_suffix(&arg, ".idx") ||
+	    !ends_with(arg.buf, ".pack"))
+		strbuf_addstr(&arg, ".pack");
 	argv[2] = arg.buf;
 
 	memset(&index_pack, 0, sizeof(index_pack));
-- 
2.0.0.566.gfe3e6b2
