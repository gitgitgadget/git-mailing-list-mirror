From: Jeff King <peff@peff.net>
Subject: [PATCH] clone: make sure we support the transport type
Date: Tue, 27 May 2008 10:28:43 -0400
Message-ID: <20080527142842.GA7651@sigill.intra.peff.net>
References: <200805271124.50172.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 16:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K10BF-00054Q-Me
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 16:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbYE0O2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 10:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755702AbYE0O2q
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 10:28:46 -0400
Received: from peff.net ([208.65.91.99]:1431 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755425AbYE0O2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 10:28:45 -0400
Received: (qmail 3682 invoked by uid 111); 27 May 2008 14:28:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 27 May 2008 10:28:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 May 2008 10:28:43 -0400
Content-Disposition: inline
In-Reply-To: <200805271124.50172.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83020>

If we use an unsupported transport (e.g., http when curl
support is not compiled in), transport_get reports an error
to the user, but we still get a transport object. We need to
manually check and abort the clone process at that point, or
we end up with a segfault.

Noticed by Thomas Rast.

Signed-off-by: Jeff King <peff@peff.net>
---
There are a few other calls to transport_get in builtin-clone, for
setting up references and doing local cloning. I didn't check, but
assumed it was impossible for http:// remotes to make it to that code
path.

 builtin-clone.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 4740b13..f4accbe 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -449,6 +449,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		struct remote *remote = remote_get(argv[0]);
 		struct transport *transport = transport_get(remote, argv[0]);
 
+		if (!transport->get_refs_list || !transport->fetch)
+			die("Don't know how to clone %s", transport->url);
+
 		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
 		if (option_depth)
-- 
1.5.6.rc0.128.g5fd3b9.dirty
