From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Mon, 3 Aug 2009 19:51:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908031938280.3270@localhost.localdomain>
References: <20090803034741.23415.qmail@science.horizon.com> <alpine.LFD.2.01.0908031924230.3270@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, appro@fy.chalmers.se, appro@openssl.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 04:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYA89-0006SA-K6
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 04:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbZHDCvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 22:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbZHDCvp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 22:51:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60897 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751833AbZHDCvp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 22:51:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n742p6tc001265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Aug 2009 19:51:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n742p5Hc006631;
	Mon, 3 Aug 2009 19:51:05 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908031924230.3270@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124745>



On Mon, 3 Aug 2009, Linus Torvalds wrote:
> 
> The thing that I'd prefer is simply
> 
> 	git fsck --full
> 
> on the Linux kernel archive. For me (with a fast machine), it takes about 
> 4m30s with the OpenSSL SHA1, and takes 6m40s with the Mozilla SHA1 (ie 
> using a NO_OPENSSL=1 build).
> 
> So that's an example of a load that is actually very sensitive to SHA1 
> performance (more so than _most_ git loads, I suspect), and at the same 
> time is a real git load rather than some SHA1-only microbenchmark. It also 
> shows very clearly why we default to the OpenSSL version over the Mozilla 
> one.

"perf report --sort comm,dso,symbol" profiling shows the following for 
'git fsck --full' on the kernel repo, using the Mozilla SHA1:

    47.69%               git  /home/torvalds/git/git     [.] moz_SHA1_Update
    22.98%               git  /lib64/libz.so.1.2.3       [.] inflate_fast
     7.32%               git  /lib64/libc-2.10.1.so      [.] __GI_memcpy
     4.66%               git  /lib64/libz.so.1.2.3       [.] inflate
     3.76%               git  /lib64/libz.so.1.2.3       [.] adler32
     2.86%               git  /lib64/libz.so.1.2.3       [.] inflate_table
     2.41%               git  /home/torvalds/git/git     [.] lookup_object
     1.31%               git  /lib64/libc-2.10.1.so      [.] _int_malloc
     0.84%               git  /home/torvalds/git/git     [.] patch_delta
     0.78%               git  [kernel]                   [k] hpet_next_event

so yeah, SHA1 performance matters. Judging by the OpenSSL numbers, the 
OpenSSL SHA1 implementation must be about twice as fast as the C version 
we use.

That said, under "normal" git usage models, the SHA1 costs are almost 
invisible. So git-fsck is definitely a fairly unusual case that stresses 
the SHA1 performance more than most git lods.

		Linus
