From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: What's in git.git
Date: Tue, 14 Feb 2006 15:10:39 -0800
Message-ID: <20060214231039.GA15680@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05AA1FB3@scsmsx401.amr.corp.intel.com> <7v8xsk5a6k.fsf@assigned-by-dhcp.cox.net> <7v3bis59un.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 00:10:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F99Jm-0001ih-D1
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 00:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWBNXKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 18:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWBNXKn
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 18:10:43 -0500
Received: from fmr21.intel.com ([143.183.121.13]:57504 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422864AbWBNXKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 18:10:43 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k1ENAdrG022387;
	Tue, 14 Feb 2006 23:10:40 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [10.3.52.217])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k1ENAUsO029420;
	Tue, 14 Feb 2006 23:10:30 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id BFAB919F63;
	Tue, 14 Feb 2006 15:10:39 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id k1ENAdij015692;
	Tue, 14 Feb 2006 15:10:39 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bis59un.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16192>

> >   (1) First merge "master" into "topic":
> >
> >         $ git checkout topic
> >         $ git pull . master
> >
> >   (3) Pick commits only on "topic" branch but not on "master"
> >
> >         $ git rev-list --pretty --no-merges master..topic >P.log
> >
> >       This will pick up the three 'o' commits on the lower
> >       development track and show their commit log message.
> >
> >
> > This obviously would work equally well for single strand of
> > pearls case.  Maybe you can package the above up, and send in a
> > patch to add "git-squash" command?
> 
> I am stupid.  (4) can be done a lot more easily.  Do not do step
> (2) -- you do not need a diff at all.  But do do step (3) to get
> the logs.  Then:
> 
> 	$ git reset --soft master
>         $ git commit -F P.log -e

Yes, that all seems to work as advertised.  One extra wrinkle was to
preserve the author information by grepping out the last Author: line
from the log.  Here's the work-in-progress version of git-squash (I
don't have a "master" branch, so I stuck in the "mbranch" shell variable
so there is only one place for me to change ... to mbranch=linus).

Any style (or other) comments?  If not I'll package into patch format
with a manual page in a few days.

-Tony

#!/bin/sh

. git-sh-setup

branch="$1"
mbranch=master

if [ ! -f .git/refs/heads/"$branch" ]
then
	die "Can't see branch '$branch'"
fi

if [ -f .git/refs/heads/"$branch"-unsquashed ]
then
	die "Branch '$branch' has been squashed before"
fi

cp .git/refs/heads/"$branch" .git/refs/heads/"$branch"-unsquashed

git checkout "$branch" || die "Couldn't checkout '$branch'"

git pull . $mbranch || die "Can't merge $mbranch into $branch"

git-rev-list --pretty --no-merges $mbranch..$branch > /tmp/git-squash-$$

git reset --soft $mbranch

author=$(sed -n -e  '/^Author: /s///p' /tmp/git-squash-$$ | tail -1)

git commit --author "$author" -F /tmp/git-squash-$$ -e

rm -f /tmp/git-squash-$$
