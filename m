From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 10:24:32 -0700
Message-ID: <7vk69kyxbj.fsf@assigned-by-dhcp.cox.net>
References: <20060420133640.GA31198@spearce.org>
	<Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
	<20060420150315.GB31198@spearce.org>
	<Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
	<20060420164351.GB31738@spearce.org>
	<Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 19:24:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWctU-00029W-GH
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 19:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWDTRYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 13:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWDTRYe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 13:24:34 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61385 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751177AbWDTRYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 13:24:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420172433.DVAX8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 13:24:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 20 Apr 2006 10:03:31 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18981>

Linus Torvalds <torvalds@osdl.org> writes:

> You can try "--depth=50" (slogan: more "hot delta on delta action"), but 
> it's looking less and less like a delta selection issue, and more and more 
> like the deltas themselves are deproved.

I do not think I have time to look into this today until late
night, but one thing I noticed is that trying to delta more
things sometimes tend to produce bigger result X-<.  

At the end of pack-objects.c::find_deltas(), there is a code
that is commented out, which is remnant from a failed
experiment.  What it tried to do was to avoid placing an object
whose delta depth is already window-size back into the
candidates list, which means the next object gets compared with
one object more than otherwise would be (the extra one being the
oldest one in the window -- which might not produce better delta
than the maxed out one, but the delta with the maxed out one
would not be used anyway).  The result was noticeably worse
overall packsize with more deltified objects.

We might be better off favoring compressed undeltified
representation over deltified representation a bit more
aggressively.  Currently we allow delta as big as half the
uncompressed size minus 20-byte overhead or something like that;
tweaking that limit might show improvements.
