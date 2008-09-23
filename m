From: Andreas Ericsson <ae@op5.se>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 10:20:58 +0200
Message-ID: <48D8A6EA.4020805@op5.se>
References: <20080922155749.c8070681.stephen@exigencecorp.com>	<20080922231927.ef18f420.stephen@exigencecorp.com>	<48D88813.9060400@viscovery.net> <20080923024653.a3bb8666.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:22:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki39z-0002WC-Ng
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 10:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYIWIVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYIWIVG
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 04:21:06 -0400
Received: from mail.op5.se ([193.201.96.20]:57581 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbYIWIVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 04:21:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 01C891B80081;
	Tue, 23 Sep 2008 10:11:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.263
X-Spam-Level: 
X-Spam-Status: No, score=-4.263 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.136, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9U+Lxf-BmqFJ; Tue, 23 Sep 2008 10:11:30 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C4FD41B80051;
	Tue, 23 Sep 2008 10:11:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080923024653.a3bb8666.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96537>

Stephen Haberman wrote:
>> This is the expected behavior and not up for debate.
> 
> Cool, thanks for the reply. However, I debate... :-)
> 
>>   ---o--o--o--o--o--o         <-- origin
>>                      \
>>                       A'--B'  <-- master
> 
> Nice. That makes sense in your scenario.
> 
> Here is mine:
> 
>  ---A--B--C--D           <-- origin/stable
>      \       |
>       E--F   |           <-- origin/topica
>           \  |
>              g--h        <-- topica
> 
> All the upper case commits have been published to origin. Other
> devs, etc., know about them, their hashes are in the bug tracking
> system.
> 
> I'm bringing topica up to date, but with a merge because I have
> published history already on topica, so I merge stable and get a
> new merge commit: g. And maybe make another change: h.
> 

Why do you merge stable at this point?

If you want the latest and greatest for testing/conflict resolution
purposes, you can simply throw away the merge later and just know
that it works.
If you need some bugfix on stable but not everything else, cherrypick
only that change. Otherwise you're applying a huge patch to fix a
small problem.

> Everything's cool...now, with surprising frequency, someone beats
> me to moving origin/topica:
> 
>  ---A--B--C--D           <-- origin/stable
>      \       |
>       E--F---|--I        <-- origin/topica
>           \  |
>              g--h        <-- topica
> 
> Pushing h gets rejected as a rewind. Good. I want to pull, which
> we had previously always used "--rebase" for, and the desired output
> of a pull --rebase, to me, would be:
> 
>  ---A--B--C--D           <-- origin/stable
>      \        \
>       E--F--I |          <-- origin/topica
>              \|
>               g'--h'     <-- topica
> 
> Instead, I get:
> 
>  ---A--B--C--D           <-- origin/stable
>      \
>       E--F--I            <-- origin/topica
>              \
>               B'-C'-D'-h'<-- topica
> 
> So, yes, linearized history with no merges. However, this leads
> to quizzical looks when B'/C'/D' hit the email list, bug tracker, etc.
> as new commits.
> 
> Currently I just try to pull/merge/push in quick succession, but
> it's a manual collaboration hack ("okay, I'm merging now, no
> committing...") that would be nice to not have to worry about.
> 

I think you just need to ask yourself *why* you're doing that
first merge of "stable" into your topic. If they aren't really
separate, using a topic-branch doesn't make so much sense. If
they *are* separate, doing the merge doesn't make much sense,
unless you're integration testing a snapshot build, but in that
case you'd want to throw away the merge once it's done and
tested.

> I need to investigate the interactive rebase more, but my hesitant
> assertion is that it's parent rewriting seems smart enough to handle
> this. Perhaps not, and I admit our desired DAG output may not be
> attainable without manual intervention.
> 
> I apologize--I should have included the example DAGs in my first
> post, but since I didn't I felt the need to clarify. So, humoring
> me, is the B'/C'/D' from this example really the expected behavior?
> 

Assuming the person who did "h" doesn't have the merge commit, then
yes.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
