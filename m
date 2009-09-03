From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 0/5] jgit diff
Date: Thu, 3 Sep 2009 12:45:43 +0200 (CEST)
Message-ID: <cover.1251974493u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 03 12:45:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj9pC-0007nA-4e
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 12:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbZICKpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 06:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbZICKpo
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 06:45:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:44892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752080AbZICKpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 06:45:43 -0400
Received: (qmail invoked by alias); 03 Sep 2009 10:45:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp054) with SMTP; 03 Sep 2009 12:45:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fE1EEF7wf8/Mld18wazYr6Qaxqtv5QOzUZbalE7
	pwGqV6uo2wPlyY
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127644>

This patch series provides a rudimentary, working implementation of "jgit 
diff".  It does not provide all modes of "git diff" -- by far! -- but it 
is robust, and should provide a good starting point for further work.

Unfortunately, I lack the time to do proper profiling/benchmarking, but I 
verified at least that it succeeds in recreating valid patches for all 
commits in jgit.git with this script:

	git rev-list HEAD |
	sed '$d' |
	while read commit
	do
	        printf "\\r$commit "
	        (export GIT_INDEX_FILE=test-index &&
	         ./jgit diff $commit^ $commit > test-patch &&
	         git read-tree $commit^ &&
	         git apply --cached test-patch &&
	         git diff --exit-code --cached $commit) || break
	done

Johannes Schindelin (5):
  Add set to IntList
  Add Myers' algorithm to generate diff scripts
  Add a test class for Myers' diff algorithm
  Prepare RawText for diff-index and diff-files
  Add the "jgit diff" command

 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Diff.java             |  133 +++++
 .../tst/org/spearce/jgit/diff/MyersDiffTest.java   |  103 ++++
 .../tst/org/spearce/jgit/util/IntListTest.java     |   21 +
 .../src/org/spearce/jgit/diff/DiffFormatter.java   |    2 +-
 .../src/org/spearce/jgit/diff/MyersDiff.java       |  515 ++++++++++++++++++++
 .../src/org/spearce/jgit/diff/RawText.java         |   28 +-
 .../src/org/spearce/jgit/util/IntList.java         |   17 +
 8 files changed, 818 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Diff.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/diff/MyersDiffTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/diff/MyersDiff.java
