From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Fri, 7 Sep 2007 10:43:52 +0200
Message-ID: <20070907084352.GD4538@xp.machine.xx>
References: <20070906075104.GA10192@hand.yhbt.net> <1189096669534-git-send-email-hjemli@gmail.com> <20070906210155.GA20938@soma> <20070906213556.GA21234@soma> <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com> <20070906235516.GC4538@xp.machine.xx> <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 10:44:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITZSH-0008HS-Dv
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 10:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbXIGIoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 04:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbXIGIoA
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 04:44:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:33244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965205AbXIGIn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 04:43:58 -0400
Received: (qmail invoked by alias); 07 Sep 2007 08:43:55 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp021) with SMTP; 07 Sep 2007 10:43:55 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/+UuN35gv+AmgleIZeRSzq+yyTicjFdWGikBy7mP
	bY3eR9FSNSGBan
Mail-Followup-To: Lars Hjemli <hjemli@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58006>

On Fri, Sep 07, 2007 at 02:23:58AM +0200, Lars Hjemli wrote:
> On 9/7/07, Peter Baumann <waste.manager@gmx.de> wrote:
> > Wouldn't it be much more pleasant to say something like
> >
> >         git-svn dcommit --on the_branch
> >
> > whereas 'the_branch' is the name of the upstream branch as specified
> > in the fetch/branch section in the git config?
> 
> Well, git-svn extracts the svn url, revision and repo uuid from the
> commit message, while your proposal only specifies the url. But I'm
> still not certain that there is a need for --upstream or anything
> similar if git-svn always uses 'git log --first-parent' (see
> http://article.gmane.org/gmane.comp.version-control.git/57951).
> 

First parent is a heuristic (and a good one, me thinks).

If you did something like this:

(1) Start state:

       a-b-c-d-e    trunk	(both trunk and branch1 are imported
          \			 from SVN)
	   \-x-y    branch1

(2) Hm. My Branch 'branch1' should be ready to be merged to 'trunk', so
   lets do it (not yet dcommited)

       a-b-c-d-e- m trunk
          \	 /
	   \ -x-y   branch1

(3) ARGH. I just discovered a serious bug in 'branch1' and can't just merge
   it into 'trunk', yet. But the merge was painfull enough so I don't want to
   redo it again, so lets reset 'trunk' to its state before the merge and
   'branch1' to the merge commit, before fixing the bug in 'branch1'.

       a-b-c-d-e    trunk
          \	 \
	   \ -x-y m branch1

Notice that this DAG is identical to the one in (2), but just the branch
labels stick to different commits. And if you now want to commit the
merge 'm' to 'branch1' before fixing the bug you are screwed, because
--first-parent will give you 'e' instead of 'y'.

Yes, I know that this example isn't something happening every day, but
at least it shows that --first-parent could *only* be a heuristic and
not something you would rely 100% on. And if you imagine several people
who are sharing their git commits for codereview with pulling/pushing,
it isn't obvious what branch got merged into the other, because it is
possible that the other person did the merge.

Don't get me wrong, --first-parent *is* an improvement over the current
behaviour, but I think it is simply not the *best* we can do.

-Peter
