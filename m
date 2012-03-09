From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: who's on first? - following first parent and merge-management
Date: Fri, 09 Mar 2012 13:29:22 +0100
Message-ID: <4F59F7A2.3030606@viscovery.net>
References: <jj6s47$m98$1@dough.gmane.org> <7vwr6woo8p.fsf@alter.siamese.dyndns.org> <7vty1zfwmd.fsf@alter.siamese.dyndns.org> <20120308071403.GE7643@sigill.intra.peff.net> <4F5867D4.1010904@viscovery.net> <7vpqcndmpa.fsf@alter.siamese.dyndns.org> <4F59F212.6030701@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Mar 09 13:29:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ywv-0000ED-1e
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 13:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab2CIM3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 07:29:30 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:34084 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075Ab2CIM32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 07:29:28 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S5ywk-0001Y3-Vk; Fri, 09 Mar 2012 13:29:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A83941660F;
	Fri,  9 Mar 2012 13:29:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F59F212.6030701@ira.uka.de>
X-Enigmail-Version: 1.3.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192715>

Am 3/9/2012 13:05, schrieb Holger Hellmuth:
> On 08.03.2012 18:30, Junio C Hamano wrote:
>> Johannes Sixt<j.sixt@viscovery.net>  writes:
>>> To avoid the situation,...
>>> This would not be necessary if the order of the merge parents could be
>>> specified, e.g.:
>>>
>>>     # on topic
>>>     git merge --into master
>>
>> I think the underlying mechanism needed to implement the above
>> shares a lot with what Jeff called "crazy idea", but where you would
>> want to be after such a merge may be different in these two cases.
> 
> I don't think there is much question that you should still be in the same
> branch. Not because you necessarily want to be in that branch. But because
> it would be surprising if git-merge changed your branch sometimes and most
> times not.

I don't think that it is so clear-cut. And for this reason, I would even
go as far as to suggest that you should end up with a detached HEAD.

Before the merge we have this situation:

--o--o--o--o      <- master
   \
    o--o--o--X    <- topic

The result of 'git merge --into master' must advance branch master by the
merge commit (I think there is no doubt about this):

--o--o--o--o---M  <- master
   \          /
    o--o--o--X    <- topic

Also, the index and worktree must match M (no doubt, either, IMO). But
what does HEAD refer to? I see three possibilities:

1. master; as you say, this may be surprising if we were on topic before
the branch.

2. topic; but then the index would be dirty because it does not match X.

3. M, i.e. a detached HEAD; this is just a compromise and a fat warning at
the end of the merge output would be necessary that instructs the user to
checkout a suitable branch.

Now that I have tossed around these ideas, there's another caveat: What if
the merge fails due to a conflict? After the conflicts were resolved, 'git
commit' is needed to complete the merge. But this would create the commit
where HEAD points to. IOW, we have to chose option 1 so that the merge
commit advances master.

Would this be less surprising if the option were named --checkout-into?

-- Hannes
