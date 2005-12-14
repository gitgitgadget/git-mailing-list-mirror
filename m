From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Make git-send-pack exit with error when some refs couldn't be pushed out
Date: Wed, 14 Dec 2005 03:30:05 +0100
Message-ID: <20051214023005.GS10680@pasky.or.cz>
References: <20051214004540.15040.93518.stgit@machine.or.cz> <7vbqzk5tx1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 03:30:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmMPJ-0006PV-Ax
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 03:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVLNCaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 21:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLNCaN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 21:30:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3029 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030260AbVLNCaM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 21:30:12 -0500
Received: (qmail 1970 invoked by uid 2001); 14 Dec 2005 03:30:05 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqzk5tx1.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13617>

Dear diary, on Wed, Dec 14, 2005 at 02:50:02AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> However, I am not quite sure if the recent change to Cogito to
> update the mirror of remote branch is a good one.  Since I am
> not a Cogito user, I did not question it when I saw the change,
> but I wondered what you are using the cached "remote ref is
> supposed to be pointing at this commit" knowledge for.  If it is
> only "pretending to have fetched the remote branch immediately
> after we pushed into it before anybody else touched the same
> remote branch", then it probably is benign.

Exactly, we're just pretending that. It's useful since cg-fetch's
diff-tree output is less confusing then, cg-log -r <remotebranch> and
cg-diff -r ... gives expected results, etc.

> But this bit puzzles and worries me:
> 
> > ... otherwise
> > it gets out of sync, which can lead even to loss of commits on the local
> > side (this happenned to Jonas Fonseca - thanks for the report, BTW).
> 
> I do not remember seeing that report so I do not know how that
> lossage happens with unreleased Cogito, but I suspect there is
> something very fishy going on here.  I presume it happens when
> the next fetch/pull from the remote is run, but if the locally
> cached information can affect the next fetch/pull in such a way,
> wouldn't updates by other people to the shared remote repository
> branch also cause things to go out-of-sync and cause the same
> breakage?

Jonas only reported it on IRC as weird cg-commit behaviour (which it
appeared to be, but the cause turned out to be this and the nice
side-effect that this kind of breakage cannot lose you actual data at
least, just metadata).

If the push really happened, this shouldn't be a problem, since then we
get into a "fast-forward relation" to the remote branch, and commits by
other people don't affect it either, since they don't break this
relation. The "interesting behaviour" Cogito implements happens only if
your current HEAD == <the_old_remote_head>, which can't happen when
other people commit, only when you push it out to the remote head.

What kicks in is the fast-forward behaviour change I proposed quite some
time ago on the mailing list and got zero feedback about --- when
updating from a remote branch, the Cogito 0.17pre's fast-forward test
is extended from

	if (head ancestor_of remote_new)

to

	if (head ancestor_of remote_new OR head == remote_old)

which will make fast-forward able to follow even remote rebases
and should have no negative side-effects as long as remote_old
was correct (which it is except when our bug comes out). So in
the reported case, remote_old was set to head, while remote_new
stayed as before, and Cogito therefore thought that the remote
branch just got rebased from head to remote_new, and adjusted
the head appropriately.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
