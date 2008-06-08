From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Sun, 8 Jun 2008 22:28:52 +0200
Message-ID: <200806082228.55495.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <4845CF9F.10604@gmail.com> <484C22BF.7040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 22:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5RWd-0005MC-Qk
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 22:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbYFHU3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYFHU3G
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 16:29:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:36224 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbYFHU3E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 16:29:04 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1014138ugf.16
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KQVUaboWWngycEqZON6rt3Vf1Fe1xhwVVM33b9yQmEI=;
        b=pA9sH2TBBagYe30sXUJ8SBEK8BBgT/g6fEiuMXxrVMhVsa7mGkxE1RAp3RdqfSpUaj
         72rxEDHlk8r9DzIepBvUaawG2nqko4Yv0pRb5WEIbfQkvB3MM9j+SdNWQKba2os1p+Ps
         sGwcZ1lH3kOoRTa6lHPDsq663MW0y/SM9Qd3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AZhJHKKge/fTBgG6CL2/e8e+NxCN7e0oMk9wvfl73ebsh7d+lS8MvpXV77Cvtat9VI
         cXRD8S/NzRW+jQ9K5Fs1CofIUwvCTOXmFPU7doub8CPs1GSH0tTuYHJaOaK0qBP/36KE
         gF1dlwMSLL/9vxGaW+AdNAQt23FBDbPQ6AbBM=
Received: by 10.66.244.2 with SMTP id r2mr667194ugh.73.1212956940430;
        Sun, 08 Jun 2008 13:29:00 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.161])
        by mx.google.com with ESMTPS id g30sm4855142ugd.16.2008.06.08.13.28.58
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 13:28:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <484C22BF.7040700@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84315>

On Sun, 8 Jun 2008, Lea Wiemann wrote:
> On Wed, 04 Jun 2008, Lea Wiemann wrote:
>>
>> Blame first calculates the whole blame and then dumps it out in
>> zero-time [so] there's no performance difference in getting all  blame
>> output and then dumping it out vs. reading and outputting it line-by-line.
> 
> I haven't been following the recent discussion in detail, but here's 
> another thought: If you want to look up the parents, it's usually faster 
> (at least when caching is enabled) to get them all in a single call. 
> IOW, don't look up the parent for each hash as it appears, but collect 
> all hashes and then get a list of all parents with a single call.

If caching is enabled, then parent info can be retrieved from cache.
If caching is disabled, or cache expired (cache miss) you would have
to get whole blame output to get all revisions to get parents for.
This means for a short while twice amount of memory (whole blame in
git-blame, because thats how non-incremental blame works, and whole
blame in gitweb, till reading last byte of blame when git-blame ends);
and that is not good when memory-based cache (be it memcache, mmap,
or other solution) is on the same machine (sometimes you just don't
have a farm of servers...).

Junio's patches adding "previous" header to git blame result in no
worse output (result) than current code.  I have proposed improvements,
but I'm not sure they can be implemented cheaply (fairly sure that they
cannot, and I'm not sure if improvements are worth the cost).  I'd like
to know what happens in Junio code when evil merge is blamed; I don't
know code enough (and I am a bit lazy here) to get this from code
itself.

-- 
Jakub Narebski
Poland
