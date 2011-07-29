From: Pete Wyckoff <pw@padd.com>
Subject: refs/replace advice
Date: Fri, 29 Jul 2011 08:31:22 -0700
Message-ID: <20110729153122.GA4535@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 17:37:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmp86-0002ps-3Q
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 17:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab1G2Phd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 11:37:33 -0400
Received: from honk.padd.com ([74.3.171.149]:34183 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470Ab1G2Phc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 11:37:32 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jul 2011 11:37:32 EDT
Received: by honk.padd.com (Postfix, from userid 7770)
	id 200E1223A; Fri, 29 Jul 2011 08:31:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178155>

I've got two near-identical git repos, both imported from
gigantic upstream p4 repos.  They started at slightly different
times so have different commit SHA1s, even though the tree
contents are the same.  I can't filter-branch either of them; too
many users already.

I'm trying to use "git replace" to avoid cloning the entire set
of duplicate commits across a slow inter-site link.  Like this:

    ...---A----B----C   site1/top
                     \
                      D---E---F  site1/proj

    ...---A'---B'---C'  site2/top

It is true that "git diff C C'" is empty:  they are identical.

This set of commands, run from site2, clones most of the repo
locally (up to C'), then grabs the few changes D..F from the
faraway site1:

    git clone /path/to/site2.git repo
    cd repo
    git remote add -f site1 /path/to/faraway/site1.git

But it causes an entire fetch of all commits because C != C'.
I'd prefer it just to fetch D, E and F.  So I try:

    git refs replace A' A

but it still fetches everything.  I toyed with grafting
site1's A on top of the parent of our local A':

    echo A A'^ > .git/info/grafts

no luck.

I thought maybe I could "git fetch --depth=N" where N would cover
the range A'..site2/top, then replace.  But testing with "git
fetch --depth=3" still wants to fetch 100k objects.

Any ideas?

                -- Pete
