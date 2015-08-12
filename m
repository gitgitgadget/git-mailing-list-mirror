From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: partial stash, reversed-merge, and file modifications
Date: Wed, 12 Aug 2015 16:05:11 -0400
Message-ID: <jwvr3n8xptl.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 22:05:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPcHU-0000Uh-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 22:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbbHLUFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 16:05:44 -0400
Received: from plane.gmane.org ([80.91.229.3]:40530 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbbHLUFn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 16:05:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZPcHK-0000Oj-Cb
	for git@vger.kernel.org; Wed, 12 Aug 2015 22:05:38 +0200
Received: from modemcable022.171-203-24.mc.videotron.ca ([24.203.171.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 22:05:38 +0200
Received: from monnier by modemcable022.171-203-24.mc.videotron.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 22:05:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: modemcable022.171-203-24.mc.videotron.ca
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Cancel-Lock: sha1:Yu5GJkpYclgpqtcinlOr9mQZUSk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275807>

I'm pretty happy about Git in general, but for two situations where I've
found workarounds, which both have the same problem, which is that they
"touch" files unnecessarily:

* First case: merge into a dirty tree.

I often want to "git pull" into a tree
that's dirty.  I know many people find this to be heresy, but for
various reasons, I have a few trees that are pretty much always dirty
and where I want to pull anyway without ever wanting to commit
those changes.

The simplest solution I found is:

  git stash; git merge --ff-only; git stash apply; git stash drop

Problem with it: this will needlessly "touch" all the files which are
locally modified but aren't affected by the merge.  So a subsequent
"make" can easily end up taking a lot more time than needed.

A simple solution to this problem would be to only stash those files
which conflict:

  git stash save --only-some-files $(git merge 2>&1 | sed -ne 's/^	//p')
  git merge --ff-only; git stash apply; git stash drop

but of course the "--only-some-files" option to "stash save"
doesn't exist.  And writing an equivalent script is pretty painful.

* Second case: merge with reversed parents

The order of parents in a merge is sometimes important.
Say you're in your branch "newfeature" and you want to install it into
"master", you could do it this way:

   git merge master; <..make; check; push..>

but that gives you a history where the first parent is your feature
branch and all the changes made to master in the mean time look like
secondary changes.  This is probably OK seen from "newfeature" but if
you push this to "master", it will look odd on "master".

So instead, you'll want to do what I call a "reversed merge":

  git checkout master; git merge newfeature; <..make; check; push..>

Now the history tree is right.  Good.  But beside it being sightly more
cumbersome, the main problem with it is that, again, this will
needlessly "touch" all those files that are modified by "newfeature" but
not by "master" (compared to the ancestor).  So again, the subsequent "make"
can take a lot more time than needed.

I'd love to either hear about ways to avoid/reduce this problem with
current Git, or else to see some new features added to Git to
reduce/solve those problems.


        Stefan
