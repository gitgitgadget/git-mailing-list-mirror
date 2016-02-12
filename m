From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: Bug report: 'git commit --dry-run' corner case: returns error  ("nothing to commit") when all conflicts resolved to HEAD
Date: Thu, 11 Feb 2016 18:04:03 -0700
Message-ID: <2471685.OJU1dNe0yn@thunderbird>
References: <1649296.sC1eN3ni6k@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 02:03:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU29O-0005bX-2C
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 02:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbcBLBDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 20:03:54 -0500
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:54218 "EHLO
	fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcBLBDx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 20:03:53 -0500
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160212010352.JNGI26406.fed1rmfepo203.cox.net@fed1rmimpo209>
          for <git@vger.kernel.org>; Thu, 11 Feb 2016 20:03:52 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo209 with cox
	id HD3s1s0052tqoqC01D3sd8; Thu, 11 Feb 2016 20:03:52 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.56BD2F78.007B,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=RNFt6fe+ c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=jFJIQSaiL_oA:10 a=mvw1aI2ua-iA7i51uRgA:9
 a=CjuIK1q_8ugA:10 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 1999F13F650;
	Thu, 11 Feb 2016 18:04:04 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.4.0-4-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286024>

On Monday, February 08, 2016 06:55:17 PM Stephen & Linda Smith wrote:
> > #!/bin/bash
> > mkdir test-repository || exit 1
> > cd test-repository
> > git init
> > echo "Initial contents, unimportant" > test-file
> > git add test-file
> > git commit -m "Initial commit"
> > echo "commit-1-state" > test-file
> > git commit -m "commit 1" -i test-file
> > git tag commit-1
> > git checkout -b branch-2 HEAD^1
> > echo "commit-2-state" > test-file
> > git commit -m "commit 2" -i test-file
> > 
> > # Creates conflicted state.
> > git merge --no-commit commit-1
> > 
> > # Resolved entirely to commit-2, aka HEAD.
> > echo "commit-2-state" > test-file
> > # If we'd set to commit-1=state, all would work as expected (changes vs HEAD).
> > git add test-file
> > 
> > # =====  Bug is here.
> > git commit --dry-run && echo "Git said something to commit" \
> >         || echo "Git said NOTHING to commit"

With the  '--dry-run' switch, dry_run_commit() is called which returns 1 
since run_status() is returning the wt_status commitable field which has a value of 0.

That field is only set in one place (wt_status_print_updated) which isn't getting called
directly or indirectly by run_status.   I checked this by code inspection as well as by 
instrumenting the code.

I'm not sure that we want to add a call to wt_status_print_updated in run_status since 
I don't believe we want the print statements.   An alternative might be to create a
new function.

> > 
> > git commit -m "Something to commit after all" && echo "Commit went through"
> > 
> > git log --pretty=oneline
