From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] avoid bogus "recursion detected in die handler" message
Date: Mon, 15 Apr 2013 19:06:51 -0400
Message-ID: <20130415230651.GA16670@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 01:07:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URsUJ-0002f1-Jj
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935163Ab3DOXG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:06:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47194 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934813Ab3DOXG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:06:58 -0400
Received: (qmail 30396 invoked by uid 107); 15 Apr 2013 23:08:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 19:08:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 19:06:51 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221325>

If upload-pack fails while generating a pack, the receiving side of a
fetch will print out a message like this:

  fatal: git remote host hung up unexpectedly
  fatal: recursion detected in die handler

You can see it by instrumenting upload-pack to fail like this:

diff --git a/upload-pack.c b/upload-pack.c
index bfa6279..721b416 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -777,6 +777,7 @@ static void upload_pack(void)
 	receive_needs();
 	if (want_obj.nr) {
 		get_common_commits();
+		exit(0);
 		create_pack_file();
 	}
 }

and doing a clone or fetch. What's actually happening is that we have
two threads running, each of which dies, fooling the recursion check.
This series attempts to fix it. The errors afterwards look like:

  fatal: git remote host hung up unexpectedly
  fatal: index-pack failed

which is what was printed pre-cd163d4 (usage.c: detect recursion in die
routines and bail out immediately).

-Peff
