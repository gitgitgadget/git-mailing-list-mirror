From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 15:00:38 -0700
Message-ID: <42C46B86.8070006@zytor.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 23:55:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do6zb-0007SZ-7l
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 23:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVF3WBx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 18:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVF3WBx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 18:01:53 -0400
Received: from terminus.zytor.com ([209.128.68.124]:30895 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263063AbVF3WB1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 18:01:27 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j5UM0hXV020601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jun 2005 15:00:44 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 30 Jun 2005, H. Peter Anvin wrote:
> 
>>It does that, but it only have to do that when the actual file has 
>>changed.  That's acceptable, at least for the repository sizes we're 
>>likely to deal with within the medium term.
> 
> 
> Well, realize that "incremental packs" deltify a lot worse than a "big
> pack", since pack-files don't do deltas to objects outside the pack-file.
> 
> So we'd get _some_ compression, but not as much as possible. The current
> kernel compresses down to a single 63 MB pack-file (that's with the 2.6.11
> tree too, not just the HEAD history), but without deltas it weights in at
> about 177 MB.
> 
> So a "sum of incremental packs" should be somewhere in between those two
> values, even today. For a single kernel archive.
> 
> So repository sizes aren't exactly trivial. I don't know how expensive
> that rsync hash thing is, but one thing you lose is the ability to
> hardlink objects, so if you have a few kernel repositories at some point
> it doesn't fit in the cache any more, and then the rsync will have to read
> that much pack object stuff from disk in addition to doing the hash. Ugh.
> 

The bulk of the cost in doing the hashing comes from having to read the 
file.

Well, if you grow a single pack file with appending, then you can have 
delta references to earlier objects within the same pack file.

At least at this point, we'd handle a few very large files a lot better 
than an enormous swarm of smaller ones.

In the end, it might be that the right thing to do for git on kernel.org 
is to have a single, unified object store which isn't accessible by 
anything other than git-specific protocols.  There would have to be some 
way of dealing with, for example, conflicting tags that apply to 
different repositories, though.

	-hpa
