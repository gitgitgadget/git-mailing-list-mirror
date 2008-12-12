From: Jeff King <peff@peff.net>
Subject: Re: git log --numstat disagrees with git apply --numstat
Date: Thu, 11 Dec 2008 21:08:58 -0500
Message-ID: <20081212020857.GB23128@sigill.intra.peff.net>
References: <20081211235337.GK32487@spearce.org> <20081212015254.GA23128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAxUO-0004r6-BD
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022AbYLLCJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756955AbYLLCJE
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:09:04 -0500
Received: from peff.net ([208.65.91.99]:3228 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758101AbYLLCJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:09:03 -0500
Received: (qmail 31430 invoked by uid 111); 12 Dec 2008 02:09:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 11 Dec 2008 21:09:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2008 21:08:58 -0500
Content-Disposition: inline
In-Reply-To: <20081212015254.GA23128@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102860>

On Thu, Dec 11, 2008 at 08:52:55PM -0500, Jeff King wrote:

> It looks like it is just a place where two different valid diffs can be
> constructed:
> [...]
> which is probably just due to different xdi settings being used between
> the two codepaths. I haven't looked closely to see which different
> options we are feeding to xdiff.

Ah. Doing this gives me the 68/12 answer for "git log --numstat":

diff --git a/diff.c b/diff.c
index af822c1..5f314ce 100644
--- a/diff.c
+++ b/diff.c
@@ -1539,6 +1539,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
+		xecfg.ctxlen = o->context;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
 			      &xpp, &xecfg, &ecb);

I guess it is slightly less efficient (since we just throw away the
context lines anyway), but it is nice to count the exact same patch
that "git log -p" would produce.

-Peff
