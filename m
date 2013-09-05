From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 5 Sep 2013 12:38:22 +0100
Message-ID: <20130905113822.GF2582@serenity.lan>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
 <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
 <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
 <CAEBDL5VfHObeWZWvj0bnv5x+QF1_DACdU+Ehds6fHUioziHWrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 13:38:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHXtY-0003K2-Jh
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 13:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934561Ab3IELig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 07:38:36 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:58288 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934435Ab3IELif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 07:38:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 13BC522EF4;
	Thu,  5 Sep 2013 12:38:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8sN3RT4tGL8; Thu,  5 Sep 2013 12:38:33 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 9775321755;
	Thu,  5 Sep 2013 12:38:24 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAEBDL5VfHObeWZWvj0bnv5x+QF1_DACdU+Ehds6fHUioziHWrQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233953>

On Thu, Sep 05, 2013 at 07:01:03AM -0400, John Szakmeister wrote:
> On Wed, Sep 4, 2013 at 6:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [snip]
> > When "git pull" stops because what was fetched in FETCH_HEAD does
> > not fast-forward, then what did _you_ do (and with the knowledge you
> > currently have, what would you do)?  In a single project, would you
> > choose to sometimes rebase and sometimes merge, and if so, what is
> > the choice depend on?  "When I am on these selected branches, I want
> > to merge, but on other branches I want to rebase?"
> 
> Our team isn't quite proficient enough yet to have a completely rebase
> workflow... though we might have less of a problem if we did.  So,
> several interesting points.  Most of the time, `git pull` would be a
> fast-forward merge.  We typically perform the merges of topic branches
> server-side--we have a build server who checks to make sure the result
> would be successful--and we just hit the big green button on the Merge
> button for the pull request (we use GitHub Enterprise at the moment).
> 
> However, nearly as often, we just merge the branch locally because
> someone on the team is doing some manual testing, and it's just
> convenient to finish the process on the command line.  What
> occasionally happens is that you merge the topic locally, but someone
> else has introduced a new commit to master.  We try to preserve the
> mainline ordering of commits, so `git pull` doing a merge underneath
> the hood is undesirable (it moves the newly introduced commit off to
> the side).  Rebasing your current master branch is not the answer
> either, because it picks up the commits introduced by the topic branch
> and rebases those to--at least with the -p option, and without it, the
> results are just as bad).  Instead, we want to unfold our work,
> fast-forward merge the upstream, and the replay our actions--namely
> remerge the topic branch.  It often ends up translating to this:
> 
>    $ git reset --hard HEAD~1
>    $ git merge --ff-only @{u}
>    $ git merge topic
>    $ git push
> 
> So what I really want isn't quite rebase.  I'm not sure any of the
> proposed solutions would work.  It'd be really nice to replay only the
> mainline commits, without affecting commits introduced from a topic
> branch.

Does "git rebase --preserve-merges" do what you want here?
