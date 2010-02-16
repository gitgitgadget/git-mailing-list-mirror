From: Jeff King <peff@peff.net>
Subject: [PATCH] dwim_ref: fix dangling symref warning
Date: Tue, 16 Feb 2010 02:03:16 -0500
Message-ID: <20100216070315.GE2169@coredump.intra.peff.net>
References: <20100216041945.GB10296@vfb-9.home>
 <20100216060528.GB2169@coredump.intra.peff.net>
 <20100216062422.GC10296@vfb-9.home>
 <20100216064753.GD2169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 08:03:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHSv-00014B-ME
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 08:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176Ab0BPHDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 02:03:20 -0500
Received: from peff.net ([208.65.91.99]:42172 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169Ab0BPHDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 02:03:19 -0500
Received: (qmail 30137 invoked by uid 107); 16 Feb 2010 07:03:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Feb 2010 02:03:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2010 02:03:16 -0500
Content-Disposition: inline
In-Reply-To: <20100216064753.GD2169@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140077>

If we encounter a symref that is dangling, in most cases we
will warn about it. The one exception is a dangling HEAD, as
that indicates a branch yet to be born.

However, the check in dwim_ref was not quite right. If we
were fed something like "HEAD^0" we would try to resolve
"HEAD", see that it is dangling, and then check whether the
_original_ string we got was "HEAD" (which it wasn't in this
case). And that makes no sense; the dangling thing we found
was not "HEAD^0" but rather "HEAD".

Fixing this squelches a scary warning from "submodule
summary HEAD" (and consequently "git status" with
status.submodulesummary set) in an empty repo, as the
submodule script calls "git rev-parse -q --verify HEAD^0".

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 7729925..43884c6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -280,8 +280,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		} else if ((flag & REF_ISSYMREF) &&
-			   (len != 4 || strcmp(str, "HEAD")))
+		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD"))
 			warning("ignoring dangling symref %s.", fullref);
 	}
 	free(last_branch);
-- 
1.7.0.25.g1cf14
