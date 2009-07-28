From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 0/5] {checkout,reset,stash} --patch
Date: Tue, 28 Jul 2009 23:20:06 +0200
Message-ID: <cover.1248815580.git.trast@student.ethz.ch>
References: <200907271210.40001.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 23:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVu6E-0001P2-MQ
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 23:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbZG1VUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 17:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbZG1VUX
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 17:20:23 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28959 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721AbZG1VUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 17:20:22 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 23:20:21 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 23:20:21 +0200
X-Mailer: git-send-email 1.6.4.rc3.215.gd714f
In-Reply-To: <200907271210.40001.trast@student.ethz.ch>
X-OriginalArrivalTime: 28 Jul 2009 21:20:21.0344 (UTC) FILETIME=[36AA1600:01CA0FC9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124276>

I wrote:
> 1b) 'stash save -p' defaults to --keep-index (which can be disabled
>     with a new option --no-keep-index).  In --keep-index mode, it only
>     offers hunks from the worktree.

I ended up implementing the even more restricted form, it always
stashes the index as-is and only offers hunks from the worktree.  This
is because it finally dawned on me that 'git stash apply' does not
merge the changesets base..index and index..worktree, but in fact (in
one go) base..worktree, into the new HEAD.

That way the rules are much simpler as to what goes where.  The
downside of course is that the state of the worktree (with all stashed
hunks discarded) compared to the index (still as before) can be a bit
confusing if you stash areas of files that already have staged
changes.

I also finally found some round tuits, and wrote tests.  Which then of
course immediately showed that neither 'git reset -p HEAD^' nor 'git
checkout -p HEAD^' ever worked as advertised, so I had to fix that.
Patches 1/5 and 2/5 are unaffected and still the same.

Last but not least, I rather like Dscho's patch

  http://article.gmane.org/gmane.comp.version-control.git/124182

so I added a small patch to do the same DWIM logic for -p/--patch that
goes on top of a merge of 1-5 and his patch.  I suspect it's more work
to do the merge than to just edit either 5/5 or Dscho's patch,
however.


Thomas Rast (6):
  git-apply--interactive: Refactor patch mode code
  builtin-add: refactor the meat of interactive_add()
  Implement 'git reset --patch'
  Implement 'git checkout --patch'
  Implement 'git stash save --patch'
  DWIM 'git stash save -p' for 'git stash -p'
