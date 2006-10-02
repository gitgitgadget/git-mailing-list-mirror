From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] lock_ref_sha1_basic does not remove empty directories on BSD
Date: Mon, 2 Oct 2006 19:23:53 +0200
Message-ID: <20061002172353.G44b12bbc@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 02 19:24:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GURWT-00059a-1x
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 19:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWJBRX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 13:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWJBRX4
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 13:23:56 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:49280 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S965149AbWJBRX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 13:23:56 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500)
	id CDC9A12727E; Mon,  2 Oct 2006 19:23:53 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Mon, 02 Oct 2006 19:16:22 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28226>

lock_ref_sha1_basic relies on errno beeing set to EISDIR by the
call to read() in resolve_ref() to detect directories.  But calling
read() on a directory under NetBSD returns EPERM, and even succeeds
for local filesystems on FreeBSD.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 refs.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index aa4c4e0..305c1a9 100644
--- a/refs.c
+++ b/refs.c
@@ -234,6 +234,12 @@ const char *resolve_ref(const char *ref,
 			}
 		}
 
+		/* Is it a directory? */
+		if (S_ISDIR(st.st_mode)) {
+			errno = EISDIR;
+			return NULL;
+		}
+
 		/*
 		 * Anything else, just open it and try to use it as
 		 * a ref
-- 
1.4.2
