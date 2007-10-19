From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:17:37 -0400
Message-ID: <20071019031737.GD14735@spearce.org>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <alpine.LFD.0.9999.0710182247130.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiN7-0007J1-Ah
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbXJSDRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbXJSDRu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:17:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44559 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298AbXJSDRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:17:49 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiiMZ-0001hS-0p; Thu, 18 Oct 2007 23:17:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1444620FBAE; Thu, 18 Oct 2007 23:17:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182247130.19446@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61626>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 18 Oct 2007, Shawn O. Pearce wrote:
> 
> > I really don't have an opinion either way.  Actually I think the
> > entire progress system of git-pack-objects should be reduced even
> > further so that users aren't exposed to the internal phases we
> > are going through.  Most of them just don't care.  They just
> > want to know when its going to be done[*1*].
> 
> Well, with my latest patches in that area, the typical progress on 
> screen has been cut in half.  And the different phases are intertaining.

Yup.  Your patches were a big improvement.  But I'm now sitting here
wondering if we shouldn't just allow a progress meter to overwrite
the prior one.  Then you only see the current task and progress,
or the final output if we have nothing further to say about that.

Hmmph.  Maybe something like this:

I like how it comes out in the end, but it really screws with the
sideband protocol.  Like horribly.  I got a whole ton of "remote:
remote: remote: remote: remote: remote:" during a remote clone.

diff --git a/progress.c b/progress.c
index 7629e05..099fc14 100644
--- a/progress.c
+++ b/progress.c
@@ -37,8 +37,6 @@ static void clear_progress_signal(void)
 
 static int display(struct progress *progress, unsigned n, int done)
 {
-	char *eol;
-
 	if (progress->delay) {
 		if (!progress_update || --progress->delay)
 			return 0;
@@ -55,18 +53,26 @@ static int display(struct progress *progress, unsigned n, int done)
 	}
 
 	progress->last_value = n;
-	eol = done ? ", done.   \n" : "   \r";
-	if (progress->total) {
+	if (done) {
+		size_t c = strlen(progress->title);
+		while (c--)
+			fputc(' ', stderr);
+		fputs("            ", stderr);
+		for (; n > 0; n /= 10)
+			fputs("  ", stderr);
+		fputc('\r', stderr);
+		return 1;
+	} else if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
 			fprintf(stderr, "%s: %3u%% (%u/%u)%s", progress->title,
-				percent, n, progress->total, eol);
+				percent, n, progress->total, "   \r");
 			progress_update = 0;
 			return 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s: %u%s", progress->title, n, eol);
+		fprintf(stderr, "%s: %u%s", progress->title, n, "   \r");
 		progress_update = 0;
 		return 1;
 	}

-- 
Shawn.
