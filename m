From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: who's on first? - following first parent and merge-management
Date: Thu, 08 Mar 2012 09:03:32 +0100
Message-ID: <4F5867D4.1010904@viscovery.net>
References: <jj6s47$m98$1@dough.gmane.org> <7vwr6woo8p.fsf@alter.siamese.dyndns.org> <7vty1zfwmd.fsf@alter.siamese.dyndns.org> <20120308071403.GE7643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 09:03:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5YK6-0000ig-Mq
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 09:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab2CHIDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 03:03:37 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31540 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752934Ab2CHIDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 03:03:37 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S5YJw-0001pC-Ml; Thu, 08 Mar 2012 09:03:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5BAD11660F;
	Thu,  8 Mar 2012 09:03:32 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120308071403.GE7643@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192535>

Am 3/8/2012 8:14, schrieb Jeff King:
> What if the user could specify a partial ordering of refs, and we used
> that order when listing merge parents in the resulting commit. So for
> example, if you said that:
> 
>   refs/remotes/origin/master > refs/heads/master
> 
> then doing:
> 
>   $ git checkout master
>   $ git pull origin master
> 
> would result in a "flipped" merge commit, with origin/master as the
> first parent, and master as the second.

I have wished for such a thing several times already.

It happens when I have a topic with changes that trigger a complete
rebuild of the project. When I merge it to master, I have to

   # on topic
   git checkout master   #1
   git merge topic       #2

#1 triggers a rebuild, but I don't do a build. Then #2 again triggers a
rebuild, but in reality the only changes since the last build are those
from master since the topic forked (no, I can't use ccache).

To avoid the situation, I jump through hoops by preparing an index and
worktree with the merge result while I am on topic:

   # on topic
   git checkout --detach
   git merge master      # triggers rebuild of only master's changes
   # merge result ready; carry it over to master and repeat the merge
   git reset --soft master
   git checkout master
   git merge topic       # fails if content merge is necessary
   git checkout master -- file/needing/content/merge # (*)
   git merge topic       # now succeeds

This would not be necessary if the order of the merge parents could be
specified, e.g.:

   # on topic
   git merge --into master

(*) Jumping through these hoops make sense only if
file/needing/content/merge is _not_ the one that triggers the complete
rebuild.

-- Hannes
