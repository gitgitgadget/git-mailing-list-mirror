From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git rev-list --all --reflog does not include worktree references
Date: Tue, 6 Oct 2015 11:39:09 +0200
Message-ID: <561396BD.9030205@drmicha.warpmail.net>
References: <87io6l16cc.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 11:39:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjOiK-0003Vl-F4
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 11:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbbJFJjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 05:39:12 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45805 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751552AbbJFJjL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 05:39:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B4D00201C0
	for <git@vger.kernel.org>; Tue,  6 Oct 2015 05:39:10 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 06 Oct 2015 05:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=wSnfNW6B3LUwtKMQD0+MQGQqUQc=; b=LPl4pJ
	0YsZbtol2cvdsDpiapNeskYAVfGXvRoTk5G2bJ2UmHUpuP6m0mPrbXw97ep1FuTG
	CmV4lCQ8eeIpAphmd+PjIBPuEUQ02+LtvQWuJwvHkZL5PB7GrsFcIw0eBYNS7min
	P2baTcrFQwvq8Um3cGmvEX8ycS6Sx77YBIdNE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=wSnfNW6B3LUwtKM
	QD0+MQGQqUQc=; b=ksBOGRUFL4/fndoz2PORJbK3z5KJ7U7V3ABMnS7L/Z0xBRF
	pGdPpEGSkxwAtTnWjf3oLCdgR1aHB4TQOjQUEEhbKrklBNjq+r75Sdr47zb8CUxT
	Q26BMtIHU3eA17hj9sr0dVlIrFeA0B2Byi0thq/XNz30nz4/MTf7Vvn4k4TE=
X-Sasl-enc: 3Kpk9bGSVJoGMFIg/r98FiOmAObkwkYPWW/ydtOqkidD 1444124350
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3472E68015B;
	Tue,  6 Oct 2015 05:39:10 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <87io6l16cc.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279126>

Andreas Schwab venit, vidit, dixit 05.10.2015 21:08:
> When running git rev-list --all --reflog in the main worktree it doesn't
> include commits only referenced by the worktrees, neither HEAD nor its
> reflog.

HEAD is per worktree, so other worktrees' HEADs should not be included
in "--all", I would think.

> $ git init test
> $ cd test
> # add some commits
> $ touch 1; git add 1; git commit -m 1
> $ touch 2; git add 2; git commit -m 2
> # add new worktree
> $ git worktree add ../test2 master^{}
> $ cd ../test2
> # add more commits
> $ touch 3; git add 3; git commit -m 3
> $ touch 4; git add 4; git commit -m 4
> # create an unreferenced commit
> $ git checkout @^
> # both commands should give the same number of commits
> $ git rev-list --reflog | wc -l
> 4
> $ git -C ../test rev-list --all --reflog | wc -l
> 2
> 
> IIUC this will cause git gc to prune references from worktrees too
> early.

Since HEAD is per worktree, its reflog is so, too. So I think that "git
rev-list" is actually right.

What's worrysome is that running "git prune -n" gives different results,
depending on whether you run it in the main worktree or the new worktree.

In fact, running "git prune" in the main worktree followed by "git
reflog" in the new worktree results in

fatal: bad object HEAD

So, "rev-list" should learn something like "--reflogs" or (better)
"--worktrees" to make it look at worktree specific refs, too, and prune
should use that, of course. "prune" does know about worktrees, but I
guess it looks at HEADs only, not their reflogs.

Michael
