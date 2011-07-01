From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 07/31] rebase: stricter check of standalone sub
 command
Date: Fri, 1 Jul 2011 09:16:49 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1107010833310.580@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-8-git-send-email-martin.von.zweigbergk@gmail.com> <20110701035503.GA9818@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 15:17:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcdaf-0004AL-V4
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 15:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab1GANQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 09:16:57 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34778 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab1GANQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 09:16:56 -0400
Received: by vxb39 with SMTP id 39so2318355vxb.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=Cl/Sc9AZa8EK5f8aDv6YwbbQ+hJD5XSZkGbBQCFeFxc=;
        b=ZUSV+2DQ3tYYZtRxrv3hpxYg6w9DdvAREylhpCIyvjqm5lQRfOx8bY1b1APNQ8bTHm
         OzyFkoN+X+5msTKlDpPd5UBgJI5q4ZC+NrgupplIiMfo0hF9oVUInbrbTb4N0xZFNvKh
         ekq7MaDOfACf6OCiZDtTtUtXX0QraGaZHOS8A=
Received: by 10.52.180.103 with SMTP id dn7mr4588114vdc.220.1309526215523;
        Fri, 01 Jul 2011 06:16:55 -0700 (PDT)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e8sm1254405vdf.21.2011.07.01.06.16.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Jul 2011 06:16:53 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <20110701035503.GA9818@elie>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176521>

Hi Jonathan,

On Thu, 30 Jun 2011, Jonathan Nieder wrote:

> Hi Martin,
> 
> Martin von Zweigbergk wrote:
> 
> > The sub commands '--continue', '--skip' or '--abort' may only be used
> > standalone according to the documentation.
> [...]
> > Is this too simplistic? Do we forsee that we want to support passing
> > options when resuming a rebase? Is it better to check for each other
> > option that it is not passed (i.e. no '-v', no '-s' etc.)?
> >
> > Might some users be depending on the current behavior, even though it
> > is undocumented?
> 
> Yes.
> 
> I have no clue why, but my fingers are wired to do
> 
> 	git rebase -i --continue
> 
> when resuming an interactive rebase.  So with v1.7.6, I use two commands
> instead of one.
> 
> It's possible that I was crazy, and we should just mention this in the
> release notes and move on.  Another possibility would be to make "git
> rebase -i --continue" mean "check if in the middle of an interactive
> rebase, and if so, continue".  Yet another possibility would be to
> allow transforming a non-interactive rebase into an interactive one
> after a conflict with that command (though I can't imagine why someone
> would want to).  I'm tempted to say the first way (keeping the command
> broken and documenting the change) is the way to go, since it means it
> would be possible to make commands like this mean something else in
> the future.
> 
> What do you think?

I think it feels like 'git rebase -i --continue' to resume a
non-interactive rebase should be an error until we actually support
transforming it into an interactive rebase (if ever). I agree that if
the rebase was already interactive, it would not harm to accept
it. OTOH, since the -i means nothing in this context, I don't see much
need to accept it either. In short, I agree with you that documenting
it is enough. Is the below patch what you had in mind?


> *searches*
> 
> Ah, it seems you already wrote a patch at [1].  The commit message
> says it fails for "-i --continue" but I don't any code doing that;
> what am I missing?

That patch was never accepted, but 95135b0 (rebase: stricter check of
standalone sub command, 2011-02-06) was.

> [1] http://thread.gmane.org/gmane.comp.version-control.git/164241/focus=166684
> 


-- >8 --
Subject: [PATCH] rebase usage: subcommands can not be combined with -i

Since 95135b0 (rebase: stricter check of standalone sub command,
2011-02-06), git-rebase has not allowed to use -i together with
e.g. --continue. Yet, when rebase started using OPTIONS_SPEC in
45e2acf (rebase: define options in OPTIONS_SPEC, 2011-02-28), the
usage message included

  git-rebase [-i] --continue | --abort | --skip

Remove the "[-i]" from this line.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d7855ea..6afc596 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -32,7 +32,7 @@ OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] --onto <newbase> --root [<branch>]
-git-rebase [-i] --continue | --abort | --skip
+git-rebase --continue | --abort | --skip
 --
  Available options are
 v,verbose!         display a diffstat of what changed upstream
-- 
1.7.5.3.640.gd1066
