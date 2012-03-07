From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: who's on first? - following first parent and merge-management
Date: Tue, 06 Mar 2012 23:36:06 -0600
Message-ID: <jj6s47$m98$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 06:36:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S59Y1-000198-6d
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 06:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab2CGFgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 00:36:20 -0500
Received: from plane.gmane.org ([80.91.229.3]:51676 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2CGFgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 00:36:19 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S59Xu-00015y-2N
	for git@vger.kernel.org; Wed, 07 Mar 2012 06:36:18 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 06:36:18 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 06:36:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192427>

"first parent" and "follow first parent" are mentioned frequently in git 
documentation.  This seems to imply that its pretty important.  That 
would imply it should be intentional (planned).  Who is "first parent"? 
  Who is "first parent" _meant_ to be?  What is "follow first parent" 
_meant_ to show?

(I've been on the rebase track until now so I'm "new" to git-merge's.) 
Symptomatically, I think "first parent" is the branch you were on when 
you did the merge.  That would mean the first parent can change 
depending on your merge-management practices.  This affects the results 
that "follow first parent" produces.  For example:

$ git log --first-parent --oneline origin/master
deadbee some commit x

Scenario A: "First-Parent Flip-Flop" (some users are doing this)

(1) I commit on local master.  USER=foo
$ git checkout master && hack && git commit -a -m "foo commit 1"
$ git log --first-parent --oneline master
foo1111 foo commit 1
deadbee some commit x

(2) You push to canonical master.  USER=bar
$ git checkout master && hack && git commit -a -m "bar commit 1"
$ git log --first-parent --oneline master
bar1111 bar commit 1
deadbee some commit x
$ git push origin HEAD && git fetch origin
$ git log --first-parent --oneline origin/master
bar1111 bar commit 1
deadbee some commit x

(3) I merge canonical master w/my master and push.  USER=foo
$ git checkout master && git pull origin
$ git log --first-parent --oneline master
mrg1111 Merge branch 'master' of file:///root/BARE
foo1111 foo commit 1
deadbee some commit x
$ git push origin HEAD && git fetch origin
$ git log --first-parent --oneline origin/master
mrg1111 Merge branch 'master' of file:///root/BARE
foo1111 foo commit 1
deadbee some commit x

(4) You merge canonical master w/your master and push.  USER=bar
$ git checkout master && hack && git commit -a -m "bar commit 2"
$ git log --first-parent --oneline master
bar2222 bar commit 2
bar1111 bar commit 1
deadbee some commit x
$ git pull origin
$ git log --first-parent --oneline master
mrg2222 Merge branch 'master' of file:///root/BARE
bar2222 bar commit 2
bar1111 bar commit 1
deadbee some commit x
$ git push origin HEAD && git fetch origin
$ git log --first-parent --oneline origin/master
mrg2222 Merge branch 'master' of file:///root/BARE
bar2222 bar commit 2
bar1111 bar commit 1
deadbee some commit x

This "flip-flop" practice does not seem right to me.  Please comment.

Scenario B: "First-Parent Consistency"
(1) I commit on local master.  USER=foo
$ git checkout -b foo-topic master && hack && git commit -a -m "foo 
commit 1"
$ git log --first-parent --oneline foo-topic
foo1111 foo commit 1
deadbee some commit x

(2) You push to canonical master.  USER=bar
$ git checkout -b bar-topic master && hack && git commit -a -m "bar 
commit 1"
$ git log --first-parent --oneline bar-topic
bar1111 bar commit 1
deadbee some commit x
$ git checkout master && git merge bar-topic && git push origin HEAD && 
git fetch origin
$ git log --first-parent --oneline origin/master
bar1111 bar commit 1
deadbee some commit x

(3) I merge --no-ff into master and push.  USER=foo
$ git checkout master && git pull --ff-only origin
$ git log --first-parent --oneline master
bar1111 bar commit 1
deadbee some commit x
$ git-merge foo-topic
$ git log --first-parent --oneline master
mrg1111 Merge branch 'foo-topic'
bar1111 bar commit 1
deadbee some commit x
$ git push origin HEAD && git fetch origin
$ git log --first-parent --oneline origin/master
mrg1111 Merge branch 'foo-topic'
bar1111 bar commit 1
deadbee some commit x

(4) You merge --no-ff into master and push.  USER=bar
$ git checkout bar-topic && hack && git commit -a -m "bar commit 2"
$ git log --first-parent --oneline bar-topic
bar2222 bar commit 2
bar1111 bar commit 1
deadbee some commit x
$ git checkout origin && git pull --ff-only origin
$ git log --first-parent --oneline master
mrg1111 Merge branch 'foo-topic'
bar1111 bar commit 1
deadbee some commit x
$ git merge bar-topic
$ git log --first-parent --oneline master
mrg2222 Merge branch 'bar-topic'
mrg1111 Merge branch 'foo-topic'
bar1111 bar commit 1
deadbee some commit x
$ git push origin HEAD && git fetch origin
$ git log --first-parent --oneline origin/master
mrg2222 Merge branch 'bar-topic'
mrg1111 Merge branch 'foo-topic'
bar1111 bar commit 1
deadbee some commit x

This "consistency" scenario seems better, but I'm not sure if its right. 
  Git seems to "like it" in that the merge messages make more sense. 
Please comment.

Please advise on "first parent" intent, best-practices, and pitfalls, or 
documentation that explains it.  (I haven't found documentation that 
directly explains "first parent theory and practice".  I've seen many 
references to "first parent" and its implied meaning that I'm supposed 
to "just know" or deduce).

Thanks in advance for any pointers.

v/r,
neal
