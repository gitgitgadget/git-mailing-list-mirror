From: Jeff King <peff@peff.net>
Subject: [PATCH v3 13/14] for-each-ref: use skip_prefix instead of starts_with
Date: Thu, 21 May 2015 00:45:51 -0400
Message-ID: <20150521044551.GM23409@peff.net>
References: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:46:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIMp-0000Iz-JL
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbbEUEpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:45:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:33721 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753466AbbEUEpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:45:53 -0400
Received: (qmail 2445 invoked by uid 102); 21 May 2015 04:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:45:53 -0500
Received: (qmail 31322 invoked by uid 107); 21 May 2015 04:45:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:45:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:45:51 -0400
Content-Disposition: inline
In-Reply-To: <20150521044429.GA5857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269553>

This saves us having to maintain a magic number to skip past
the matched prefix.

Signed-off-by: Jeff King <peff@peff.net>
---
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
2.4.1.528.g00591e3
