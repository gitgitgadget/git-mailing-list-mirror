From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Copy branch into master
Date: Thu, 01 Dec 2011 13:43:54 -0600
Message-ID: <4ED7D8FA.5000305@gmail.com>
References: <CAHxBh_T-f7O4r0zn=NtLTYtdbNqd3qSo2tW84aYRJp7ugDSMpw@mail.gmail.com> <20111128183616.GB29503@foghorn.codeweavers.com> <3655DADD9B52450B81B0CD34F1B0FAB6@bny.us.bosch.com> <20111128192659.GD29503@foghorn.codeweavers.com> <CB09450076EA444CA289CDCB995F16A4@bny.us.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'Andrew Eikum' <aeikum@codeweavers.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 20:44:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWCYS-0006wz-1s
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 20:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab1LAToR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 14:44:17 -0500
Received: from lo.gmane.org ([80.91.229.12]:58214 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510Ab1LAToQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 14:44:16 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RWCYF-0006sp-E3
	for git@vger.kernel.org; Thu, 01 Dec 2011 20:44:11 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 20:44:11 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 20:44:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
In-Reply-To: <CB09450076EA444CA289CDCB995F16A4@bny.us.bosch.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186188>

On 11/28/2011 1:30 PM, Ron Eggler wrote:
>> Sorry, I have no idea how to use any of the GUI tools. Perhaps your
>> GUI tool has a mailing list where you can ask about merge conflict
>> resolution?
>
> No problem, I actually got it all figured out now, and got my branch
> smoothly merged back into master.
>
That is not what you originally asked for.  What you asked for was:
"Now I would like to copy exactly what I have in that branch back into 
my master to have an exact copy in my master of what got deployed with 
out any changes."  If you did a git-merge then what you did was combine 
master with DVT.  That most likely did not make master equal to DVT.  If 
you run the following git-diff the results will likely show they do not 
match:
$ git-diff --name-only sha1-of-master-after-DVT-merge 
sha1-of-DVT-before-merge-to-master

If you merge branch A into branch B it does not make branch B equal to 
branch A.  It makes branch B a combination of branch B and branch A 
(plus your merge conflict resolutions).  If you truly want to make 
master exactly match DVT then I recommend the following: (I'm assuming 
this is not a superproject containing submodules, and that you are using 
linux.  I am using git 1.7.1.)

(Return master to the state it was in when you asked the question)
(1) git checkout master
(2) git branch BKUP-master-DVT-merge (backup your current post-merge 
master to another branch)
(3) git reset --hard sha1-of-master-before-merge

(Return DVT to the state it was in when you asked the question)
(1) git checkout DVT
(2) git branch BKUP-DVT-B4-merge (backup current DVT if it has new work)
(3) git reset --hard sha1-of-DVT-before-merge

(Make master match DVT exactly)
(1) Use the "vendor branch code drop" method described in the git-rm 
manpage* (see note on permissions below).  (Use the git-archive command 
to create your tarball of DVT for this.)
(2) After "vendor branch code drop" is committed, git-diff --name-status 
master DVT (they should match, ie. no results that matter)
(3) git-tag the resulting commit to make it clear this is the version 
you deployed.

*Note: if you are tracking permissions in git (executable vs. 
non-executable bits) then you will need to accomodate and validate 
permissions in your git-archive and/or ensure permissions are set 
properly before committing your vendor branch code drop.  Otherwise, you 
will have permissions changes that do not exactly match DVT.

I recommend trying the above on a test copy of your repo to verify the 
results are really what you want.
(tar up your repo as root to retain permissions, and untar in test dir)
(repo path = /home/me/MY-REPO)
(1) pwd ( = /home/me)
(2) mkdir test
(3) su root
(4) pwd ( = /home/me)
(5) tar -cvzf MY-REPO.tar.gz MY-REPO/
(6) cd test
(7) mv ../MY-REPO.tar.gz .
(8) tar -xvzf MY-REPO.tar.gz
(test repo path = /home/me/test/MY-REPO)
(9) exit
(10) cd /home/me/test/MY-REPO
(11) try out what I said on test/MY-REPO and then decide if you want to 
do it on the real me/MY-REPO.

If you already have additional commits on master after your master-DVT 
merge then they are backed up in the BKUP-master-DVT-merge branch you 
made earlier.  These commits can then be interactively rebased on your 
remediated master.  (Be aware of any possible unique master-DVT merged 
code the new commits are dependent on.  If so, that code needs to be 
reincorporated instead of being unwittingly lost.)

All the above assumes that others have not already pulled your 
master-DVT merge and based their work on it.  If they have already 
pulled your new master and based work on it then it may be too late for 
this to be practical, or additional steps would be needed for others to 
properly remediate.  I'm assuming you have a known set of developers 
pulling from you.  It is possible for them to interactively rebase their 
new work onto your remediated master and take the merged-master out of 
their history.  (Be aware of any possible unique master-DVT merged code 
the new commits are dependent on.  If so, that code needs to be 
reincorporated instead of being unwittingly lost.)

Hope this helps.

v/r,
neal
