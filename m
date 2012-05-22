From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Tue, 22 May 2012 21:30:17 +0200
Message-ID: <4FBBE949.8060305@kdbg.org>
References: <4FBAA33D.1080703@kdbg.org> <7vobpg3wj6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 21:30:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWumo-0000Wc-HW
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 21:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760214Ab2EVTaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 15:30:21 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41258 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab2EVTaV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 15:30:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AF81AA7ED0;
	Tue, 22 May 2012 21:31:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6ED8A19F69F;
	Tue, 22 May 2012 21:30:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <7vobpg3wj6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198232>

Am 22.05.2012 20:23, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> When rebase -p had to replay a merge commit, it used to redo the merge.
>> But this has drawbacks:
>>
>> - When the merge was evil, i.e., contained changes that are in neither of
>>   the parents, that change was not preserved.
> 
> This is a desiable property, and not necessarily limited to "evil" merges
> but also applies to everyday conflict resolutions.  Replaying the change
> between the merge and its first parent is a way to achieve it, but I think
> it also has downsides.  If you are replaying a merge to an updated history
> that already contains a part of what is merged, some part of the
> difference between the original merge and its first parent already exists
> in the commit that the will become the first parent of the replayed merge.

Yes, in such a case we need some cleverness from the merge machinery in
cherry-pick: It has to recognize that some changes were applied on both
branches. This might generate new conflicts.

I'll have to see whether this is an issue in practice.

At any rate, if any difficulties with a particular merge commit can be
anticipated, it is always possible to replace the

  pick that-merge-commit

instruction by

  x git merge that-branch

(we could even generate these lines in the instruction sheet as a comment).

>> - The 'git merge' invocation passed the commit message of the old merge
>>   commit, but it still obeyed the merge.log option. If it was set, the log
>>   ended up twice in the commit message.
> 
> This should be fixed independent of this patch, no?  Is it a matter of
> just passing --no-log or something, or is there anything more elaborate
> necessary?

Frankly, IMHO[*], rebase -p that is based on git-cherry-pick is so much
better that I don't want to think about which workarounds would be
needed to make it work better with git-merge :-)

[*] It is still only an opinion. I haven't gotten around to use the
updated rebase -p in the field. Another reason that it's still RFC.

Thanks,
-- Hannes
