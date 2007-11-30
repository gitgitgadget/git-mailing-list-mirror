From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git performance measurements..
Date: Thu, 29 Nov 2007 18:54:01 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711291836230.8458@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711282244190.9605@xanadu.home> <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home> <finmvm$da8$1@ger.gmane.org> <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixw1W-0001t5-TR
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763987AbXK3CyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763972AbXK3CyS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:54:18 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43326 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755898AbXK3CyS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 21:54:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU2s4cq027128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 18:54:05 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU2s1UF020143;
	Thu, 29 Nov 2007 18:54:04 -0800
In-Reply-To: <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.728 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66610>



On Thu, 29 Nov 2007, Linus Torvalds wrote:
> 
> Something like the appended (untested!

Ok, tested now. It does seem to work. The page fault trace for the 
pack-file shows that we now get basically perfect IO patterns for my "git 
checkout" testcase, and while I'm not sure that's necessarily a test-case 
that really deserves this kind of attention, it's certainly potentially 
interesting.

To check the performance impact of this, though, you'd need to pack the 
same repository two different ways - with this kind of sorting change and 
without - and then test different cold-cache timings for things like "git 
blame" etc that might care.

The timing of the commands itself could be done with either a pre-change 
or post-change version of git, it's only the resulting order in the 
pack-file that matters.

My very unscientific tests says that "git read-tree" is speed up by the 
change (from 5.2s to 3.3s, so it's quite noticeable), but "git blame" 
slows down (from 8.7s to 12.9s, so that's quite noticeable too). But as 
Jakub pointed out, the cold-cache numbers do fluctuate a lot, and while 
they were reasonably stable over runs, the "git blame" numbers in 
particular probably depend a fair amount on whether the file is commonly 
changed or not.

Anybody interested in trying to do something more scientific?

			Linus
