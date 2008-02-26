From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
	threads for packing
Date: Tue, 26 Feb 2008 04:33:01 -0500
Message-ID: <20080226093300.GA5812@coredump.intra.peff.net>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil> <20080226074933.GA3485@coredump.intra.peff.net> <7vhcfwb116.fsf@gitster.siamese.dyndns.org> <20080226080634.GA4129@coredump.intra.peff.net> <7vablo848d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 10:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTwC0-0006UM-PK
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 10:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbYBZJdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 04:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbYBZJdH
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 04:33:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2412 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbYBZJdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 04:33:05 -0500
Received: (qmail 24458 invoked by uid 111); 26 Feb 2008 09:33:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Feb 2008 04:33:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2008 04:33:01 -0500
Content-Disposition: inline
In-Reply-To: <7vablo848d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75116>

On Tue, Feb 26, 2008 at 01:19:14AM -0800, Junio C Hamano wrote:

> But now you mention it, I tend to agree with you.  This is
> primarily of interest for git developers and I do not think the
> end users would care.  Maybe under --verbose or --debug option
> (but I do not think we have --debug option anywhere).

I wrote up a --verbose patch, but it just seemed silly. Who would
actually turn it on?

How about this instead?

-- >8 --
pack-objects: show "using N threads" only when autodetected

Every other case is uninteresting, since either:
  - it is the default of 1, in which case we are always just
    printing "using 1 thread"
  - it is whatever the user set it to, in which case they
    already know

But with --threads=0, they might want to be informed of the
number of CPUs detected.
---
If we ever change the default to autodetect, this logic might change,
but we can deal with that then.

BTW, I seem to remember some work recently on coalescing hunks in merge
conflicts separated by a small number of lines. It seems to me that the
diff below would be easier to read with a similar tactic.

 builtin-pack-objects.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b70b2e5..516eb24 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2236,11 +2236,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		die("--thin cannot be used to build an indexable pack.");
 
 #ifdef THREADED_DELTA_SEARCH
-	if (!delta_search_threads)	/* --threads=0 means autodetect */
+	if (!delta_search_threads) {	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
-	if (progress)
-		fprintf(stderr, "Using %d pack threads.\n",
-			delta_search_threads);
+		if (progress)
+			fprintf(stderr, "Using %d pack threads.\n",
+					delta_search_threads);
+	}
 #endif
 
 	prepare_packed_git();
-- 
1.5.4.3.340.gda2e.dirty
