From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Tue, 27 Nov 2007 21:20:10 -0800
Message-ID: <C24B0B38-BD37-4BDA-B138-275C900670AE@midwinter.com>
References: <20071127211730.GA11861@midwinter.com> <7v4pf7b20b.fsf@gitster.siamese.dyndns.org> <49EB8C6F-8100-48C1-BB2D-A8F6023BACAD@midwinter.com> <Pine.LNX.4.64.0711272143470.5349@iabervon.org> <7vzlwz9ghg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:50:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKw6-0004WS-6w
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:18:34 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxFTA-0001U0-FK
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 06:28:20 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxFSt-00017V-Q4
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 06:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbXK1FUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 00:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbXK1FUM
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 00:20:12 -0500
Received: from tater.midwinter.com ([216.32.86.90]:33582 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750839AbXK1FUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 00:20:11 -0500
Received: (qmail 8617 invoked from network); 28 Nov 2007 05:20:10 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Qi4BmxUNgRfbprCXXcjapct1ScmCLa5etE07eLAYYEqF3Fe4OPQ68ehsnG/qY6wi  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 05:20:10 -0000
In-Reply-To: <7vzlwz9ghg.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: F13415B74EF222EBEFF18AE520BC4C53A02979D1
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 58 total 723888 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66310>


On Nov 27, 2007, at 7:49 PM, Junio C Hamano wrote:
> Yeah, and I am wondering why update hook needs to be changed for this.
> Didn't we introduce post-receive exactly for this sort of thing?

I didn't think the post-receive hook could reject a revision. I need  
to be able to do that here, e.g., if the user's change fails to commit  
because it's rejected by an svn commit hook. (Hooks upon hooks upon  
hooks...) If I do the svn commit in post-receive it's not clear how  
the user would repush the change after fixing it -- their fix would  
show up as a delta on top of a revision that I can't commit on its own  
to svn, so I would somehow have to know to do a squash merge and there  
would no longer be a one-to-one correspondence between git and svn  
revisions. That's not a total showstopper (I'm rewriting history  
anyway) but it sure seems like it'll be confusing and error-prone.

Also, running in post-receive will subject me to race conditions that  
aren't present in the update hook case; if I make my update hook  
script do its own locking and update the refs on its own, I'm  
guaranteed no other push will come along and update my ref out from  
under me. In post-receive there is no such guarantee and I may end up  
sending two pushes' worth of commits to svn when I think I'm only  
sending one.

If I'm misunderstanding the flow of control, please feel free to  
correct me. It just seemed like update was the only good place to do  
what I needed to do.

-Steve
