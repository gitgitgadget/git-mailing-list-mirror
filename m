From: Jeff King <peff@peff.net>
Subject: [PATCH 4/9] avoid infinite loop in read_istream_loose
Date: Mon, 25 Mar 2013 16:21:14 -0400
Message-ID: <20130325202114.GD16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:21:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDtp-0005aP-J7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259Ab3CYUVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:21:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39340 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156Ab3CYUVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:21:17 -0400
Received: (qmail 27884 invoked by uid 107); 25 Mar 2013 20:23:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:23:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:21:14 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219082>

The read_istream_loose function loops on inflating a chunk of data
from an mmap'd loose object. We end the loop when we run out
of space in our output buffer, or if we see a zlib error.

We need to treat Z_BUF_ERROR specially, though, as it is not
fatal; it is just zlib's way of telling us that we need to
either feed it more input or give it more output space. It
is perfectly normal for us to hit this when we are at the
end of our buffer.

However, we may also get Z_BUF_ERROR because we have run out
of input. In a well-formed object, this should not happen,
because we have fed the whole mmap'd contents to zlib. But
if the object is truncated or corrupt, we will loop forever,
never giving zlib any more data, but continuing to ask it to
inflate.

We can fix this by considering it an error when zlib returns
Z_BUF_ERROR but we still have output space left (which means
it must want more input, which we know is a truncation
error). It would not be sufficient to just check whether
zlib had consumed all the input at the start of the loop, as
it might still want to generate output from what is in its
internal state.

Signed-off-by: Jeff King <peff@peff.net>
---
The read_istream_pack_non_delta function does not suffer from the same
issue, because it continually feeds more data via use_pack(). Although
it may run into problems if it reads to the very end of a pack. I also
didn't audit the other zlib code paths for similar problems; we may want
to do that.

 streaming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/streaming.c b/streaming.c
index f4ab12b..cabcd9d 100644
--- a/streaming.c
+++ b/streaming.c
@@ -309,7 +309,7 @@ static read_method_decl(loose)
 			st->z_state = z_done;
 			break;
 		}
-		if (status != Z_OK && status != Z_BUF_ERROR) {
+		if (status != Z_OK && (status != Z_BUF_ERROR || total_read < sz)) {
 			git_inflate_end(&st->z);
 			st->z_state = z_error;
 			return -1;
-- 
1.8.2.13.g0f18d3c
