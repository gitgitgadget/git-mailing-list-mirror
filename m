From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
 threads for packing
Date: Tue, 26 Feb 2008 12:05:46 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802261149220.3167@xanadu.home>
References: <47B1BEC6.6080906@nrlssc.navy.mil>
 <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil>
 <47BF812A.4020205@nrlssc.navy.mil>
 <20080226074933.GA3485@coredump.intra.peff.net>
 <47C435DC.2070508@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 26 18:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU3GL-00087X-00
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 18:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761723AbYBZRGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761113AbYBZRGB
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 12:06:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51314 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758801AbYBZRGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 12:06:00 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWU00JHIVHMG250@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Feb 2008 12:05:47 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <47C435DC.2070508@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75152>

On Tue, 26 Feb 2008, Brandon Casey wrote:

> Jeff King wrote:
> > On Fri, Feb 22, 2008 at 08:12:58PM -0600, Brandon Casey wrote:
> > 
> >> +	if (progress)
> >> +		fprintf(stderr, "Using %d pack threads.\n",
> >> +			delta_search_threads);
> > 
> > I just noticed that this was in next. Do we really need to display this
> > message? A considerable amount of discussion went into reducing git's
> > chattiness and clutter during push and fetch, and I feel like this is a
> > step backwards (yes, I know most people won't see it if they don't build
> > with THREADED_DELTA_SEARCH).
> > 
> > Can we show it only if threads != 1? Only if we auto-detected the number
> > of threads and it wasn't 1?
> 
> I like the message and thought it was useful especially for non-developers.
> 
> Even if the number of threads was not auto-detected, it is a confirmation
> that the number of threads used is the number of threads configured.
> 
> For example, it seems easy to do this:
> 
> 	git config pack.thread 4
> 	git repack
> 
> The user would immediately know something was wrong when they saw the
> message "Using 1 pack threads" instead of the "4" they thought they
> configured.

Maybe a message for any unrecognized config option should be displayed 
instead.

> Also, since it's only printed in the THREADED_DELTA_SEARCH
> case, it's also a confirmation that this option was indeed used for a
> particular build of git.
> 
> Mainly, I thought it was a harmless message that other users would "enjoy"
> seeing, but if others disagree, I won't argue. Notice I quoted "enjoy" to
> emphasize it.

This is enjoyable maybe the first time, but that might get 
useless/annoying after a while.  I think that displaying it in the 
autodetection case is a good compromize, and then simply specifying the 
number of threads explicitly will silence it.

Also, I think that such message should absolutely not be sent over in 
the context of a fetch/clone.  This is a local matter only, and should 
be displayed only when those progress messages are meant for the local 
user.

Therefore I propose this patch instead:

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b70b2e5..6dcb4e2 100644
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
+		if (progress > pack_to_stdout)
+			fprintf(stderr, "Using %d pack threads.\n",
+				delta_search_threads);
+	}
 #endif
 
 	prepare_packed_git();
