From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Pushing to a non-bare repository, round 2
Date: Wed, 25 Apr 2007 10:04:15 +0200
Message-ID: <vpqps5subgg.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 10:04:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgcUZ-0004Ks-70
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161841AbXDYIEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161843AbXDYIEn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:04:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:42292 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161841AbXDYIEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:04:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l3P84LtT023889
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2007 10:04:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HgcU3-00059h-Ka; Wed, 25 Apr 2007 10:04:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HgcU3-0004eZ-IL; Wed, 25 Apr 2007 10:04:15 +0200
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 25 Apr 2007 10:04:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45507>

Hi,

Following up to a recent thread:

http://lists.zerezo.com/git/msg419909.html

I wrote a (very primitive) update hook that updates the working tree
on the remote side when pushing to its current branch.

==== cut here : .git/hooks/update ====

#!/bin/bash

if [[ "$1" = $(git symbolic-ref HEAD) ]]; then
    GIT_DIR=$(pwd)
    cd ..
    git reset --soft $2
    git merge $3
    git reset --soft $2
fi

==== end ====

It has several problems. First, the

GIT_DIR=$(pwd)
cd ..

is ugly. Indeed, since I push to the URL of the tree of the remote
repository, git knows about the location of this tree, but it doesn't
seem to tell it to the update hook. So, I hardcoded ".." here. And the
GIT_DIR the hook receives isn't terribly informative, it's just ".",
and having a relative path here means I have to do this
GIT_DIR=$(pwd) before doing any "cd".

Then, 

    git reset --soft $2
    git merge $3

does the update (there should also be something to complain loudly if
there is a risk of conflict here, but let's say it's on the
todo-list).

But then, the refs/heads/<branch> does not point anymore to the point
where git expects it. So, I need another

    git reset --soft $2

to get back to the point it used to be. I find that pretty ugly
too :-(.

I really think there should be something about this in git itself. Not
necessarily something to actually update the tree, but at least, make
it easy to actually "update" the tree after a push.

In mercurial, for example, the above hook is just:

[hooks]
changegroup = hg update 

in .hg/hgrc. It tells hg to run "update" each time a group of changes
is pushed into the repository. And update _knows_ which revision the
tree used to point to, and which revision is the head of the branch.

Any opinion?

Thanks,


(at the moment, I need this to easily push changes to a machine to
make them available to users, letting them the choice between git and
rsync to get a fresh tree. Most of the users won't have git and won't
want to learn it)

-- 
Matthieu
