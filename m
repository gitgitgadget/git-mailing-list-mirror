From: John Keeping <john@keeping.me.uk>
Subject: git log --cherry with disjoint roots
Date: Sat, 11 May 2013 11:53:21 +0100
Message-ID: <20130511105321.GC2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 12:53:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub7Qx-0006f5-Ei
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 12:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab3EKKxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 06:53:31 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50639 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab3EKKxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 06:53:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A1BA1CDA5D2
	for <git@vger.kernel.org>; Sat, 11 May 2013 11:53:29 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t07SLHynzF-m for <git@vger.kernel.org>;
	Sat, 11 May 2013 11:53:27 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id AE61DCDA5A9
	for <git@vger.kernel.org>; Sat, 11 May 2013 11:53:26 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 93593161E340
	for <git@vger.kernel.org>; Sat, 11 May 2013 11:53:26 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RYfeWarvjum for <git@vger.kernel.org>;
	Sat, 11 May 2013 11:53:24 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 6B9A2161E418
	for <git@vger.kernel.org>; Sat, 11 May 2013 11:53:22 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223956>

I use my own integration branch manager[1] to manage my WIP changes to
various projects, including git.git and one of the features of this is a
--status option that shows whether anything that I'm tracking has been
merged to the base branch I'm building on top of.  Since the commit IDs
will be different after being sent to the list, this uses the --cherry
option to git-log.

Today I realised that I wasn't tracking a git-gui change I sent to the
list a couple of weeks ago [2] and so I pulled that in and added it.
Getting the status for this is significantly slower than anything else
because it does this:

    git log --cherry --oneline origin/master...git-gui-fix-subdir

and although there are only 5 commits in git-gui-fix-subdir not in
master there are 31964 commits in master not in git-gui-fix-subdir and
--cherry seems to inspect all of those.  So I get:

    $ time git log --oneline --cherry master...git-gui-fix-subdir \
        >/dev/null
    real    0m41.378s
    user    0m40.248s
    sys     0m0.986s

Now I know that I don't need to check anything older than commit 8ead1bf
(Merge tag 'gitgui-0.17.0' of git://repo.or.cz/git-gui, 2012-10-17) and
if I tell Git that it gets significantly better:

    $ time git log --oneline --cherry master...git-gui-fix-subdir \
        --not 8ead1bfe111085ef1ad7759e67340f074996b244 >/dev/null
    real    0m2.163s
    user    0m2.070s
    sys     0m0.084s

I'd like a way to automatically find the last merge that pulled in a
subtree so that my script can construct the above command line without
me needing to tell it the correct SHA-1 every time I have a branch that
is affected by this.

I guess this boils down to having a way to ask Git to list merges that
have a parent in a specified range, but perhaps I'm missing an easier
solution to this.

I also wonder if it would be interesting to cache patch IDs rather than
generating them every time...

[1] http://johnkeeping.github.io/git-integration/
[2] http://article.gmane.org/gmane.comp.version-control.git/222646
