From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 06 Aug 2009 21:10:00 +0200
Message-ID: <4A7B2A88.2040602@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8Lu-0000KJ-L8
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831AbZHFTKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755686AbZHFTKF
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:10:05 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:36086 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755397AbZHFTKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 15:10:04 -0400
Received: by yxe5 with SMTP id 5so1325690yxe.33
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Zf079DOm5O/fyglREoyhT8cHhbRSPkgjnaBUeYuRmzg=;
        b=qSd2GKXxzvESmAxJK7stBxiZDTwKl4ZnXT9T9PrS/hvWyoDo2pM12bmw0z59jLlhhS
         WRTLk5GTnyYJPkQWfBOwPDnrNdXBzdBldCsmylb/BamMWvI80rfcw0sXjmAqTvH5+/uz
         YmYLwOy7ERiKXRlvbHPxTqO4qBvyKvz8OlMkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=EWEYN7YC9v0zWSytgGz3BhzEeMENOcF6SmTFdA3hmP5dJo5YL+NjZkAg9vlWluBVAq
         ZHJleB5hF4CWFcHeXsMRBZOTsQ9wtNH/9/i8TPWQel8ryn5b10clRBIZvmfR2qxbCkVZ
         k9kT9btODF8F24AMEDGqrcQChQAgkEsRsol1Y=
Received: by 10.90.26.3 with SMTP id 3mr177731agz.30.1249585804598;
        Thu, 06 Aug 2009 12:10:04 -0700 (PDT)
Received: from ?172.19.43.221? ([72.14.241.7])
        by mx.google.com with ESMTPS id 39sm848725agb.44.2009.08.06.12.10.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 12:10:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125108>

Linus Torvalds wrote:
> 
> On Thu, 6 Aug 2009, Artur Skawina wrote:
>> For those curious just how close the C version is to the various
>> asm and C implementations, the q&d microbenchmark is at 
>> http://www.src.multimo.pl/YDpqIo7Li27O0L0h/sha1bench.tar.gz
> 
> Hmm. That thing doesn't work at all on x86-64. Even apart from the asm 
> sources, your timing thing does soem really odd things (why do you do that 
> odd "iret" in GETCYCLES and GETTIME?). You're better off using 
> lfence/mfence/cpuid, and I think you could make it work on 64-bit that 
> way too.

yes, it's 32-bit only, i should have mentioned that. The timing
code was written more than a decade ago, it really works on p2,
haven't updated it, it's all just c&p'ed ever since. All of it
can be safely disabled; on p2 you could account for every cycle,
nowadays gettimeofday is more than enough.

> I just hacked it away for testing.
> 
>> In short: 88% of openssl speed on P3, 42% on P4, 66% on Atom.
> 
> I'll use this to see if I can improve the 32-bit case.
> 
> On Nehalem, with your benchmark, I get:
> 
> 	#             TIME[s] SPEED[MB/s]
> 	rfc3174         5.122       119.2
> 	# New hash result: d829b9e028e64840094ab6702f9acdf11bec3937
> 	rfc3174         5.153       118.5
> 	linus           2.092       291.8
> 	linusas         2.056       296.8
> 	linusas2        1.909       319.8
> 	mozilla         5.139       118.8
> 	mozillaas       5.775       105.7
> 	openssl         1.627       375.1
> 	spelvin         1.678       363.7
> 	spelvina        1.603       380.8
> 	nettle          1.592       383.4
> 
> And with the hacked version to get some 64-bit numbers:
> 
> 	#             TIME[s] SPEED[MB/s]
> 	rfc3174         3.992       152.9
> 	# New hash result: b78fd74c0033a4dfe0ededccb85ab00cb56880ab
> 	rfc3174         3.991       152.9
> 	linus            1.54       396.3
> 	linusas         1.533       398.1
> 	linusas2        1.603       380.9
> 	mozilla         4.352       140.3
> 	mozillaas       4.227       144.4
> 
> so as you can see, your improvements in 32-bit mode are actually 
> de-provements in 64-bit mode (ok, your first one seems to be a tiny 
> improvement, but I think it's in the noise).

Actually i didn't keep anything that wasn't a win, one reason
why linusas2 stayed was that it really surprised me, i'd have
expected for gcc to do a lot worse w/ the many temporaries and
the compiler came up w/ a 70% gain; gcc really must have improved
when i wasn't looking.

> But you're right, I need to try to improve the 32-bit case.

I never said anything like that. :) there probably isn't all that
much that can be done. I tried a few things, but never saw any 
improvement above measurement noise (a few percent). Would have
though that overlapping the iterations a bit would be a gain, but
that didn't do much (-20%..0), maybe on 64 bit, with more registers...

Oh, i noticed that '-mtune' makes quite a difference, it can change
the relative performance of the functions significantly, in unobvious
ways; depending on which cpu gcc tunes for (build config or -mtune);
some implementations slow down, others become a bit faster.

artur
