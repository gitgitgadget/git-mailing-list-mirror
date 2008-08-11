From: Marcus Griep <marcus@griep.us>
Subject: [PATCH 0/3] git-svn and temporary file improvements
Date: Mon, 11 Aug 2008 11:53:52 -0400
Message-ID: <1218470035-13864-1-git-send-email-marcus@griep.us>
References: <489DBB8A.2060207@griep.us>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZk8-00080k-P6
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYHKPyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755795AbYHKPyA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:54:00 -0400
Received: from boohaunt.net ([209.40.206.144]:33692 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732AbYHKPx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:53:57 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id DB8341878CCA; Mon, 11 Aug 2008 11:53:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <489DBB8A.2060207@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91951>


This series of patches relates to temp file usage within git-svn and possible
extensions applicable to other perl auxiliary functions.

The first patch allows for a central "registry" of temp files to be maintained.
It offers both locking and non-locking constructs depending upon the user's
complexity concern. The functions provided are also documented for perldoc.

The second patch changes git-svn to utilize the central registry in the first
patch to help reduce the amount of temp files created and destroyed during a
normal run of git-svn. The asymptotic limit on the number of temp files needed
is decreased from O(n+m) to O(1) where n is the number of files imported and
m is the number of file deltas. In real terms, this change does not
significantly reduce the time required for an import as other concerns, such as
network and disk i/o dominate over inode/MFT changes, however an incremental
reduction of ~10% system time was found on large change sets, though in a large
repository of small changesets, this incremental reduction reduced to 
approximately 3%.

The third patch modifies the way git-svn handles symlinks versus normal files
imported from svn. Currently, git-svn is very inefficient in this respect,
duplicating entire files solely for the sake of eliminating the first five
bytes of the file if it is a symlink. This causes a large amount of unnecessary
disk i/o, even when considering most of it takes place in in-memory buffers.
By eliminating the unnecessary duplication for normal files, a significant 48%
reduction in system time and a 33% reduction in user time was realized on
large changesets. Over many commits with small changesets, other operations
dominate, but an incremental 6% reduction was still noted. In addition, in both
cases a 15-25% reduction in maximum resident set size was found.

Logs and results of the benchmarks along with the procedure used are available
at http://blog.xpdm.us/2008/08/git-svn-and-temporary-files.html.

Marcus Griep (3):
      Git.pm: Add faculties to allow temp files to be cached
      git-svn: Make it scream by minimizing temp files
      git-svn: Reduce temp file usage when dealing with non-links

 git-svn.perl |   84 ++++++++++++++++++++--------------
 perl/Git.pm  |  145 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 192 insertions(+), 37 deletions(-)
