From: Jeff King <peff@peff.net>
Subject: Re: how to suppress progress percentage in git-push
Date: Mon, 23 Nov 2009 22:07:42 -0500
Message-ID: <20091124030742.GA32029@coredump.intra.peff.net>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <alpine.LFD.2.00.0911231043310.2059@xanadu.home>
 <20091124011339.GA18003@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 04:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCll0-0005fc-FN
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 04:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757844AbZKXDHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 22:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757838AbZKXDHi
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 22:07:38 -0500
Received: from peff.net ([208.65.91.99]:34965 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757817AbZKXDHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 22:07:38 -0500
Received: (qmail 6612 invoked by uid 107); 24 Nov 2009 03:12:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Nov 2009 22:12:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2009 22:07:42 -0500
Content-Disposition: inline
In-Reply-To: <20091124011339.GA18003@debian.b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133557>

On Tue, Nov 24, 2009 at 09:13:39AM +0800, bill lam wrote:

> On Mon, 23 Nov 2009, Nicolas Pitre wrote:
> > Then, during the pack-objects process, there are 3 phases: counting 
> > objects, compressing objects, and writing objects.  However in the fetch 
> 
> during git-gc it shows yet another progress 
> 
> Removing duplicate objects: 100% (256/256), done.

Thanks, this doesn't seem to have been guarded at all (but since it is
on a 2-second delay, you have to have quite a lot of loose objects or a
slow disk to trigger it).

We should apply the patch below to keep things consistent.

I also checked every other call to start_progress; everything else seems
to be guarded. Most of them were easy to trace to an isatty check,
though the one in unpack-trees is influenced by o->verbose_update. That
in turn usually corresponds to a quiet option, though merge does seem to
use it unconditionally. Maybe that should be tweaked, too?

-- >8 --
Subject: [PATCH] prune-packed: only show progress when stderr is a tty

This matches the behavior of other git programs, and helps
keep cruft out of things like cron job output.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-prune-packed.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index be99eb0..f9463de 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -71,7 +71,7 @@ void prune_packed_objects(int opts)
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int opts = VERBOSE;
+	int opts = isatty(2) ? VERBOSE : 0;
 	const struct option prune_packed_options[] = {
 		OPT_BIT('n', "dry-run", &opts, "dry run", DRY_RUN),
 		OPT_NEGBIT('q', "quiet", &opts, "be quiet", VERBOSE),
-- 
1.6.6.rc0.249.g9b4cf.dirty
