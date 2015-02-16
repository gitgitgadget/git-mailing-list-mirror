From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] cmd_push: pass "flags" pointer to config callback
Date: Mon, 16 Feb 2015 01:13:25 -0500
Message-ID: <20150216061325.GB32381@peff.net>
References: <20150216061051.GA29895@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 07:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEw0-00089d-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 07:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbBPGN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 01:13:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:49406 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751108AbbBPGN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 01:13:27 -0500
Received: (qmail 9229 invoked by uid 102); 16 Feb 2015 06:13:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:13:27 -0600
Received: (qmail 12538 invoked by uid 107); 16 Feb 2015 06:13:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 01:13:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 01:13:25 -0500
Content-Disposition: inline
In-Reply-To: <20150216061051.GA29895@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263879>

This will let us manipulate any transport flags which have matching
config options (there are none yet, but we will add one in
the next patch).

We could also just make "flags" a static file-scope global,
but the result is a little confusing. We end up passing it
along through do_push and push_with_options, each of which
further munge it. Having slightly-differing versions of the
flags variable available to those functions would probably
cause more confusion than it is worth. Let's just keep the
original local to cmd_push, and it can continue to pass it
through the call-stack.

Signed-off-by: Jeff King <peff@peff.net>
---
I was also tempted to just remove the passing of "flags" through the
call stack entirely, and just have everybody touch a global
transport_flags. That is a much bigger change, and less obviously
correct (after a callee munges their local version, do we ever care
about seeing the original in the caller?). I don't think so.

To be honest, the whole do_push is confusing to me. It seems like that
should just be part of cmd_push.

 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index f558c2e..c25108f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -555,7 +555,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("push");
-	git_config(git_push_config, NULL);
+	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
-- 
2.3.0.rc1.287.g761fd19
