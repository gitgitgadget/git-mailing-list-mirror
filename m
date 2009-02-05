From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Question about --tree-filter
Date: Thu, 5 Feb 2009 13:13:54 +0000 (UTC)
Message-ID: <loom.20090205T123832-998@post.gmane.org>
References: <loom.20090204T155824-858@post.gmane.org> <4989C437.4070401@viscovery.net> <4989FDC6.2080404@gmail.com> <498AA41D.3000609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 14:16:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV45B-0003sl-NZ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 14:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbZBENOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 08:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbZBENOV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 08:14:21 -0500
Received: from main.gmane.org ([80.91.229.2]:51574 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515AbZBENOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 08:14:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LV43Y-0004UP-UR
	for git@vger.kernel.org; Thu, 05 Feb 2009 13:14:13 +0000
Received: from 137.204.16.135 ([137.204.16.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 13:14:12 +0000
Received: from sergio.callegari by 137.204.16.135 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 13:14:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.16.135 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.5) Gecko/2008121622 Ubuntu/8.10 (intrepid) Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108556>

Johannes Sixt <j.sixt <at> viscovery.net> writes:

> 
> [ Don't cull Cc list, please! ]

Sorry... first made a reply ignoring the list and then tried to
fix!
 
> I think I know what's going on. filter-branch has this code where the
> tree-filter is applied:
> 
> 	git checkout-index -f -u -a ||
> 		die "Could not checkout the index"
> 
> This command may take a while to complete, and at the end it writes the
> index file. At this point:
> 
> (=) Some files may have the same timestamp as the index file.
> 
> (<) Others have an earlier timestamp.
> 
> Later we have this code:
> 
> 	(
> 		git diff-index -r --name-only $commit
> 		git ls-files --others
> 	) |
> 	git update-index --add --replace --remove --stdin
> 
> The files (=) are racily-clean, and are added to the database; they pass
> through the clean filter (rezip). The files (<) are regarded as unchanged,
> and are not added again, and are not rezipped.

Ok it is because of a race... now I start understanding the non-consistent
behaviour between different runs!  Thanks a lot for the explanation.

When you say "at the end it updates the index file" do you mean the effect of
the -u switch?

And when you say "Some files have the same timestamp as the index file" do you
mean that diff-index uses the stat info inside the index only if a file is "<"
than the index otherwise it is directly assumed that the file is changed wrt the
index content? If so, would it make sense to re-touch the index after the
checkout -u so that after the checkout the index is always > than every file it
contains and one always starts at a non-racy situation? With this, one could
only explicitly touch those files that need to get (re)filtered and gain in
efficiency... or am I still missing something?

Sergio

 
