From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Fri, 8 Jul 2005 00:14:44 +0200
Message-ID: <20050707221443.GB7151@pasky.ji.cz>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 00:16:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqeeI-0005De-Rl
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 00:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVGGWOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 18:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVGGWOw
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 18:14:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21680 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262379AbVGGWOq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 18:14:46 -0400
Received: (qmail 27285 invoked by uid 2001); 7 Jul 2005 22:14:44 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Let me join the sceptics camp. :-)

Dear diary, on Thu, Jul 07, 2005 at 09:04:58PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Note that I just re-packed the kernel archive on kernel.org, and removed 
> _all_ unpacked files. Once that percolates to the mirrors, the http 
> protocol will be useless without anything like this.

*grumble*

So, what _is_ then the way to pull now, actually? If we use rsync, won't
we end up with having the objects we previous had twice now?

> That said, I really think the dumb protocols are useless anyway. No other 
> system supports pure static object pulling anyway, and as far as I'm 
> concerned, I want "rsync" to kind of work (but it won't be optimal, since 
> re-packing will delete all the old objects and replace it with the new 
> pack that is downloaded anew). But plain http? I'm not convinced.

You can always just spider the repository which will work just as well
as rsync in the git case. ;-)

I think it would be actually simplest (for the user) to have a trivial
CGI script on the other side which will do the git-upload-pack stuff.
Minimal extra administrative overhead, flexibility, works through
proxies, and stuff.  People can rewrite it in Perl or PHorridP if they
wish and use it on webhosting servers not allowing much else.

That's not to say a dedicated server wouldn't have its place too, and
that's what's now probably simplest for us. ;-)

Now we are in a situation when there's actually no way to pull from your
kernel repository without throwing own repository to mess and
duplicating data, AFAICS.

> I'd much rather have a "stupid server" that just listens to a port, and
> basically forks off and executes "git-upload-pack" when it's connected to
> (perhaps reading the directory name first).  Nothing else. Then we can do 
> a security analysis of upload-pack, which should be fairly easy since it's 
> not actually ever _writing_ anything.
> 
> At that point, you can do
> 
> 	git pull git://www.kernel.org/pub/scm/git/..
> 
> and it would just connect to some default "git port", pass off the 
> directory name, and be done with it - exact same discovery protocol that 
> now use for ssh. And "git clone" would also automatically work.

Eek. Could you please make it at least pretend to be extensible? Compare
git-upload-pack with git-ssh-pu* - the second one prepends letters to
the data it sends so that if you add a new type of stuff to send (say
for authentication or some smart tags stuff), you could extend it in a
sensible way. What about dividing the communication to "blocks"
separated by a newline? Each block would have its first word on the
first line saying what kind of block it is - "refs", "have", "want", or
"pack" (for simplicity, the pack block might have additional restriction
that it's always the last one).  If you hit unknown block, you should
respond back by something like "huh" and ignore the rest of it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
