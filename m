From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Make git-fetch follow tags we already have objects for sooner
Date: Fri, 29 Feb 2008 23:25:10 -0500
Message-ID: <20080301042510.GW8410@spearce.org>
References: <20080228084257.GC16870@spearce.org> <7v3arcduil.fsf@gitster.siamese.dyndns.org> <20080229223431.GT8410@spearce.org> <alpine.LNX.1.00.0802291736580.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 05:26:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVJIi-0002TU-0K
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 05:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbYCAEZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 23:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYCAEZQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 23:25:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33915 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYCAEZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 23:25:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVJHP-0004PG-8l; Fri, 29 Feb 2008 23:24:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 439D520FBAE; Fri, 29 Feb 2008 23:25:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0802291736580.19665@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75606>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 29 Feb 2008, Shawn O. Pearce wrote:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > This is cute.  Obviously some tests need to be adjusted for this
> > > change, though.
> > 
> > I'll take a look at the current tests this weekend and see what
> > needs to be adjusted, if anything.  I'd also like to get a few
> > tests written for this, so we are certain the optimizations are
> > kicking in when they are supposed to be.
> 
> I'd be really grateful if you came up with a good general strategy for 
> testing that we're not doing too much work in fetching, because clone has 
> optimizations that I need to test in a similar way, and I haven't been 
> able to think of anything not horribly intrusive.

Is this "horribly intrusive" ?

We can test it with something like this:

  $ GIT_DEBUG_SEND_PACK=1 git fetch 3>UPLOAD_LOG
  $ cat UPLOAD_LOG
  #S
  want 8e10cf4e007ad7e003463c30c34b1050b039db78 multi_ack side-band-64k thin-pack ofs-delta
  want ddfa4a33562179aca1ace2bcc662244a17d0b503
  #E
  #S
  want 3253df4d1cf6fb138b52b1938473bcfec1483223 multi_ack side-band-64k thin-pack ofs-delta
  #E

Notice we made two connections, wanting 2 things and then later
only wanting 1 thing.  Tag auto-following.  :-)

diff --git a/upload-pack.c b/upload-pack.c
index b26d053..4e14020 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -444,7 +444,10 @@ static void receive_needs(void)
 	struct object_array shallows = {0, 0, NULL};
 	static char line[1000];
 	int len, depth = 0;
+	int debug_needs = !!getenv("GIT_DEBUG_SEND_PACK");
 
+	if (debug_needs)
+		write_in_full(3, "#S\n", 3);
 	for (;;) {
 		struct object *o;
 		unsigned char sha1_buf[20];
@@ -452,6 +455,8 @@ static void receive_needs(void)
 		reset_timeout();
 		if (!len)
 			break;
+		if (debug_needs)
+			write_in_full(3, line, len);
 
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
@@ -507,6 +512,8 @@ static void receive_needs(void)
 			add_object_array(o, NULL, &want_obj);
 		}
 	}
+	if (debug_needs)
+		write_in_full(3, "#E\n", 3);
 	if (depth == 0 && shallows.nr == 0)
 		return;
 	if (depth > 0) {

-- 
Shawn.
