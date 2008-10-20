From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Working with remotes; cloning remote references
Date: Mon, 20 Oct 2008 12:50:00 -0400
Message-ID: <48FCB6B8.6090708@xiplink.com>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:23:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krxya-0002rv-69
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbYJTQuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbYJTQuO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:50:14 -0400
Received: from smtp242.iad.emailsrvr.com ([207.97.245.242]:49952 "EHLO
	smtp242.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYJTQuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:50:13 -0400
Received: from relay14.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay14.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 9C83E206D79;
	Mon, 20 Oct 2008 12:50:01 -0400 (EDT)
Received: by relay14.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 61516205B89;
	Mon, 20 Oct 2008 12:50:01 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <48FC8624.9090807@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98711>

Thanks for the explicit instructions, but I think I'm still missing 
something.  Here's exactly what I'm trying, just to make sure I'm not 
doing something odd.

First I set up the remote in the main repo:

main/$ git remote add -f ThingOne git://thing/ThingOne.git
main/$ git merge -s ours --no-commit ThingOne/master
main/$ git read-tree --prefix=thing-one/ -u ThingOne/master
main/$ git commit -m "Adding ThingOne"

Then I make a clone, fetch main's refs to ThingOne, and try to pull in 
changes from ThingOne by using those refs:

$ git clone /path/to/main clone
$ cd clone
clone/$ git config remote.origin.fetch \
         '+refs/remotes/ThingOne/*:refs/remotes/ThingOne/*' 

clone/$ git fetch
 From /path/to/main/
  * [new branch]      ThingOne/master -> ThingOne/master 

clone/$ git pull -s subtree git://thing/ThingOne.git ThingOne/master
fatal: Couldn't find remote ref ThingOne/master

The config & fetch commands indeed add a 
.git/refs/remotes/ThingOne/master file to the clone, but I'm missing the 
magic words for how to use that ref.


Also:

Michael J Gruber wrote:
> 
>> And actually, git's remote functionality feels a bit crippled if clones 
>> can't make some use of the origin's remotes.  Is there a reason for 
>> keeping remote definitions out of a clone?
> 
> Say A and B are working on a project C. Then, typically, A is interested
> in B's work on C, i.e. some of B's local branches, but not on B's remote
>  tracking branches: A tracks a "central" C already, just like B does,
> and remote tracking branches don't carry any "value adding" by the
> cloner, they're just a local unmodified copy of the remote.

I can appreciate that, but the approach leads to two consequences that I 
suggest should be avoidable:

1. A and B both have to set up the references to C themselves.  A can't 
just piggyback on whatever B has already set up.  (This is the impetus 
for my original message.)

2. Suppose B is just a repository that's being shared between A and D -- 
i.e. there's no B entity doing any work directly in B.  In this case if 
A (or D) wants to change B's reference to C (say, to track a new branch 
in C), they can't: B has to be changed directly, and nothing can be done 
in a clone to accomplish this.

I admit I'm picking at nits here -- obviously someone is able to access 
the B repo and do whatever needs doing.  I just feel that there are some 
situations where you want the origin's remotes in your clone, and some 
where you don't, and git should let you decide.

		Marc
