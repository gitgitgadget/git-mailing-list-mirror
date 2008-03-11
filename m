From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4.4
Date: Tue, 11 Mar 2008 15:11:41 -0400
Message-ID: <47D6D96D.2000302@garzik.org>
References: <7vr6f31iwj.fsf@gitster.siamese.dyndns.org> <7vr6eknpjf.fsf@gitster.siamese.dyndns.org> <47D416C8.1020903@garzik.org> <7v1w6jod54.fsf@gitster.siamese.dyndns.org> <47D459D5.2020101@garzik.org> <7vmyp7kryp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ9tk-0002Sl-OX
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 20:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbYCKTLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 15:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754935AbYCKTLs
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 15:11:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52871 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbYCKTLr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 15:11:47 -0400
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JZ9sz-0000iP-V9; Tue, 11 Mar 2008 19:11:45 +0000
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <7vmyp7kryp.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.4 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76894>

Junio C Hamano wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> Yes, I regularly run both 'git gc' and 'git prune'.
>>
>> But since (ref original email) I was doing some rebasing, there are
>> inevitably changesets left dangling after such an operation.
> 
> Yeah, I'd say it is stupid if "am" ran "gc --auto" for every patch.  I
> recall that we had the same issue with git-svn and we made it run once
> every 1k round, and we probably should do the same for "am" and "rebase",
> running once at the very end.

> Perhaps we would want to raise the default "gc --auto" limit?  Currently


That seems quite reasonable.  This "feels" like a threshold-too-low problem.



> when it estimates that you have roughly 6700 objects unpacked it runs
> "repack --prune-packed", and if there still are that many unpacked objects
> after that, it suggests you to run "git prune" to remove them.  If you are
> rebasing, the commits in the old history that are rewritten will _not_
> immediately become dangling because they will still be reachable from your
> reflog.  If you are getting the message, these objects were already
> dangling (ancient commits that are not even reachable from your reflog
> entries that are by default kept for 90 days) even before you started your
> rebase or am run.

My workflow generally looks like this:

	# repo was created in this manner....  this was done ONCE,
	# not every time I apply patches

	git clone --reference ../linux-2.6 ../linux-2.6 libata-dev


	# a patch-applying session

	git checkout master
	git pull ../linux-2.6
	git fetch --tags ../linux-2.6	# yes, still necessary...

	git branch -D ALL NEXT
	git branch -D upstream-fixes upstream-linus

	git checkout -b upstream-fixes master
	git-am --utf8 --signoff -i /g/tmp/mbox	# repeat many times...
	git branch upstream-linus upstream-fixes

	git-checkout sii-lbt && git-rebase master
	git-checkout mv-ahci-pata && git-rebase master
	git-checkout new-eh && git-rebase master
	git branch NEXT master
	git branch ALL new-eh

	git checkout master
	git prune
	git push --force --all $URL

Thus, 'git prune' is run on a very regular basis, but 'git gc' is not.

However, I presume the lack of 'git gc' regularity on libata-dev.git is 
mitigated by the fact that I _do_ run 'git gc' regularly on 
linux-2.6.git (listed in libata-dev's alternatives, as noted by 
git-clone statement above)


> After you finished your day's work on a typical day, what does the output
> from "git count-objects -v" and "git fsck-objects" look like, I wonder?

[jgarzik@pretzel libata-dev]$ git count-objects -v
count: 51
size: 244
in-pack: 475
packs: 4
prune-packable: 0
garbage: 0
[jgarzik@pretzel libata-dev]$ git fsck-objects
[jgarzik@pretzel libata-dev]$




As an aside...  a git-debug-info might be a useful command, wrapping up 
everything you (a git developer) would find interesting from me (a 
humble and appreciative git user).  Users could attach the output from 
git-debug-info to emails, when discussing problems in their repositories.

	Jeff
