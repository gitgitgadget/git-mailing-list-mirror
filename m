From: Bill Lear <rael@zopyra.com>
Subject: Re: Dangers of working on a tracking branch
Date: Fri, 16 Feb 2007 09:13:22 -0600
Message-ID: <17877.51730.418633.750922@lisa.zopyra.com>
References: <17876.51013.561979.431717@lisa.zopyra.com>
	<Pine.LNX.4.64.0702151557410.1757@xanadu.home>
	<17876.52962.662946.582507@lisa.zopyra.com>
	<17876.53654.426022.454712@lisa.zopyra.com>
	<er333i$787$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 16:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI4mH-0002KF-Mw
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 16:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbXBPPNd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 10:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbXBPPNd
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 10:13:33 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61123 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964986AbXBPPNc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 10:13:32 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1GFDUk14472;
	Fri, 16 Feb 2007 09:13:30 -0600
In-Reply-To: <er333i$787$1@sea.gmane.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39918>

On Friday, February 16, 2007 at 03:00:04 (+0100) Jakub Narebski writes:
>Bill Lear wrote:
>
>> On Thursday, February 15, 2007 at 15:21:38 (-0600) Bill Lear writes:
>>>On Thursday, February 15, 2007 at 16:00:23 (-0500) Nicolas Pitre writes:
>>>>On Thu, 15 Feb 2007, Bill Lear wrote:
>>>>
>>>>> We are about to switch to git 1.5 from git 1.4.4.1.  I cannot remember
>>>>> if someone posted about this, but what is the danger of working on a
>>>>> tracking branch --- there are abundant cautions about doing this, but
>>>>> I can't recall and can't find the reason this is bad.
>>>>
>>>>A tracking branch is supposed to be a local mirror of what is available 
>>>>remotely.  If you commit local changes to it then you break that model.
>>>
>>>Ok, so I break the model, what is the harm in that?  Can I no longer
>>>pull from or push to the remote branch?  Do I corrupt something
>>>locally?  Does something else break?  I'm trying to formulate an
>>>explanation to our users why the 1.5 way is superior and I can't just
>>>say "if you do that you break the model".
>
>You cannot fetch or push to the remote branch if you made some commits
>on the tracking branch ("broke the model") and remote branch has other
>commits. You can force the issue, but then either remote (for push)
>or local (for fetch) commits would be lost.

Ok, I'm trying to come up with an experiment that verifies this, so
I can give a concrete example to our developers.

I don't seem to be able to get it to fail, but I sure remember having
severe problems with this in practice.  Here is my attempt, again with
git 1.4.4.1:

# Create my repo and add a file A
% mkdir my_repo
% cd my_repo
% git init-db
defaulting to local storage area
% echo A > A
% git add A && git commit -a -m "Add A"
Committing initial tree f53c91092dbda83f3565e78c285f3e2ab0cfd968

# Create a peer repo and add a file B
% cd ..
% mkdir peer_repo
% cd peer_repo/
% git init-db
defaulting to local storage area
% echo B > B
% git add B && git commit -a -m "Add B"
Committing initial tree bfcfa4ca04d80d4b092e022ad163e82ca0f4a34f

# Create a topic branch in peer repo and add file C
% git checkout -b topic
% echo C > C
% git add C && git commit -a -m "Add C"

# Go back to my repo and fetch peer's topic branch
% cd ../my_repo/
% git fetch ../peer_repo topic:topic
warning: no common commits
remote: Generating pack...
remote: Done counting 6 objects.
remote: Deltifying 6 objects.
remote: /6) done/6) done
Unpacking 6 objects
remote: Total 6, written 6 (delta 0), reused 0 (delta 0)
 100% (6/6) done
* refs/heads/topic: storing branch 'topic' of ../peer_repo
  commit: af3ab53

# In my repo, checkout topic and change B
% git checkout topic
% echo "Change B" >> B
% git commit -a -m "Change B"

# Go back to peer repo and change C
% cd ../peer_repo/
% echo "Change C" >> C
% git commit -a -m "Change C"

# Go back to my repo and pull peer's topic branch
% cd ../my_repo
% git pull ../peer_repo topic:topic
remote: Generating pack...
remote: Done counting 5 objects.
remote: Result has 3 objects.
remote: Deltifying 3 objects.
remote:  100% (3/3) done
remote: Total 3, written 3 (delta 0), reused 0 (delta 0)
Unpacking 3 objects
 100% (3/3) done
* refs/heads/topic: not updating to non-fast forward branch 'topic' of ../peer_repo
  old...new: d3cf979...9e36a9a
Trying really trivial in-index merge...
Wonderful.
In-index merge
 C |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

So, why does it say "not updating to non-fast forward branch", yet
it does the merge and gets the changes anyway?

# Seem to have gotten the changes into my_repo anyway:
% git branch
  master
* topic
% cat B C
B
Change B
C
Change C

I'm trying to come up with a white-board presentation I can give to
the group this afternoon and they are a contumacious bunch.


Bill
