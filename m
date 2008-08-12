From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFC: Allow missing objects during packing
Date: Tue, 12 Aug 2008 00:44:11 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808120023250.22892@xanadu.home>
References: <20080811182839.GJ26363@spearce.org>
 <7vk5enuqfg.fsf@gitster.siamese.dyndns.org>
 <20080811224404.GQ26363@spearce.org> <20080812012859.GT26363@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 06:52:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSlrZ-0000SW-Ft
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 06:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbYHLEoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 00:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbYHLEoR
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 00:44:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63069 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYHLEoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 00:44:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5H00COK15N0YH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Aug 2008 00:44:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080812012859.GT26363@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92066>

On Mon, 11 Aug 2008, Shawn O. Pearce wrote:

> > Junio C Hamano <gitster@pobox.com> wrote:
> > > If the check is only about a thin delta base that is not going to be
> > > transmit, I'd agree.  But I do not see how you are distinguishing that
> > > case and the case where an object you are actually sending is missing (in
> > > which case we would want to error out, wouldn't we?)
> 
> Turns out to be pretty simple I think.  We just delay the
> error handling for ->type < 0 until write_object().  If we
> get this far we know we wanted to include the object but
> we really don't have it.  Up until that point its fine
> for us to get objects which are missing, we'll just wind
> up with a suboptimal pack.

If you're going to die anyway due to an object with unknown type, better 
do so _before_ going through the delta search phase and leaving a 
partial pack behind.  IOW, the type check can be performed in 
prepare_pack() instead of write_object() like:

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2dadec1..01ab49c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1722,8 +1733,12 @@ static void prepare_pack(int window, int depth)
 		if (entry->no_try_delta)
 			continue;
 
-		if (!entry->preferred_base)
+		if (!entry->preferred_base) {
 			nr_deltas++;
+			if (entry->type < 0)
+				die("unable to get type of object %s",
+				    sha1_to_hex(entry->idx.sha1));
+		}
 
 		delta_list[n++] = entry;
 	}

Also a comment in check_object() mentioning where the return value of 
sha1_object_info() is verified would be in order.

And I also agree with Junio about a test script for this so the usage is 
fully demonstrated, and to ensure it keeps on working as intended 
(most people will simply never exercise this otherwise).


Nicolas
