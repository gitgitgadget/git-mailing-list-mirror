From: Dave Jones <davej@redhat.com>
Subject: someone changed the contents of my HEAD.
Date: Mon, 27 Feb 2006 22:04:46 -0500
Message-ID: <20060228030446.GA23490@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 28 04:05:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDvAX-00056W-Ey
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 04:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWB1DEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 22:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWB1DEz
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 22:04:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13206 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751722AbWB1DEy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 22:04:54 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1S34lco029030
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 22:04:47 -0500
Received: from nwo.kernelslacker.org (vpn83-121.boston.redhat.com [172.16.83.121])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1S34l119702
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 22:04:47 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.5) with ESMTP id k1S34kcU024185
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 22:04:46 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k1S34k45024184
	for git@vger.kernel.org; Mon, 27 Feb 2006 22:04:46 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16909>

I just tried to check in some changes to some trees
on master.kernel.org, and found after the first checkin
that git claimed..

fatal: Not a git repository

A lot of head-scratching later, I think I've figured out
what's happened.  It seems there was a recent upgrade
to the version of git on m.k.o, which is incompatible
with the helper scripts I used before.

When checking in changes previously, I used this..

#!/bin/sh
export GIT_AUTHOR_NAME="$1"
export GIT_AUTHOR_EMAIL="$2"
tree=$(git-write-tree) || exit 1
commit=$(git-commit-tree $tree -p HEAD) || exit 1
echo $commit > .git/HEAD

and called it thus..

commit-as "Dave Jones" "<davej@redhat.com>"

Previously, this updated .git/HEAD to a ptr to the latest committed change.
All was well, as I only ever have one HEAD in my trees.

With the new .git however, when I clone a new tree, .git/HEAD
contains ref: refs/heads/master, so my script destroys the git metadata.

For my newly created repos, this isn't a problem, as I can fudge my
commit-as script to write to .git/refs/heads/master instead, but
my concern now is the unpulled changes in the existing repos
I have on master.  Will Linus be able to pull those into his tree
with git 1.2.3, or will I have to recreate those repos with the
new-style .git/HEAD ?

		Dave
