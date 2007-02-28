From: Yann Dirson <ydirson@altern.org>
Subject: stgit "push --merged" woes
Date: Wed, 28 Feb 2007 23:15:52 +0100
Message-ID: <20070228221552.GL4045@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth> <b0943d9e0702211049i7953a3d1x4912e80968546714@mail.gmail.com> <20070221215731.GE4045@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702211458o6de55e3fgd15dd4f4c1c2c622@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 23:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMX5l-0004Fs-Dx
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbXB1WQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbXB1WQG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:16:06 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60982 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488AbXB1WQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:16:05 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4C000389E;
	Wed, 28 Feb 2007 23:16:00 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 571FA1F08A; Wed, 28 Feb 2007 23:15:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702211458o6de55e3fgd15dd4f4c1c2c622@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41011>

On Wed, Feb 21, 2007 at 10:58:13PM +0000, Catalin Marinas wrote:
> >Oh, while I'm at it, "push -m" does not seem to work as expected.
> >After pulling from your tree, which contains my changes, and rebasing
> >to your head, "push -m" of the "Factorize..." patch results in a
> >conflict, while rebasing onto this particular commit and then pushing
> >my original patch gets the merge properly detected.  Sounds like a
> >candidate for a quick 0.12.2 if we cannot kill it before 0.12.1.
> 
> Unless you deleted the empty patch, you could do a push --undo and try
> to reverse apply the diff (that's what push -m does) and see whether
> it fails or not. There might be a bug in StGIT and not be able to cope
> with new files while doing the merge check (this patch has a new test
> script). If I have time tomorrow, I'll try to put this in the push
> test-case.

Just had a similar case, trying to "push -m" my Documentation patches.
The patch creating Documentation/ fails with conflict on Makefile.

Trying to reverse-apply the diff does not work, since the Makefile has
been modified by another commit.  I verified that reverse-applying the
2 patches touching that file in my stack does work.

That seems to imply that added files are not the only ones causing
problems to the current "push -m".  They just exhibit the problem more
often.

"push -m" should probably try other techniques if that one fails.
Reverse-apply on top of every newly-pulled commit that touches the
problematic files would be a possibility, but that's expensive.
Trying a meta-diff[1] between the patch to be pushed and candidate
newly-pulled commits could be cheaper.

But both techniques would miss a case that current "push -m" seems to
handle: when a patch was applied and then reversed upstream.


[1] FWIW, my (naive) stg-mdiff script:

====================
#!/bin/bash
set -e

# stg-mdiff - display meta-diffs, ie. diffs of diffs

# Main use: show evolutions of a patch.
# eg. stg-mdiff foo@stable foo
#     stg-mdiff foo 012345567ABCD # sha1 for "foo" as integrated upstream

# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
# Subject to the GNU GPL, version 2.

usage()
{
    echo "Usage: $(basename $0) <patch1> <patch2>"
    exit 1
}

if [ "$#" != 2 ]; then
    usage
fi

colordiff -u <(stg show "$1") <(stg show "$2") | less -RFX
====================
