From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] fix memcpy of overlapping area
Date: Fri, 29 Jan 2010 05:28:44 -0500
Message-ID: <20100129102844.GA6025@coredump.intra.peff.net>
References: <20100129102518.GA5875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 11:28:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nao5s-0003kU-97
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 11:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220Ab0A2K2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 05:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453Ab0A2K2r
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 05:28:47 -0500
Received: from peff.net ([208.65.91.99]:51525 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153Ab0A2K2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 05:28:46 -0500
Received: (qmail 3961 invoked by uid 107); 29 Jan 2010 10:28:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 Jan 2010 05:28:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2010 05:28:44 -0500
Content-Disposition: inline
In-Reply-To: <20100129102518.GA5875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138308>

Caught by valgrind in t5500, but it is pretty obvious from
reading the code that this is shifting elements of an array
to the left, which needs memmove.

Signed-off-by: Jeff King <peff@peff.net>
---
This was introduced in f53514b (allow deepening of a shallow repository,
2006-10-30), released as part of v1.5.0. So probably 'maint'-worthy.

 commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index 632061c..731191e 100644
--- a/commit.c
+++ b/commit.c
@@ -224,7 +224,7 @@ int unregister_shallow(const unsigned char *sha1)
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < commit_graft_nr)
-		memcpy(commit_graft + pos, commit_graft + pos + 1,
+		memmove(commit_graft + pos, commit_graft + pos + 1,
 				sizeof(struct commit_graft *)
 				* (commit_graft_nr - pos - 1));
 	commit_graft_nr--;
-- 
1.7.0.rc0.41.g538720
