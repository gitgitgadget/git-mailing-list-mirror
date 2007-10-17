From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Switching from CVS to GIT
Date: Wed, 17 Oct 2007 21:33:32 +0200
Message-ID: <200710172133.34273.robin.rosenberg.lists@dewire.com>
References: <1192293466.17584.95.camel@homebase.localnet> <Pine.LNX.4.64.0710161331440.25221@racer.site> <4D822762-D344-465E-B77D-90A64D61F5A9@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eli Zaretskii <eliz@gnu.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>, tsuna@lrde.epita.fr,
	Andreas Ericsson <ae@op5.se>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEbt-0005n2-TV
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbXJQTbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbXJQTbF
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:31:05 -0400
Received: from [83.140.172.130] ([83.140.172.130]:5887 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753550AbXJQTbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:31:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0ED3082758E;
	Wed, 17 Oct 2007 21:22:26 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15424-09; Wed, 17 Oct 2007 21:22:25 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 7F09F802C03;
	Wed, 17 Oct 2007 21:22:25 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <4D822762-D344-465E-B77D-90A64D61F5A9@zib.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61415>

tisdag 16 oktober 2007 skrev Steffen Prohaska:
> 
> On Oct 16, 2007, at 2:33 PM, Johannes Schindelin wrote:
> 
> >> Maybe we need a configuration similar to core.autocrlf (which  
> >> controls
> >> newline conversion) to control filename comparison and normalization?
> >>
> >> Most obviously for the case (in-)sensitivity on Windows, but I also
> >> remember the unicode normalization happening on Mac's HFS filesystem
> >> that caused trouble in the past.
> >
> > Robin Rosenberg has some preliminary code for that.  The idea is to  
> > wrap
> > all filesystem operations in cache.h, and do a filename normalisation
> > first.
> 
> At that point we could add a safety check. Paths that differ only by
> case, or whitespace, or ... (add general and project specific rules  
> here)
> should be denied. This would guarantee that tree objects can always be
> checked out. Even if the filesystem capabilities are limited.
> 
> Robin, what do you think?

My code only normalizes filenames to UTF-8 inside git, which isn't the same 
thing. I think that can be extended to handling MacOSX normalized UTF-8 and
Windows UTF-16 so, when you check out a thing from git there will be no 
surprises. Case insensitivity is another dimension. I have no idea as to the
performance of the code, it's more like a proof-that-it-can-be-done.

The code cannot "fail", it always does something reasonable, like not 
converting when that is not possible. Something else has to be done for 
validation.

The UTF-16 that windows use is not a current issue because git  only does 
local code page. Jgit, but it isn't very smart either because git doesn't say 
anything about filename encoding, while Windows/MacOSX/CIFS and other 
filesystems does.

The fact that git uses eigth bit file names may also be a reason performance 
is slower on Windows, because the eight-bit Win32API transforms all strings 
and filenames to the native UTF-16 encoding on *every* system call, in and 
out; that's a lot of work when you do it thousands of times. If git itself 
did the transform it might be made smarter and more suited to git's purposes, 
and most importantly faster. I have no idea about the performance hit. One
has to measure something.

I notice a number of SCM's out there, including one with a \$\d{4} pricetag 
gets you into trouble if you rename a file from Foo to FOO on Windows.

-- robin
