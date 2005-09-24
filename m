From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Sat, 24 Sep 2005 14:50:01 +0200
Message-ID: <20050924125001.GB25069@pasky.or.cz>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <7vvf0r6x97.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 14:51:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJ9Tr-0005Z7-L4
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 14:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVIXMuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 08:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVIXMuE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 08:50:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58079 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750743AbVIXMuD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 08:50:03 -0400
Received: (qmail 31171 invoked by uid 2001); 24 Sep 2005 14:50:01 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvf0r6x97.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9230>

Dear diary, on Sat, Sep 24, 2005 at 04:00:04AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > It takes loooong time, unfortunately - scp -r takes its time itself on
> > many small files, and then we have to make a separate call to
> > git-ssh-fetch for each tag. Isn't that braindamaged... :/
> 
> I think you could run git-peek-remote to find all the refs and
> then run git-fetch-pack to slurp all the tags (and heads for
> that matter) at once.  Is there a particular reason you would
> prefer the commit walker?

Actually, probably not, except consistency with rsync and http handling
- but that's obviously not too good reason. I did it this way since I'm
going to be a bit busy again from now on.

I will probably rewrite the tags fetching to use git-peek-remote
(info/refs for http) the next weekend. One problem with this is that in
many repositories, git-update-server-info does not get ever run and
things would break "mysteriously". I don't want the policy that the user
has to take care of this on his own for Cogito, so I will probably add
something that will automagically append git-update-server-info at least
to the post-update hook (like

	uphook="$_git/hooks/update-post"
	if ! [ -x "$uphook" ]; then
		if ! [ -e "$uphook" ]; then
			echo '#!/bin/sh' >>"$uphook"
			echo 'exec git-update-server-info' >>"$uphook"
		fi
		# If the user added something custom and left the hook
		# disabled, he knew what he was doing. Also don't
		# reenable the hook if we already did that once.
		if [[ "$(grep -v '^#\($\|[^#]\)\|^$' "$uphook")" == "*exec git-update-server-info*" ]]; then
			chmod a+x "$uphook"
			echo "## Enabled by Cogito. It won't try to enable it again as long as this comment is here." >>"$uphook"
		fi
	fi

or something).

Actually, I might also add something like

	[ -e "$_git/git-dummy-support" ] && git-update-server-info

at all the places in Cogito where I update the refs. Then the
default post-update hook could change to

	[ -e "$_git/git-dummy-support" ] && exec git-update-server-info

and be enabled by default?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
