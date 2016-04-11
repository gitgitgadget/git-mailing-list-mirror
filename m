From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Mon, 11 Apr 2016 14:24:46 +0300
Message-ID: <20160411141428-mutt-send-email-mst@redhat.com>
References: <1460296343-17304-1-git-send-email-mst@redhat.com>
 <1460296343-17304-2-git-send-email-mst@redhat.com>
 <alpine.DEB.2.20.1604111239100.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 11 13:25:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apZxk-0006Kc-HH
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 13:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbcDKLYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 07:24:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38502 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbcDKLYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 07:24:50 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50A7780B20;
	Mon, 11 Apr 2016 11:24:49 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3BBOlJc027750;
	Mon, 11 Apr 2016 07:24:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604111239100.2967@virtualbox>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291211>

On Mon, Apr 11, 2016 at 01:02:07PM +0200, Johannes Schindelin wrote:
> Hi Michael,
> 
> On Sun, 10 Apr 2016, Michael S. Tsirkin wrote:
> 
> > This implements a new ack! action for git rebase -i
> > It is essentially a middle ground between fixup! and squash!:
> > - commits are squashed silently without editor being started
> > - commit logs are concatenated (with action line being discarded)
> > - because of the above, empty commits aren't discarded,
> >   their log is also included.
> > 
> > I am using it as follows:
> > 	git am -s < mailbox #creates first commit
> > 	hack ...
> > 	get mail with Ack
> > 	git commit --allow-empty -m `cat <<-EOF
> > 	ack! first
> > 
> > 	Acked-by: maintainer
> > 	EOF`
> > 	repeat cycle
> > 	git rebase --autosquash -i origin/master
> > 	before public branch push
> > 
> > The "cat" command above is actually a script that
> > parses the Ack mail to create the empty commit -
> > to be submitted separately.
> 
> This looks awfully complicated, still, and not very generic.
> 
> How about making it easier to use, and much, much more generic, like this?

I can look at using a different syntax but the below does not
support the workflow I described, which is a standard
email based one: get email, handle it.

> 1. introducing an `--add-footer` flag to `git commit` that you could use
> like this:
> 
> 	git commit --amend --add-footer "Acked-by: Bugs Bunny"
> 2. introducing an `--exec-after` flag to `git commit` that would be a new
> sibling of `--fixup` and `--squash` and would work like this:
> 
> 	git commit --exec-after HEAD~5 \
> 		'git commit --amend --add-footer "Acked-by: Bugs Bunny"'

But it wouldn't address my use-case where I get an ack
by email. If I have to dig up the relevant commit(s) by hand
anyway, then what was the point?

> 
> (it should imply `--allow-empty`, of course, and probably even fail if
> anything was staged for commit at that point.) The commit message would
> then look something like
> 
> 	exec-after! Fix broken breakage
> 
> 	git commit --amend --add-footer "Acked-by: Bugs Bunny"

So if I happen to fetch a branch from someone
and rebase it, stuff gets auto-executed on my local system?
That looks scary. 

> This way would obviously benefit a lot more users.

It might benefit others who have the commit handy but it does not look
like it helps email based workflow.

> For example, you could
> easily say (and alias)
> 
> 	git commit --amend --add-footer 'Reviewed-by: Arrested Developer"
> 
> i.e. support all kind of use cases where developers need to slap on
> footers in a quick & easy way.
>
> And the --exec-after option would obviously have *a lot* more use cases
> than just squashing in ACKs.
> 
> Ciao,
> Johannes

So far I only see examples of adding footers. If that's all we can think
up, why code in all this genericity?  All these small scripts scattered
around just make things hard to use, and add security issues.


-- 
MSR
