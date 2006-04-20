From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 14:31:05 -0700
Message-ID: <7vodywvsrq.fsf@assigned-by-dhcp.cox.net>
References: <20060420133640.GA31198@spearce.org>
	<Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
	<20060420150315.GB31198@spearce.org>
	<Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
	<20060420164351.GB31738@spearce.org>
	<Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
	<20060420173131.GF31738@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 23:31:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWgk3-0005dU-90
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 23:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWDTVbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 17:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWDTVbI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 17:31:08 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:27314 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751330AbWDTVbH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 17:31:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420213106.IQEY8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 17:31:06 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18999>

Shawn Pearce <spearce@spearce.org> writes:

> I just spent some time bisecting this issue and it looks like the
> following change by Junio may be the culprit:
>
>   commit 1d6b38cc76c348e2477506ca9759fc241e3d0d46
>   Author: Junio C Hamano <junkio@cox.net>
>   Date:   Wed Feb 22 22:10:24 2006 -0800
>   
>       pack-objects: use full pathname to help hashing with "thin" pack.
>       
>       This uses the same hashing algorithm to the "preferred base
>       tree" objects and the incoming pathnames, to group the same
>       files from different revs together, while spreading files with
>       the same basename in different directories.
>       
>       Signed-off-by: Junio C Hamano <junkio@cox.net>
>   

Unfortunately, that is not the same hash we use in v1.3.0, so we
need to look elsewhere for interactions.

v1.2.3 hash was base-name only.  doc/Makefile and t/Makefile
were thrown in the same bin and sorted by size.  When the
history you are packing is deep, and doc/Makefile and t/Makefile
are not related at all, this made effective size of delta window
1/N where N is the number of such duplicates.

The one you found above uses a hash that is fully full-path.
The two are in completely different bins, and bins are totally
random.  This was not a good strategy.

v1.3.0 hash is base-name hash concatenated with leading-path
has.  t/Makefile and doc/Makefile go in separate bins, but the
bins are close to each other; this avoids the problem in v1.2.3
when you have deep history, but at the same time if you do not
have many many versions of t/Makefile to overflow the delta
window, it gives t/Makefile a chance to delta with doc/Makefile.

The earlier observation by Linus on reverting eeef7135 is
consistent with it; that commit was the one that introduced
v1.3.0 hash.

You could try this patch to resurrect the hash used in v1.2.3,
and you may get better packing for your particular repository;
but I am not sure if it gives better results in the general
case.  I am running the test myself now while waiting for my
day-job database to load X-<.

NOTE NOTE NOTE.  The hash in v1.2.3 was done with the basename
(relying on rev-list --objects to only show the basename) and
hashed from front to back.  The current one uses the same hash
scrambling function, but it hashes from back to front, and it
knows rev-list --objects gives it a full path.

What this patch does is to stop the hashing after we are done
with the basename part.  So it still gives different hash value
to the same path from v1.2.3 version, but the distribution
should be equivalent.

NOTE 2.  Feeding output from the current "rev-list --objects" to
v1.2.3 pack-object is the same as "hash full path and spread
things out" intermediate version, which is the worst performer.

-- >8 --
git diff
diff --git a/pack-objects.c b/pack-objects.c
index 09f4f2c..e58e169 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -492,6 +492,8 @@ static unsigned name_hash(struct name_pa
 		name_hash = hash;
 		hash = 0;
 	}
+	return name_hash;
+
 	for (p = path; p; p = p->up) {
 		hash = hash * 11 + '/';
 		n = p->elem + p->len;
