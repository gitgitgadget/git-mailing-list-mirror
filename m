From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Blaming differences
Date: Tue, 19 Jun 2012 09:07:08 +0200
Message-ID: <87hau76aqr.fsf@thomas.inf.ethz.ch>
References: <CABURp0omoLoNaOhD3Vx734aVtm5sbk0E7_2uaZJWrWs=_g84iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 09:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgsX4-0006ZK-9v
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 09:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab2FSHHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 03:07:13 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:31894 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab2FSHHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 03:07:12 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 09:07:09 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 09:07:09 +0200
In-Reply-To: <CABURp0omoLoNaOhD3Vx734aVtm5sbk0E7_2uaZJWrWs=_g84iA@mail.gmail.com>
	(Phil Hord's message of "Mon, 18 Jun 2012 18:56:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200182>

Phil Hord <phil.hord@gmail.com> writes:

> I want something like a product of diff and blame.  I want to see some
> kind of "blame" output for each line of "diff -U0".
>
> I tried something like this:
>    git blame $changed_files
>
> Is there such a command already?

Perhaps the WIP 'log -L' feature can help:

  http://thread.gmane.org/gmane.comp.version-control.git/199385

> I'd also like to do something of the inverse operation:  I want to
> find commits within a range whose changes are NOT in some other
> commit.   So, say I have these four commits
>    A---B---C---D
>
> Where D was created by 'git revert B'.
> I'd like to find out somehow that this is equivalent to
>    A--C
>
> So that if I remove B and D completely, the with just A and C will get
> me to the same end result.
>
> Something like 'git list-contributors HEAD' which would show me A and
> C, since these are the only commits that appear in any 'git blame
> $any_file'.

I wonder if these are really equivalent.  The first one is perhaps not
feasible: If it can only detect exact reverts, that's not incredibly
helpful; the commit message will probably tell you that it's a revert
anyway.  I suspect that distinguishing conflicted reverts from true
changes is AI-complete.  You're free to go and try, though :-)

The second one, "find all commits which appear in blame output", is
different: it would only list commits which have surviving lines.  For
example,

  $ git blame --incremental commit.h | grep -E -o '^[0-9a-f]{40}' | sort -u | wc -l
  77
  $ git rev-list --no-merges HEAD -- commit.h | wc -l
  110

tells me that there are 33 commits changing commit.h without any
surviving lines.  However there were no reverts:

  $ git log --grep=Revert -- commit.h

comes up empty.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
