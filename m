From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Fri, 09 Mar 2007 08:40:04 -0500
Message-ID: <45F163B4.2000905@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 14:40:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPfKO-0007qK-Mm
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 14:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767285AbXCINkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 08:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767287AbXCINkF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 08:40:05 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:29620 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767285AbXCINkB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 08:40:01 -0500
Received: by an-out-0708.google.com with SMTP id b33so767225ana
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 05:40:01 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eN4xYbKhbQm037as3g4s6dgbZNGIEE+gO+Uh0E2wk2T/ObE+LhXY/s7Lpm4t6xidK9jkxhTsBBW4k057f9oZkNDCTl3lLkZX43P6VQNG33nqd6DLPAtBG/6Ou1jEHZ3ib6g0o/XIgalJ6WJeY+miCI6jiPp2FgHMq6K6pOvJ84Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sbKUqHzP36EIPVOB1zER1u1bdUPmUSrsUTNxpc8xhHsA2EJ2ZJZtBrJFhv1PaIYCFQxpWsR2CHuvoo2GlrlP3JRP6ryVrfw9cDHvekVV1ainm54rdhDlgrulaFyj4K4Mpktj+9geiRyuu4Lj4FXwhPqebitjdsg1b28Nm+hb+fg=
Received: by 10.100.190.8 with SMTP id n8mr1215128anf.1173447600692;
        Fri, 09 Mar 2007 05:40:00 -0800 (PST)
Received: from ?10.1.5.213? ( [206.166.206.34])
        by mx.google.com with ESMTP id c27sm4850155ana.2007.03.09.05.39.59;
        Fri, 09 Mar 2007 05:39:59 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41795>

Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
> I am not sure if the above is true.  How are you preventing the
> command from bundling everything?  You must have some limiter at
> the bottom, something like --since=25.hours (to account for cron
> schedule skew), not just <list of refs>.
>   
Sorry, I trimmed too much. My typical command usage is something like
    git bundle create foo --since=10.days.ago --all

I include a very generous date range so that folks don't have to update 
daily, can cover a vacation with a single bundle, etc. I think this 
usage renders moot all practical issues with clock skew. I am being 
loose, if the bundle won't apply then get one from the previous week, 
apply, and go forward.

BTW, shouldn't git check for clock skew when creating a commit to assure 
the parents predate the child? Clock skew could allow this circumstance 
which would look suspicious when exploring a history.
> In any case, the semantics of --since=25.hours limiter is not
> "show everything newer than 25.hours that are reachable from any
> of these refs"; it is "start digging from these tips, and stop
> exploring the path as soon as you hit something that is newer
> than 25.hours".
>   
I presume you mean "older than 2.5" hours in the above.

> If I were doing a nightly script, I would probably be doing
> something like this:
>
> 	#!/bin/sh
> 	yesterday=$(git bundle list-heads yesterday.bdl | sed -e 's/ .*//')
> 	git bundle create today.bdl --all --not $yesterday
> 	# mail it out
>
> After sending today's bundle out, you will rotate it out to
> yesterday.bdl in order to prepare for the next round.  It is
> likely that you would want to keep a few day's worth of bundles
> for other reasons _anyway_ (say, some project members might be
> out of office, or mail gets dropped, or whatever), I think the
> above is a reasonably clean and easy thing to arrange.
>
>   
This is certainly a reliable method, but has the difficulty of how to 
get started and of course requires that history be kept for the entire 
range covered by each bundle. The first bundle is either a) the entire 
repository, or b) crafted by trying each and every ref to find which are 
legal to define. While all of this can be done, I think this cure is 
worse than the disease (seconds to minutes of clock skew).

I would prefer to just add a warning to the manual that when limiting by 
date, be generous to allow for all possible clock skew across the 
distributed set of computers.

Mark
