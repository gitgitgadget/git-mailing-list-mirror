From: Pavel Roskin <proski@gnu.org>
Subject: StGIT refreshes all added files - limitation of git-write-tree?
Date: Tue, 14 Feb 2006 23:42:08 -0500
Message-ID: <1139978528.28292.41.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Feb 15 05:42:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9EUZ-00023E-Tl
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 05:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWBOEmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 23:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWBOEmN
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 23:42:13 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:31362 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1422666AbWBOEmM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 23:42:12 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F9EUU-0002CY-Ui
	for git@vger.kernel.org; Tue, 14 Feb 2006 23:42:11 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F9EUS-0007Qu-6i; Tue, 14 Feb 2006 23:42:08 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16211>

Hello!

Current StGIT would refresh all added files on "stg refresh", even if
they are not specified on the command line.  I believe the same is true
for removed files.

That's when it can hurt.  I apply a large patch that modifies and adds
several files.  I want to split the patch into several StGIT patches by
selecting which files belong to which patch.  All files that need to be
modified are already modifies.  It's natural that I add new files using
"stg add" at this stage.  To me, adding files looks very similar to
modifying them.  However, then I create a patch by "stg new" and commit
_some_ files to it using "stg refresh" with those files on the command
line, I discover that _all_ added files have been refreshed.

The only workaround seems to be to add only those files that will be
included in the current patch.  The same should be true for renamed
files.

Debugging StGIT shows that it builds correct lists of the files to be
included in the current patch (update_cache in git.py), but they are
never used.  Instead, StGIT runs "git-write-tree" without arguments
(commit in git.py).  While StGIT is careful to only add user-specified
modified files to the directory cache, it does nothing to the added
files, which are in the cache already.

Purely StGIT way of handling this problem would be to remove added files
from the directory cache if they are not being committed.  The problem
is, "stg add" uses the cache, so this would undo "stg add" on files
unused in the current operation.  Either StGIT should restore files in
the cache after the refresh, or there should be a separate StGIT cache
that "stg add" would work on.  The former is potentially unreliable
(what if refresh is interrupted), the later creates an extra layer,
another directory cache no less, this reducing usability of the pure git
commands.

Another approach would be to get rid of "stg add" and "stg rm" and use
"stg refresh --add" and "stg refresh --rm" to add files to the current
patch or to remove them.  It does feel like removal of a useful feature,
since "stg diff" without arguments will no longer show added or removed
files.  Adding and removing files would be too immediate compared to
modifying them.

What I really hope to hear is that there is or there will be a git based
solution.  Either git-write-tree could be changed to only process files
specified on the command line, or there should be some other command
doing that.

Or maybe git-write-tree and other utilities could be changed to work on
a copy of the index file?  I would prefer not to move the
actual .git/index away, but to make a copy for the current "stg refresh"
operation.

-- 
Regards,
Pavel Roskin
