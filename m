From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Fix default pull not to do an unintended Octopus.
Date: Tue, 27 Sep 2005 11:52:42 +0200
Message-ID: <200509271152.42963.Josef.Weidendorfer@gmx.de>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <7vr7bba3lo.fsf@assigned-by-dhcp.cox.net> <7vu0g72c4y.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 27 11:54:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKC9N-0001g0-A0
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 11:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVI0Jw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 05:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVI0Jw4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 05:52:56 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:32723 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S964881AbVI0Jw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 05:52:56 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 500F326DD
	for <git@vger.kernel.org>; Tue, 27 Sep 2005 11:52:52 +0200 (MEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vu0g72c4y.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9385>

On Tuesday 27 September 2005 09:38, Junio C Hamano wrote:
> I think it could be modified without too much pain to take
> "which heads to use for merge by default" information from
> separate "Merge: " line as Jon proposed, if enough people like
> that idea better.  Personally I do not think it would make much
> practical difference from the end users' point of view, but I've
> been proven wrong more often than not in the past, so...

Hmm...
What is the "intuitive" thing a user would expect when looking at
a remotes file? It looks like including lists of default heads which
are used for git commands when no further head is specified, i.e.
which are automatically appended to the command line.

E.g. with .git/remotes/remoterep looking like

	URL: ...
	Pull: local1:remote1 local2:remote2
	Push: local3:remote3 local4:remote4

a
	git push remoterep

expands to (AFAIK)

	git push remoterep local3:remote3 local4:remote4

So for
	git pull remoterep

the expected command seems to be

	git pull local1:remote1 local2:remote2

and of course this does an octopus merge at the end.
It may be a strange thing to do, but if the user does *not* want to do
octopus merges, he probably only will give one default head in the Pull
line of the remotes file.

So I would not change the current behavior.

It seems better to me to support an additional "Fetch:" line.
IMHO, a "Merge:" lines does not make sense, as "git merge" has
nothing to do with remote repositories at all [I just looked up
the man page of git-merge, and confusingly it talks about "remotes",
which are in fact local heads to be merged].

> As Pasky said in another thread, git-fetch is not the most
> elegantly written script on earth, and it is not my favorite
> script either -- it needs to do complex things, like interacting
> with the later git-pull stage.

Like Pasky, I am not really comfortable with this remotes stuff.
AFAIK, it was introduced to shorten some command line by providing defaults
(to be used by the "GIT core porcelain"). But I still have to provide the 
remote shortcut on the command line.

As Cogito does, I expect the porcelain to store the mapping of a
local head to a remote head, automatically using the right remote
repository.

I want to type "git fetch maint" to get the maintanance branch of
git, and not specify an additionally introduced arbitrary short name
for the remote git repo (which is used quite less often than my
head names: heads appear in gitk, I switch among heads...).
And using the same name for a remote shortcut and a local head can
confuse people.

So IMHO default actions should be stored for branches, not for shortcuts
of remote positions. The branches stuff matches this better, as one
file in branches/ corresponds exactly to one head with the same name,
and specifies the attributes "remote repository" and "remote head".

This also shortens command lines much better then the remotes stuff,
as you implicity specify a default head: The one you are on.

Perhaps we should have extended the branches file to allow different
remote reps and heads depending on the command (fetch/pull/merge/push).
A "URL:" is not needed, as you probably like to have different repos for pull 
and push. And in contrast to the remotes stuff above, a "Merge:" line makes 
quite sense here: When on "mybranch", a merge should default to merging
the heads specified on the Merge line in branches/mybranch.

When cloning a remote head, Cogito creates a local "origin" head and
corresponding mapping in branches/origin. Afterwards, it automatically
generates a new local branch "master", which branches of at the
origin. Further "cg-updates" (=git fetch+merge) fetch origin, and merge
origin into master.
I assume that this currently is hardcoded in scripts?
Shouldn't there be created a branches/master, specifying that a default
merge should happen with "origin"? This way, an "cg-update" would look
into "branches/master" on the "Merge:" line. It sees that "origin" is
bound to a remote head, and thus, does a fetch before merging.

Opinions?

Josef
