From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Fri, 24 Jun 2005 22:04:11 -0700
Message-ID: <7vslz758ok.fsf@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 07:00:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm2m4-0000bb-IR
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 07:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbVFYFET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 01:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbVFYFET
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 01:04:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58271 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S263339AbVFYFEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 01:04:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625050412.ERSI16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 01:04:12 -0400
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050624.212009.92584730.davem@davemloft.net> (David S.
 Miller's message of "Fri, 24 Jun 2005 21:20:09 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DSM" == David S Miller <davem@davemloft.net> writes:

DSM> To get a clean history to push to Linus, I typically blow
DSM> away my trees and make fresh ones to stick patches into
DSM> which I want to merge.

DSM> Should I:

DSM> 1) Do a git pull from Linus's tree once he takes my changes, then
DSM>    ask GIT to prune the tree?  How do I do that and how does it work?

DSM> 2) Should I use .git/object/ database symlinking?

DSM>    Are there any scripts out there which do this automatically?
DSM>    Something as simple to run as "git-pull-script" and it takes
DSM>    care of using links when possible on a local filesystem.

git-pull-script internally uses git-fetch-script which knows how
to do the local tree using hardlinks.  Presumably, the following
workflow would work:

 (1) You hack away in your private tree, while you keep a "to be
     published" clean tree, both on your local machine.

 (2) Do a GIT pull, merge in your private tree, to come up with
     a clean set of changes in your private tree.  This is the
     tree you "typically blow away".  Reordering the commits to
     come up with a clean history since you last pulled from
     Linus would also happen in this tree.

 (3) Once you have a commit that you want to publish (i.e. the
     commit chain between that commit and the point you last
     pulled from Linus is the "clean history to push to Linus"),
     you go to your "to be published" clean tree, and run
     git-fetch-script to fetch the commit you want to publish
     from your private tree.  When you give an absolute path as
     the "remote repo", git-local-pull with linking behaviour is
     used by git-fetch-script; otherwise rsync backend is used
     so you end up polluted object database.  This way you copy
     only the clean stuff from your private tree.  Your HEAD in
     this tree should be set to the commit you wanted to
     publish.  Running git-prune would be nicer but if your
     history is truly clean it should not be necessary.

 (4) Garbage collecting with git-prune your private tree is your
     business.

