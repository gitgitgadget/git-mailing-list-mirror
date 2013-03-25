From: Jeff King <peff@peff.net>
Subject: [PATCH 2/9] check_sha1_signature: check return value from
 read_istream
Date: Mon, 25 Mar 2013 16:17:17 -0400
Message-ID: <20130325201717.GB16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:17:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDq0-0007yU-92
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933250Ab3CYURV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:17:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39327 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801Ab3CYURU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:17:20 -0400
Received: (qmail 27831 invoked by uid 107); 25 Mar 2013 20:19:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:19:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:17:17 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219080>

It's possible for read_istream to return an error, in which
case we just end up in an infinite loop (aside from EOF, we
do not even look at the result, but just feed it straight
into our running hash).

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't actually trigger this code path in any of my tests, but I
audited all of the callers of read_istream after the last patch, and
noticed this one (the rest looked fine to me).

 sha1_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 16967d3..0b99f33 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1266,6 +1266,10 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 		char buf[1024 * 16];
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
 
+		if (readlen < 0) {
+			close_istream(st);
+			return -1;
+		}
 		if (!readlen)
 			break;
 		git_SHA1_Update(&c, buf, readlen);
-- 
1.8.2.13.g0f18d3c
