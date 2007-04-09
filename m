From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 09 Apr 2007 19:22:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091905291.28181@xanadu.home>
References: <46197950.3080804@gmail.com>
 <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704082012220.28181@xanadu.home>
 <20070409173858.GT5436@spearce.org>
 <alpine.LFD.0.98.0704091404530.28181@xanadu.home>
 <20070409184039.GZ5436@spearce.org>
 <56b7f5510704091211i3d101cafq371fbb96ca27238b@mail.gmail.com>
 <alpine.LFD.0.98.0704091525260.28181@xanadu.home>
 <56b7f5510704091438v4d42a7efq9b241bdc31affd08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 05:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb3CE-0004La-17
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 01:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbXDIXWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 19:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbXDIXWc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 19:22:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63916 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbXDIXWb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 19:22:31 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG900BU77LIJ620@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 19:22:31 -0400 (EDT)
In-reply-to: <56b7f5510704091438v4d42a7efq9b241bdc31affd08@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44100>

On Mon, 9 Apr 2007, Dana How wrote:

> On 4/9/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 9 Apr 2007, Dana How wrote:
> > > Wouldn't the following address the "object count unknown
> > > at the start of sequential pack writing" problem:
> > >  Write 0 for object count in the header. This is a flag to look for
> > >  another header of same format just before the final SHA-1 which
> > >  has the correct count. The SHA-1 is still a checksum of everything
> > >  before it and no seeking/rewriting is needed on generation.
> > 
> > No.  You really wants to know up front how many objects a pack contains
> > when streaming it.  And this is not only for packs written to stdout.
> OK, let me ask a dumb question and flog one last additional obvious idea.
> 
> Does your wanting to know stem from more than wanting
> to stick to one malloc of all the object info at once?

That, plus progress reporting when fetching.  And progress reporting is 
probably the most important thing for the user experience.

> My suggestion quoted above is actually a change to the .pack format.
> With all the other ideas for .pack format changes floating around,
> let me withdraw that and suggest a simpler one: write a "0" in the header,
> and terminate the pack with a sentinel in object format before the final
> SHA-1s.
> The sentinel would be type=OBJ_NONE/length=0, i.e. a null byte.
> "Not much" would need to be updated to tolerate it and
> you could count objects while looking for it (if header has 0)
> during normal processing.  (I'm reacting to your word "streaming".)

When streaming you really want to know up front how much to expect / 
wait for.

> BTW,  I've caught up on reading the mailing list archives,
> but I don't recall seeing any overview of the objectives of pack v2/v3/v4.
> Does that exist any where? I didn't see it in Documentation or
> Documentation/technical. It would probably reduce uninformed
> questions like the above.  I've deduced rationales for what
> miscellaneous details I have seen,
> except moving the SHA-1s from .idx to .pack (?).

I'm sure this exists in the archive as I recall sending a summary about 
that a while ago.

In short:

 - Pack v1 was the initial implementation from Linus.  It had some flaws
   and didn't exist for more than 2 or 3 days.  It was never used in any 
   official release.

 - Pack v2 is what GIT still produces today.

 - Pack v3 was created when a bit in the delta encoding was redefined.
   See commit d60fc1c8649f8 for the details.  Because it caused too much
   compatibility issues when we attempted to enable pack v3 at the time, 
   we reverted pack generation to v2.

 - Pack v4 has a much larger scope.  This is the WIP from Shawn Pearce 
   and I and I know for sure Shawn already posted a detailed design 
   overview to the list already.


Nicolas
