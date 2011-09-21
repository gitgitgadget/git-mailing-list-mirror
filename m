From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git checkout under 1.7.6 does not properly list untracked files
 and aborts
Date: Wed, 21 Sep 2011 09:47:54 +0200
Message-ID: <4E7996AA.4040909@drmicha.warpmail.net>
References: <4E6A7167.6070408@workspacewhiz.com> <4E779BA4.8070109@workspacewhiz.com> <4E78ACE2.60306@drmicha.warpmail.net> <4E78DACF.3030200@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 09:48:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6HXI-0008Ni-KI
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 09:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab1IUHr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 03:47:59 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48500 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab1IUHr6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 03:47:58 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id DD6D3290B8;
	Wed, 21 Sep 2011 03:47:57 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 21 Sep 2011 03:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1VUQAGHvO9tsDVkPvHDUJg
	4u+Sg=; b=HpRCbtZwL1EgnrRApmEJJmwWgtkHDAE5vgjQbHmtpWPA0NgboGxEt7
	2vD8zG4Q5eku5sA2mHGfpnk+kDZFIHP7z5sb6cgxzreKlmOZdaphCyX1tcFDzmAR
	gbC02LxqL9xZxNYbkgDVm3KMgJ6Mziqs1Ce69s20rNU8i+6uqLrV0=
X-Sasl-enc: cyBwE0CC/4836iuGylBeyVSN3zsFtFMZlD+rRY+vVNU5 1316591277
Received: from localhost.localdomain (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C3D317C064A;
	Wed, 21 Sep 2011 03:47:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <4E78DACF.3030200@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181820>

Joshua Jensen venit, vidit, dixit 20.09.2011 20:26:
> ----- Original Message -----
> From: Michael J Gruber
> Date: 9/20/2011 9:10 AM
>> Can you provide a simple test case, such as this one:
>>
>> ---%<---
>> #!/bin/sh
>>
>> rm -Rf utest || exit 1
>> mkdir utest || exit 1
>> cd utest || exit 1
>> git init
>> echo tracked>a
>> git add a
>> git commit -m a a
>> git branch side
>> echo tracked>b
>> git add b
>> git commit -m b
>> cat b
>> git checkout side
>> cat b
>> echo untracked>b
>> cat b
>> git checkout master
>> cat b
>> ---%<---
>>
>> Does this test reproduce your problem on msysgit?
> As listed, your script produces the same results on msysGit.
> 
> It appears the issue is related to sparse checkouts:
> 
> ---%<---
> #!/bin/sh
> 
> rm -Rf utest || exit 1
> mkdir utest || exit 1
> cd utest || exit 1
> git init
> git config core.sparseCheckout true
> echo *>.git/info/sparse-checkout
> echo tracked>a
> git add a
> git commit -m a a
> git branch side
> echo tracked>b
> git add b
> git commit -m b
> cat b
> git checkout side
> cat b
> echo untracked>b
> cat b
> git checkout master
> cat b
> ---%<---
> 
> -Josh

Interesting. So, it is related to sparse, it seems, and there is also a
mistake in the documentation (which contradicts itself, btw). With your
script, since all files are requested to be checked out ('*'), none
should have skip-worktree set, and the result should be the same as with
my version. But I get this:

Initialized empty Git repository in /tmp/t/utest/.git/
[master (root-commit) 5929c8b] a
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
[master 60ad69e] b
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 b
tracked
Switched to branch 'side'
cat: b: No such file or directory
untracked
untracked

That is probably the same output as for you. The final "git checkout
master" errored out without doing anything and without message. I'll
send a few cleanups now, and do some bisecting and thinking later;
though there are people whose sparse-knowledge is way less sparse than
mine ;)

Michael
