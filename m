From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] validate_headref: tighten ref-matching to just branches
Date: Thu, 29 Jan 2009 03:30:16 -0500
Message-ID: <20090129083015.GA6273@coredump.intra.peff.net>
References: <20090129080145.GA777@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 09:31:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSSJO-0002FF-1x
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 09:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933AbZA2IaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 03:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZA2IaT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 03:30:19 -0500
Received: from peff.net ([208.65.91.99]:51478 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756852AbZA2IaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 03:30:18 -0500
Received: (qmail 29912 invoked by uid 107); 29 Jan 2009 08:30:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 03:30:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 03:30:16 -0500
Content-Disposition: inline
In-Reply-To: <20090129080145.GA777@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107646>

When we are trying to determine whether a directory contains
a git repository, one of the tests we do is to check whether
HEAD is either a symlink or a symref into the "refs/"
hierarchy, or a detached HEAD.

We can tighten this a little more, though: a non-detached
HEAD should always point to a branch (since checking out
anything else should result in detachment), so it is safe to
check for "refs/heads/".

Signed-off-by: Jeff King <peff@peff.net>
---
When I was writing the commit message, my spider sense tingled a little
bit. I don't think this is an unreasonable thing to do, but I also don't
know that it helps in any meaningful way. There is no evidence of people
having other stuff in their HEADs anyway.

 path.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index a074aea..108d9e9 100644
--- a/path.c
+++ b/path.c
@@ -154,7 +154,7 @@ int validate_headref(const char *path)
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
 		len = readlink(path, buffer, sizeof(buffer)-1);
-		if (len >= 5 && !memcmp("refs/", buffer, 5))
+		if (len >= 11 && !memcmp("refs/heads/", buffer, 11))
 			return 0;
 		return -1;
 	}
@@ -178,7 +178,7 @@ int validate_headref(const char *path)
 		len -= 4;
 		while (len && isspace(*buf))
 			buf++, len--;
-		if (len >= 5 && !memcmp("refs/", buf, 5))
+		if (len >= 11 && !memcmp("refs/heads/", buf, 11))
 			return 0;
 	}
 
-- 
1.6.1.1.425.gdbb13
