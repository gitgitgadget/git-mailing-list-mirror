From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] receive-pack: drop "n/a" on unpacker errors
Date: Fri, 21 Sep 2012 01:38:46 -0400
Message-ID: <20120921053846.GC9863@sigill.intra.peff.net>
References: <20120921053057.GA9768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 07:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEvx3-0005d6-8W
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 07:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab2IUFit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 01:38:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52312 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab2IUFis (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 01:38:48 -0400
Received: (qmail 29537 invoked by uid 107); 21 Sep 2012 05:39:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 01:39:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 01:38:46 -0400
Content-Disposition: inline
In-Reply-To: <20120921053057.GA9768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206108>

The output from git push currently looks like this:

  $ git push dest HEAD
  fatal: [some message from index-pack]
  error: unpack failed: index-pack abnormal exit
  To dest
   ! [remote rejected] HEAD -> master (n/a (unpacker error))

That n/a is meant to be "the per-ref status is not
available" but the nested parentheses just make it look
ugly. Let's turn the final line into just:

   ! [remote rejected] HEAD -> master (unpacker error)

Signed-off-by: Jeff King <peff@peff.net>
---
Maybe it is just me, but I have always found the "n/a" and extra
parentheses ugly and unnecessary. But obviously others may differ.
It doesn't really come up that often, since index-pack failing usually
implies a git bug. But with transfer.fsckObjects turn on, it is more
common.

I don't think there should be any backwards compatibility issues with
changing this. The "reason" field sent back by receive-pack has always
been a free-form human-readable string.

I also dislike the "index-pack abnormal exit" message. Again, when
index-pack really crashes, it's fine, but it can die due to bogus
objects, too, in which case it might be nice to have a more
human-readable message.

 builtin/receive-pack.c          | 2 +-
 t/t5504-fetch-receive-strict.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ac679ab..ff781fe 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -695,7 +695,7 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 
 	if (unpacker_error) {
 		for (cmd = commands; cmd; cmd = cmd->next)
-			cmd->error_string = "n/a (unpacker error)";
+			cmd->error_string = "unpacker error";
 		return;
 	}
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 35ec294..69ee13c 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -89,7 +89,7 @@ To dst
 
 cat >exp <<EOF
 To dst
-!	refs/heads/master:refs/heads/test	[remote rejected] (n/a (unpacker error))
+!	refs/heads/master:refs/heads/test	[remote rejected] (unpacker error)
 EOF
 
 test_expect_success 'push with receive.fsckobjects' '
-- 
1.7.11.7.15.g085c6bd
