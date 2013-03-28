From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] merge-tree: fix "same file added in subdir"
Date: Thu, 28 Mar 2013 09:34:58 +0000
Message-ID: <20130328093458.GV2286@serenity.lan>
References: <0a6a0c978569906b8c8d9209a85338554e503236.1364419952.git.john@keeping.me.uk>
 <7vk3osjwgv.fsf@alter.siamese.dyndns.org>
 <20130327225739.GT2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 10:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL9FE-0004bh-Fr
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 10:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab3C1JfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 05:35:10 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:50050 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab3C1JfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 05:35:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id BA78C161E3E6;
	Thu, 28 Mar 2013 09:35:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FJ7tpPciS8NG; Thu, 28 Mar 2013 09:35:06 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id E5128161E362;
	Thu, 28 Mar 2013 09:35:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130327225739.GT2286@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219378>

On Wed, Mar 27, 2013 at 10:57:39PM +0000, John Keeping wrote:
> On Wed, Mar 27, 2013 at 03:42:40PM -0700, Junio C Hamano wrote:
> > John Keeping <john@keeping.me.uk> writes:
> > 
> > > When the same file is added with identical content at the top level,
> > > git-merge-tree prints "added in both" with the details.  But if the file
> > > is added in an existing subdirectory, threeway_callback() bails out early
> > > because the two trees have been modified identically.
> > >
> > > In order to detect this, we need to fall through and recurse into the
> > > subtree in this case.
> > >
> > > Signed-off-by: John Keeping <john@keeping.me.uk>
> > 
> > The rationale the above description gives is internally consistent,
> > but it is rather sad to see this optimization go.  The primary
> > motivation behind this program, which does not use the usual
> > unpack-trees machinery, is to allow us to cull the identical result
> > at a shallow level of the traversal when the both sides changed (not
> > added) a file deep in a subdirectory hierarchy.
> > 
> > The patch makes me wonder if we should go the other way around,
> > resolving the "both added identically" case at the top cleanly
> > without complaint.
> 
> I don't use merge-tree so I have no opinion on this, just wanted to fix
> an inconsistency :-)

Having re-read the manpage, I think you're right that we should just
resolve the "both added identically" case cleanly, but I wonder whether
some of the other cases should also be resolved cleanly.

git-merge-tree(1) says:

    the output from the command omits entries that match the <branch1>
    tree.

so you could argue that "added in branch1", "changed in branch1,
unmodified in branch2" and "removed in branch1, unchanged in branch2"
should also print no output.

But as I said above I don't use git-merge-tree so perhaps people who do
would like to explain what they expect in these cases.
