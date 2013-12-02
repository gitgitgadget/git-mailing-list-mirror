From: Martin Fick <mfick@codeaurora.org>
Subject: Ideas to speed up repacking
Date: Mon, 2 Dec 2013 16:30:45 -0700
Organization: CAF
Message-ID: <201312021630.45767.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 00:30:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vncx3-0002eg-GM
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 00:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab3LBXat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 18:30:49 -0500
Received: from smtp.codeaurora.org ([198.145.11.231]:55709 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab3LBXas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 18:30:48 -0500
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1C4C613EF80;
	Mon,  2 Dec 2013 23:30:48 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 0F36713F279; Mon,  2 Dec 2013 23:30:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 8315A13EF80
	for <git@vger.kernel.org>; Mon,  2 Dec 2013 23:30:47 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
X-Length: 3824
X-UID: 268
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238660>

I wanted to explore the idea of exploiting knowledge about 
previous repacks to help speed up future repacks.  

I had various ideas that seemed like they might be good 
places to start, but things quickly got away from me.  
Mainly I wanted to focus on reducing and even sometimes 
eliminating reachability calculations since that seems to be 
be the one major unsolved slow piece during repacking.

My first line of thinking goes like this:  "After a full 
repack, reachability of the current refs is known.  Exploit 
that knowledge for future repacks."  There are some very 
simple scenarios where if we could figure out how to 
identify them reliably, I think we could simply avoid 
reachability calculations entirely, and yet end up with the 
same repacked files as if we had done the reachability 
calculations.  Let me outline some to see if they make sense 
as starting place for further discussion.

-------------

* Setup 1:  

  Do a full repack.  All loose and packed objects are added 
to a single pack file (assumes git config repack options do 
not create multiple packs).

* Scenario 1:

  Start with Setup 1.  Nothing has changed on the repo 
contents (no new object/packs, refs all the same), but 
repacking config options have changed (for example 
compression level has changed).

* Scenario 2:

   Starts with Setup 1.  Add one new pack file that was 
pushed to the repo by adding a new ref to the repo (existing 
refs did not change).

* Scenario 3: 

   Starts with Setup 1.  Add one new pack file that was 
pushed to the repo by updating an existing ref with a fast 
forward.

* Scenario 4:

   Starts with Setup 1.  Add some loose objects to the repo 
via a local fast forward ref update (I am assuming this is 
possible without adding any new unreferenced objects?)


In all 4 scenarios, I believe we should be able to skip 
history traversal and simply grab all objects and repack 
them into a new file?

-------------

Of the 4 scenarios above, it seems like #3 and #4 are very 
common operations (#2 is perhaps even more common for 
Gerrit)?  If these scenarios can be reliably identified 
somehow, then perhaps they could be used to reduce repacking 
time for these scenarios, and later used as building blocks 
to reduce repacking time for other related but slightly more 
complicated scenarios (with reduced history walking instead 
of none)?

For example to identify scenario 1, what if we kept a copy 
of all refs and their shas used during a full repack along 
with the newly repacked file?  A simplistic approach would 
store them in the same format as the packed-refs file as 
pack-<sha>.refs.  During repacking, if none of the refs have 
changed and there are no new objects...  

Then, if none of the refs have changed and there are new 
objects, we can just throw the new objects away?

...

I am going to stop here because this email is long enough 
and I wanted to get some feedback on the ideas first before 
offering more solutions.

Thanks,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
