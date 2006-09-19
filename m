From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix broken sha1 locking
Date: Tue, 19 Sep 2006 23:23:40 +0200
Message-ID: <20060919212340.GC8259@pasky.or.cz>
References: <20060919205823.18579.59604.stgit@machine.or.cz> <Pine.LNX.4.64.0609191411460.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 23:24:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPn4D-0001Vt-Kc
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWISVXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWISVXn
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:23:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40065 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751148AbWISVXm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 17:23:42 -0400
Received: (qmail 21071 invoked by uid 2001); 19 Sep 2006 23:23:40 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609191411460.4388@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27288>

Dear diary, on Tue, Sep 19, 2006 at 11:16:04PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Tue, 19 Sep 2006, Petr Baudis wrote:
> >
> > Current git#next is totally broken wrt. cloning over HTTP, generating refs
> > at random directories. Of course it's caused by the static get_pathname()
> > buffer. lock_ref_sha1() stores return value of mkpath()'s get_pathname()
> > call, then calls lock_ref_sha1_basic() which calls git_path(ref) which
> > calls get_pathname() at that point returning pointer to the same buffer.
> 
> Hmm. This was exactly the schenario why I did commit
> e7676d2f6454c9c99e600ee2ce3c7205a9fcfb5f - allowing a couple of 
> overlapping paths
> 
> Isn't that in the "next" branch too?

Yes, and between the mkpath() and git_path() calls exactly three other
get_pathname() calls happen.

Of course you could just enlarge the cache, but that will merely make
the bugs even harder to spot, let alone track down. I argue that having
this cache at all is harmful and will result in bugs over time as new
get_pathname() calls are added in the middle of currently safe
"concurrent" calls.

> Of course, that still assumes that you strdup() the result at _some_ time, 
> and can't just save it away, but lock_ref_sha1_basic() should do that.

lock_ref_sha1_basic() never strdup()s ref (at least the reference used
for git_path() later).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
