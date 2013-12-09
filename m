From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] rebase: use reflog to find common base with upstream
Date: Mon, 9 Dec 2013 20:40:08 +0000
Message-ID: <20131209204008.GF3163@serenity.lan>
References: <9e5fa57b027e1a5cd11a456c14f43b64f8f5386c.1386531376.git.john@keeping.me.uk>
 <xmqq7gbdzsvt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:40:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7cv-0007kv-AW
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009Ab3LIUkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:40:21 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:33214 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582Ab3LIUkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:40:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3DEEF6064D2;
	Mon,  9 Dec 2013 20:40:19 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n3TFoJgS1jNT; Mon,  9 Dec 2013 20:40:18 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C8D906064CA;
	Mon,  9 Dec 2013 20:40:10 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqq7gbdzsvt.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239090>

On Mon, Dec 09, 2013 at 12:11:50PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Last time this came up [1], there was some discussion about moving the
> > added block of code to affect upstreams given on the command line as
> > well as when the upstream is discovered from the config.  Having tried
> > that, it has some more fallout on the test suite than I like; this
> > pattern ends up dropping the tip commit of "side" because it's in the
> > reflog of "master":
> >
> > 	# start on "master"
> > 	git branch side &&
> > 	git reset --hard HEAD^ &&
> > 	git checkout side &&
> > 	git rebase master
> 
> We shouldn't do anything funky using the reflog when an explicit
> commit object name was given like in the last step above, I think.
> Automation to help human end-users is good, but at some level there
> must be a mechanism to reliably reproduce the same result given the
> same precondition for those who implement such automation, and I do
> not think it is a good idea to force scripts to say
> 
> 	git rebase --do-not-look-at-reflog master
> 
> in order to do so.
> 
> > I wonder if it would be better to add a --fork-point argument to
> > git-rebase and default it to true when no upstream is given on the
> > command line.
> 
> I am not sure what you exactly mean by "when no upstream is given",
> though.  Do you mean
> 
> 	git rebase <no other arguments>
> 
> which we interpret as "rebase the current branch on @{u}", and it
> should behave as if the command was run like so:
> 
> 	git rebase --fork-point @{u}
> 
> If that is what you suggest, I certainly can buy that.  Those who
> want to disable the automation can explicitly say
> 
> 	git rebase @{u}
> 
> and rebase the current exactly on top of the named commit (e.g. the
> current value of refs/remotes/origin/master or whatever remote-tracking
> branch you forked from).

Yes, that's what I meant; the first non-option argument to "git rebase"
is called "upstream" in the manpage (and throughout the code).  So if
"<no other arguments>" means "<no non-option arguments>" then that's
exactly what I meant.
