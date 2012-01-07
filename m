From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] credentials: unable to connect to cache daemon
Date: Sat, 7 Jan 2012 12:54:36 +0100
Message-ID: <20120107115434.GA8568@ecki.lan>
References: <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
 <20120105025559.GB7326@sigill.intra.peff.net>
 <20120105160612.GA27251@ecki.lan>
 <20120106155204.GA17355@sigill.intra.peff.net>
 <20120106194800.GA9301@ecki.lan>
 <20120106223215.GA13106@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 07 13:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjUzT-0007yu-QA
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 13:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab2AGMCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 07:02:54 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:38884 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751368Ab2AGMCx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 07:02:53 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 2C7BCA7EB9;
	Sat,  7 Jan 2012 13:03:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120106223215.GA13106@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188075>

Error out if we just spawned the daemon and yet we cannot connect.

And always release the string buffer.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Hi Jeff,

I wrote this while debugging why t0301-credential-cache.sh failed after
I enabled cleanup_children by default. This error condition turned out
not to be the problem, and this patch would not have helped in debugging
this case. But I think it makes sense anyways.

 credential-cache.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/credential-cache.c b/credential-cache.c
index dc98372..8f25c06 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -71,11 +71,10 @@ static void do_cache(const char *socket, const char *action, int timeout,
 			die_errno("unable to relay credential");
 	}
 
-	if (!send_request(socket, &buf))
-		return;
-	if (flags & FLAG_SPAWN) {
+	if (send_request(socket, &buf) < 0 && flags & FLAG_SPAWN) {
 		spawn_daemon(socket);
-		send_request(socket, &buf);
+		if (send_request(socket, &buf) < 0)
+			die_errno("unable to connect to cache daemon");
 	}
 	strbuf_release(&buf);
 }
-- 
1.7.8
