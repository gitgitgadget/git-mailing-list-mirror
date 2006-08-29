From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 10:40:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608291024470.2598@xanadu.home>
References: <20060829134233.GA21335@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 16:42:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI4mA-00080Q-Hn
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 16:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWH2Okw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 10:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWH2Okw
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 10:40:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:3759 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965001AbWH2Okw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 10:40:52 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4R00G01KS2SHE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 Aug 2006 10:40:51 -0400 (EDT)
In-reply-to: <20060829134233.GA21335@spearce.org>
X-X-Sender: nico@xanadu.home
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26206>

On Tue, 29 Aug 2006, Shawn Pearce wrote:

> Sorry but this really is a pretty stupid question on my part:
> 
> In builtin-pack-objects.c write_one(), why is the base object written
> behind the first delta that depends on it (if it hasn't been written
> already) rather than BEFORE the first delta that depends on it?

Most of the time the base object will have been written already since we 
favor backward deltas, and newer objects are written first.  But that 
might not always be the case.

> If the base always had to appear before any delta that uses it then
> unpack-objects wouldn't need to cache a delta in memory waiting
> for the base to get unpacked.

Like mentioned above this is not the common case.  And deltas are small 
anyway.  And when you think about it the delta and base objects have to 
be both in memory so this doesn't change anything in the end.  So in 
practice there is no really special caching.

> >From a data locality perspective putting the base object before
> or after the delta shouldn't matter, as either way the delta
> is useless without the base.  So placing the base immediately
> before the delta should perform just as well as placing it after.
> Either way the OS should have the base in cache by the time the
> delta is being accessed.

Not necessarily.  In fact if you checkout a particular revision with 
such a case, putting the base first will force a seek over it since what 
is referenced first is the delta, then seek back to the base.  If it is 
right after the delta then there is no need to seek back and some read 
ahead might have picked the base by the time it is referenced.  OK since 
all this is mmap()'ed there might not be much difference in practice, 
but in theory the current arrangement could have a slight advantage.

> In other words, why not apply this patch and make it a requirement
> of the pack file format?

I don't think this should be a requirement.


Nicolas
