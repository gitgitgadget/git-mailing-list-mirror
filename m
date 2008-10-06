From: Peter Waller <peter.waller@gmail.com>
Subject: Git filter branch - removing empty commits
Date: Mon, 6 Oct 2008 07:57:22 -0700 (PDT)
Message-ID: <19839587.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 17:02:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmrXb-0002sv-WB
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYJFO5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYJFO5Z
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:57:25 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48281 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYJFO5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:57:24 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KmrWU-0004t5-V6
	for git@vger.kernel.org; Mon, 06 Oct 2008 07:57:22 -0700
X-Nabble-From: peter.waller@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97592>


Dear List,

I have removed lots of files from my history with a procedure something like
this:

1) Clone repository

2) git filter-branch --index-filter 'git rm --quiet -r Archive; git ls-files
-z '\''*.png'\'' '\''*.eps'\'' | xargs -0r git rm --quiet; true'

3) git reflog expire --expire=0 --all

4) git prune; git gc

The problem is that this leaves many empty commits.

The helpful people over at #git advised I do:

git filter-branch --commit-filter 'if [ z$1 = z`git rev-parse $3^{tree} 2>
/dev/null` ]; then skip_commit "$@"; else git commit-tree "$@"; fi'

But this gets to about commit 70/1300 and grinds to a halt. I modified
/usr/libexec/git-core/git-filter-branch to say #!/bin/sh -x, and the result
was over 80mb in a few seconds.

I have pasted the last few lines here:
http://rafb.net/p/ABWvCy44.html

It is like it is following some exponential behaviour and not getting
anywhere.

Any ideas what is wrong?

I have tried a couple of scripts I have found around that should do the same
thing, for example:

skip_commit()
{
        shift
        while [[ -n $1 ]] ; do
                shift
                map "$1"
                shift
        done
}

our_tree="$1"
our_parent_tree=$(map $3)

if [[ ${our_tree} == $(git rev-parse $(map $3)) ]]; then
        git commit-tree "$@"
else
        skip_commit "$@"
fi

This goes much faster, but when it reaches the final commit, it says this:
Ref 'refs/heads/master' was deleted
fatal: Not a valid object name HEAD

And not much useful seems to have happened.

Any help appreciated.

Regards,

- Peter
-- 
View this message in context: http://www.nabble.com/Git-filter-branch---removing-empty-commits-tp19839587p19839587.html
Sent from the git mailing list archive at Nabble.com.
