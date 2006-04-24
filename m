From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 12:31:27 -0400
Message-ID: <D1E1F442-2CE8-4CA0-A6E6-94B8FFC5E82D@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com> <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain> <20060424151901.GA2663@adacore.com> <Pine.LNX.4.64.0604241123490.18520@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 18:32:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY3yj-0001sp-KV
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 18:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWDXQb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 12:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWDXQb7
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 12:31:59 -0400
Received: from nile.gnat.com ([205.232.38.5]:54179 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1750945AbWDXQb6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 12:31:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 6230848CE22;
	Mon, 24 Apr 2006 12:31:26 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 17327-01-10; Mon, 24 Apr 2006 12:31:26 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 3B22248CE01;
	Mon, 24 Apr 2006 12:31:26 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0604241123490.18520@localhost.localdomain>
To: Nicolas Pitre <nico@cam.org>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19097>

> Sure, but the data buffers aren't necessarily so.  At least some  
> code to
> align index_step with actual memory offset if necessary should be
> considered.
I don't quite understand. Do you mean that if I mmap a file, I can't
count on the memory being word-aligned? Note that I traverse the
target buffer byte-by-byte, but the matches in the source buffer are
always aligned to index_step. Doing a word load there instead of
individual byte loads actually is a significant speedup on PPC,
and most other non-Intel platforms.
> Indeed.  And since the primary goal for GIT is to manage relatively
> small files with relatively few differences then we have to  
> optimize for
> that case while trying to simply limit the dammage in the other cases.
Yes, I'll look at those now. Also, comparing one index against
10 target files may change the profile quite a bit. The new
algorithm spends most time on indexing, but when comparing against
many files, the find_copy part suddenly becomes dominant.

> Well, I did lots of benchmarks too over the Linux kernel repository
> with the current code.  It is of course a dataset quite different from
> two large files.  And simply increasing the hash size to improve on  
> pack
> size did increase CPU usage quite significantly.
BTW, I still get:
potomac%git-rev-list --objects  
e64961b0573b0e72bd55eab6d36bd97f859f9516 | ./git-pack-objects --no- 
reuse-delta --stdout
Generating pack...
Done counting 17005 objects.
Deltifying 17005 objects.
100% (17005/17005) done
fatal: delta size changed
(This is for my git.git tree.)

>> PS. Somehow your code had "double line spacing" :)
> Gah.  Your original version must have CRLF line terminations, and vi
> simply notice that and writes the file back with CRLF by default.   
> Find
> attached a version with those converted to LF only.
Strange, my platform doesn't use CRLF, and my sources all have
pristine LF line terminations.

   -Geert
