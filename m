From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] imap-send: avoid buffer overflow
Date: Thu, 8 Dec 2011 03:23:17 -0500
Message-ID: <20111208082317.GA26409@sigill.intra.peff.net>
References: <20111208082118.GA1507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 09:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZGM-0006pC-Iy
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409Ab1LHIXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:23:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43092
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab1LHIXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:23:20 -0500
Received: (qmail 25602 invoked by uid 107); 8 Dec 2011 08:29:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 03:29:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 03:23:17 -0500
Content-Disposition: inline
In-Reply-To: <20111208082118.GA1507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186537>

We format the password prompt in an 80-character static
buffer. It contains the remote host and username, so it's
unlikely to overflow (or be exploitable by a remote
attacker), but there's no reason not to be careful and use
a strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
Just something I noticed while doing the cleanup in the next patch.

 imap-send.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index e1ad1a4..4c1e897 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1209,9 +1209,10 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 			goto bail;
 		}
 		if (!srvc->pass) {
-			char prompt[80];
-			sprintf(prompt, "Password (%s@%s): ", srvc->user, srvc->host);
-			arg = git_getpass(prompt);
+			struct strbuf prompt = STRBUF_INIT;
+			strbuf_addf(&prompt, "Password (%s@%s): ", srvc->user, srvc->host);
+			arg = git_getpass(prompt.buf);
+			strbuf_release(&prompt);
 			if (!arg) {
 				perror("getpass");
 				exit(1);
-- 
1.7.8.rc2.8.gf0f4f
