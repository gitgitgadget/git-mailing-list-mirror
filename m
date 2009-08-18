From: Andy Polyakov <appro@fy.chalmers.se>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Tue, 18 Aug 2009 23:50:14 +0200
Message-ID: <4A8B2216.6080607@fy.chalmers.se>
References: <20090803034741.23415.qmail@science.horizon.com> <alpine.LFD.2.01.0908031924230.3270@localhost.localdomain> <alpine.LFD.2.01.0908031938280.3270@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWZU-00066c-FR
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbZHRVuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbZHRVuN
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:50:13 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:64290 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZHRVuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:50:12 -0400
Received: from fyserv1.fy.chalmers.se (fyserv1.fy.chalmers.se [129.16.110.66])
	by atum.ita.chalmers.se (Postfix) with ESMTP id E0A818328;
	Tue, 18 Aug 2009 23:50:13 +0200 (CEST)
Received: from [127.0.0.1] (stty [129.16.50.165])
	by fyserv1.fy.chalmers.se (8.8.8/8.8.8) with ESMTP id XAA08039;
	Tue, 18 Aug 2009 23:48:44 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <alpine.LFD.2.01.0908031938280.3270@localhost.localdomain>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126468>

> On Mon, 3 Aug 2009, Linus Torvalds wrote:
>> The thing that I'd prefer is simply
>>
>> 	git fsck --full
>>
>> on the Linux kernel archive. For me (with a fast machine), it takes about 
>> 4m30s with the OpenSSL SHA1, and takes 6m40s with the Mozilla SHA1 (ie 
>> using a NO_OPENSSL=1 build).
>>
>> So that's an example of a load that is actually very sensitive to SHA1 
>> performance (more so than _most_ git loads, I suspect), and at the same 
>> time is a real git load rather than some SHA1-only microbenchmark.

I couldn't agree more that real-life benchmarks are of greater value
than specific algorithm micro-benchmark. And given the provided
profiling data one can argue that +17% (or my +12%) improvement on
micro-benchmark aren't really worth bothering about. But it's kind of
sport [at least for me], so don't judge too harshly:-)

>> It also 
>> shows very clearly why we default to the OpenSSL version over the Mozilla 
>> one.

As George implicitly mentioned most OpenSSL assembler modules are
available under more permissive license and if there is interest I'm
ready to assist...

> "perf report --sort comm,dso,symbol" profiling shows the following for 
> 'git fsck --full' on the kernel repo, using the Mozilla SHA1:
> 
>     47.69%               git  /home/torvalds/git/git     [.] moz_SHA1_Update
>     22.98%               git  /lib64/libz.so.1.2.3       [.] inflate_fast
>      7.32%               git  /lib64/libc-2.10.1.so      [.] __GI_memcpy
>      4.66%               git  /lib64/libz.so.1.2.3       [.] inflate
>      3.76%               git  /lib64/libz.so.1.2.3       [.] adler32
>      2.86%               git  /lib64/libz.so.1.2.3       [.] inflate_table
>      2.41%               git  /home/torvalds/git/git     [.] lookup_object
>      1.31%               git  /lib64/libc-2.10.1.so      [.] _int_malloc
>      0.84%               git  /home/torvalds/git/git     [.] patch_delta
>      0.78%               git  [kernel]                   [k] hpet_next_event
> 
> so yeah, SHA1 performance matters. Judging by the OpenSSL numbers, the 
> OpenSSL SHA1 implementation must be about twice as fast as the C version 
> we use.

And given /lib64 path this is 64-bit C compiler-generated code compared
to 32-bit assembler? Either way in this context I have extra comment
addressing previous subscriber, Mark Lodato, who effectively wondered
how would 64-bit assembler compare to 32-bit one. First of all there
*is* even 64-bit assembler version. But as SHA1 is essentially 32-bit
algorithm, 64-bit implementation is only nominally faster, +20% at most.
Faster thanks to larger register bank facilitating more efficient
instruction scheduling.

Cheers. A.
