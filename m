From: Jeff King <peff@peff.net>
Subject: [PATCH 11/12] for-each-ref: use skip_prefix instead of starts_with
Date: Fri, 1 May 2015 18:55:59 -0400
Message-ID: <20150501225559.GK1534@peff.net>
References: <20150501224414.GA25551@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 00:56:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJqp-00058D-SD
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbbEAW4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:56:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:53126 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750886AbbEAW4C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:56:02 -0400
Received: (qmail 24196 invoked by uid 102); 1 May 2015 22:56:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:56:01 -0500
Received: (qmail 21143 invoked by uid 107); 1 May 2015 22:56:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:56:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:55:59 -0400
Content-Disposition: inline
In-Reply-To: <20150501224414.GA25551@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268196>

This saves us having to maintain a magic number to skip past
the matched prefix.

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed because I'm adding similar code in the next patch...

 builtin/for-each-ref.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 18d209b..345d8dd 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -659,10 +659,12 @@ static void populate_value(struct refinfo *ref)
 		else if (starts_with(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (starts_with(name, "upstream")) {
+			const char *branch_name;
 			/* only local branches may have an upstream */
-			if (!starts_with(ref->refname, "refs/heads/"))
+			if (!skip_prefix(ref->refname, "refs/heads/",
+					 &branch_name))
 				continue;
-			branch = branch_get(ref->refname + 11);
+			branch = branch_get(branch_name);
 
 			refname = branch_get_upstream(branch, NULL);
 			if (!refname)
-- 
2.4.0.rc3.477.gc25258d
