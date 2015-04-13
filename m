From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] reduce progress updates in background
Date: Mon, 13 Apr 2015 10:11:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
References: <20150413134850.GC23475@mewburn.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Luke Mewburn <luke@mewburn.net>
X-From: git-owner@vger.kernel.org Mon Apr 13 16:26:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhfJZ-0007rJ-BH
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 16:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbbDMO0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 10:26:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10882 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbbDMO0L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 10:26:11 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2015 10:26:11 EDT
Received: from yoda.home ([66.131.180.142]) by VL-VM-MR007.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0NMR002TN0QMY2E0@VL-VM-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 13 Apr 2015 10:11:10 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 21CBD2DA023B; Mon, 13 Apr 2015 10:11:10 -0400 (EDT)
In-reply-to: <20150413134850.GC23475@mewburn.net>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267082>

On Mon, 13 Apr 2015, Luke Mewburn wrote:

> Hi,
> 
> I've noticed that when a long-running git operation that generates
> progress output is suspended and converted to a background process,
> the terminal still gets spammed with progress updates (to stderr).
> 
> Many years ago I fixed a similar issue in the NetBSD ftp progress
> bar code (which I wrote).
> 
> I've experimented around with a couple of different solutions, including:
> 1. suppress all progress output whilst in the background
> 2. suppress "in progress" updates whilst in the background,
>    but display the "done" message even if in the background.
> 
> In both cases, warnings were still output to the terminal.
> 
> I've attached a patch that implements (2) above.
> 
> If the consensus is that all progress messages should be suppressed,
> I can provide the (simpler) patch for that.
> 
> I've explicitly separated the in_progress_fd() function
> so that it's easier to (a) reuse elsewhere where appropriate,
> and (b) make any portability changes to the test if necessary.
> I also used getpgid(0) versus getpgrp() to avoid portability
> issues with the signature in the latter with pre-POSIX.
> 
> A minor optimisation could be to pass in struct progress *
> and to cache getpgid(0) in a member of struct progress
> in start_progress_delay(), since this value shouldn't change
> during the life of the process.

What if you suspend the task and push it into the background? Would be 
nice to inhibit progress display in that case, and resume it if the task 
returns to the foreground.

Also the display() function may be called quite a lot without 
necessarily resulting in a display output. Therefore I'd suggest adding 
in_progress_fd() to the if condition right before the printf() instead.


Nicolas
