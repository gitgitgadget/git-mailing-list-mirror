From: Bill Lear <rael@zopyra.com>
Subject: Re: How to revert one of multiple merges
Date: Mon, 19 Oct 2009 13:13:23 -0500
Message-ID: <19164.44099.875117.96168@lisa.zopyra.com>
References: <19162.32265.738503.382638@lisa.zopyra.com>
	<4ADC8387.9010808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 20:13:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzwjy-0004PQ-SN
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 20:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbZJSSNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 14:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755448AbZJSSNm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 14:13:42 -0400
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:58698
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbZJSSNl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 14:13:41 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id n9JIDhF29187;
	Mon, 19 Oct 2009 12:13:43 -0600
In-Reply-To: <4ADC8387.9010808@drmicha.warpmail.net>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130721>

On Monday, October 19, 2009 at 17:19:35 (+0200) Michael J Gruber writes:
>Bill Lear venit, vidit, dixit 18.10.2009 04:31:
>> Branch A, B, C each have 20 commits, 0-19.
>> 
>> Branch v1.0.0 created, then merge of A, B, C performed.
>> 
>> After testing, we realize that the branch B is not ready for
>> production release and we'd like to remove it from branch
>> v1.0.0.
>> 
>> If I do
>> 
>> % git merge A B C
>> 
>> I get a single commit:
>> 
>> % git log -p
>> 
>> commit 1644a0b98c01869aa83e59aa41374c22098c47b6
>> [...]
>> Date:   Fri Oct 16 09:52:32 2009 -0500
>> 
>>     Merge branches 'A', 'B' and 'C' into v1.0.0
>> 
>> [20 x 3 commits]
>> 
>> If I do
>> 
>> % git merge A
>> % git merge B
>> % git merge C
>> 
>> Then:
>> 
>> % git log -p
>> 
>> commit 8946edd381384d0882221c87b5b3b7bf47127d70
>> [...]
>> Date:   Sat Oct 17 21:28:36 2009 -0500
>> 
>>     Merge branch 'B' into v1.0.0
>> 
>> commit 076ed422443e3684e564f7cae2b92e4538088ae6
>> [...]
>> Date:   Sat Oct 17 21:28:35 2009 -0500
>> 
>>     Merge branch 'A' into v1.0.0
>> 
>> but no "Merge branch 'C' into v1.0.0".
>
>Do you get any commits after the merge of B? If yes, then v1.0.0 got
>fast-forwarded (you can avoid that using --no-ff). If no, C was
>contained in v1.0.0 already.

BTW this is all with git 1.6.5.

My test script that set all of this up makes no commit to any branch
after the merge of any branch is done.  C was not in v1.0.0 already.
Here is the script I used to set this up:

% cat scripto
rm -rf branch_test
mkdir branch_test
cd branch_test
git init

echo foo > foo
git add foo
git commit -a -m "foo"

git checkout -b A
for ((i=0; i < 20; ++i)); do
    echo "bar $i" > bar
    git add bar
    git commit -a -m "bar $i"
done

git checkout master
git checkout -b B
for ((i=0; i < 20; ++i)); do
    echo "baz $i" > baz
    git add baz
    git commit -a -m "baz $i"
done

git checkout master
git checkout -b C
for ((i=0; i < 20; ++i)); do
    echo "buz $i" > buz
    git add buz
    git commit -a -m "buz $i"
done

git checkout master
git checkout -b v1.0.0

After that, I did the merges this way:

% git merge A
% git merge B
% git merge C

and then the git log shows no merge of C, as above.  Hmm, actually, when I
just ran this, I get no output showing branch A was merged.  I just
did this again and here is the merge output:

% git branch -a
  A
  B
  C
  master
* v1.0.0
% git merge A
Updating af6c884..c7e5f2c
Fast forward
 bar |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bar
% git merge B
Merge made by recursive.
 baz |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 baz
% git merge C
Merge made by recursive.
 buz |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 buz

Then, git log -p shows no branch A merge:

% git log -p | grep -i merge
Merge: f462b95 2c2b064
    Merge branch 'C' into v1.0.0
Merge: c7e5f2c adde6ff
    Merge branch 'B' into v1.0.0

>In both cases, it's not clear how C could have been "ready" when B was not.

A, B, and C, are entirely independent of one another.  I'm trying to
replicate an instance in which a feature is developed and submitted for
inclusion in a release, accepted for inclusion, but then later found
to be defective.

>> And so, I'm faced with git rebase -i posing some unanswerable questions
>> to our release manager.  She cannot easily remove B from the merge after
>> doint either merge A B C, or merge A, merge B, merge C.
>
>The way you described the situation there are no commits after the
>merges. So, why not reset to before the merge and do a "git merge A C"?

Presumably, I would need to tag the v1.0.0 branch after creating it,
which I was hoping not to have to do.  I wanted the equivalent of
"git unmerge B" after doing three separate merges as above, or an octopus
merge.  I'm just trying to make life simpler for our release manager,
who is not equipped with git fu.


Bill
