From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Thu, 24 May 2007 16:43:52 -0400
Message-ID: <C35F50C5-28E8-45B6-8A4E-02233CE4B4B9@adacore.com>
References: <46528A48.9050903@gmail.com> <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net> <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com> <7vps4ryp02.fsf@assigned-by-dhcp.cox.net> <20070524071235.GL28023@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Dana How <danahow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <boschg@mac.com>
X-From: git-owner@vger.kernel.org Thu May 24 22:50:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrKGC-0005cb-QH
	for gcvg-git@gmane.org; Thu, 24 May 2007 22:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbXEXUuJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 16:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbXEXUuJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 16:50:09 -0400
Received: from nile.gnat.com ([205.232.38.5]:35254 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbXEXUuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 16:50:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id B25C948CC58;
	Thu, 24 May 2007 16:50:06 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 02959-01-9; Thu, 24 May 2007 16:50:06 -0400 (EDT)
Received: from [172.16.1.99] (sdsl-216-220-103-158.dsl.bway.net [216.220.103.158])
	by nile.gnat.com (Postfix) with ESMTP id 6511148CBF7;
	Thu, 24 May 2007 16:50:05 -0400 (EDT)
In-Reply-To: <20070524071235.GL28023@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48304>

[resent because of malformed headers causing rejection]
On May 24, 2007, at 03:12, Shawn O. Pearce wrote:
> I still don't buy the idea that these megablobs shouldn't be packed.
> I understand Dana's pain here (at least a little bit, my problems
> aren't as bad as his are), but I also hate to see us run away from
> packfiles for these really sick cases just because we have some
> issues in our current packfile handling.
>
> Packfiles give us a lot of benefits:
>
>  1) less inode usage;
Using 1 inode per huge blob can never be an issue
>  2) transport can write directly to local disk;
>  3) transport can (quickly) copy from local disk;
Can do these by re-enabling the new loose object format
>  4) testing for existance is *much* faster;
>  5) deltafication is possible;

Look at it the other way. If we have huge objects (say >1GB),
we should put them in a pack of their own anyway. What's better:
having a pack with a separate index file or just a loose object?
While the one object per file model is awful for many small files
with lots of similarity, it is really quite efficient for large
objects, and the most reasonable model for huge objects.

Such blobs are just too large to do anything useful with.
The only operations done on them will be to check them in
or check them out. Ideally, we should never try to have them
in memory at all, but just stream them to/from disk while
compressing or decompressing.

Trying to deltify huge objects just takes too much time.
Similarly, we don't want to read 100MB to then apply a delta
and maybe throw out half of the data we read in the first place.
It's just too inefficient. If we'd even read the huge blobs once
during "git repack", we'll waste so much time that we're unlikely
to ever gain it back in any real world scenario.

   -Geert
