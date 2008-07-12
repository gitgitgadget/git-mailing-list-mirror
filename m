From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: git-new-workdir should not share .git/rr-cache/MERGE_RR
Date: Sat, 12 Jul 2008 14:27:07 +0300
Message-ID: <87skufmjg4.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Keywords: git repository,merge,conflict resolution,bug,symbolic link
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 14:08:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHdtd-00065X-3L
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 14:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYGLMCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 08:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbYGLMCP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 08:02:15 -0400
Received: from 85-23-32-88-Rajakyla-TR1.suomi.net ([85.23.32.88]:50607 "EHLO
	Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752205AbYGLMCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 08:02:14 -0400
X-Greylist: delayed 2105 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jul 2008 08:02:14 EDT
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1KHdFr-0001ra-M7; Sat, 12 Jul 2008 14:27:07 +0300
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88235>

The contrib/workdir/git-new-workdir script makes .git/rr-cache in
each workdir a symlink to the shared .git/rr-cache directory.
This lets git-rerere share conflict resolutions between workdirs.
However, that directory also contains .git/rr-cache/MERGE_RR,
which lists the files for which conflict resolutions should be
saved in the next commit.  It is thus possible that git-merge in
one workdir records conflicts to the shared MERGE_RR file, and
git-commit in another workdir saves the staged files to rr-cache
as conflict resolutions, even though those files are from a
different branch and never saw the merge.  Such invalid conflict
resolutions need then be separately deleted.  This happened to
me, with git version 1.5.6.

I don't see any way to modify the symlinks made by
git-new-workdir so that new SHA-1 directories in .git/rr-cache
would be shared but .git/rr-cache/MERGE_RR would not.  On IRC,
"gitte" suggested changing Git to use $GIT_DIR/MERGE_RR instead
of $GIT_DIR/rr-cache/MERGE_RR.  I suppose compatibility with
people's existing repositories would require the modified Git to
keep reading $GIT_DIR/rr-cache/MERGE_RR too, so that Git could be
painlessly upgraded during a merge, but it is not obvious to me
how lock files should then work.

Alternatively, the SHA-1 directories in .git/rr-cache could be
moved to a subdirectory; then git-new-workdir could be changed to
symlink only that subdirectory.
