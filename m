From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 16:56:08 +0200
Message-ID: <48061388.6090705@viscovery.net>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com> <4805FD7C.5000206@viscovery.net> <20080416142551.GB3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 17:11:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm94F-0006OB-1x
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 16:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761315AbYDPO4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 10:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758041AbYDPO4N
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 10:56:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40923 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbYDPO4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 10:56:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jm93Q-00042C-IN; Wed, 16 Apr 2008 16:56:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4F9696C4; Wed, 16 Apr 2008 16:56:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080416142551.GB3133@dpotapov.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 2.2 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, PLING_QUERY=0.514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79711>

Dmitry Potapov schrieb:
> On Wed, Apr 16, 2008 at 03:22:04PM +0200, Johannes Sixt wrote:
>> Brian Foster schrieb:
>>> Dmitry Potapov <dpotapov@gmail.com> correctly deduced:
>>>>  I suspect your original git repository has info/grafts
>>> hi Dmitry,
>>>
>>>  bingo!  YES, it does:
>> ...
>>>  the goal is to put things into a sane state so any new
>>>  clones are healthy.  there's only one(?) existing clone,
>>>  which may or may not be(? become?) an issue.
>> Just move info/grafts out of the way and you *may* be all set. Don't
>> delete it - there might be a reason that the file exists.
> 
> I believe that parts of history hidden by info/grafts are removed now,
> otherwise git clone would not have problems to clone this repository.

No. The reason why git clone'd repositories have problems is that
git-upload-pack sends a pack that does not contain the hidden objects; but
since the cloned repository doesn't have the info/grafts, it tries to look
up the hidden, now missing, objects, and fails.

>> - The repository is broken. Then 'git repack -f -d -a' was done while the
>> grafts were in effect (and obviously the grafts had hidden parts of the
>> history, which are now no longer available).
> 
> Actually, 'git repack -f -d -a' does not remove hidden parts of the
> history (because 'git prune-packed' does not remove hidden parts), but
> 'git prune' does remove hidden parts. I believe 'git prune' relies on
> 'git-fsck --unreachable', which outputs hidden parts as unreachable.
> Perhaps, git-fsck should be corrected, so it will not treat hidden as
> unreachable, because anything what is hidden is still reachable for
> anyone who is trying to clone the repository.

Actually, no. The trouble is that *all* tools obey grafts. Hence,
git-repack -f -d -a will remove the hidden objects. But a subsequent fsck
won't notice, because it *also* obeys the grafts. git prune will remove
hidden objects only as long as they are loose; if they are already packed,
then only a repack -f will remove them.

Here's a thread with a proposal by Linus how to improve the situation, but
nobody came along and implemented it:

http://thread.gmane.org/gmane.comp.version-control.git/37744/focus=37908

-- Hannes
