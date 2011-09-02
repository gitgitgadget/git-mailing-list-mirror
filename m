From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess,iffy] [PATCH] git-svn: teach git-svn to populate svn:mergeinfo
Date: Fri, 02 Sep 2011 11:40:25 -0700
Message-ID: <4E612319.7030006@vilain.net>
References: <20110902140702.066a4668@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 20:40:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzYfK-0000zf-Ka
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 20:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab1IBSk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 14:40:28 -0400
Received: from uk.vilain.net ([92.48.122.123]:57694 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314Ab1IBSk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 14:40:28 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 11A21824C; Fri,  2 Sep 2011 19:40:24 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from [192.168.112.205] (unknown [64.125.143.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id 51B8B8176;
	Fri,  2 Sep 2011 19:40:23 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.1) Gecko/20110830 Thunderbird/6.0.1
In-Reply-To: <20110902140702.066a4668@robyn.woti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180629>

On 9/2/11 11:07 AM, Bryan Jacobs wrote:
> For this particular case, it works well: svn:mergeinfo is populated in such a way that the local merge history is recreated when another git-svn user pulls down the repository. This patch thus allows to git users to exchange branching and merging development through a central SVN server without loss of fidelity and without explicitly manipulating the mergeinfo property by hand.

Whee!  That's what I was intending when I wrote the original change.  I 
might have written it myself back in 2008 or whenever it was, but I 
found I didn't actually have any SVN projects I was sending commits to, 
let alone merges.  git-svn is a project with a continually atrophying 
userbase :-).  Thanks for picking it up.

> If the user has made commits to two local branches, merges them with --no-ff, and attempts to dcommit the result, the tool will error out with a message stating that all parents must reside in the SVN repository before their merge can be committed.
>
> I was unable to discover a way to clean way to restore the repository state in the case where this happens before reaching the HEAD commit. For example:
>
> r1 --- B --- C -- F
>   \               /
>    r2 --- E ------
>
> If r1 and r2 already reside in SVN, git-svn will dcommit B and C, then error when it tries to dcommit F (since the SVN revision number for E has not yet been set; the user should dcommit E before dcommitting F). The repository SHOULD be set to the following state after this happens:
>
> r1 -- r3 -- r4 -- F
>   \               /
>    r2 --- E ------
>
> ... but git-svn seems to put all the changes from all objects that it will be dcommitting into the working copy, which means that cherry-picking F atop the state the WC is in fails (due to conflicts with "untracked" objects already added). So in this patch if you try the above, you actually end up in this state:
>
> r1 --- r3 -- r4
>   \
>    r2 --- E
>
> F is lost and cannot be cherry-picked back onto the WC, as any files created in E are already present but untracked locally.

Are r1 and r2 supposed to be on the same SVN branch?

Overall, I could believe that.  Perhaps it is simpler to detect those 
situations in advance and insist the user dcommits them independently, 
although it appears to me that it would apply to any dcommit which 
failed for any reason part way through.  So perhaps there is a wider 
justification for fixing that.

Sam
