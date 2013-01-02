From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Missing Refs after Garbage Collection
Date: Wed, 2 Jan 2013 15:43:07 -0700
Organization: CAF
Message-ID: <201301021543.08029.mfick@codeaurora.org>
References: <C0A16EC8-D05A-41D0-BF2A-34BF3B1B839E@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Earl Gresh <egresh@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:43:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqX20-0000x5-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 23:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab3ABWnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 17:43:10 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:45157 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab3ABWnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 17:43:09 -0500
X-IronPort-AV: E=Sophos;i="4.84,398,1355126400"; 
   d="scan'208";a="17379142"
Received: from pdmz-ns-snip_115.254.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.254])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 Jan 2013 14:43:08 -0800
Received: from mfick-laptop.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 9CE0110004BE;
	Wed,  2 Jan 2013 14:43:08 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-41-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <C0A16EC8-D05A-41D0-BF2A-34BF3B1B839E@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212550>

On Friday, December 21, 2012 06:41:43 pm Earl Gresh wrote:
> Hi-
> 
> I have observed that after running GC, one particular git
> repository ended up with some missing refs in the
> refs/changes/* namespace the Gerrit uses for storing
> patch sets. The refs were valid and should not have been
> pruned. Concerned about loosing data, GC is still enabled
> but ref packing is turned off. Now the number of refs has
> grown to the point that it's causing performance problems
> when cloning the project.
> 
> Is anyone familiar with git gc deleting valid references?
> I'm running git version 1.7.8. Have there been any
> patches in later git releases that might address this
> issue ( if it is a git problem )?


When Earl was testing ref-packing a few months ago, that the 
refs in question where reported invalid by git show-ref:

  git show-ref 2>&1 |grep refs/changes/45/129345/1
  error: refs/changes/45/129345/1 does not point to a valid 
object!

But we could trace the refs manually to git show-object just 
fine.  But oddly enough, when using git show-ref with the -v, 
the error above would not be spit out.

So, my guess is that something during the repack was 
following the same code path that git show-ref (without the -
v) was following and determining that the ref was invalid and 
therefor it was not able to add it to the new packfile, but 
yet perhaps it was still being added to the prune-list and 
thus getting pruned?  Is this possible somehow?  

Looking at handle_one_ref() I can't see how.  The fprintf() 
happens before the ref is added to the prune list and is 
unconditional.  I am grasping here, but what if the sha1 
passed into handle_one_ref() somehow gets set incorrectly to 
000...?  Would it then basically get written to the packed-
ref file as 000... (deleted), but then still get added to the 
prune list?  You might say "but then it wouldn't get pruned 
since the loose ref doesn't match 000..., but if the logic 
which checks this matching makes the same error reading the 
sha1 and thinks it is 000... it might then get pruned?


-Martin
