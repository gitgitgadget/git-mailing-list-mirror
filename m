From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] avoid possible overflow in delta size filtering computation
Date: Thu, 26 Mar 2009 08:18:10 +0100
Organization: private
Message-ID: <86y6usah1p.fsf@broadpark.no>
References: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
 <86hc1hdcj1.fsf@broadpark.no>
 <alpine.LFD.2.00.0903250936100.26337@xanadu.home>
 <86bprptvcx.fsf@broadpark.no> <alpine.LFD.2.00.0903251514360.26337@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 08:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjsP-0007DC-LI
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 08:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbZCZHSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 03:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbZCZHSP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 03:18:15 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:52669 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZCZHSO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 03:18:14 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KH3007AQQYCJEB0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 26 Mar 2009 08:18:12 +0100 (CET)
Received: from localhost ([80.202.166.137]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KH300AXUQYBXZ20@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 26 Mar 2009 08:18:12 +0100 (CET)
In-reply-to: <alpine.LFD.2.00.0903251514360.26337@xanadu.home>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114744>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 25 Mar 2009, Kjetil Barvik wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > On Wed, 25 Mar 2009, Kjetil Barvik wrote:
>> >
>> >>   So, it seems that this patch almost fixed the issue.  But notice that
>> >>   the pack file was 10 bytes larger for the --depth=95000 case.
>> >> 
>> >>   I made a small perl script to compare the output from 'git verify-pack
>> >>   -v' of the 2 idx/pack files, and found the following difference(1)
>> >>   (first line from --depth=20000 case, second from --depth=95000):
>> >> 
>> >>   fe0a6f3e971373590714dbafd087b235ea60ac00  tree   9  19  18921247  731  96a3ec5789504e6d0f90c99fb1937af1ebd58e2d
>> >>   fe0a6f3e971373590714dbafd087b235ea60ac00  tree  20  29  18921247  730  12e560f7fb28558b15e3a2008fba860f9a4b2222
>> >
>> > OK.  Apparently, a different base object for that one delta was chosen 
>> > between those two runs.
>> >
>> > Is your machine SMP?
>> 
>>   kjetil ~$ uname -a
>>   Linux localhost 2.6.28.4 #26 SMP PREEMPT Tue Feb 10 17:07:14 CET 2009
>>   i686 Intel(R) Core(TM)2 CPU T7200 @ 2.00GHz GenuineIntel GNU/Linux
>
> Here you go.  If you want a perfectly deterministic repacking, you'll 
> have to force the pack.threads config option to 1.

  OK, have rerun the test again with pack.config set to 1, and got the
  exact same result(1) as above this time also!  :-)

  And I think I can explain the reason for the same result: When the
  --window and/or --depth value(s) is larger than (half?) the value of
  possible number of objects (98438 in this time), I think that the
  thread logic finds out that it can only run one thread (there is not
  room/objects enough for 2 or more threads).

  This also explains what I see when I run the repack command (without
  the pack.config option), only 1 git process is running on 1 of the
  CPU's from the start, and the other is idle.

  ~~

  Give me a hint if you want some debug info from the 2 pack/idx files.

  -- kjetil

  1) The output from the 2 'git repack' commands did not show the
     "running delta with 2 threads" (or something similar) this time.
     I guess this is the sign that "pack.threads = 1" is working.
