From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Commiting automatically
Date: Sun, 10 Oct 2010 19:23:56 +0000 (UTC)
Message-ID: <loom.20101010T212207-709@post.gmane.org>
References: <loom.20100924T224155-693@post.gmane.org> <AANLkTimpyTVe+OhYRhsV3H8TGahgsASOPAZRqwR=V6od@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 21:24:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P51Vf-0001lg-R7
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab0JJTYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 15:24:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:48216 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab0JJTYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 15:24:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P51V7-0001Vg-BE
	for git@vger.kernel.org; Sun, 10 Oct 2010 21:24:05 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 21:24:05 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 21:24:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.62)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158686>

On 10-09-25 12:05, Alex Riesen wrote:
> On Fri, Sep 24, 2010 at 22:43, Maaartin <grajcar1@seznam.cz> wrote:
>> I'm going to run periodically a process which uses the current working tree 
and
>> I'd like to protocol what happens. As a part of the protocol I need the exact
>> state of the working tree and that's what is git good for, right? But it must
>> neither disturb my normal workflow nor interfere with my ordinal commits. I
>> could probably use something like
>
> Try using low-level git commands (the "plumbing").
> Take a look at GIT_INDEX_FILE environment variable and
> "git write-tree", "git commit-tree" and "git update-ref", in
> addition to "git add".
> 
> I.e. (untested):
> 
>   $ (
>   export GIT_INDEX_FILE=.git/myindex
>   git add . &&
>   tree=$(git write-tree) &&
>   commit=$(date |git commit-tree $tree -p protocol) &&
>   git update-ref -m autolog protocol $commit
>   )

Based on this, I've created a simple script "git-autocom" which seems to work 
somehow. In order to test it place both attachments in a new directory and run 
"test-git-autocom". The test creates a new working tree with a repository and 
some commits and then invokes "git-autocom".

A branch autocom gets created, but I'm quite unsure if it's correct. I see a 
problem in case the script runs with the branch autocom checked out. Maybe a 
tag could be better or whatever.

I see I can attach no files here in http://post.gmane.org

So I placed them in
http://dl.dropbox.com/u/4971686/101010/git-autocom
and
http://dl.dropbox.com/u/4971686/101010/test-git-autocom
and copied them here as well (I hope there's a better way).

====== git-autocom
#!/bin/sh
message="autocom $(date)"
head=$(git show-ref -s --head HEAD)

# the first parent should be autocom
parent1="-p $(git show-ref -s refs/heads/autocom)"
# needed for the very first use
test -f .git/refs/heads/autocom || parent1=""
# the second parent should be the current head
parent2="-p $head"
# make sure not giving the same parent twice
test "$parent1" = "$parent2" && parent1=""

#temporary index
export GIT_INDEX_FILE=.git/autocom.tmp

git add -A &&
tree=$(git write-tree) &&
commit=$(echo "$message" | git commit-tree $tree $parent1 $parent2) &&
git update-ref -m "$message" refs/heads/autocom $commit
====== test-git-autocom
#!/bin/sh

/bin/rm -fR testtree 2>/dev/null
mkdir testtree &&
cd testtree && 
git init && 
echo a > a &&
git add -A && git commit -m "a" &&
echo b > b &&
git add -A && git commit -m "b" &&
echo c > c &&
/bin/rm b &&
git add -A &&
/bin/rm a &&
echo "preparation OK" &&
../git-autocom &&
echo "autocom OK" &&
git log &&
git log autocom
======
