From: Andreas Ericsson <ae@op5.se>
Subject: Re: suggestion? only pull cleanly applying commits
Date: Wed, 26 Nov 2008 14:30:54 +0100
Message-ID: <492D4F8E.10002@op5.se>
References: <492D37A2.4010500@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Maximilian Mehnert <maximilian.mehnert@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 14:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5KV6-0005jB-RT
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 14:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYKZNa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 08:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbYKZNa7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 08:30:59 -0500
Received: from mail.op5.se ([193.201.96.20]:34453 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbYKZNa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 08:30:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4F58E24B0BF4;
	Wed, 26 Nov 2008 14:26:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9SZnaOPjmIv; Wed, 26 Nov 2008 14:26:42 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id C3EC024B0BE5;
	Wed, 26 Nov 2008 14:26:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <492D37A2.4010500@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101734>

Maximilian Mehnert wrote:
> Hi!
> 
> I've a scenario where I don't really want to do a full merge but rather
> to pull all commits from another repository that merge without conflicts.
> 
> I've put together the script at the bottom which seems to work ok but is
> damn slow.
> 
> Is there a smarter and faster way to do this that I missed reading the
> documentation?
> 
> Any help would be really appreciated! :-)
> 
> Regards,
> Maximilian
> 
> 
> #!/bin/sh
> 
> for commit in `git rev-list --reverse HEAD..other-repository/master`; do
>         git diff-tree -p $commit|patch --dry-run -p1 -N -f >/dev/null
>         if [ $? -eq 0 ]; then
>                 echo "getting $commit"
>                 parents=`git rev-list --parents -n1  $commit|wc -w`
>                 if [ $parents -eq 2 ]; then
>                         git cherry-pick $commit
>                 else
>                         git cherry-pick -m1 $commit
>                 fi
>         fi
> done
> 

The fact that you're cherry-picking the commits means you create new
ones, constantly. It's very, very, very bad practice to do from a
script with commits you're getting from somewhere else. Git can (and
will) handle it properly come merge-day, but your history will be a
stinking pile of horse-manure if you keep it up for very long.

There are more important questions, however.

1. Why do you have to merge so often? Merging is something that should
   not be undertaken lightly, and you shouldn't do it "just to stay up
   to date".
2. Why can't you just merge (resolving conflicts as they appear) when
   you're done with what you're working on?

Remember that "conflict-free" means totally different things depending
on which way you're looking at it. Upstream could rename a function
that you're using, and it would merge without *textual* conflicts, but
your stuff would be totally broken afterwards. Such design-scope
conflicts can only be protected from with testing. Git will not handle
them for you.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
