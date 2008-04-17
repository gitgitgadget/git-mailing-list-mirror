From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Thu, 17 Apr 2008 08:18:39 +0200
Message-ID: <4806EBBF.9060906@viscovery.net>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com> <4805FD7C.5000206@viscovery.net> <20080416142551.GB3133@dpotapov.dyndns.org> <48061388.6090705@viscovery.net> <20080416161742.GC3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 08:19:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmNSw-00045R-Vl
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 08:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYDQGSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 02:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbYDQGSm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 02:18:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21843 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYDQGSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 02:18:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JmNSB-0000z3-LN; Thu, 17 Apr 2008 08:18:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 52E206D9; Thu, 17 Apr 2008 08:18:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080416161742.GC3133@dpotapov.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 2.2 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, PLING_QUERY=0.514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79770>

Dmitry Potapov schrieb:
> On Wed, Apr 16, 2008 at 04:56:08PM +0200, Johannes Sixt wrote:
>> Actually, no. The trouble is that *all* tools obey grafts. Hence,
>> git-repack -f -d -a will remove the hidden objects. But a subsequent fsck
>> won't notice, because it *also* obeys the grafts. git prune will remove
>> hidden objects only as long as they are loose; if they are already packed,
>> then only a repack -f will remove them.
> 
> I use git 1.5.5 and I have a script that creates are repo with a hidden
> commit and then it cleans the reflog cleaned (as it would be happen after
> expiration of gc.reflogExpire). Then I run 'git-repack -f -d -a' and the
> hidden commit still presents, but when I run 'git prune' then the hidden
> object disappear. You can try it for yourself. Here is the script, I used:

And the reason for this is...

> 
> ===
> #!/bin/sh
> 
> set -e
> 
> mkdir t5
> cd t5
> git init
> 
> echo 1 > foo
> git add foo
> git commit -m 'add foo'
> R1=$(git rev-parse HEAD)
> 
> echo 2 >> foo
> git commit -m 'edit foo' -a
> R2=$(git rev-parse HEAD)
> 
> echo 3 >> foo
> git commit -m 'edit foo again' -a
> R3=$(git rev-parse HEAD)
> 
> set -x
> git log
> echo "$R3 $R1" > .git/info/grafts
> git log
> git-fsck --unreachable
> : > .git/logs/HEAD
> : > .git/logs/refs/heads/master
> git-fsck --unreachable
> git gc

... at this point the hidden commit still exists as loose objects (because
the repack inside gc didn't see the commit), and therefore...

> git-fsck --unreachable
> 
> 
> git-repack -f -d -a

... this does not make a difference at all.

> git-fsck --unreachable
> 
> git prune

Here you remove the loose objects (because prune doesn't see the commit,
either), and by doing so you corrupt the repository.

> git-fsck --unreachable
> ===

A repack -a -d makes a difference if info/grafts is installed *after* the
first repack/gc.

-- Hannes
