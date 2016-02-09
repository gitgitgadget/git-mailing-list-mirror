From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: Bug report: 'git commit --dry-run' corner case: returns error  ("nothing to commit") when all conflicts resolved to HEAD
Date: Mon, 08 Feb 2016 18:55:17 -0700
Message-ID: <72756249.nAoBccgOj7@thunderbird>
References: <1649296.sC1eN3ni6k@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Ovidiu Gheorghioiu <ovidiug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 02:55:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSxWH-0001n2-Lt
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 02:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbcBIBzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 20:55:02 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:55822 "EHLO
	fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbcBIBzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 20:55:01 -0500
Received: from fed1rmimpo305 ([68.230.241.173]) by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160209015500.KUVX17588.fed1rmfepo103.cox.net@fed1rmimpo305>
          for <git@vger.kernel.org>; Mon, 8 Feb 2016 20:55:00 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo305 with cox
	id G1v01s0012tqoqC011v0nA; Mon, 08 Feb 2016 20:55:00 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.56B946F4.006F,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=f8aW8pOM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=jFJIQSaiL_oA:10 a=pGLkceISAAAA:8
 a=TSbVqHtbAAAA:8 a=7kFP1d7yrrZWZ7r2cTMA:9 a=CjuIK1q_8ugA:10
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id ABA4513F6F5;
	Mon,  8 Feb 2016 18:55:17 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.4.0-2-generic; KDE/5.15.0; x86_64; ; )
In-Reply-To: <1649296.sC1eN3ni6k@thunderbird>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285829>

Ovidiu Gheorghioiu <ovidiug@gmail.com> wrote:
>  Hi git guys,
>
> The bug is fairly simple: if we have a conflicted merge, AND all the
> conflicts have been resolved to the version in HEAD, the commit
> --dry-run error code says nothing to commit. As expected, git commit
> goes through.
> 
> The commit message IS correct (-ish), just not the error code:
> 
> """
> All conflicts fixed but you are still merging.
>   (use "git commit" to conclude merge)
> 
> nothing to commit, working directory clean
> """
> 
> The script below demonstrates the problem; version tested was 2.5.0.
> Let me know if you need any more details.
> 
> Best,
> Ovidiu
> 
> ------
> #!/bin/bash
> mkdir test-repository || exit 1
> cd test-repository
> git init
> echo "Initial contents, unimportant" > test-file
> git add test-file
> git commit -m "Initial commit"
> echo "commit-1-state" > test-file
> git commit -m "commit 1" -i test-file
> git tag commit-1
> git checkout -b branch-2 HEAD^1
> echo "commit-2-state" > test-file
> git commit -m "commit 2" -i test-file
> 
> # Creates conflicted state.
> git merge --no-commit commit-1
> 
> # Resolved entirely to commit-2, aka HEAD.
> echo "commit-2-state" > test-file
> # If we'd set to commit-1=state, all would work as expected (changes vs HEAD).
> git add test-file
> 
> # =====  Bug is here.
> git commit --dry-run && echo "Git said something to commit" \
>         || echo "Git said NOTHING to commit"
> 
> git commit -m "Something to commit after all" && echo "Commit went through"
> 
> git log --pretty=oneline
> 
> cd ..

I've reproduced the bug with git 2.7.1. [1]
I plan on adding a test case and a patch to fix this.

[1] http://article.gmane.org/gmane.comp.version-control.git/276591

I would have responded to the original email but 
the gmane "follow-up" is not sending out the email.
