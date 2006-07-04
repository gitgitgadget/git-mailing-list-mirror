From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 13:08:10 -0700
Message-ID: <44AACAAA.1030708@gmail.com>
References: <44A9E6AE.10508@gmail.com>	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 04 22:08:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxrC2-0003jA-4Y
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 22:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWGDUIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 16:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWGDUIO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 16:08:14 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:41393 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932375AbWGDUIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 16:08:13 -0400
Received: by py-out-1112.google.com with SMTP id t32so1955472pyc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 13:08:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AipUaR8LKl75fUuPhzELyT53niAdQ/Rz9yefR+pFNFiM7xNNqQ65Iqq82dR1KwI3vrhIZsm1+M1+x+9C8N66R4IZkHrONHrB+BcqOBOUsqq0lSxQQ1WVtWpRHrbS1wdX6JumJ+h+eiERXVEhTodUa6H0JaKPckCjMZofN1u6yNg=
Received: by 10.35.82.15 with SMTP id j15mr4410419pyl;
        Tue, 04 Jul 2006 13:08:13 -0700 (PDT)
Received: from ?10.0.0.6? ( [69.160.147.208])
        by mx.gmail.com with ESMTP id w54sm635006pye.2006.07.04.13.08.11;
        Tue, 04 Jul 2006 13:08:12 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23313>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>>> This is a good demonstration that merge-base may not give you
>>> minimal set for pathological cases.  If you want to be through
>>> you could traverse everything to make sure we do not say 'S' is
>>> relevant, but that is quite expensive, so I think there will
>>> always be artifacts of horizon effect like this no matter how
>>> you try to catch it (didn't I keep saying that already?).
>> The problem is in mark_reachable_commits(); it is either superfluous
>> or it needs to parse_commit() those commits that haven't been parsed
>> yet that it needs to traverse.
> 
> Yes, you could traverse everything.  But that is not practical.
> We have known that the clean-up pass has this horizon effect,
> and it is a compromise.

The clean-up pass was devised to eliminate bases that are reachable from 
other bases. It just doesn't look hard enough.

> If you apply this testing patch on top of yours, you will see
> that parsing more commits at that point makes the clean-up
> pass go all the way down to the root commit.

Yes, I was aware of graphs that would have that behavior.

The root of the problem is that the heuristic, that attempts to use 
timestamps to detect that a commit is _not_ reachable from a given 
commit, relies on the timestamps of commits with a reachability 
relationship to have a relationship that matches the graph.

> We may alternatively not use the clean-up pass at all, but I
> suspect that might give us many false positives.  I don't
> remember the details but I think we added it while fixing
> merge-base in the real life situation.

The history of the clean-up pass is that before it was added, 
git-merge-base was returning a base reachable from another base, and the 
base returned was, in some significant way, worse for merging. My 
construct demonstrates that the clean-up pass only deals with special case.

> It may be interesting to run tests on real merges (I believe the
> kernel repository has a handful merges that have more than one
> merge bases) to see how effective the current clean-up pass is.
> It may turn out to be ineffective in practice, in which case we
> could kill it off.

Although a very important set of repositories to Git, the linux kernel 
repositories may no longer be representative of the diversity of Git 
use. Still, it would be interesting to know the outcome.
