From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/6] Extensions of core.ignorecase=true support
Date: Mon, 16 Aug 2010 21:38:08 +0200
Message-ID: <cover.1281985411.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 21:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol5Wn-0007Pw-VT
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 21:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172Ab0HPTid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 15:38:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59059 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932160Ab0HPTic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 15:38:32 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E7FE8A7ED0;
	Mon, 16 Aug 2010 21:38:24 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A1AC819F5AE;
	Mon, 16 Aug 2010 21:38:24 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.402.gf1eeb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153672>

The following patch series extends the core.ignorecase=true support to
handle case insensitive comparisons for the .gitignore file, git status,
and git ls-files.  git add and git fast-import will fold the case of the
file being added, matching that of an already added directory entry.  Case
folding is also applied to git fast-import for renames, copies, and deletes.

The most notable benefit, IMO, is that the case of directories in the
worktree does not matter if, and only if, the directory exists already in
the index with some different case variant.  This helps applications on
Windows that change the case even of directories in unpredictable ways.
Joshua mentioned Perforce as the primary example.

Concerning the implementation, Joshua explained when he initially submitted
the series to the msysgit mailing list:

 git status and add both use an update made to name-hash.c where 
 directories, specifically names with a trailing slash, can be looked up 
 in a case insensitive manner. After trying a myriad of solutions, this 
 seemed to be the cleanest. Does anyone see a problem with embedding the 
 directory names in the same hash as the file names? I couldn't find one, 
 especially since I append a slash to each directory name.

 The git add path case folding functionality is a somewhat radical 
 departure from what Git does now. It is described in detail in patch 5. 
 Does anyone have any concerns?

I support the idea of this patch, and I can confirm that it works: I've
used this series in production both with core.ignorecase set to true and
to false, and in the former case, with directories and files with case
different from the index.

Joshua Jensen (6):
  Add string comparison functions that respect the ignore_case
    variable.
  Case insensitivity support for .gitignore via core.ignorecase
  Add case insensitivity support for directories when using git status
  Add case insensitivity support when using git ls-files
  Support case folding for git add when core.ignorecase=true
  Support case folding in git fast-import when core.ignorecase=true

 dir.c         |  105 ++++++++++++++++++++++++++++++++++++++++++++++----------
 dir.h         |    4 ++
 fast-import.c |    7 ++--
 name-hash.c   |   72 ++++++++++++++++++++++++++++++++++++++-
 read-cache.c  |   23 ++++++++++++
 5 files changed, 188 insertions(+), 23 deletions(-)
