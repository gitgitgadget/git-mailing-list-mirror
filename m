From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: Re: [PATCH] stash: dont save during a conflicted merge
Date: Mon, 15 Mar 2010 20:05:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003151954050.4362@narbuckle.genericorp.net>
References: <1268451633-30046-1-git-send-email-cxreg@pobox.com> <7vhbohdygu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 04:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrN64-0007RB-5j
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 04:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937304Ab0CPDF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 23:05:26 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:41323 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937042Ab0CPDFZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 23:05:25 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2G3530v016576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Mar 2010 22:05:05 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <7vhbohdygu.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142293>

On Mon, 15 Mar 2010, Junio C Hamano wrote:

> Dave Olszewski <cxreg@pobox.com> writes:
>
>> Similar to commit c8c562a, if a user is resolving conflicts, they may
>> think it wise to stash their current work tree and git pull to see if
>> there are additional changes on the remote.
>>
>> The stash will fail to save if the index contains unmerged entries, but
>> if the conflicts are resolved, the stash will succeed, and both
>> MERGE_HEAD and MERGE_MSG will be removed.  This is probably a mistake,
>> and we should warn the user and refuse to stash.
>
> Warning is probably Ok, but refusing with die() might be too much.
>
> When trying a topic with more than one integration branches (think
> "master", "next, "pu"), and the merge is a bit too hairy that I am not
> very confident with the resolution, I've deliberately used stash to record
> a tentative conflict resolution to avoid contaminating my rerere database:
>
>    $ git merge topic
>    ... heavy conflicts, manually "resolved" to a dubious result ...
>    $ git rerere clear
>    $ git stash save "tentative merge of topic"
>    $ git stash apply
>    ... test test test ...
>    $ git reset --hard
>    $ git checkout another-integration-branch
>    $ git stash apply
>    ... test test test ...
>    ... repeat the above for other integration branches ...
>
> This is using the stash as a glorified form of
>
>    $ git diff HEAD >./+save-tentative-merge
>
> and then applying it to other integration branches to test out
>
>    $ git reset --hard
>    $ git checkout another-integration-branch
>    $ git apply ./+save-tentative-merge
>
> but it actually is better than diff/apply because stash application uses a
> real three-way merge.
>
> So I am not entirely happy with this feature-removal.

This is an interesting use-case.  If you determine that your resolution
is satisfactory, how then do you complete your merge?  You can't apply a
stash on a dirty index, and the MERGE_* files are gone.  It seems like
using this workflow to "pause" and resume a merge is difficult, although
it's exactly the thing that led to this patch in the first place.  Maybe
git-stash could hold onto those files somehow if they exist when saving?
