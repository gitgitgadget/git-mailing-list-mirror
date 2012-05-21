From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Attempt of a git-svn-switch
Date: Mon, 21 May 2012 15:03:28 -0700
Message-ID: <87k40519an.fsf@an-dro.info.enstb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 00:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWahX-00024Y-3a
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759394Ab2EUWDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:03:34 -0400
Received: from minou.info.enstb.org ([193.50.97.146]:45905 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab2EUWDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:03:33 -0400
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.4/8.14.4/Debian-2) with ESMTP id q4LM3SS3023013
	for <git@vger.kernel.org>; Tue, 22 May 2012 00:03:30 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198130>

One of my projects relies heavily on many SVN repositories I use through
git-svn.

The upstream SVN URL has changed recently and I found incredibly complex
and time-consuming to do this (apparent) simple change.

Afterwards, I think it would have been simpler for me and more robust to
add a "switch" command to git-svn... But anyway, I've done a shell
script and I do not have more time to work on it.
It is not rocket science but it may be useful to others...

https://git.hpc-project.com/cgit/par4all/tree/src/dev/git-svn-switch?h=p4a-own


#! /bin/sh

# Switch the SVN URL of a local git-svn repository

# git-svn-switch <old-url-substring> <new-url-substring>

# Do a fetch and replace in the URL old-url-substring by new-url-substring.
# The rationale for substring is to be able to process many git-svn repository

# Typical use case:
#   git-svn-switch http://svn.cri.ensmp.fr/svn https://scm.cri.ensmp.fr/svn
# or to update a bunch of git-svn repositories in the same directory:
#   for i in *; do (cd $i; git-svn-switch http://svn.cri.ensmp.fr/svn https://scm.cri.ensmp.fr/svn); done

# Basically implement https://git.wiki.kernel.org/index.php/GitSvnSwitch
# and add a reset to one version in the past to be sure to have new stuff
# to fetch from the SVN server.
# It guesses that the previous svn version is the current - 1


# Irresponsible of this: Ronan.Keryell at wild-systems.com
# I think afterwards it would have been easier to add a switch option to
# git svn instead of hacking this way...


# Switch tracing mode on, so that if something goes wrong we can figure
# out where to resume later, back-track and so on:
set -vx

old_url_string="$1"
new_url_string="$2"

old_url=`git config --get svn-remote.svn.url`

# Do the URL rewriting (we hope there are no '|' in the URL):
new_url=`echo "$old_url" | sed -e "s|$old_url_string|$new_url_string|"`

# Get the previous svn revision so that we can reset to it to be sure we
# will fetch something (well, we guess here that the previous version is
# current - 1):
current_svn_revision=`git svn info | awk '/^Revision:/ { print $2 - 1 }'`

# Go back to previous version:
git svn reset -r $current_svn_revision

git config --replace-all svn-remote.svn.url "$new_url"
git svn fetch
git config --replace-all svn-remote.svn.url "$old_url"
git svn rebase -l
git config --replace-all svn-remote.svn.url "$new_url"
git svn rebase



-- 
  Ronan KERYELL                            |\/  Phone:  +1 408 658 9453
  Wild Systems / HPC Project               |/)
  5201 Great America Parkway, Suite 320    K    Ronan.Keryell@wild-systems.com
  Santa Clara, CA 95054                    |\   skype:keryell
  USA                                      | \  http://wild-systems.com
