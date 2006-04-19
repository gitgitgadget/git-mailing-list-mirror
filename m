From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-daemon memory usage, disconnection.
Date: Wed, 19 Apr 2006 16:27:49 +0100
Message-ID: <1145460469.11909.25.camel@pmac.infradead.org>
References: <1145452967.13200.92.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0604190749160.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 17:28:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWEbF-0008Iq-O4
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 17:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWDSP1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 11:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWDSP1x
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 11:27:53 -0400
Received: from canuck.infradead.org ([205.233.218.70]:55956 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750893AbWDSP1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 11:27:52 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FWEat-0008FW-1a; Wed, 19 Apr 2006 11:27:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604190749160.3701@g5.osdl.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18929>

On Wed, 2006-04-19 at 07:59 -0700, Linus Torvalds wrote:
> Well, you've probably got two issues: 
> 
>  - it looks like you aren't packing your archives (which explains why the 
>    disk accesses are horrid, which in turn explains the "D" part).

Hm, good point. They're fairly new trees -- I had foolishly assumed that
they would at least start off packed. That isn't the case though --
perhaps it should be? Did the original clone receive a pack on the wire
and then _split_ it?

If the tools would automatically pack when the number of unpacked
objects reaches a threshold, that would be useful.

Since this repo is only available through git:// and git+ssh:// URLs, I
can safely use git-repack's '-a -d' options, right?

I'll do 'git-repack -l' nightly and 'git-repack -a -d -l' weekly -- does
that seem sane?

>    For a git server, you _really_ want all trees to be mostly packed, or 
>    you want absolutely tons of memory (and 256kB is definitely not "tons"
>    as far as git is concerned).
> 
> Well, the way things work under UNIX, you normally don't notice that the 
> other end isn't interested until you try to write, and you get a "nobody 
> is listening". And sadly, the packing stuff does most (not all) of the 
> heavy lifting before it can even start to write things out.

Well, it does that with SIGALRM happening periodically, theoretically
for the purpose of providing progress output. Perhaps we could do a
getpeername() or something else to check on the output fd each time?

-- 
dwmw2
