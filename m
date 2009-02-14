From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Sat, 14 Feb 2009 18:50:34 +0100
Organization: private
Message-ID: <86ab8olxg5.fsf@broadpark.no>
References: <cover.1233751281.git.barvik@broadpark.no>
 <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no>
 <49899FA4.2020003@viscovery.net> <7vfxiut57t.fsf@gitster.siamese.dyndns.org>
 <86tz7ayo51.fsf_-_@broadpark.no> <498A9FD3.2020601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 18:52:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYOgo-00065k-2y
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 18:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbZBNRui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 12:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZBNRui
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 12:50:38 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:42703 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbZBNRui (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 12:50:38 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KF2001BKHKB1N60@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sat, 14 Feb 2009 18:50:35 +0100 (CET)
Received: from localhost ([84.48.79.110]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KF200FD8HKA0B20@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sat, 14 Feb 2009 18:50:35 +0100 (CET)
In-reply-to: <498A9FD3.2020601@viscovery.net>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109886>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Kjetil Barvik schrieb:
>>   And, yes, since each lstat() call cost approximately 44 microseconds
>>   compared to 12-16 for each lstat() on my Linux box, there was a little
>                                ^^^^^^^ fstat()?
>>   performance gain from this patch.
>
> This does look like a good gain. But do you have hard numbers that back
> the claim?

  OK, I have done some testing/profiling with oprofile(1), and one thing
  I found out was that my Linux kernel was built with SLUB debug, and of
  course it cost some system time to run the VM debug code.  After I
  turned this off, the total system time when down from aprox 6 to 3
  seconds for the 'git checkout -q my-v2.6.25/7' test.

  Also, from strace output each lstat() call now take around 16
  microseconds, and each fstat() call around 12 microseconds, so for
  aprox 14000 changed calls (lstat() => fstat()) the performance gain
  should now only be (* 14000 (- 16 12)) = 56 ms, compared to 467 ms,
  which I reported before.

  -- kjetil

  1) http://oprofile.sourceforge.net/about/
