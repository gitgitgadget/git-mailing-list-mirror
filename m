From: Jeff King <peff@peff.net>
Subject: [RFC PATCH 5/5] fix overlapping memcpy in normalize_absolute_path
Date: Wed, 22 Oct 2008 16:32:23 -0400
Message-ID: <20081022203222.GE4547@coredump.intra.peff.net>
References: <20081022202810.GA4439@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 22:33:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskOk-0000Po-Dn
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbYJVUc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755056AbYJVUc0
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:32:26 -0400
Received: from peff.net ([208.65.91.99]:3803 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbYJVUcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:32:25 -0400
Received: (qmail 4239 invoked by uid 111); 22 Oct 2008 20:32:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:32:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:32:23 -0400
Content-Disposition: inline
In-Reply-To: <20081022202810.GA4439@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98904>

The comments for normalize_absolute_path explicitly claim
that the source and destination buffers may be the same
(though they may not otherwise overlap). Thus the call to
memcpy may involve copying overlapping data, and memmove
should be used instead.

This fixes a valgrind error in t1504.

Signed-off-by: Jeff King <peff@peff.net>
---
An alternative fix, since we declare that only true equality is OK,
would be to keep the memcpy and explicitly check for "comp_start ==
dst". That might have a performance benefit if memcpy is faster than
memmove, but I don't know that normalize_absolute_path is in any
critical paths.

 path.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index 76e8872..c1cb54b 100644
--- a/path.c
+++ b/path.c
@@ -348,7 +348,7 @@ int normalize_absolute_path(char *buf, const char *path)
 			goto next;
 		}
 
-		memcpy(dst, comp_start, comp_len);
+		memmove(dst, comp_start, comp_len);
 		dst += comp_len;
 	next:
 		comp_start = comp_end;
-- 
1.6.0.2.825.g6d19d
