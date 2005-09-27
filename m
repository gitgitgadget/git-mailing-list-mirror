From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 11:40:29 +0200
Message-ID: <20050927094029.GA30889@pasky.or.cz>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net> <7v3bnra20z.fsf@assigned-by-dhcp.cox.net> <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <20050926212536.GF26340@pasky.or.cz> <7virwna2oi.fsf@assigned-by-dhcp.cox.net> <20050926222944.GG26340@pasky.or.cz> <7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net> <8764snyufn.fsf@ualberta.net> <7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 11:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKBx7-00037f-Sl
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 11:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVI0Jkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 05:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVI0Jkc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 05:40:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61149 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964885AbVI0Jkc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 05:40:32 -0400
Received: (qmail 3028 invoked by uid 2001); 27 Sep 2005 11:40:29 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bnra20z.fsf@assigned-by-dhcp.cox.net> <7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9383>

Dear diary, on Tue, Sep 27, 2005 at 07:28:16AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Tom Prince <tom.prince@ualberta.net> writes:
> 
> > Junio C Hamano <junkio@cox.net> writes:
> >
> >> Now you completely lost me.  I really do not understand what you
> >> mean by tags caching and re-slurping.
> >
> > I think Petr is interested in the case where the user hasn't asked for a
> > particular tag. He wants to automatically grab all the tags in a repository,
> > or at least those that refer to a branch being downloaded.
> 
> Ah, _automatically_ was the key.
> 
> If all you had were tags and there were no branches (the "I
> could have done without maint branch"), that kind of automatic
> grabbing would not work well anyway.

I don't think that's a realistic situation. IMHO it is a reasonable
requirement for Cogito fetch that you are primarily fetching a _head_.
Then, you also grab tags which are meaningful for that head - that's
what I want to do. If you want to also specifically grab some extra
tags, you should be able to tell cg-fetch about that too (cg-fetch -t
tagname) or something. Being able to do this, I'm inclined to agree that
we shouldn't grab even trees and blobs.

> I personally feel that is a lost cause.  The user can run 'git
> ls-remote' himself to find out if there are new tags on the remote
> side and ask for them if needed.

Yes, that's perhaps a fine solution for the core GIT plumbing, but in
Cogito, I _really_ want to have this working automagically.

> Also, I feel names under refs/ is local to the repository, but
> if the tags are automatically grabbed, I presume they are stored
> directly under the same name in refs/tags as the remote side has
> them?

Yes. And I certainly don't say that what Cogito does now is perfect, not
even that it's very good. But we (well, rather the users) certainly _do_
need some kind of automatic tags fetching - that's something that has to
Just Work (tm).

As I already said in the past (without much feedback, unfortunately), we
certainly need to distinguish between private tags (specific for given
repository) and public tags (should be propagated by fetching).

Another thing I proposed back then (I think it was in June) was having
the refs/tags directory further divised based on heads, so all tags for
head A would be in refs/tags/A/, etc. I didn't pursue this idea now
because it seemed that there would be way too many duplicate stuff in
refs/tags/ since most tags are likely to be shared across heads, but
perhaps it is the beast and cleanest solution after all.

Dear diary, on Tue, Sep 27, 2005 at 12:37:48AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I think there should be a way to say "I do not care if this
> repository does not have all the history back to root -- as long
> as I can operate on reasonably recent commits, do not complain
> about missing objects" to fsck-objects and various fetch
> engines.  We can cauterize commit history chain using the grafts
> file so that 'git log', 'git whatchanged', and 'gitk' would stop
> somewhere.  Commit walkers can help you, albeit somewhat
> differently, if you do not give -a flag to them.

Well, this wasn't something I had on my mind in this thread, but it is
actually what I want to do too (I have such a loooong TODO list). Sure,
you can workaround the problem with grafts, but I think that this hack
should be really used only in specific cases (like grafting big history
pack after importing the project to GIT, making it kind of optional
"addon", which is actually very nice). In the general case, I would much
more like if you could say "I want only commits to the depth of 5" or
even CVS-like "I want only the HEAD commit" (actually, I received some
patches to make Cogito support this, but I didn't yet get to have a look
at them). This shifts the policy decision from the repository owner to
the user, and makes it contignuous instead of fragmented to the points
when you have grafts.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
