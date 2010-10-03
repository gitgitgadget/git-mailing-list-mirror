From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH v2  0/6] Extensions of core.ignorecase=true support
Date: Sat, 02 Oct 2010 22:32:21 -0600
Message-ID: <20101003043221.1960.73178.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 06:32:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2GFj-0005hQ-KE
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 06:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048Ab0JCEcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 00:32:25 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49480 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0JCEcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 00:32:25 -0400
Received: (qmail 1227 invoked by uid 399); 2 Oct 2010 22:32:20 -0600
Received: from unknown (HELO ?192.168.56.1?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 2 Oct 2010 22:32:20 -0600
X-Originating-IP: 76.27.116.215
User-Agent: StGit/0.15-60-g0641
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157819>

The second version of this patch series fixes the problematic case
insensitive fnmatch call in patch 1 that relied on an apparently GNU-only
extension.  Instead, the pattern and string are lowercased into
temporary buffers, and the standard fnmatch is called without relying
on the GNU extension.

Patches 2-6 received no modifications.

The original cover for the patch series follows as posted by Johannes Sixt:

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
      Add string comparison functions that respect the ignore_case variable.
      Case insensitivity support for .gitignore via core.ignorecase
      Add case insensitivity support for directories when using git status
      Add case insensitivity support when using git ls-files
      Support case folding for git add when core.ignorecase=true
      Support case folding in git fast-import when core.ignorecase=true


 dir.c         |  152 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 dir.h         |    4 ++
 fast-import.c |    7 ++-
 name-hash.c   |   72 +++++++++++++++++++++++++++
 read-cache.c  |   23 +++++++++
 5 files changed, 235 insertions(+), 23 deletions(-)
