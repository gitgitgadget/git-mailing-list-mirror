From: Jeff King <peff@peff.net>
Subject: [PATCHv2 1/9] imap-send: avoid buffer overflow
Date: Sat, 10 Dec 2011 05:40:45 -0500
Message-ID: <20111210104045.GA16648@sigill.intra.peff.net>
References: <20111210103943.GA16478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:40:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKMO-00007T-AB
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab1LJKks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:40:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47045
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1LJKks (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:40:48 -0500
Received: (qmail 14304 invoked by uid 107); 10 Dec 2011 10:47:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:47:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:40:45 -0500
Content-Disposition: inline
In-Reply-To: <20111210103943.GA16478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186748>

We format the password prompt in an 80-character static
buffer. It contains the remote host and username, so it's
unlikely to overflow (or be exploitable by a remote
attacker), but there's no reason not to be careful and use
a strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
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
1.7.8.rc2.40.gaf387
