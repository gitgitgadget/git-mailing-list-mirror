From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] finish_async: be quiet when waiting for async process
Date: Thu, 31 Mar 2011 14:44:00 -0400
Message-ID: <20110331184400.GB16906@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 20:44:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Mqp-0001Qa-0F
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759034Ab1CaSoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:44:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60517
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759030Ab1CaSoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:44:04 -0400
Received: (qmail 1330 invoked by uid 107); 31 Mar 2011 18:44:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 14:44:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 14:44:00 -0400
Content-Disposition: inline
In-Reply-To: <20110331184243.GA12027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170512>

When we ask to finish_async, we should be quiet about things
like signal death in the async process, for two reasons:

  1. This better matches what happens on the Windows side,
     where threads are used (and what will eventually happen
     when pthreads are used on unix).

  2. We pass along the error code to the caller, who needs
     to check and produce an error message anyway for the
     case of a non-zero exit code.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 0d5626a..258c880 100644
--- a/run-command.c
+++ b/run-command.c
@@ -427,7 +427,7 @@ error:
 int finish_async(struct async *async)
 {
 #ifndef WIN32
-	int ret = wait_or_whine(async->pid, "child process", 0);
+	int ret = wait_or_whine(async->pid, "child process", 1);
 #else
 	DWORD ret = 0;
 	if (WaitForSingleObject(async->tid, INFINITE) != WAIT_OBJECT_0)
-- 
1.7.4.13.g8566c
