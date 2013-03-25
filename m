From: Jeff King <peff@peff.net>
Subject: [PATCH 3/9] read_istream_filtered: propagate read error from upstream
Date: Mon, 25 Mar 2013 16:18:16 -0400
Message-ID: <20130325201816.GC16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:18:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDr0-00018p-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933327Ab3CYUSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:18:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39333 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156Ab3CYUST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:18:19 -0400
Received: (qmail 27863 invoked by uid 107); 25 Mar 2013 20:20:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:20:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:18:16 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219081>

The filter istream pulls data from an "upstream" stream,
running it through a filter function. However, we did not
properly notice when the upstream filter yielded an error,
and just returned what we had read. Instead, we should
propagate the error.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't know if we should be preserving fs->i_end from getting a
negative value. I would think the internal state of the istream after an
error is undefined.

 streaming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/streaming.c b/streaming.c
index f4126a7..f4ab12b 100644
--- a/streaming.c
+++ b/streaming.c
@@ -237,7 +237,7 @@ static read_method_decl(filtered)
 		if (!fs->input_finished) {
 			fs->i_end = read_istream(fs->upstream, fs->ibuf, FILTER_BUFFER);
 			if (fs->i_end < 0)
-				break;
+				return -1;
 			if (fs->i_end)
 				continue;
 		}
-- 
1.8.2.13.g0f18d3c
