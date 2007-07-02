From: "Patrick Doyle" <wpdster@gmail.com>
Subject: pushing a project started in git back to a subversion repository...
Date: Mon, 2 Jul 2007 16:29:11 -0400
Message-ID: <e2a1d0aa0707021329p29242393ua10817c85ca7422a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 22:29:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5SWO-00033K-B0
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 22:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbXGBU3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754279AbXGBU3N
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 16:29:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:8004 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbXGBU3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 16:29:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2476296wah
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 13:29:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eb5IP6EJZZ/sXO+X5ao2OqqBZq0V+8Td4XsyL/zn+wesdfLOHCZa+SO+E4Q51iDiGuQSd/b9Mi6HF+llzn80FS3XppkTbUVRYEa2xpSSFFZoKS/mnUDDxpt/h/I70O0QF6cJgMF4Yj04/GWVExP/ssFBMTrSlye9sH2UCKYSYDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kt4PyNyoiaJ5aibzvhsLw7AXYFVHgg1JpXdDp9KZ3mdOI1WzFEvVxvdQCj7tmWBy8kNhZwa5xCG6z2V1+YI3NFIO0uRSq7y6eLA4m7XcqH1ngGtdx5hS950JrqS+YVICU/gsrPjFjiMXj1A0Y35tuDhMOPia/dGVz+mRjBrbA2A=
Received: by 10.114.75.1 with SMTP id x1mr5420822waa.1183408151646;
        Mon, 02 Jul 2007 13:29:11 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Mon, 2 Jul 2007 13:29:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51401>

Well, I think I've parsed through the documentation and tips enough to
finally produce a script that does what I want it to do... and that
was: "I started a project, tracking the revisions with git, and I want
to track the changes and revisions on our company Subversion server."

Here is what I did:
1) packed up the existing git repository with "git-pack-objects"

$ git-rev-list master | git-pack-objects --revs --stdout > ../mypack

2) Used git-rev-list to find the name of first and last commits in my repo.

*** 1st question: ****
I can use

$ git-rev-list -n 1 master

to get the most recent commit.  Is there a similar shortcut to get the
very first commit?  (I used used "tail -1" to get the last line out of
git-rev-list

3) Cloned the SVN repository, which I had previously created with an
empty directory into which I wanted to import my new project

$ git-svn clone url://path/to/repo/topdir

4) unpacked the packfile into the new .git repo

$ cd topdir
$ git-unpack-objects < ../mypack

5) Created a .git/info/grafts file with the first commit from my old
.git repo grafted onto the single (empty directory) commit of this new
repo

$ echo XXX YYY > .git/info/grafts

6) Here's the scary part -- I overwrote .git/refs/heads/master with
the last commit from my old repo, so now "master" points to a chain of
commits going back to the beginning of time in the old repo and now
grafted onto the empty directory commit of my new repo.

**** 2nd question: ****
How many of you cringed when I said I did this?  If so, why?

7) Fetched the files into my empy directory

$ git checkout

8) And committed them back to the SVN repo:

$ git-svn dcommit

**** Last question: ****
What happened to all of those objects I imported from the pack file?
I can still see them in the .git/objects/*/* directories, but they
don't show up in git-ls-revs.  git-fsck doesn't report any errors.
git-gc seems like it packs them up -- I get 193 objects packed into
the pack file compared to 167 in a fresh clone of the (newly updated)
svn reposistory

I'm also curious what experts would think of my fumbling efforts to
transfer this git-managed project into a git/svn-managed project,
maintaining the initial history.  Did I go tremendously out of my way
to do something that was a one-line command?

--wpd
