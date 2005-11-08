From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Tue, 8 Nov 2005 17:46:20 +0100
Message-ID: <200511081746.20348.Josef.Weidendorfer@gmx.de>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de> <7v8xw216q9.fsf@assigned-by-dhcp.cox.net> <20051107232122.GZ1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 08 17:56:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZWcD-0006ZG-91
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 17:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVKHQqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 11:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVKHQqY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 11:46:24 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:28322 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750877AbVKHQqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 11:46:23 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 383B32781
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 17:46:22 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051107232122.GZ1431@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11338>

On Tuesday 08 November 2005 00:21, Petr Baudis wrote:
> The problem is that at least Cogito defaults to the 'origin' branch when
> pulling/merging, so if you'll have 'origin/master' instead of 'origin',
> I will have to hack that around. So it's not _just_ a convention but
> something reflected in some code as well.

The new git-clone simply would not produce an "origin" branch at all, and I do
not think Cogito expects that a repository always has an "origin" branch.

The following fact (Git's default clone setup until now, Cogito's clone setup)

	"origin" tracks remote "master", to be merged into local "master"

has to be stored into some configuration file, and not to be set up implicitly
as it is done currently. Then you take this setup from the configuration, and
there never would be something hardcoded, and Junios suggestion would be a
convention.

Git already stores half of this into remotes/repo: the "Pull" lines specify
which local head tracks which remote head; the same with Cogito's .git/branches.
Missing in both cases is the information that "origin" maps to the local
development head "master". More common name for this information: "origin" is
the upstream for "master".

This information is useful at least for two cases:
(1) for specifying the default action to be done on "git-pull" or "cg-update",
and (2) try to prohibit accidental bogus merges.

The default action currently is either hardcoded (Cogito) or working somehow
by luck (Git: you have to be on "master" for git-pull).
AFAIK, Cogito prohibits bogus merges by enforcing to be either on "master"
or to be in a not-mergeable state (cg-seeking).

Merge relationship is useful to be specified not only for upstream direction,
but also for branches which branched off the current head and should be
merged back (e.g. topical branches). For this, multiple branches to be
merged with "git pull" should be specifyable.

Where to put the information about default merge relation?

Both .git/remotes and .git/branches are candidates, but merge relation
also makes sense for local branches, i.e. git-branch <branch> <origbranch>
should set up to merge from <origbranch> if you are on <branch> by default.
Similarly, it should set up a relation the other way to state that it is
useful to merge from <branch> into <origbranch> (this is for (2) above).

A possiblity would be to put the merge relationship into .git/config:

[master]
merge-canditate: origin
merge-default: origin

Problem here is that head names should not appear in key names,
because key names are case insensitive :-(
A possibility would be for config keys to become case sensitive after a ":"
(of course only for toplevel keys):

[head:master]
merge-default: origin

> >  - clone by default [*1*] creates .git/refs/heads/origin/*
> >    heads; your "master" becomes my "origin/master".
> >    Interestingly but logically, if your repository was cloned
> >    from somewhere else, you would have "origin/master", which
> >    would become my "origin/origin/master".
> 
> This loses the pretty nice property that 'origin' refers to the HEAD
> branch of the remote repository, no matter how is it called (well, it is
> nice as long as the remote repository doesn't _switch_ the HEAD to some
> non-superset branch; but repositories you're cloning from shouldn't do
> that). So you should either have origin/HEAD locally, or make the
> 'master' branch more "socially canonical".

Ah, so git-clone sets up a local development head for the remote HEAD, which
does not always have to be "master", right? This information would be available
by the proposed storing of merge relationship: local "master" wants get merges
from remote HEAD to be updated.

Josef
