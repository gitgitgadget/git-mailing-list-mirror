From: Andrey Smirnov <allter@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of =?utf-8?b?CXN1YnRyZWVz?= separately.
Date: Thu, 16 Jul 2009 18:04:26 +0000 (UTC)
Message-ID: <loom.20090716T160021-218@post.gmane.org>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>  <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>  <20090430085853.GA21880@pvv.org> <32541b130904300732i691800f5kecc2f845584071c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 20:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRVPL-0002Z9-EM
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 20:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951AbZGPSKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 14:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbZGPSKG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 14:10:06 -0400
Received: from main.gmane.org ([80.91.229.2]:33158 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932941AbZGPSKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 14:10:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MRVP8-0005Ap-Lf
	for git@vger.kernel.org; Thu, 16 Jul 2009 18:10:02 +0000
Received: from ns.cyberplat.com ([62.231.13.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 18:10:02 +0000
Received: from allter by ns.cyberplat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 18:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.231.13.130 (Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.8.1.20) Gecko/20081217 Firefox/2.0.0.20 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123413>

Hello!

Avery Pennarun <apenwarr> writes:

> d) Merge upstream changes of shared module:
>       git subtree pull --prefix=shared-dir shared-remote master
>     or
>       git fetch shared-remote master
>       git subtree merge --prefix=shared-dir FETCH_HEAD

I found the git-subtree aproach of handling sub-repositories very interesting 
and useful to me. This is the previous-to-last feature I've awaited from DVCS
world since I went into it. <remark> The remaining feature I wish that's not 
already there is the ability to automatically track the tree of repos I work
with and manage this tree as simple as filemanager-style clients 
like Tortoise SVN allow. This is a feature like submodules, but with tracking
refs, remotes and remote URIs in a repo itself rather than in .git dirs
and with different commands for propagation and display of changesets). 
Hope someone has time to try this approach (or at least patience to discuss).
</remark>

I've just used git-subtree (latest github version) and it worked for me. 
However I've encountered some difficulty using it for my purpose and wish
to shere the solution I've come to and ask if it is ok:

My goal was to rebase changes to shared library of two similar projects from one
project to another. The commits in the more recent project were touching both
lib/ directory with shared library and the rest of the project.

When I did 
   git subtree split --prefix=lib NewProj -b test-split
 and
   git subtree split --prefix=lib OldProj -b test-split-old
I got the following two trees without a common root:

...X ----- Y ----- OldProj ----...---- Z ---- NewProj

X' ----- Y'==test-split-old ----- Z'==test-split

Problem:

When I did
   git subtree merge test-split --prefix=lib
it printed:
 Auto-merged lib/x.cgi
 CONFLICT (add/add): Merge conflict in lib/x.cgi
 Auto-merged lib/y.cgi
 CONFLICT (add/add): Merge conflict in lib/y.cgi
 Automatic merge failed; fix conflicts and then commit the result.

It's obvious that it should be that way because logically both trees don't have
the same root at the time of merge. But I've expected subtree merge --prefix
will understand that X' is identical to changes to 'lib/*' in X, Y' to Y and Z'
to Z.

Solution: 

    git rebase --onto OldProj test-split-old test-split
it printed:
 First, rewinding head to replay your work on top of it...
 Applying ZZZZZ
 error: x.cgi: does not exist in index
 error: y.cgi: does not exist in index
 Using index info to reconstruct a base tree...
 Falling back to patching base and 3-way merge...

I don't know what magic it used but it did rebase right. Furthermore "-s
subtree" didn't work at all:
    git rebase --onto OldProj test-split-old test-split -s subtree
 First, rewinding head to replay your work on top of it...
 Fast-forwarded OldProj to OldProj.

And so I ask if this behavior is the way git-subtree was meant to work.
It probably has sense to add 'rebase' command to git-subtree script to let
perform such tasks simplier.

My best regards, Andrey Smirnov.
