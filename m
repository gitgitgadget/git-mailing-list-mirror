From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Tue, 7 Aug 2012 01:32:25 -0400
Message-ID: <20120807053225.GA1541@sigill.intra.peff.net>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
 <1344315709-15897-1-git-send-email-drafnel@gmail.com>
 <1344315709-15897-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 07:32:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SycPB-0003Gh-RL
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 07:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab2HGFc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 01:32:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54156 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab2HGFc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 01:32:28 -0400
Received: (qmail 24731 invoked by uid 107); 7 Aug 2012 05:32:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 01:32:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 01:32:25 -0400
Content-Disposition: inline
In-Reply-To: <1344315709-15897-2-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203015>

On Mon, Aug 06, 2012 at 10:01:49PM -0700, Brandon Casey wrote:

> This informational message can cause a problem if 'git prune' is spawned
> from an auto-gc during receive-pack.  In this case, the informational
> message will be sent back over the wire to the git client and the client
> will try to interpret it as part of the pack protocol and will produce an
> error.
> 
> So let's refrain from producing this message unless show_only or verbose
> is enabled.

This seems like a band-aid. The real problem is that auto-gc can
interfere with the pack protocol, which it should not be allowed to do,
no matter what it produces.

We could fix that root cause with this patch (on top of your 1/2):

-- >8 --
Subject: [PATCH] receive-pack: redirect auto-gc stdout to stderr

In some cases, git-gc may produce informational messages to
stdout, rather than stderr. This is bad for receive-pack,
because its stdout (and therefore that of its child) is
connected to a git client and speaking pack protocol.
Instead, let's redirect these messages to stderr to avoid
interference and let the client see them.

Signed-off-by: Jeff King <peff@peff.net>
---
We already do the same thing for all of the hooks we run. With this
change, all sub-processes have their stdout redirected (either to a
pipe, or to stderr) except git-unpack-objects.

Looking at unpack-objects, it should not write anything to stdout under
normal circumstances. However, if it is fed more bytes than the
pack data claims (e.g., extra entries beyond what the header claims), it
will send them to stdout. I've never heard of that happening, but
probably it should go to /dev/null, and/or flag an error.

 builtin/receive-pack.c | 3 ++-
 t/t5400-send-pack.sh   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0afb8b2..e0b9f2e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -977,7 +977,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			const char *argv_gc_auto[] = {
 				"gc", "--auto", "--quiet", NULL,
 			};
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+			run_command_v_opt(argv_gc_auto,
+					  RUN_GIT_CMD | RUN_COMMAND_STDOUT_TO_STDERR);
 		}
 		if (auto_update_server_info)
 			update_server_info(0);
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 04a8791..250c720 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -145,7 +145,7 @@ test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	)
 '
 
-test_expect_failure 'receive-pack runs auto-gc in remote repo' '
+test_expect_success 'receive-pack runs auto-gc in remote repo' '
 	rm -rf parent child &&
 	git init parent &&
 	(
-- 
1.7.12.rc1.12.g6d3a2d7
