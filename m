From: Mark Nudelman <markn@greenwoodsoftware.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Wed, 24 Jan 2007 09:54:48 -0800
Message-ID: <45B79D68.6040200@greenwoodsoftware.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org> <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17846.20498.635623.173653@lisa.zopyra.com> <Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 19:00:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9mPe-0000Cj-0a
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 18:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXAXR7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 12:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbXAXR7x
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 12:59:53 -0500
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:58548 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbXAXR7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 12:59:52 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jan 2007 12:59:52 EST
Received: from [127.0.0.1] (c-24-6-147-161.hsd1.ca.comcast.net[24.6.147.161])
          by comcast.net (rwcrmhc15) with ESMTP
          id <20070124175449m1500l7sdfe>; Wed, 24 Jan 2007 17:54:50 +0000
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37663>

On 1/23/2007 12:32 PM, Linus Torvalds wrote:
> I think "less" is actually seriously buggy with -F.
> 
> There are two bugs:
> 
>  - it will always screw up the screen and move to the end. It does this 
>    even if you use -FX which should disable any init sequences, so it's 
>    not about that problem.
> 
>  - if you resize the terminal while less is waiting for input, less
>    will exit entirely without even showing the output. This is very
>    noticeable if you do something like "git diff" on a big and cold-cache 
>    tree and git takes a few seconds to think, and then you resize the 
>    window while it's preparing. Boom. No output AT ALL.
> 
> Both bugs are easily seen with this simple command line
> 
> 	clear ; (sleep 5 ; echo Hello) | less -F
> 
> where you would EXPECT that the "Hello" would show up at the first line of 
> the screen (since we cleared the screen and moved to the top left corner), 
> but in fact it doesn't.
> 
> And try resizing the terminal to make it bigger during the five-second 
> pause, and now you'll see less not show the "Hello" at _all_. It's just 
> gone (this is true even if the output was _more_ than a screen: try with
> 
> 	(sleep 10 ; yes ) | less -F
> 
> and resize the screen, and it will exit silently after 10 seconds - never 
> showing any output at all! Even though the output is obviously bigger than 
> a screen..
> 
> Tested with Kterm, gnome-terminal and xterm. They all behave the same for 
> me.
> 
> I don't know exactly what the bug is, but I find the "eof" handling very
> confusing in the less sources. It makes me suspect that there is something 
> that gets confused by the partial read, sets EOF (since we're on the last 
> line), and then thinks that it should quit, since EOF is set.
> 
> I dunno. Mark?
> 
> 		Linus


Hi Linus,

The first issue that you mention (that we move to the bottom of the 
screen before printing the first line) is behavior that has always 
existed in less.  It's not the init sequence that's doing it; less 
deliberately moves to lowerleft before printing any output that is 
intended to go at the bottom of the screen, including both file data and 
the prompt.  This was a design decision from the first version of less, 
and I've never been brave enough to try to find all the places that 
would be affected by changing this.  For example, less tries to keep 
track of exactly what's displayed on the screen at all times, and it's 
harder to do this if we don't know whether some output scrolled the 
screen or not.  It may or may not be a big job to make all the changes 
that would be required.  I will move this up the priority list and take 
a look at it for the next release of less.

BTW, this issue is documented as enhancement request #112 at 
http://www.greenwoodsoftware.com/less/bugs.html.

Your second issue is definitely a bug.  Less's handling of -F and eof in 
general is indeed rather baroque and confusing, and probably needs a 
complete revision.  Some of the complexity comes from being portable to 
many (not necessarily Unix-like) systems.  But in this case, I think the 
early exit is happening because less makes the decision about whether to 
quit due to -F based on the state of the input when the first prompt 
occurs.  When less receives SIGWIND, it repaints the screen and 
*reprompts*.  So if it gets this signal before the first screen is 
completely filled, it tries to prompt, somehow gets confused and thinks 
that the partially filled screen is evidence of a short file, and exits. 
  I will add this to the bug list and try to fix it in the next release.

--Mark
