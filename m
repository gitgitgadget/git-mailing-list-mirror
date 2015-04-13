From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] reduce progress updates in background
Date: Mon, 13 Apr 2015 11:01:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Luke Mewburn <luke@mewburn.net>
X-From: git-owner@vger.kernel.org Mon Apr 13 17:01:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhfra-00084s-IT
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 17:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbbDMPBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 11:01:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57155 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbbDMPBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 11:01:06 -0400
Received: from yoda.home ([66.131.180.142]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0NMR0053Z31TF210@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 13 Apr 2015 11:01:05 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 273822DA023B; Mon, 13 Apr 2015 11:01:05 -0400 (EDT)
In-reply-to: <20150413144039.GD23475@mewburn.net>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267084>

On Tue, 14 Apr 2015, Luke Mewburn wrote:

> On Mon, Apr 13, 2015 at 10:11:09AM -0400, Nicolas Pitre wrote:
>   | What if you suspend the task and push it into the background? Would be 
>   | nice to inhibit progress display in that case, and resume it if the task 
>   | returns to the foreground.
> 
> That's what happens; the suppression only occurs if the process is
> currently background.  If I start a long-running operation (such as "git
> fsck"), the progress is displayed. I then suspend & background, and the
> progress is suppressed.  If I resume the process in the foreground, the
> progress starts to display again at the appropriate point.

I agree. I was just comenting on your suggestion about caching the 
in_progress_fd() result which would prevent that.

> In the proposed patch, the stop_progress display for a given progress
> (i.e. the one that ends in ", done.") is displayed even if in the
> background so that there's some indication of progress. E.g.
>   Checking object directories: 100% (256/256), done.
>   Checking objects: 100% (184664/184664), done.
>   Checking connectivity: 184667, done.
> This is the test 'if (is_foreground || done)'.

Yes.  And I think this is nice.

>   | Also the display() function may be called quite a lot without 
>   | necessarily resulting in a display output. Therefore I'd suggest adding 
>   | in_progress_fd() to the if condition right before the printf() instead.
> 
> That's an easy enough change to make (although I speculate that the
> testing of the foreground status is not that big a performance issue,
> especially compared the the existing performance "overhead" of printing
> the progress to stderr then forcing a flush :)

Sure.  But what I'm saying is that progress() may be called a thousand 
times and only one or two of those calls will result in an actual 
print-out. So it is best to test the foreground status only at that 
point.

> Should I submit a revised patch with
> (1) call in_progress_fd() just before the fprintf() as requested, and
> (2) suppress all display output including the "done" call.
> ?

I'd suggest (1) but not (2).


Nicolas
