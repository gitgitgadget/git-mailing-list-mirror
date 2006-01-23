From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: Subprojects
Date: Mon, 23 Jan 2006 02:22:27 +0100
Message-ID: <20060123012227.GW28365@pasky.or.cz>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org> <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de> <7vek37rj83.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601170001130.25300@iabervon.org> <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601171150050.25300@iabervon.org> <7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601181214150.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 02:20:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0qO8-0005Yx-W1
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 02:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWAWBUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 20:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWAWBUw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 20:20:52 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51146 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932133AbWAWBUv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 20:20:51 -0500
Received: (qmail 4889 invoked by uid 2001); 23 Jan 2006 02:22:27 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601181214150.25300@iabervon.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15070>

Dear diary, on Wed, Jan 18, 2006 at 07:21:59PM CET, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> said that...
> Okay, so you're using additional branch heads in the superproject to track 
> the current state of the subprojects. That makes sense, although I think 
> it would confuse people less if they were held separately. IIRC, 
> refs/subprojects/kernel/heads/master is a perfectly good ref name these 
> days, so that might be a good idea. That would also mean that 
> refs/tags/v2.6.14 and refs/tags/v2.7.2.3 wouldn't get confused (being 
> linux and gcc tags, respectively), because they'd be under the appropriate 
> subprojects.

I passionately agree - this is the only thing I do not like on the
current Junio's proposal (besides that top-level subproject confusion).
The way it is proposed, you are mixing different projects in a single
refs namespace and I think that's *really* confusing.

Besides, you are going to get a lot of complications since to do merging
properly you need two heads per subproject (its 'master' and 'origin'
heads; and it's useful to have e.g. all the upstream heads called
'origin' since then you can say cg-fetch -r origin in the superproject
and have all the subproject origins fetched as well) and you might want
to have other subproject heads as well. Now, for different superproject
heads, you want separate set of subproject heads. You can see the
downward spiral from here, I guess... And multiply all that by two since
you also have tags.

It actually took me a short while to realize that keeping separate
subproject/.git/refs makes no sense precisely because for different
superproject heads, you want a different set of subproject refs.
So in line with Daniel's proposal, I'd propose:

	refs/subprojects/<superhead>/<subid>/heads/master

<superhead> is the name of the current HEAD (${#refs/heads/}). <subid>
is a little more tricky - this should be the part after the equal sign
in .git/mtab (or .git/binds or .git/subprojects or whichever is the name
of the day). Obviously, you can just figure out something, but I'd like
to assign this automagically.

OTOH, in Cogito I might as well just default to sha1 of something random
(e.g.  the path+commitid+time()) since I do not expect this to be
normally referenced by a human; I just intend to switch from refs/ to
refs/subprojects/<superhead>/<subid>/ when dealing with the subproject
exclusively. ($GIT_REF_DIR (by default $GIT_DIR/refs) would come useful;
I'll probably whip up a patch when I get to finally need it.)

> I hope people will want to prepare their commits to the kernel subproject 
> as would be suitable for pushing to Linus, which would suggest that they'd 
> tend to do a commit in the kernel subproject embedded in their 
> superproject separately from doing the commit in the superproject, and 
> so the branch head would match the index but not the bind line when they 
> got to committing the superproject.

FWIW, my idea is that it should be "a seamless experience for the user"
(tm) to do development in a subproject of another project, and I can see
no reason why should that be hard to do in any way.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
