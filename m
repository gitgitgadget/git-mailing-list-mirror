From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [RFC] git submodule split
Date: Wed, 02 Apr 2014 23:52:39 +0200
Message-ID: <87sipviel4.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 13:12:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeaI-000348-Il
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbaDBWBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 18:01:25 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:55829 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030453AbaDBWBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 18:01:24 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Apr 2014 18:01:24 EDT
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id A940019F340A
	for <git@vger.kernel.org>; Wed,  2 Apr 2014 23:52:50 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id a_hhNAceoERk for <git@vger.kernel.org>;
	Wed,  2 Apr 2014 23:52:45 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 6EBBA19F3365
	for <git@vger.kernel.org>; Wed,  2 Apr 2014 23:52:45 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.82)
	(envelope-from <sojka@merica.cz>)
	id 1WVT5L-0006VP-K2
	for git@vger.kernel.org; Wed, 02 Apr 2014 23:52:39 +0200
User-Agent: Notmuch/0.17 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245708>

Hello,

I needed to convert a subdirectory of a repo to a submodule and have the
histories of both repos linked together. I found that this was discussed
few years back [1], but the code seemed quite complicated and was not
merged.

[1]: http://git.661346.n2.nabble.com/RFC-What-s-the-best-UI-for-git-submodule-split-tp2318127.html

Now, the situation is better, because git subtree can already do most of
the work. Below is a script that I used to split a submodule from my
repo. It basically consist of a call to 'git subtree split' followed by
'git filter-branch' to link the histories together.

I'd like to get some initial feedback on it before attempting to
integrate it with git sources (i.e. writing tests and doc). What do you
think?

Thanks,
-Michal


#!/bin/sh

set -e

. git-sh-setup

url=$1
dir=$2

test -d "$dir" || die "$dir is not a directory"

# Create subtree corresponding to the directory
subtree=$(git subtree split --prefix="$dir")

subtree_tag=tmp/submodule-split-$$
git tag $subtree_tag $subtree
superproject=$PWD
export subtree subtree_tag superproject

# Replace the directory with submodule reference in the whole history
git filter-branch -f --index-filter "
    set -e
    # Check whether the $dir exists in this commit
    if git ls-files --error-unmatch '$dir' > /dev/null 2>&1; then

        # Find subtree commit corresponding to the commit in the
        # superproject (this could be made faster by not running git log
        # for every commit)
        subcommit=\$(git log --format='%T %H' $subtree |
     	    grep ^\$(git ls-tree \$GIT_COMMIT -- '$dir'|awk '{print \$3}') |
     	    awk '{print \$2}')

        # filter-branch runs the filter in an empty work-tree - create the
        # future submodule in it so that the 'git submodule add' below
        # does not try to clone it.
        if ! test -d '$dir'; then
     	    mkdir -p '$dir'
     	    ( cd '$dir' && clear_local_git_env && git init --quiet && git pull $superproject $subtree_tag )
        fi

        # Remove all files under $dir from index so that the 'git
        # submodule add' below does not complain.
        git ls-files '$dir'|git update-index --force-remove --stdin

        # Add the submodule - the goal here is to create/update .gitmodules
        git submodule add $url '$dir'

        # Update the submodule commit hash to the correct value
        echo \"160000 \$subcommit	$dir\"|git update-index --index-info
    fi
"

# Replace the directory in the working tree with the submodule
( cd "$dir" && find -mindepth 1 -delete && git init && git pull $superproject $subtree_tag )

# Clean up
git tag --delete $subtree_tag
