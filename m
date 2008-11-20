From: paulfred <paul.fredrickson@gmail.com>
Subject: git-svn confused by "empty" (svn prop change) commit
Date: Wed, 19 Nov 2008 19:11:32 -0800
Message-ID: <m28wrfhz17.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 09:01:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L34Te-0001Dr-L5
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 09:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYKTIAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 03:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbYKTIAF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 03:00:05 -0500
Received: from main.gmane.org ([80.91.229.2]:41025 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095AbYKTIAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 03:00:03 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1L34SI-0006aH-6g
	for git@vger.kernel.org; Thu, 20 Nov 2008 08:00:02 +0000
Received: from dhcp39016.vcd.hp.com ([15.252.39.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 08:00:02 +0000
Received: from paul.fredrickson by dhcp39016.vcd.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 08:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp39016.vcd.hp.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.91 (darwin)
Cancel-Lock: sha1:jpfpkLCSfHqrRx0T+KO0duZgGgU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101389>


I've been using git and git-svn to commit to a central SVN repository for
the last several months.  It's been working great so far, well enough that
I really, *really* don't want to go back.

But yesterday, someone committed a number of changes to svn:properties,
and there were no tree changes.  git-svn now fails to dcommit anything,
instead giving me the following output:

  $ git svn dcommit
  Committing to https://project.com/svn/trunk ...
  No changes
  68af7eb26504e324cd6e3a2d50cd0562852a2dca~1 == 68af7eb26504e324cd6e3a2d50cd0562852a2dca
  W: 68af7eb26504e324cd6e3a2d50cd0562852a2dca and refs/remotes/trunk differ, using rebase:
  :040000 040000 7d76021c10cebf4a0b5c8fdf614bec8e66734a28 197442c7bd8c29cdd11f52ffb18fbd882d1c7f50 M	eu
  Current branch master is up to date.
  # of revisions changed  
  before:
   683a4ed53d8859f184733eaeebc6fcb904aa1e3b
  10e85dc1c3b03b77dcabb53b26893b2d30bd56c5
  07c1f476b6a5feae410e315cae57d878e898896d
  27aad097ace7ec5db128032f29d775791463ddc7
    [...several commits omitted...]
  751e53e536c98bf9ee1bd8b876c56f06f6b6b059 
  
  after:
   68af7eb26504e324cd6e3a2d50cd0562852a2dca
  683a4ed53d8859f184733eaeebc6fcb904aa1e3b
  10e85dc1c3b03b77dcabb53b26893b2d30bd56c5
  07c1f476b6a5feae410e315cae57d878e898896d
  27aad097ace7ec5db128032f29d775791463ddc7
    [...all the same commits again omitted...]
  751e53e536c98bf9ee1bd8b876c56f06f6b6b059 
   If you are attempting to commit  merges, try running:
  	 git rebase --interactive --preserve-merges  refs/remotes/trunk 
  Before dcommitting


It's strange that it wanted to rebase, since I had already rebased on top of
remotes/trunk, and I have exactly one commit I'm trying to dcommit. After
rebasing, it appears to bail because 68af7e is in one list and not the other.
Well, 68af7e happens to be the commit with no tree changes, only svn property
changes.  And yet "git branch --contains 68af7e" output includes master.  (hmm,
but not remotes/trunk.  Shouldn't it? master^ == remotes/trunk)

Anyway, git svn rebase continues to pull in new changes from everyone else,
but won't dcommit mine.

Based on a suggestion from irc, I tried --no-rebase, and got:

  Attempting to commit more than one change while --no-rebase is enabled.
  If these changes depend on each other, re-running without --no-rebase may be required. at /usr/local/libexec/git-core/git-svn line 447.
  No changes
  68af7eb26504e324cd6e3a2d50cd0562852a2dca~1 == 68af7eb26504e324cd6e3a2d50cd0562852a2dca
  Unable to extract revision information  from commit 683a4ed53d8859f184733eaeebc6fcb904aa1e3b~1

But I don't know what to do with that error message.  Is it looking for the git-svn-id's?

Other (perhaps important) details: I created the repository several months
ago,and only recently put "[svn] noMetadata = true" in my config file because
I'm the only person on the team using git, and nobody else wanted to see the
git-svn-id messages.

This is git version 1.6.0.4.761.g47577 on OS X 10.5.

I suppose I could nuke everything and clone another shallow copy of the code
from some point after the bad commit, but I'd be happy with any kind of
work around that gets me dcommitting again.

Thanks!

--Paul
