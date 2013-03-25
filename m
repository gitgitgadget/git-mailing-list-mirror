From: Jeff King <peff@peff.net>
Subject: [PATCH 1/9] stream_blob_to_fd: detect errors reading from stream
Date: Mon, 25 Mar 2013 16:16:50 -0400
Message-ID: <20130325201650.GA16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:17:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDpZ-0007EG-CV
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243Ab3CYUQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:16:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39324 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933176Ab3CYUQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:16:53 -0400
Received: (qmail 27813 invoked by uid 107); 25 Mar 2013 20:18:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:18:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:16:50 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219079>

We call read_istream, but never check its return value for
errors. This can lead to us looping infinitely, as we just
keep trying to write "-1" bytes (and we do not notice the
error, as we simply check that write_in_full reports the
same number of bytes we fed it, which of course is also -1).

Signed-off-by: Jeff King <peff@peff.net>
---
No test yet, as my method for triggering this causes _another_ infinite
loop. So the test comes after the fixes, to avoid infinite loops when
bisecting the history later. :)

 streaming.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/streaming.c b/streaming.c
index 4d978e5..f4126a7 100644
--- a/streaming.c
+++ b/streaming.c
@@ -514,6 +514,8 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
 		ssize_t wrote, holeto;
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
 
+		if (readlen < 0)
+			goto close_and_exit;
 		if (!readlen)
 			break;
 		if (can_seek && sizeof(buf) == readlen) {
-- 
1.8.2.13.g0f18d3c
