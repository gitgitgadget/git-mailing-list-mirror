From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Tue, 12 Feb 2008 14:25:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121412520.2920@woody.linux-foundation.org>
References: <200802081828.43849.kendy@suse.cz>  <m3ejbngtnn.fsf@localhost.localdomain>  <200802091627.25913.kendy@suse.cz>  <alpine.LFD.1.00.0802092200350.2732@xanadu.home>  <alpine.LSU.1.00.0802101640570.11591@racer.site>  <alpine.LSU.1.00.0802101845320.11591@racer.site>
  <alpine.LSU.1.00.0802122036150.3870@racer.site>  <alpine.LFD.1.00.0802121303450.2920@woody.linux-foundation.org> <9e4733910802121336x42055baawf2b8f3714e2a1eb4@mail.gmail.com> <alpine.LFD.1.00.0802121356330.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP3aa-0003C6-Jy
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 23:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbYBLW0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 17:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYBLW0R
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 17:26:17 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47822 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638AbYBLW0Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 17:26:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CMPMPE012783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 14:25:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CMPKK2025560;
	Tue, 12 Feb 2008 14:25:20 -0800
In-Reply-To: <alpine.LFD.1.00.0802121356330.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.741 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73704>



On Tue, 12 Feb 2008, Linus Torvalds wrote:
>
>  (b) we compare each object to the "window-1" preceding objects, which is 
>      how I got the O(windowsize^2) 

That's not really true, of course. But my (broken and inexact) logic is 
that we get one cost multiplier from the number of objects, and one from 
the size of the objects.

So *if* we have the situation of not limiting the window size, we 
basically have a big slowdown from raising the window in number of 
objects: not only do we get a slowdown from comparing more objects, we 
spend relatively more time comparing the *large* ones to begin with and 
having more of them just makes it even more skewed - when we hit a series 
of big blocks, the window will also contain more big blocks, so it kind of 
a double whammy.

But I don't think calling it O(windowsize^2) is really correct. It's still 
O(windowsize), it's just that the purely "number-of-object" thing doesn't 
account for big objects being much more expensive to diff. So you really 
want to make the *memory* limiter the big one, because that's the one that 
actually approximates how much time you end up spending.

So ignore that O(n^2) blather. It's not correct. What _is_ correct is that 
we want to aggressively limit memory size, because CPU cost goes up 
linearly not just with number of objects, but also super-linearly with 
size of the object ("super-linear" due to bad cache behavior and in worst 
case due to paging).

			Linus
