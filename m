From: David Woodhouse <dwmw2@infradead.org>
Subject: Handling renames.
Date: Thu, 14 Apr 2005 18:54:20 +0100
Message-ID: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 19:52:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM8Up-0000jo-Hk
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 19:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVDNRya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDNRya
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 13:54:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25478 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261575AbVDNRyW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 13:54:22 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DM8Xl-0001WB-8N; Thu, 14 Apr 2005 18:54:22 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've been looking at tracking file revisions. One proposed solution was
to have a separate revision history for individual files, with a new
kind of 'filecommit' object which parallels the existing 'commit',
referencing a blob instead of a tree. Then trees would reference such
objects instead of referencing blobs directly.

I think that introduces a lot of redundancy though, because 99% of the
time, the revision history of the individual file is entirely
reproducible from the revision history of the tree. It's only when files
are renamed that we fall over -- and I think we can handle renames
fairly well if we just log them in the commit object. 

My 'gitfilelog.sh' script is already capable of tracking a given file
back through multiple tree commits, listing those commits where the file
in question was actually changed. It uses my patched version of diff-
tree which supports 'diff-tree <TREE_A> <TREE_B> <filename>' in order to
do this.

By storing rename information in the commit object, the script (or a
reimplementation of a similar algorithm) could know when to change the
filename it's looking for, as it goes back through the tree. That ought
to be perfectly sufficient.

So a commit involving a rename would look something like this...

	tree 82ba574c85e9a2e4652419c88244e9dd1bfa8baa
	parent bb95843a5a0f397270819462812735ee29796fb4
	rename foo.c bar.c
	author David Woodhouse <dwmw2@hades.cambridge.redhat.com> 1113499881 +0100
	committer David Woodhouse <dwmw2@hades.cambridge.redhat.com> 1113499881 +0100
	Rename foo.c to bar.c and s/foo_/bar_/g

Opinions? Dissent? We'd probably need to escape the filenames in some
way -- handwave over that for now.

-- 
dwmw2

