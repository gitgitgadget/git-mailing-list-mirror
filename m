From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: add (failing) test for SVN 1.5+ merge
	with intervening commit
Date: Sat, 14 Nov 2009 13:40:32 -0800
Message-ID: <20091114214031.GA3732@dcvr.yhbt.net>
References: <874ooz5o8s.fsf@navakl084.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>,
	Toby Allsopp <toby.allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Sat Nov 14 22:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9QMJ-0004Aa-0K
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 22:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbZKNVk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 16:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbZKNVk0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 16:40:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54855 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbZKNVk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 16:40:26 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560871F5FC;
	Sat, 14 Nov 2009 21:40:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <874ooz5o8s.fsf@navakl084.mitacad.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132890>

Toby Allsopp <toby.allsopp@navman.co.nz> wrote:
> This test exposes a bug in git-svn's handling of SVN 1.5+ mergeinfo
> properties.  The problematic case is when there is some commit on an
> unrelated branch after the last commit on the merged-from branch.
> When SVN records the mergeinfo property, it records the latest
> revision in the whole repository, which, in the problematic case, is
> not on the branch it is merging from.
> 
> To trigger the git-svn bug, we modify t9151 to include two SVN merges,
> the second of which has an intervening commit.  The SVN dump was
> generated using SVN 1.6.6 (on Debian squeeze amd64).
> 
> Signed-off-by: Toby Allsopp <toby.allsopp@navman.co.nz>

Hi Toby,

Thanks for this series, acked and squashed into a single commit to avoid
unnecessary bisection failures at git://git.bogomips.org/git-svn

commit 753dc384dc2c4ab3e1049f695425cebf41ff7e6b
Author: Toby Allsopp <toby.allsopp@navman.co.nz>
Date:   Sat Nov 14 13:26:47 2009 -0800

    git svn: handle SVN merges from revisions past the tip of the branch
    
    When recording the revisions that it has merged, SVN sets the top
    revision to be the latest revision in the repository, which is not
    necessarily a revision on the branch that is being merged from.  When
    it is not on the branch, git-svn fails to add the extra parent to
    represent the merge because it relies on finding the commit on the
    branch that corresponds to the top of the SVN merge range.
    
    In order to correctly handle this case, we look for the maximum
    revision less than or equal to the top of the SVN merge range that is
    actually on the branch being merged from.
    
    [ew: This includes the following (squashed) commit to prevent
         errors during bisect:]
    
      Author: Toby Allsopp <toby.allsopp@navman.co.nz>
      Date:   Fri Nov 13 09:48:39 2009 +1300
    
        git-svn: add (failing) test for SVN 1.5+ merge with intervening commit
    
        This test exposes a bug in git-svn's handling of SVN 1.5+ mergeinfo
        properties.  The problematic case is when there is some commit on an
        unrelated branch after the last commit on the merged-from branch.
        When SVN records the mergeinfo property, it records the latest
        revision in the whole repository, which, in the problematic case, is
        not on the branch it is merging from.
    
        To trigger the git-svn bug, we modify t9151 to include two SVN merges,
        the second of which has an intervening commit.  The SVN dump was
        generated using SVN 1.6.6 (on Debian squeeze amd64).
    
    Signed-off-by: Toby Allsopp <toby.allsopp@navman.co.nz>
    Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
