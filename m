From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Grafts workflow for a "shallow" repository...?
Date: Mon, 15 Sep 2008 22:24:25 -0700
Message-ID: <20080916052425.GA14644@spearce.org>
References: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 07:26:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfT5J-0007ax-2u
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 07:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbYIPFY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 01:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbYIPFY0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 01:24:26 -0400
Received: from george.spearce.org ([209.20.77.23]:49323 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYIPFY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 01:24:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 95EED3835F; Tue, 16 Sep 2008 05:24:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95972>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Here is my attempt at a "let's publish a shallow repository for branch
> of moodle". Let me show you what I did...
...
>  # 1.7 was a significant release, anything earlier than that
>  # is just not interesting -- even for pickaxe/annotate purposes
>  # so add a graft point right at the branching point.
...
> Is this kind of workflow (or a variation of it) supported? For this to
> work, we should communicate the grafts in some push operations and
> read them in clone ops - and perhaps in fetch too.

Currently the grafts file isn't transferred over any transport
protocol as it is considered to be local only to the repository.

For one thing, grafts are a security risk.  Any user can graft
anything in at any position and log/blame operations will honor
the graft, rather than what is stored in the signed commit chain.
Its a low risk, but it allows a peer to lie to you and give you
something other than what you asked for.

Pushing (or fetching) a graft just seems ugly.  You don't want
to fetch a graft if you have no grafts because you have the full
history.  Nor do you want to fetch a graft that might possibly
overwrite/replace a graft you already have.  You might not want to
push all of your available grafts to a remote.  Etc.

I think that in this case the best thing to do is give users
a shell script that does roughly:

	git init
	echo $BASE >.git/info/grafts
	git remote add -f origin $url
	git checkout -b master origin/master

Sign the script, and let users verify it before executing.  You may
also want a script to drag in the history behind by removing the
graft and fetching $BASE^, but that is hard because your repository
already "has" that.

-- 
Shawn.
