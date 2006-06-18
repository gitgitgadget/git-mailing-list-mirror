From: Jeff Garzik <jeff@garzik.org>
Subject: Re: git 1.4.0 usability problem
Date: Sun, 18 Jun 2006 19:01:15 -0400
Message-ID: <4495DB3B.10403@garzik.org>
References: <449557B6.1080907@garzik.org> <7vbqsqdru0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Jun 19 01:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs6H9-0003q9-Jd
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 01:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWFRXBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 19:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWFRXBS
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 19:01:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42630 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750727AbWFRXBS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 19:01:18 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1Fs6GZ-0005LB-Vu; Sun, 18 Jun 2006 23:01:16 +0000
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqsqdru0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22111>

Junio C Hamano wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> Here is how to reproduce:
> 
> This is not related to the "not clobbering untracked files"
> safety valve under discussion, but one thing I noticed.
> 
>> git clone -l $url/torvalds/linux-2.6.git tmp-2.6
>> cd tmp-2.6
>> cp .git/refs/tags/v2.6.12 .git/refs/heads/tmp
>> git checkout -f tmp
> 
> This should never have been supported.  At this point tmp is a
> tag object that is under heads/ -- a definite no-no.  We should
> make checkout more careful to complain about it.
> 
> Doing
> 
>         git update-ref refs/heads/tmp $(git rev-parse v2.6.12^0)
> 
> instead of "cp" is kosher, and
> 
> 	git-rev-parse v2.6.12^0 >.git/refs/heads/tmp
> 
> is OK under the current implementation of refs.

Sorry about that.  The contrived example produced the same results as 
the real-world example (updating jgarzik/{libata-dev,scsilun-2.6}.git 
branches).


>> git pull . master
>> # watch OBVIOUS FAST-FORWARD MERGE complain about untracked
>> # working tree files
> 
> In any case, here is a patch I think would alleviate your
> original problem.
> 
> Sorry for the trouble.  I really did not want to disrupt the
> workflow of old timers in the name of making it safer for new
> people.  Could you comment on whether this is an acceptable
> approach?
> 
> -- >8 --
> [PATCH] Conditionally loosen "no clobber untracked files" safety valve.
> 
> This introduces a new configuration item "core.oktoclobber" to
> control how untracked working tree file is handled during branch
> switching.
> 
> The safety valve introduced during 1.4.0 development cycle
> refrains from checking out a file that exists in the working
> tree, not in the current HEAD tree and exists in the branch we
> are switching to, in order to prevent accidental and
> irreversible lossage of user data.  This can be controlled by
> having core.oktoclobber configuration item:

I'm a bit under the weather today, so I must defer thinking about this. 
  :)  But if what Ryan says is true, about simply needing to ditch the 
"-f" argument I habitually pass to 'git checkout', would that alleviate 
the need for a patch?

FWIW, my workflow is

	cd /repos
	cd linux-2.6
	git pull
	cd ../libata-dev
	git checkout -f master	# guarantee any WIP goes away
	git pull ../linux-2.6	# update vanilla branch
	git checkout -f upstream# switch to working branch,
				# guarantee any WIP goes away.
	git pull . master	# pull latest upstream updates
	build/test/etc.
	git checkout -f sii-m15w # switch to topic-specific branch,
				 # whose parent is always #upstream
	git pull . upstream
	build/test/etc.
	repeat for several topics (on-going devel branches)
	git checkout -f -b ALL upstream	# create everything-together
					# test branch
	git pull . sii-m15w
	git pull . topicB
	git pull . topicC
	build/test/etc.
	git checkout -f master
	./push		# calls 'git push --force --all $url'

More tomorrow,

	Jeff
