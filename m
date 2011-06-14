From: Johan Herland <johan@herland.net>
Subject: Re: Commit notes workflow
Date: Tue, 14 Jun 2011 16:41:13 +0200
Message-ID: <201106141641.14257.johan@herland.net>
References: <20110613090940.664b1b97@chalon.bertin.fr> <201106141215.50689.johan@herland.net> <f81891b81d39.4df76a5c@bertin.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: dirson@bertin.fr
X-From: git-owner@vger.kernel.org Tue Jun 14 16:41:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWUnz-0004ZN-KN
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 16:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab1FNOlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 10:41:18 -0400
Received: from smtp.opera.com ([213.236.208.81]:44826 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab1FNOlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 10:41:17 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p5EEfEmN023123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Jun 2011 14:41:14 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-Reply-To: <f81891b81d39.4df76a5c@bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175773>

On Tuesday 14. June 2011, dirson@bertin.fr wrote:
> > > Do we really want to "git notes" to ignore everything not in
> > >  refs/notes/ ? I can think of 2 possibilities out of this
> > > situation:
> > > 
> > > * remove that limitation
> > > * decide on a naming convention for remote notes, and teach  "git
> > > notes" not to ignore it
> > 
> > The naming convention I have proposed (in the discussion for
> > [1]) is
> > 
> > refs/notes/*:refs/remotes/$remote/notes/*
> > 
> > (but it obviously depends on reorganizing the entire remote refs
> >  hierarchy)
> > 
> > > A (minor) problem with the second possibility is that this naming
> > > convention could evolve, eg. if we end up with something like was
> > > proposed in [1] for 1.8.0. Is there any real drawback with  the
> > > first suggestion ?
> > > 
> > > [1] http://marc.info/?l=git&m=129661334011986&w=4
> > 
> > My gut feeling is to keep some sort of limit notes refs, and
> >  if/when we get around to implementing my proposal in [1] (or some
> > variation  thereof), we will of course extend the limit to put
> >  "refs/remotes/$remote/notes/*" (or whatever is decided) in the
> > same category as "refs/notes/*".
> > 
> > In the meantime, I'm unsure if it's a good idea to remove the
> >  limitation altogether (allowing notes refs everywhere), since
> > re- introducing a limit at a later point will then be MUCH
> > harder...
> 
> So we could introduce something like refs/remote-notes/<remote>/*
> today to start working, and eventually phase it out when
> refs/remotes/ gets restructured.

Yes, if you can't wait for the refs/remotes/ restructuring, then I guess 
you'll have to do that.

> Then the next point will be how best to provide git-pull-like support
> for notes refs. We have a number of alternatives, like:
> 
> * having "git pull" run "git notes merge" on all notes refs with a
> tracking-branch set to the repo from which we pull
> * do the same for a configured set of notes refs only
> * only have "git pull" and "git status" notify about notes refs being
> not uptodate, and add an explicit "git notes pull" command of some
> sort (maybe just "git notes merge" without an argument, which would
> be consistent with latest "git merge") * surely others

I guess there are a lot of different possibilities here, and there will 
probably be disagreement on what's the best default, so I'd suggest the 
following guidelines:

* make it as configurable as possible.

* follow the existing conventions of pull/merge w.r.t. branches, but 
only so far as it makes sense for notes.

* leave the defaults conservative (e.g. don't do any merging by default, 
but make pull/status notify about update-able notes refs).


My idea so far, is to model the notes configuration on the current 
branch configuration, e.g. something like this:

  [remote "origin"]
      ...
      fetch = +refs/notes/*:refs/remotes/origin/notes/*
      ...

  [notes "commits"]
      remote = origin
      merge = refs/notes/commits

  [notes "bugs"]
      remote = origin
      merge = refs/notes/bugs
      mergeoptions = --strategy=cat_sort_uniq
      automerge = true

Except for the "automerge" option, everything is analogous to current 
branch.<name>.* options. The above configuration sets up a default 
tracking ref for "refs/notes/commits", making

  git notes --ref commits merge

equivalent to

  git notes --ref commits merge refs/remotes/origin/notes/commits

This notes merge would not happen automatically.

The last section, however, would presumably trigger an automatic notes 
merge (on fetch? pull?) because of notes.bugs.automerge being enabled. 
In this case, the

  git notes --ref bugs merge

command would be issued, which would be equivalent to

  git notes --ref bugs merge --strategy=cat_sort_uniq \
      refs/remotes/origin/notes/bugs

This is just a suggestion, and we might want to impose additional 
restrictions not mentioned above. For example, enabling "automerge" 
without enabling a non-"manual" notes merge strategy is probably unwise, 
because it can force the user to resolve conflicts from a notes merge 
that the user did not explicitly initiate.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
