From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] History replay support
Date: Fri, 2 Nov 2007 18:40:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> 
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> 
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> 
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 02:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io7zw-0003Pa-TG
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 02:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbXKCBkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 21:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbXKCBkK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 21:40:10 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42623 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641AbXKCBkI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 21:40:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA31e3es011083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 18:40:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA31e25A020535;
	Fri, 2 Nov 2007 18:40:02 -0700
In-Reply-To: <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.231 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63198>



On Fri, 2 Nov 2007, Linus Torvalds wrote:
> 
> The bad news is that it doesn't work well in this simplistic form, because 
> there is a O(n**2) behaviour when replays *do* happen, ie we end up having 
> replays within replays [..]

Gaah. the more I look at this, the more I think the topo sort should be 
done at the visualization side.

It's really quite cheap to do the topo sort, *and* it's really quite cheap 
to do the tests that trigger the topo sort, but what's expensive is to 
re-output all the data again!

The silly thing is, I think I've come up with an "almost optimal" 
solution, but it's so ugly that I'm a bit ashamed of it.

That almost optimal solution is simply:
 - get the first <n> (say: 100) commits, and topo-sort just them. Feed it 
   to the visualizer.
 - the visualizer will now have enough to work with in order to show the 
   starting screen and set the cursor to the hourglass or whatever the 
   "wait for it" thing is.
 - get the rest of the commits at our normal leisurely pace (whether it 
   is one second of 17).
 - output the total number of commits (so that the visualizer can re-size 
   the slider and/or allocate some big array just once), topo-sort it all, 
   and output the full thing.

It's disgusting. But it avoids the unnecessary data transfer - except for 
just the first 100 commits that get sent twice. And it gets what *I* look 
for, namely that "immediate" feel to the initial pop-up of the history.

			Linus
