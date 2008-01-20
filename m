From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 14:03:10 -0600
Message-ID: <20080120200310.GK22503@lavos.net>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LFD.1.00.0801200942191.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysgit@googlegroups.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 21:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGgON-00052z-OE
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 21:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373AbYATUDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 15:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755350AbYATUDN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 15:03:13 -0500
Received: from mxsf00.insightbb.com ([74.128.0.70]:37706 "EHLO
	mxsf00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbYATUDM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 15:03:12 -0500
X-IronPort-AV: E=Sophos;i="4.25,224,1199682000"; 
   d="scan'208";a="189733562"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf00.insightbb.com with ESMTP; 20 Jan 2008 15:03:11 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAP83k0dKhvkY/2dsb2JhbACBV6lo
X-IronPort-AV: E=Sophos;i="4.25,224,1199682000"; 
   d="scan'208";a="189378316"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 20 Jan 2008 15:03:11 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id F3CAD309F21; Sun, 20 Jan 2008 14:03:10 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801200942191.2957@woody.linux-foundation.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71186>

On Sun, Jan 20, 2008 at 10:20:46AM -0800, Linus Torvalds wrote:
> But I guess that was a bit optimistic. On Linux, we still had about 50% 
> user time, and I guess the same is _largely_ true on Windows. Cutting the 
> system time in half only gives you about a quarter performance 
> improvement, and I was just incorrect in expecting system calls to be the 
> limiting factor.
> 
> [...]
> 
> fnmatch? It's certainly visible on Linux, I wonder if the Windows/OSX 
> version is more expensive due to trying to be case-insensitive or 
> something?

Windows (msys) Git, with the lstat patch and on my 15433-file test case,
is at least 90-95% system time.  I don't have any good tools for
measuring this, but just using the silly performance monitor you get
with ctrl-alt-del and enabling the "View -> Show Kernel Times" curve on
the graph shows this fact pretty clearly.

I think this shows that:

1. There's not much overhead in msysGit's stat wrapper at all.  It gets
   converted quite efficiently to native Windows calls.

2. Windows really sucks at filesystem ops.  Film at 11.

One thing I dimly recall is that the nightmare interface of
FindFirstFile/FindNextFile (which I assume is what is actually getting
called for opendir/readdir) actually returns some stat information with
each file.  Would it be possible to use that directly in some cases
rather than taking an extra stat call to get it?

-bcd
