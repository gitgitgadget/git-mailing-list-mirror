From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Sat, 24 Sep 2005 11:10:40 -0700
Message-ID: <7virwqwd3z.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
	<7vvf0r6x97.fsf@assigned-by-dhcp.cox.net>
	<20050924125001.GB25069@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 20:12:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJEU4-0005Xz-92
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 20:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVIXSKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 14:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVIXSKo
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 14:10:44 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53658 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932217AbVIXSKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 14:10:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924181043.HETE29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Sep 2005 14:10:43 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9241>

Petr Baudis <pasky@suse.cz> writes:

>> I think you could run git-peek-remote to find all the refs and
>> then run git-fetch-pack to slurp all the tags (and heads for
>> that matter) at once.  Is there a particular reason you would
>> prefer the commit walker?
>
> Actually, probably not, except consistency with rsync and http handling
> - but that's obviously not too good reason.

We would end up doing things internally differently between
git-native (fetch/clone-pack) and other protocols (commit walker
which is git-aware, and rsync which is not) anyway.

I misspoke for 'git-fetch-pack' in the above -- git-fetch-pack
without any refspec fetches all the refs, so you do not need a
separate peek-remote.  Right now 'git fetch' wrapper does not
let you take advantage of this, but if we wanted to add '--all'
flag to 'git fetch' wrapper, it can be implemented very easily
and efficiently for the git-native protocol.  An implementation
of such a flag for other protocols would use git-ls-remote to
find out the refs upfront.

> I will probably rewrite the tags fetching to use git-peek-remote
> (info/refs for http) the next weekend.

If you are targetting multiple protocols, git-ls-remote is the
one to use, not peek-remote.  It internally uses peek-remote for
git-native protocol, and emulates it using info/refs for http
and recursive get for rsync, so no new coding on Cogito part
should be necessary.

> default post-update hook could change to
>
> 	[ -e "$_git/git-dummy-support" ] && exec git-update-server-info
>
> and be enabled by default?

That is a thought.  While I think doing update-server-info
everywhere whenever you update ref is going a bit overboard, I
agree there should be an easy way for the end user to keep
repositories that are public accessible all times.  But running
server-info upon every commit does not make much sense to me --
something is seriously broken if we need to do that.

Cases when you would want to make your repository accessible
from outside itself varies and preferred transport obviously
depends on it.

 - Your private working area.  Typically does not allow
   anonymous downloads.  You are the only one to use git tools
   and compilation there (that's what 'private' means).

 - A CVS style shared repository.  May allow anonymous
   downloads, and allow uploads to people with 'commit
   privilege' in CVS lingo.

 - A public distribution point, like kernel.org repository.
   This is just a special case of the 'shared repository' above,
   with yourself as the only uploader.

I thought there would be more classes, but it really boils down
to whether you would allow anonymous downloads or not -- so
let's call them private and public.

Fetching over non git-native protocol is the only case where
server-info matters; so obviously it is nicer if public
repository is arranged so that update-server-info is run
everytime refs and set of packs change.

I do not think of a good reason not to use git-aware protocol
when one is fetching from a private repo -- so if we just say
people should not use non git-aware protocol when doing so, we
do not have to do server-info in the private repositories at
all.

So the question is, how often do we need to run update to keep
the refs and set of packs in public repository in sync with the
server-info.  What do people do in public repository to affect
set of packs and the refs?

 - Initiate a push into it from somewhere else; this case is
   covered by enabling post-update hook.

 - You log on to the machine of public repository and run 'git
   repack'; this runs update-server-info, so it is OK.

 - You log on to the machine of public repository and run fetch
   of another repository -- you may even end up hand merging and
   creating new commits.

 - You log on to the machine of public repository and do your
   development, making your own commits.

It is the latter two cases where your 'update-server-info
everywhere in Cogito' would be needed -- but is it realistic?
