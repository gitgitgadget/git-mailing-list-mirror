From: Jeff King <peff@peff.net>
Subject: [PATCH 08/14] remote-curl: free "discovery" object
Date: Thu, 10 Nov 2011 02:50:08 -0500
Message-ID: <20111110075008.GH27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:50:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPOu-0003LV-Fe
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933643Ab1KJHuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:50:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38922
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933613Ab1KJHuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:50:11 -0500
Received: (qmail 22402 invoked by uid 107); 10 Nov 2011 07:50:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:50:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:50:08 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185206>

We cache the last-used "discovery" object, which contains
the data we pulled from the remote about which refs it has,
which saves us an HTTP round-trip when somebody does
something like "list" followed by "fetch".

We don't bother free()ing it at the end of the program
because it just contains memory which will be reclaimed by
the OS. However, cleaning up explicitly will future-proof us
against later changes which will add external storage (like
temporary files).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index fb4d853..014d413 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -933,6 +933,7 @@ int main(int argc, const char **argv)
 		strbuf_reset(&buf);
 	} while (1);
 
+	free_discovery(last_discovery);
 	http_cleanup();
 
 	return 0;
-- 
1.7.7.2.7.g9f96f
