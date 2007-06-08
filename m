From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git-stash
Date: Fri, 8 Jun 2007 08:52:45 +0200
Message-ID: <20070608065245.GA27863@moooo.ath.cx>
References: <Pine.LNX.4.64.0706072328000.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 08:53:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwYLH-00030Q-6d
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 08:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172AbXFHGwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 02:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756583AbXFHGwt
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 02:52:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:34289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758172AbXFHGws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 02:52:48 -0400
Received: (qmail invoked by alias); 08 Jun 2007 06:52:47 -0000
Received: from pD9EBB323.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.179.35]
  by mail.gmx.net (mp029) with SMTP; 08 Jun 2007 08:52:47 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18eUv8m6h4ecqRlKvOD5i5T1j4CuwICFQsndhyehe
	fKkS6OHL86Xgup
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706072328000.4046@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49442>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I just was in the need for git-stash (for the 1e6th time this year), but 
> instead of writing a script, I though I'd try the "!" convention for 
> aliases. Works quite well for me:

I have scripts saving and restoring the current state of the working
tree in the current branch using two commits: one is the current index
and the other one the index after adding all changes.

% tail -n 1000 save restore
==> save <==
#!/bin/sh
set -e
die() { echo "$0: $*" >&2; exit 1; }

parent=$(git rev-parse HEAD^0 2> /dev/null) || die requires at least one commit
tree=$(git write-tree)
commit=$(echo wip index | git commit-tree $tree -p $parent)

git diff-files --name-only -z | git update-index --remove -z --stdin
tree=$(git write-tree)
commit=$(echo wip working tree | git commit-tree $tree -p $commit)

git update-ref -m 'wip save' HEAD $commit
echo saved wip

==> restore <==
#!/bin/sh
set -e
die() { echo "$0: $*" >&2; exit 1; }

p=$(git rev-parse HEAD~1) || die requires at least 3 commits
pp=$(git rev-parse HEAD~2) || die requires at least 3 commits
git-read-tree --reset $p

git update-ref -m 'wip restore' HEAD $pp
echo restored wip
