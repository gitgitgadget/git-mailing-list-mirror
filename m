From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] sha1_file: freshen pack objects before loose
Date: Mon, 20 Apr 2015 15:54:03 -0400
Message-ID: <20150420195403.GA15760@peff.net>
References: <20150420195337.GA15447@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:54:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkHll-0002se-6t
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 21:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbbDTTyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 15:54:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:47788 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753825AbbDTTyG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 15:54:06 -0400
Received: (qmail 8924 invoked by uid 102); 20 Apr 2015 19:54:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 14:54:06 -0500
Received: (qmail 27968 invoked by uid 107); 20 Apr 2015 19:54:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 15:54:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2015 15:54:03 -0400
Content-Disposition: inline
In-Reply-To: <20150420195337.GA15447@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267494>

When writing out an object file, we first check whether it
already exists and if so optimize out the write. Prior to
33d4221, we did this by calling has_sha1_file(), which will
check for packed objects followed by loose. Since that
commit, we check loose objects first.

For the common case of a repository whose objects are mostly
packed, this means we will make a lot of extra access()
system calls checking for loose objects. We should follow
the same packed-then-loose order that all of our other
lookups use.

Reported-by: Stefan Saasen <ssaasen@atlassian.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 88f06ba..822aaef 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3014,7 +3014,7 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (freshen_loose_object(sha1) || freshen_packed_object(sha1))
+	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
-- 
2.4.0.rc2.384.g7297a4a
