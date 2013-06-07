From: Scott McPeak <smcpeak@coverity.com>
Subject: git stash while pending merge should not be allowed
Date: Thu, 6 Jun 2013 23:52:33 -0700
Message-ID: <51B18331.6060302@coverity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 07 08:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkqXg-0001GC-Nf
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab3FGGww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:52:52 -0400
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:19015
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750971Ab3FGGwv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 02:52:51 -0400
Received: from mail200-ch1-R.bigfish.com (10.43.68.227) by
 CH1EHSOBE017.bigfish.com (10.43.70.67) with Microsoft SMTP Server id
 14.1.225.23; Fri, 7 Jun 2013 06:52:50 +0000
Received: from mail200-ch1 (localhost [127.0.0.1])	by
 mail200-ch1-R.bigfish.com (Postfix) with ESMTP id 2A290160234	for
 <git@vger.kernel.org>; Fri,  7 Jun 2013 06:52:50 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.2.21;KIP:(null);UIP:(null);IPV:NLI;H:BN1PRD0512HT003.namprd05.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 0
X-BigFish: PS0(zzzz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzzz2fh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e1dh1155h)
Received-SPF: pass (mail200-ch1: domain of coverity.com designates 132.245.2.21 as permitted sender) client-ip=132.245.2.21; envelope-from=smcpeak@coverity.com; helo=BN1PRD0512HT003.namprd05.prod.outlook.com ;.outlook.com ;
Received: from mail200-ch1 (localhost.localdomain [127.0.0.1]) by mail200-ch1
 (MessageSwitch) id 1370587967543671_15271; Fri,  7 Jun 2013 06:52:47 +0000
 (UTC)
Received: from CH1EHSMHS033.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.247])	by mail200-ch1.bigfish.com (Postfix) with ESMTP id
 78D2540004B	for <git@vger.kernel.org>; Fri,  7 Jun 2013 06:52:47 +0000 (UTC)
Received: from BN1PRD0512HT003.namprd05.prod.outlook.com (132.245.2.21) by
 CH1EHSMHS033.bigfish.com (10.43.70.33) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Fri, 7 Jun 2013 06:52:47 +0000
Received: from BY2PRD0310HT002.namprd03.prod.outlook.com (157.56.236.5) by
 pod51010.outlook.com (10.255.193.36) with Microsoft SMTP Server (TLS) id
 14.16.311.1; Fri, 7 Jun 2013 06:52:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-Originating-IP: [157.56.236.5]
X-OriginatorOrg: coverity.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226609>

A colleague of mine who is well-intentioned and fairly knowledgeable
about git recently caused havoc with our repository while merging
changes on the main line branch into a feature branch.  The reason is
that, along the way, he tried to use "git stash" while the merge was
pending.  A few commands later, this severely polluted the history of
all the files involved.

The command sequence started as follows:

   $ git checkout feature-branch
   $ git merge mainline-branch
   (conflicts; merge pending)
   $ git mergetool
   (resolve all conflicts; takes a while as there are many)
   $ make && make testsuite
   (oops, tests don't pass)

At this point, the user notices that the fix to the tests is in the
next commit on mainline-branch, which wasn't present when it was first
merged.  Not wanting to have a commit in the history whose tests do
not pass, and not wanting to redo all the conflict resolution work
involved in starting over with a different merge parent, he tries to
cherry pick it:

   $ git fetch
   $ git cherry-pick commit-with-fix
   (error: can't cherry pick while merge pending)

Ok, he thinks, git stash has worked in the past as a way to temporarily
move aside some work in progress.  So:

   $ git stash
   $ git cherry-pick commit-with-fix
   $ git stash pop

All seems well, so:

   $ git commit

Unfortunately, this does *not* do what was intended.  You see,
unbeknownst to this developer, git stash does not save the MERGE_HEAD!
So the commit shows up as an enormous single-parent commit on top of
feature-branch, referring to none of the merged commits from
mainline-branch in its ancestry.  Consequently, "git annotate" and
friends regard all the merged changes as having been made by the
developer alone and all at once, distorting the file histories to the
point of being nearly useless.  Furthermore, git still doesn't think
mainline-branch has been merged, so there is more fun to be had
sorting that out when the next merge from mainline happens.

We are now in the middle of an expensive and risky project to repair
the damage, since people pulled and pushed afterward, before the
problem was noticed.

I suggest that this problem could easily have been avoided if "git
stash" refused to run with a pending merge (present MERGE_HEAD file),
since this is crucial repository state that it does not save.  This
seems similar to what "git cherry-pick" does.

-Scott
