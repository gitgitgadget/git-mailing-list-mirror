From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] git-merge: Honor pre-merge hook
Date: Thu, 06 Sep 2012 10:16:19 +0200
Message-ID: <50485BD3.5020802@drmicha.warpmail.net>
References: <cover.1346851863.git.git@drmicha.warpmail.net> <dc8ebcd7f7b80ff930c04b5a407361ba8f2f077f.1346851863.git.git@drmicha.warpmail.net> <50476FFE.5070602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 06 10:16:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9XGP-0002zb-4Y
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 10:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab2IFIQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 04:16:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52456 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752310Ab2IFIQV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 04:16:21 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E9323202EA;
	Thu,  6 Sep 2012 04:16:20 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 06 Sep 2012 04:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=w7kovVNfdOHz9BXScoiecu
	n6m48=; b=gcL+gZ3ngTsxz+jYNA3P5vqTOoxPtIQ6GQPi1xJDGepo9uTyxu8nKF
	CL1HlxS2kEaSuu9eIA0jjQGxyju66o55BulX6/EqlHjztR1bCrxuZhyOWmI6AyTa
	77NsiZ4lQ8RkWyVeyY+2VFXWSPQO84/WgZB35hAHz0VSrNOYNCZmA=
X-Sasl-enc: NmxvEGr5ccCBrYTKlUxhe67yqFZRtBkIL4vIcsFvbYvL 1346919380
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 586C88E0217;
	Thu,  6 Sep 2012 04:16:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <50476FFE.5070602@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204870>

Michael Haggerty venit, vidit, dixit 05.09.2012 17:30:
> On 09/05/2012 03:39 PM, Michael J Gruber wrote:
>> git-merge does not honor the pre-commit hook when doing automatic merge
>> commits, and for compatibility reasons this is going to stay.
>>
>> Introduce a pre-merge hook which is called for an automatic merge commit
>> just like pre-commit is called for a non-automatic merge commit (or any
>> other commit).
> 
> What exactly is an "automatic merge commit"?  Is it any merge that
> doesn't have a conflict?  A merge that doesn't invoke the editor?  A
> merge done as part of another operation (e.g., pull)?  I don't see the
> term mentioned in the git-merge or githooks man pages.
> 
> I think it would be good if you would define this term in the
> documentation files that your patch touched, and perhaps in the githooks
> section about "pre-commit" as well.

"git merge" can go three ways:

F: fast forward: no commit is created, only a ref is changed
A: automatic: true merge (non-ff) without conflicts (i.e. chosen
strategy can perform the merge); a new commit is created
C: merge with conflicts: no commit is created but the index is prepared
(partially) for a merge commit

In case F, no commit hook is run (talking only about pre-commit/pre-merge).

In case A, no commit is run so far but my patch proposes pre-merge to be
run.

In case C, pre-commit (!) is run so far and after my patch.

> Secondly, though it is impossible (for backwards compatibility reasons)
> for the pre-commit hook to be invoked for automatic merges, no such
> considerations prohibit the pre-merge commit from being invoked for
> non-automatic merges.  In other words, both hooks, pre-commit *and*
> pre-merge, could be invoked for non-automatic merges.  Would this be
> preferable?
>
> It depends on what pre-merge scripts are likely to be used for.  If they
> will tend to be used for merge-specific actions, then it might be more
> convenient for *all* merges to be vetted by them.  On the other hand, if
> they tend to do the same actions as pre-commit hooks, then having
> non-automatic merge commits go through both hooks would tend to be more
> annoying than helpful.  Specifically, one of the scripts would probably
> have to check whether the merge is a non-automatic merge, and if so do
> nothing (i.e., letting the other script take care of it).  This would
> also require an easy way for a script to determine whether a commit is a
> non-automatic merge commit.
> 
> Have you considered this?

Your second paragraph explains why I did it the way I did. One can
easily have pre-merge call pre-commit, or have them be different. One
can not easily have only pre-merge called for a non-automatic merge
commit, but that is because of backward compatibility. The way *I* would
like it is:

- call pre-merge for any non-ff merge commit (automatic or not)
- call pre-commit for any non-merge commit (#parents <=1)

But that would break compatibility.

So I hope my patch is the best approximation to the above which keeps
compatibility and is simple to handle in most situations.

Cheers
Michael
