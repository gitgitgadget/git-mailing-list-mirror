From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 23:00:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703172228220.18328@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 04:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSldK-0002c4-8c
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 04:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbXCRDAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 23:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbXCRDAN
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 23:00:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46360 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbXCRDAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 23:00:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF20045AWCA0QC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 17 Mar 2007 23:00:11 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42471>

On Sat, 17 Mar 2007, Linus Torvalds wrote:

> 
> 
> On Sat, 17 Mar 2007, Nicolas Pitre wrote:
> > 
> > Well... in my opinion it is the _current_ tree walker that is quite ugly 
> > and complex.  It is always messier to parse strings than fixed width 
> > binary fields.
> 
> Sure. On the other hand, text is what made things easy to do initially,

Oh indeed.  No argument there.

> and you're missing one *BIG* clue: you cannot remote the support without 
> losing compatibility with all traditional object formats.
> 
> So you have no choice. You need to support the text representation. As a 
> result, *your* code will now be way more ugly and messy.

Depends. We currently have separate parsers for trees, commits, tags, 
etc.  That should be easy enough to add another (separate) parser for 
new tree objects while still having a common higher level accessor 
interface like tree_entry().

But right now we only regenerate the text representation whenever the 
binary representation is encountered just to make things easy to do, and 
yet we still have a performance gain already in _addition_ to a net 
saving in disk footprint.

> The thing is, parsing some little text may sound expensive, but if the 
> expense is in finding the end of the string, we're doing really well.

Of course the current tree parser will remain, probably forever.  And it 
is always a good thing to optimize it further when ever possible.

> But what you're ignoring here is that "16%" may sound like a huge deal, 
> but it's 16% of somethng that takes 1 second, and that other SCM's cannot 
> do AT ALL.

Sure.  But at this point the reference to compare GIT performance 
against might be GIT itself.  And while 1 second is really nice in this 
case, there are some repos where it could be (and has already been 
reported to be) much more.

I still have a feeling that we can do even better than we do now.  Much 
much better than 16% actually.  But that require a new data format that 
is designed for speed.

We'll see.


Nicolas
