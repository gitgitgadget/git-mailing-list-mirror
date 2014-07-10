From: Bill Door <duanemurphy@mac.com>
Subject: git p4 diff-tree ambiguous argument error
Date: Thu, 10 Jul 2014 10:30:28 -0700 (PDT)
Message-ID: <1405013428825-7614774.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 19:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5IAz-0004Ta-NR
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 19:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbaGJRa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 13:30:29 -0400
Received: from sam.nabble.com ([216.139.236.26]:60551 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbaGJRa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 13:30:29 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <duanemurphy@mac.com>)
	id 1X5IAu-0002rp-R6
	for git@vger.kernel.org; Thu, 10 Jul 2014 10:30:28 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253193>

$ git p4 sync --detect-branches --import-labels //main@all
... Lots of useful information elided
fatal: ambiguous argument 'git-p4-tmp/8031': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
Command failed: ['git', 'diff-tree',
'6b3ef26a3e2635a5ff0170e15fdadb386672f8b9', 'git-p4-tmp/8031']

If I re-run the command, it works the second time. Of course there are
73000+ commits. This is gonna take a while.

I've done some debugging. It appears there is a timing problem between
git-p4 and git. 

The failure occurs in P4Sync.searchParent(). Even though a checkpoint is
sent to git (for fast-import) just prior to the call to searchParent() in
importChanges(), the file does not yet exist. I used pdb, paused the program
just before the call to diff-tree and the file was missing. After the
program exits due to the error the file exists (i.e. the OS flushed the
file). This is why re-running continues to work, there is an "old" file with
basically the same information laying around (dangerous).

How can I get git (fast-import) to flush the file at the right time?

$ git --version
git version 1.7.12.4
$ python --version
Python 2.6.6
OS: GNU/Linux 2.6.32-431.el6.x86_64




--
View this message in context: http://git.661346.n2.nabble.com/git-p4-diff-tree-ambiguous-argument-error-tp7614774.html
Sent from the git mailing list archive at Nabble.com.
