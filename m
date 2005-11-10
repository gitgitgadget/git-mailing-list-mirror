From: Petr Baudis <pasky@suse.cz>
Subject: Re: rsync deprecated but promoted?
Date: Fri, 11 Nov 2005 00:17:04 +0100
Message-ID: <20051110231704.GB30496@pasky.or.cz>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org> <20050926163846.GD21019@pasky.or.cz> <Pine.LNX.4.58.0509260941340.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Coxall <quasi@cream.org>,
	Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 00:17:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaLfM-0004sG-48
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 00:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKJXRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 18:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVKJXRI
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 18:17:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:16821 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932250AbVKJXRH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 18:17:07 -0500
Received: (qmail 315 invoked by uid 2001); 11 Nov 2005 00:17:04 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509260941340.3308@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11533>

Dear diary, on Mon, Sep 26, 2005 at 06:43:08PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> 
> 
> On Mon, 26 Sep 2005, Petr Baudis wrote:
> > 
> > Actually, it would be nice to be able to tell git-fsck-objects to only
> > verify objects which are referenced between given two commits (perhaps
> > just make it support the ^object notation). Then I wouldn't mind running
> > that after each rsync fetch in Cogito.
> 
> You can kind of do it.
> 
> Do
> 
> 	git-rev-list --objects $oldheads --not $newheads >& /dev/null
> 	echo "$?"
> 
> and it _should_ largely work. Untested, of course, but I _hope_ that if 
> any object is missing, git-rev-list should die with an error. And if it 
> doesn't, I should fix it ;)

It should obviously be

	git-rev-list $(git-rev-parse $newheads --not $oldheads) >& /dev/null

but it is indeed broken:

	$ git-rev-list --objects ... ^... && echo ':)'
	001439c6a797461c3e75018d95744d463077ae33
	841e3297d8df764da417da81dbfe1044e24d4082
	cf11a3d561e76c8ba273cb0bb62d46a4b2959c1f file
	:)
	$ git-cat-file -t cf11a3d561e76c8ba273cb0bb62d46a4b2959c1f
	error: unable to find cf11a3d561e76c8ba273cb0bb62d46a4b2959c1f
	fatal: git-cat-file cf11a3d561e76c8ba273cb0bb62d46a4b2959c1f: bad file

Currently I just modified it so that I iterate through all the sha1s
git-rev-list spits out, and test them by git-cat-file -t.

Thanks for the hint,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
