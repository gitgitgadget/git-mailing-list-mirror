From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 08:14:30 +0000 (UTC)
Message-ID: <loom.20120318T083216-96@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 11:10:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9D4c-0004T5-4E
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 11:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab2CRKKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 06:10:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:45120 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031Ab2CRKKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 06:10:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S9D3r-0003zL-8h
	for git@vger.kernel.org; Sun, 18 Mar 2012 11:10:03 +0100
Received: from 77.28.169.135 ([77.28.169.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 11:10:03 +0100
Received: from grnch_lists by 77.28.169.135 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 11:10:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.28.169.135 (Opera/9.80 (Windows NT 5.1; U; en) Presto/2.10.229 Version/11.62)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193375>

I recently tried cloning a fresh copy of a large repo (converted from CVS, 
nearly 10 years of history) and to my surprise "git clone" failed with the 
following message:

    error: cannot spawn git: No such file or directory

The problem is only reproduced using the Smart HTTP transport.

I used msysGit on Windows so my first instinct was to contact them, but after 
some poking around I discovered that the problem is present in the Linux 
version too, although harder to trigger.

Try executing this script:

-------------------------------
git init too-many-refs
cd too-many-refs
echo bla > bla.txt
git add .
git commit -m test
sha=$(git rev-parse HEAD)
for ((i=0; i<100000; i++)); do 
	echo $sha refs/tags/artificially-long-tag-name-to-more-easily-
demonstrate-the-problem-$i >> .git/packed-refs
done
-------------------------------

Now share this repo using the Smart HTTP transport (git-http-backend) and then 
try cloning it in a different directory. This is what you would get:

$ git clone http://localhost/.../too-many-refs/.git
Cloning into 'too-many-refs'...
fatal: cannot exec 'fetch-pack': Argument list too long

So we come to the real reason for the failure: somewhere inside Git a 
subcommand is invoked with all the tags/heads on the command line and if you 
have enough of them it overflows the command line length limit of the OS.

Obviously the number of tags in the "too-many-refs" repo above is absurd (100k) 
because the cmdline length in Linux is much more generous, but on Windows the 
clone fails with as little as 500 tags in the above loop! I am already hitting 
this problem with msysGit on real repos, not just artificial test cases.

I tracked down the problem to remote-curl.c:fetch_git(). That's where the 
"fetch-pack" command line is being constructed with all the refs on one line:

git fetch-pack --stateless-rpc --lock-pack ...<all the refs>...

The solution is conceptually simple: if the list of refs results in a too long 
command line, split the refs in batches and call fetch-pack multiple times such 
that each call is under the cmdline limit:

git fetch-pack --stateless-rpc --lock-pack ...<first batch of refs>...
git fetch-pack --stateless-rpc --lock-pack ...<second batch of refs>...
...
git fetch-pack --stateless-rpc --lock-pack ...<last batch of refs>...
