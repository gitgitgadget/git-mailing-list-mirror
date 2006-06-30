From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] consider previous pack undeltified object state only when
 reusing delta data
Date: Thu, 29 Jun 2006 23:44:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606292335190.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
 <20060629195201.GA10786@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
 <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
 <Pine.LNX.4.64.0606291743010.1213@localhost.localdomain>
 <7vwtazobkw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 05:45:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw9wA-00010q-A9
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 05:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWF3Doz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 23:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWF3Doz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 23:44:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33695 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750793AbWF3Doy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 23:44:54 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1N008ZUMES8B20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 23:44:52 -0400 (EDT)
In-reply-to: <7vwtazobkw.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22951>

Without this there would never be a chance to improve packing for 
previously undeltified objects.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

On Thu, 29 Jun 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Thu, 29 Jun 2006, Linus Torvalds wrote:
> >
> >> 
> >> 
> >> On Thu, 29 Jun 2006, Nicolas Pitre wrote:
> >> >
> >> > On Thu, 29 Jun 2006, Linus Torvalds wrote:
> >> > 
> >> > > Instead of having a separate cache, wouldn't it be much better to just 
> >> > > take the hint from the previous pack-file?
> >> > 
> >> > DOH!  ;-)
> >> 
> >> Btw, I think this could do with a flag to turn it on/off (but probably 
> >> default to on).
> >
> > I think it should simply be coupled with the --no-reuse-delta flag.
> 
> I agree that makes sense.

So here it is.

diff --git a/pack-objects.c b/pack-objects.c
index 6e17676..47da33b 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -989,9 +989,10 @@ static int try_delta(struct unpacked *tr
 
 	/*
 	 * We do not bother to try a delta that we discarded
-	 * on an earlier try.
+	 * on an earlier try, but only when reusing delta data.
 	 */
-	if (trg_entry->in_pack && trg_entry->in_pack == src_entry->in_pack)
+	if (!no_reuse_delta && trg_entry->in_pack &&
+	    trg_entry->in_pack == src_entry->in_pack)
 		return 0;
 
 	/*
