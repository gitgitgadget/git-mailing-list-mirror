From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Tue, 27 Jan 2009 09:21:17 -0600
Organization: Exigence
Message-ID: <20090127092117.d13f24e7.stephen@exigencecorp.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 16:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRpm3-0004r2-VV
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 16:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbZA0PVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 10:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbZA0PVW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 10:21:22 -0500
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:54712 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZA0PVV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 10:21:21 -0500
Received: from relay13.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay13.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id EEFC11B4839;
	Tue, 27 Jan 2009 10:21:20 -0500 (EST)
Received: by relay13.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 87FF11B47F4;
	Tue, 27 Jan 2009 10:21:20 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901242056070.14855@racer>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107351>


> I am very sorry if somebody actually scripted rebase -i -p (by setting
> GIT_EDITOR with a script), but I am very certain that this cleanup is
> absolutely necessary to make rebase -i -p useful.

I have scripted rebase-i-p, but with GIT_EDITOR=: [1]. I assume this
will still work and just accept the default script?

(Er, maybe I can just use rebase-p...I forget why [1] is using the
GIT_EDITOR=: with -i.)

My primary pain point with rebase-i-p has been rebasing a branch that
has merged in another branch that has a lot of commits on it. E.g.:

    a -- b -- c  origin/feature
      \
       d -- e    feature
           /
      ... g      origin/master

Where e is merging in, say, a latest release that had a few hundred
commits in the master branch. After resolving conflicts/etc. in e, I
want to rebase d..e from a to be on c.

The two problems have been:

1) `git pull` with rebase set uses rebase-i, with no -p, so all of the
   commits from the latest release branch that got merged in with e are
   flattened/duplicated. This is what [1] tries to fix. I've made
   noises about hacking the branch rebase flag but haven't followed
   through.

   I know this is a git pull issue, but I bring it up because, IIRC, the
   t3410 test case came from a scenario where I was rebasing a merge
   like e above and due to --cherry-pick dropping a commit (probably e
   itself, I'm not sure), rebase-i-p as it existed then broke and
   produced a noop. So I set off to get it to do "something" and ended
   up introducing the "DROPPED" directory.

2) With manual invocation of `rebase-i-p`, previously you'd get a
   laundry list of commits from the e merge that are new to the feature
   branch, but since g and its ancestors aren't changing, you don't need
   to consider them in the script and so its (potentially a lot of)
   noise. This is what the parent probing back port from git sequencer
   addressed.

So, I don't mean to rehash old complaints, as I'd love to see the
rebase-i-p code cleaned up by someone who can really refactor it vs. my
hack patches. But I wanted to emphasize the motivation for my hacks over
their implementation so that hopefully you can still address these use
cases in the new version.

Thanks,
Stephen

[1]: http://github.com/stephenh/git-central/blob/master/scripts/pull
