From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] lock_ref: inform callers of unavailable ref
Date: Mon, 25 May 2009 06:37:15 -0400
Message-ID: <20090525103715.GA26574@coredump.intra.peff.net>
References: <20090429080650.GA25227@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 12:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8XYr-0003QS-NY
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 12:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZEYKhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 06:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbZEYKhR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 06:37:17 -0400
Received: from peff.net ([208.65.91.99]:44997 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbZEYKhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 06:37:16 -0400
Received: (qmail 3730 invoked by uid 107); 25 May 2009 10:37:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 06:37:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 06:37:15 -0400
Content-Disposition: inline
In-Reply-To: <20090429080650.GA25227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119916>

One of the ways that locking might fail is that there is a
DF conflict between two refs (e.g., you want to lock
"foo/bar" but "foo" already exists). In this case, we return
an error, but there is no way for the caller to know the
specific problem.

This patch sets errno to ENOTDIR, which is the most sensible
code. It's what we would see if the refs were stored purely
in the filesystem (but these days we must check the
namespace manually due to packed refs).

Signed-off-by: Jeff King <peff@peff.net>
---
We introduce a caller who cares in the next patch.

 refs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 45ad556..24438c6 100644
--- a/refs.c
+++ b/refs.c
@@ -893,8 +893,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-            !is_refname_available(ref, NULL, get_packed_refs(), 0))
+	     !is_refname_available(ref, NULL, get_packed_refs(), 0)) {
+		last_errno = ENOTDIR;
 		goto error_return;
+	}
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-- 
1.6.3.1.250.g01b8b.dirty
