From: "Bevan Watkiss" <bevan.watkiss@cloakware.com>
Subject: RE:
Date: Thu, 7 May 2009 15:37:59 -0400
Message-ID: <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Alex Riesen'" <raa.lkml@gmail.com>, <git@vger.kernel.org>
To: "'Linus Torvalds'" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 07 21:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29TI-0000sQ-9J
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbZEGTlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbZEGTlT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:41:19 -0400
Received: from mail.cloakware.com ([142.46.212.116]:52484 "EHLO
	mail.cloakware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbZEGTlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:41:19 -0400
Received: from caottdt504 (bwatkiss-desk.cloakware.com [172.20.201.170])
	(authenticated bits=0)
	by mail.cloakware.com (8.13.1/8.13.1) with ESMTP id n47JedPs001253;
	Thu, 7 May 2009 15:40:39 -0400
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Thread-Index: AcnPRcwPISoSB2SKQxi+V+XonmKnVgAAnW/Q
In-Reply-To: <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118510>

Looking at the trace it does appear that most of this is the lstat.  It's
the problem of having many tiny files on a network drive, and trying to use
git for something it's not meant.

The log has 265430 lines of lstat and 10887 other lines.  If you still want
the log file I'll strip out the directory names and send it off.

It would be nice to have an option that you can pull only the files that
changed in the changesets you are updating and ignore the state of the other
files.

Bevan

-----Original Message-----
From: Linus Torvalds [mailto:torvalds@linux-foundation.org] 
Sent: May 7, 2009 2:56 PM
To: Bevan Watkiss
Cc: 'Alex Riesen'; git@vger.kernel.org
Subject: RE: 



On Thu, 7 May 2009, Bevan Watkiss wrote:
> 
> Basically I have a copy of my tree where only git can write to it, so I
know
> the files are right.  The NAS box I have the tree on is slow, so reading
the
> tree adds about 10 minutes to the process when I only want to update a few
> files.

Ouch.

You could try doing

	[core]
		preloadindex = true

and see if that helps some of your loads. It does limit even the parallel 
tree stat to 20 or so, but if most of your cost is in just doing the 
lstat() over the files to see that they haven't changed, you might be 
getting a factor-of-20 speedup for at least _some_ of what you do.

If you can, it might also be interesting to see system call trace patterns 
(with times!) to see if there is something obviously horribly bad going 
on. If you're running under Linux, and don't think the data contains 
anything very private, send me the output of "strace -f -T" of the most 
problematic operations, and maybe I can see if I can come up with anything 
interesting.

I have long refused to use networked filesystems because I used to find 
them -so- painful when working with CVS, so none of my performance work 
has ever really directly concentrated on long-latency filesystems. Even 
the index preload was all done "blind" with other people reporting issues 
(and happily I could see some of the effects with local filesystems and 
multiple CPU's ;).

			Linus
	
