From: Jeff King <peff@peff.net>
Subject: [PATCH 15/16] git: avoid magic number with skip_prefix
Date: Wed, 18 Jun 2014 15:56:48 -0400
Message-ID: <20140618195648.GO22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:56:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLyY-0004Ob-VI
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944AbaFRT4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:56:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:46969 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754900AbaFRT4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:56:50 -0400
Received: (qmail 30762 invoked by uid 102); 18 Jun 2014 19:56:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:56:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:56:48 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252048>

After handling options, any leftover arguments should be
commands. However, we pass through "--help" and "--version",
so that we convert them into "git help" and "git version"
respectively.

This is a straightforward use of skip_prefix to avoid a
magic number, but while we are there, it is worth adding a
comment to explain this otherwise confusing behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
Another option would be to teach handle_options to convert "--version"
into "version" itself. That's more disruptive, but I think would be
less confusing.

 git.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index b2bb09e..1537f00 100644
--- a/git.c
+++ b/git.c
@@ -588,8 +588,8 @@ int main(int argc, char **av)
 	argc--;
 	handle_options(&argv, &argc, NULL);
 	if (argc > 0) {
-		if (starts_with(argv[0], "--"))
-			argv[0] += 2;
+		/* translate --help and --version into commands */
+		skip_prefix(argv[0], "--", &argv[0]);
 	} else {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
-- 
2.0.0.566.gfe3e6b2
