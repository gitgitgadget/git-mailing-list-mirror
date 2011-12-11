From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 21:14:37 +0100
Message-ID: <1kc4qnw.1xgi3yf14oaw7gM%lists@haller-berlin.de>
References: <jbvj5o$skt$1@dough.gmane.org>
To: gelonida@gmail.com (Gelonida N), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 21:24:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZpx0-0000qn-3x
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 21:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab1LKUYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 15:24:37 -0500
Received: from server90.greatnet.de ([83.133.96.186]:47044 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab1LKUYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 15:24:36 -0500
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Dec 2011 15:24:36 EST
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 798442A01CC;
	Sun, 11 Dec 2011 21:13:04 +0100 (CET)
In-Reply-To: <jbvj5o$skt$1@dough.gmane.org>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186812>

Gelonida N <gelonida@gmail.com> wrote:

> What is the best way to fastforward all fastforwardable tracking
> branches after a git fetch?

Here's a script that does this.  It isn't very well tested, I hope I
didn't miss any edge cases. Use at your own risk.

(It doesn't fastforward the branch you're on, on the assumtion that if
you said git fetch instead of git pull, you probably had a reason.)

========= 8< =========
#!/bin/sh

currentbranch="`git symbolic-ref HEAD 2>/dev/null`"

git for-each-ref --shell --format='ref=%(refname);upstream=%(upstream)' \
    refs/heads | \
while read entry
do
    eval "$entry"

    # skip the current branch
    test "$ref" = "$currentbranch" && continue

    # skip branches that have no upstream
    test -z "$upstream" && continue

    # skip if upstream doesn't have any new commits
    if [ -z "`git rev-list "$ref..$upstream"`" ]; then
        echo "${ref#refs/heads/} is up to date"
        continue
    fi

    # error if there are local commits
    if [ -n "`git rev-list "$upstream..$ref"`" ]; then
        echo "${ref#refs/heads/} has local commits; can't fast-forward"
        continue
    fi

    echo "${ref#refs/heads/} -> ${upstream#refs/remotes/}"
    git update-ref -m ff-all-branches "$ref" "$upstream"
done
========= >8 =========


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
