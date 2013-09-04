From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 4 Sep 2013 11:16:43 +0100
Message-ID: <20130904101643.GC2582@serenity.lan>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 04 12:17:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHA8y-0004lu-3T
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 12:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab3IDKQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 06:16:55 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:35147 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab3IDKQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 06:16:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4B168CDA5B7;
	Wed,  4 Sep 2013 11:16:54 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2o8DSd7468vt; Wed,  4 Sep 2013 11:16:53 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id BB029CDA5BF;
	Wed,  4 Sep 2013 11:16:45 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130904092527.GB22348@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233828>

On Wed, Sep 04, 2013 at 05:25:27AM -0400, Jeff King wrote:
> On Wed, Sep 04, 2013 at 09:10:47AM +0100, John Keeping wrote:
> 
> > I think there are two distinct uses for pull, which boil down to:
> > 
> >     (1) git pull
> >     (2) git pull $remote $branch
> > 
> > For (1) a merge is almost always the wrong thing to do since it will be
> > backwards and break --first-parent.
> 
> Is it always wrong? You are assuming a topic-branch workflow where
> --first-parent is actually meaningful. What about a centralized workflow
> where everyone works on "master"? The correct thing to do on a non-ff
> push in that case is "git pull && git push". Some people would argue
> that the pull should rebase there, but I think there are valid arguments
> either way. We can discuss in that direction if you want.

I'm one of the people who argues that it should rebase there ;-)  The
point of jc/pull-training-wheel is to help users think about that.

> I can perhaps buy the argument that it is better to help people who are
> using a topic branch workflow (which we generally want to encourage) to
> avoid making backwards merges, and the cost is that people with sloppy
> workflows will have to do more work / configuration. But we should be
> clear that this is a tradeoff we are making.
> 
> The patch in jc/pull-training-wheel talks about annoying old timers, but
> I think you may also be annoying clueless new users who simply want an
> svn-like workflow without thinking too hard about it.

The scenario I have is a central repository where some developers use a
topic branch workflow but others are less familiar with Git and don't
really think about what they're doing.

> > > I do not think we know what we want is to affect "git pull origin".
> > 
> > I consider "git pull $remote" to be an artifact of the way git-pull is
> > implemented on top of git-fetch; perhaps I'm missing something but I
> > can't see a scenario where this is useful.
> 
> Imagine a workflow where each topic is in its own repository instead of
> in its own branch inside a repository. Or where each developer has his
> or her own repository, but everybody just works on the master branch of
> their repository (or perhaps uses branches, but keeps master as a stable
> base). Alice is the integration manager; Bob tells her that he has work
> ready to integrate.  She runs "git pull ~bob/project", which will merge
> Bob's HEAD.
> 
> This is not very different from the kernel workflow, where Linus may do
> a "git pull $remote" to fetch a sub-system maintainer's work, except
> that these days people typically mark the to-be-integrated work in a
> "for-linus" branch or tag. However, you can find many "Merge git://"
> entries even in recent kernel history.
> 
> I think this kind of pull would fall into the same situation as your (2)
> above.

OK - so I was missing this.  Given this, the jc/pull-training-wheel
series is doing the right thing here.
