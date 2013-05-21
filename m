From: John Keeping <john@keeping.me.uk>
Subject: Re: Workflow Help
Date: Tue, 21 May 2013 10:23:14 +0100
Message-ID: <20130521092314.GO27005@serenity.lan>
References: <CAMATmi3bU7hrD-YLY1iVXbekxOx_XZfZ5yYNBfzV_VFSc_W5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Quilkey, Tony" <trq@thorpesystems.com>
X-From: git-owner@vger.kernel.org Tue May 21 11:23:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uein1-0003ro-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 11:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab3EUJXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 05:23:23 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58224 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab3EUJXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 05:23:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E1EC2CDA60C;
	Tue, 21 May 2013 10:23:21 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nfgrz31kdVN7; Tue, 21 May 2013 10:23:19 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1ED18CDA5B9;
	Tue, 21 May 2013 10:23:16 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMATmi3bU7hrD-YLY1iVXbekxOx_XZfZ5yYNBfzV_VFSc_W5jw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225023>

On Tue, May 21, 2013 at 10:59:17AM +1000, Quilkey, Tony wrote:
> I am looking at formulating and then documenting our vcs workflow
> using Git at work. I have an idea of how I want things to work, but am
> a little hazy on some of the details.
> 
> Our basic workflow will be based around:
> http://nvie.com/posts/a-successful-git-branching-model, with a few
> exceptions.
> 
> We would like to create our release-* branches from the last release
> tag. From there, we would like the ability to cherry pick (or take the
> complete diff) commits from the develop branch.
>
> So, we are after is:
> 
> 1) Create topic (feature) branches from develop, and merge back into
> develop when complete.
> 
> 2) Once it is decided we are packaging a release, make a release-*
> branch from the previous release tag.
> 
> 3) Cherry pick/merge/whatever any commits we want from develop into
> the new release-* until it is complete.
> 
> 4) Merge the new release-* branch into master and tag it.
> 
> Repeat as necessary.
> 
> At the moment I am a little stuck on how exactly we can cherry pick
> stuff from develop into a release-* branch. I'm not even sure this
> approach is exactly what we should be doing.

Having been involved in a couple of projects that use cherry-pick like
this, I strongly advise against doing this.  It makes it much harder
than it needs to be to find out which branches contain a particular
commit.

The workflow described in the URL above does the more sensible thing of
periodically merging the release branch(es) back into master (or
develop).  This is similar to the workflow Junio uses to develop Git
itself, which is described in gitworkflows(7).

The idea is to start your topic branch from the oldest release to which
a bugfix must be applied, then merge it into the appropriate release
branches.  Then you merge this branch upwards into the later release
branches and your development branch.  So your development branch always
contains all release branches (not just similar commits, but the *same*
commits so that each release branch tip is an ancestor of the
development branch's tip).

This means that you can use "git branch --contains" or "git describe
--contains" to answer the question "which release(s) contain this
commit?", whereas with cherry picking there is no easy and reliable way
to do so.

> Our main concern is that at this stage, there is no guarantee that all
> commits within develop can be pulled into a release.

One advantage of starting a bugfix topic branch from the oldest release
it applies to is that you are developing and testing that fix on the
release code.  If it doesn't apply cleanly to the development branch
then you fix the conflict when merging.

Of course you may start a bugfix branch from the wrong place, in which
case you would have to cherry pick the commits back to an older branch,
but this should be a rare occurrence and will sort itself out as you
merge the fix upwards.

> In regards to how we can achieve the above results any input would be
> much appreciated. Or if there are any other better options available,
> I'm all ears.
