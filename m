From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Wed, 04 Jun 2008 01:11:27 +0200
Message-ID: <4845CF9F.10604@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806031445.23002.jnareb@gmail.com> <48455433.8080500@gmail.com> <200806032224.08714.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 01:11:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ffJ-000403-G7
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 01:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbYFCXKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 19:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbYFCXKs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 19:10:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:64110 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbYFCXKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 19:10:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1163247fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 16:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=sUX4+1m6rR3YoGFkKzRpzj0+kEndx0+FolJk8zE+XmI=;
        b=amfa7KmrcUUWyX4nRnZoSoO5OEVL6GXG/KAhx9Yx271AcVEjLRt1JHxWIO0zaFmSS6lkyn5ja3Ko8Z50iqDDjkU1U+rdiOaZ4Ro2wdH4Hkr5UGW0dn/9nZLHLkFH5PI6bUuw2pVBVjXGwafJVG3eiZhlm1IWXm/zBt701WRuIFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=SYZedMGqa1AldH5/3V66AbtxKIbKmKOUDWnAhOkBgvI1OrWWnIOtydYhg1C2Kuk3bYHraACmneY0ucpZuOuGaY8FcXEiWx7JO0QI4DO8v+9g0Huu1odwb1SYaf3K6V9yQsVsWo0dE9jjCTd5maN+QYZoaawA2wjFpneux+POIak=
Received: by 10.86.25.17 with SMTP id 17mr5864193fgy.50.1212534645477;
        Tue, 03 Jun 2008 16:10:45 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.209.222])
        by mx.google.com with ESMTPS id e20sm771273fga.1.2008.06.03.16.10.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 16:10:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200806032224.08714.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83727>

Jakub Narebski wrote:
> I don't think %parent_commits hash is suitable for caching; it is only
> intermediate step, reducing number of git command calls (and forks) [...]
> 
> ATTENTION! This example shows where caching [parsed] data have problems 
> compared to front-end caching (caching output).

ATTENTION!  Could we please stop having this discussion?!  Your argument 
is completely bogus.  If the parent commit hashes are in cache, it's an 
almost zero-time cache lookup.  The only difference it might make 
compared front-end caching is the CPU time it takes to generate the 
page, and *I want to see benchmarks before I even start thinking about 
CPU*.  Okay?  Good, thanks.

Sorry I'm a little indignant, but you seem to be somehow trying to tell 
me what to implement, and that gets annoying after a while.  I don't 
mind your input, but at some point the discussion just doesn't go any 
further.

> Problems occur when we try to cache page with _streaming_ output, such 
> as blob view, blame view, diff part of commitdiff etc.

We can still stream backend-cache-backed data, though it's a little 
harder.  It's mostly a memory, not a performance issue though -- the 
only point where I think it actually would be performance-relevant is 
blame, and blame doesn't stream anyway (see below).

> By the way, if we agree that version %parent_commits is too intrusive 
> dusring GSoC 2008,

Oh, I don't mind, FTR.  It's not enough lines to matter.

>> 2) Major point: You're still forking a lot.  The Right Thing is to
>> condense everything into a single call
> 
> This is not a good solution for 'blame' view, which is generated "on the 
> fly", by streaming git-blame output via filter.

No, whether you have your "while <$fd>" loop or not doesn't make a 
difference.  Blame first calculates the whole blame and then dumps it 
out in zero-time, unless you use --incremental.  So there's no 
performance difference in getting all blame output and then dumping it 
out vs. reading and outputting it line-by-line.  And regarding memory, 
if your blame output doesn't fit into your RAM, you have different kinds 
of issues.

JFTR, I don't have any opinion about extending the porcelain output of 
git-blame (apart from the fact that happens to not be useful for gitweb 
for the reason I outlined in the previous paragraph).

-- Lea
