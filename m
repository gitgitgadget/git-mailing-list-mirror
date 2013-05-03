From: Johan Herland <johan@herland.net>
Subject: Re: another packed-refs race
Date: Fri, 3 May 2013 23:02:48 +0200
Message-ID: <CALKQrgdG2QOs4Z0vAg7cZt8F5LKd4X8pMMAS0C2HcztbzaBBeQ@mail.gmail.com>
References: <20130503083847.GA16542@sigill.intra.peff.net>
	<CALKQrgdHudF1fDLSXzaKfb2kne0B3rC5mM95CJGsLqL_2xemnA@mail.gmail.com>
	<20130503172853.GB21715@sigill.intra.peff.net>
	<20130503182649.GA25379@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 03 23:03:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYN87-0001bU-Ch
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 23:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761179Ab3ECVCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 17:02:55 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:56679 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3ECVCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 17:02:54 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UYN80-0002Xk-Ge
	for git@vger.kernel.org; Fri, 03 May 2013 23:02:52 +0200
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UYN80-0006vu-4D
	for git@vger.kernel.org; Fri, 03 May 2013 23:02:52 +0200
Received: by mail-ob0-f175.google.com with SMTP id wd20so669420obb.34
        for <git@vger.kernel.org>; Fri, 03 May 2013 14:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0C96AyKNgFtePApsxO2ELPrKub/7NjBPtig6LGrMYB4=;
        b=pcbs908vFPHwNBHMLqgPf4qgPTUgNp1GHVnBao0NXmG/bbXDT2SRmiB9WDcTHa5ptJ
         0vRXKosEaD+GcUN5Fpj2PPTE31W7O4JRHtM2wYfSYsT8ARAZJV0n94sLPa9oYUUO2StX
         3hw9PQ4ypTGpN4T5Utbarufni+oEgvIrJ/XHWqYq1jSwUR3ShhDtG6pO1Z7HwIGDDQ4s
         9GO9ymJuX0Ggtia8OkiwT8Y5KTL5B1e4K/smasSCRQj8LUyCnS2I+9jhqDLy8FFcmFjk
         Hh7Pc3d7ivyBK+vR5hRqH8KMpgzeIpGFf5nrqMVjfAzTTRAgJcXxmo67reDvxCcgIFMd
         1uOg==
X-Received: by 10.60.155.137 with SMTP id vw9mr1621663oeb.81.1367614968417;
 Fri, 03 May 2013 14:02:48 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Fri, 3 May 2013 14:02:48 -0700 (PDT)
In-Reply-To: <20130503182649.GA25379@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223321>

On Fri, May 3, 2013 at 8:26 PM, Jeff King <peff@peff.net> wrote:
> On Fri, May 03, 2013 at 01:28:53PM -0400, Jeff King wrote:
>> > The following solution might work in both the resolve-a-single-ref and
>> > enumerating-refs case:
>> >
>> > 0. Look for ref already cached in memory. If found, OK.
>> >
>> > 1. Look for loose ref. If found, OK.
>> >
>> > 2. If not found, load all loose refs and packed-refs from disk (in
>> > that order), and store in memory for remainder of this process. Never
>> > reload packed-refs from disk (unless you also reload all loose refs
>> > first).
>>
>> I think that would be correct (modulo that step 1 cannot happen for
>> enumeration). But we would like to avoid loading all loose refs if we
>> can. Especially on a cold cache, it can be quite slow, and you may not
>> even care about those refs for the current operation (I do not recall
>> the exact original motivation for the lazy loading, but it was something
>> along those lines).
>
> Actually, forgetting about enumeration for a minute, that would make
> single-ref lookup quite painful. Running "git rev-parse foo" shouldn't
> have to even look at most loose refs in the first place. It should be a
> couple of open() calls looking for the right spot, and then fall back to
> loading packed-refs.

True. I was overemphasizing the case where we start looking up one
ref, and later look up more refs from the same process (in which case
the load-everything step would be amortized across the other lookups),
but this is probably not the ref access pattern for most Git commands,
and definitely not for "git rev-parse foo". I think your approach is
better.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
