From: Scott Sandler <scott.m.sandler@gmail.com>
Subject: Re: Git push race condition?
Date: Thu, 10 Apr 2014 15:14:10 -0400
Message-ID: <CAAyEjTO3JTNDxDWpX+k_Z-O9=8-Vu5uyT_1eK-A8nFXWVcyD6w@mail.gmail.com>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<20140324225434.GB17080@sigill.intra.peff.net>
	<557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
	<CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
	<20140325145700.GA10132@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:14:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKQV-0005SK-MV
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbaDJTOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:14:14 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:65347 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030242AbaDJTOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:14:12 -0400
Received: by mail-la0-f41.google.com with SMTP id gl10so2735967lab.0
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M/N777339CU7tE8+Gmxja0RtXV12DC/D9o0Jvoqb1uA=;
        b=n6T4LjzrMIrnmeU2ObaxRZpD9lJEzfVKcRHleQeXEYF5fftjHV4AXH3Q5wsv+Zcc/p
         Q4EtGYQpXokdB0G058Yxw4bjHKUoMt8rDAVkjKmbx58y24PhhuWjRh8veWkatQVMQ4IN
         xtdPBDsgc8dGr6UsRS2qwp6fA7XD/w4paj2rUw1ToikYDyaHDyvx9Sz9vv6vI7GMWP6y
         WniZVh9hBY9YH7DAJUqdaXR8ZpQI44yvq82fnnLhKuVK6nHYzv1+aQzGimyBjU0HCc5C
         cMS9sIMuY+1zV0zu2CZZSW2xmfNxADNT2iXu22iYNz27bydObv6Sz4fQCU/EUG47Bz57
         5Y6A==
X-Received: by 10.112.53.170 with SMTP id c10mr2178lbp.70.1397157250517; Thu,
 10 Apr 2014 12:14:10 -0700 (PDT)
Received: by 10.114.64.103 with HTTP; Thu, 10 Apr 2014 12:14:10 -0700 (PDT)
In-Reply-To: <20140325145700.GA10132@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246037>

On Tue, Mar 25, 2014 at 10:57 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 25, 2014 at 09:45:20AM -0400, Scott Sandler wrote:
>
>> Version of git on the server? git version 1.8.3-rc0
>
> There was significant work done between v1.8.3 and v1.8.4 on handling
> races in the ref code. As I said before, I don't think the symptoms you
> are describing are anything we have seen, or that could be triggered by
> the races we found (which were mostly to do with ref enumeration, not
> ref writing). But I would suggest upgrading to a newer version of git as
> a precaution.
>
> You mentioned elsewhere turning on the reflog, which I think is a good
> idea. If there is a race of this sort, you will see a "hole" in the
> reflog, where a ref goes from A->B, then again from A->B' (whereas with
> normal writes, it would be B->B').
>
> -Peff

This finally happened again. Here's what the reflog looks like:

2805f68 master@{0}: push
96eebc0 master@{1}: push
75bd4a6 master@{2}: push
abc30da master@{3}: push
eba874f master@{4}: push
10981e7 master@{5}: push
76b3957 master@{6}: push
2e3ea06 master@{7}: push
9d4e778 master@{8}: push
dbd70ae master@{9}: push
508ab4f master@{10}: push
36a0ce4 master@{11}: push
ddc258e master@{12}: push
cf025de master@{13}: push
dbd70ae master@{14}: push
95d33eb master@{15}: push
75b8e9a master@{16}: push

The commit that was lost does not show in the reflog at all, its short
hash was e0de949aa. The commit that "won the race" against it is
9d4e778 (I'm inferring this based on timing since it was pushed at
about the same time as the lost commit).

One interesting thing to note is that dbd70ae shows up at two separate
points in the reflog though, one being directly before the 9d4e778
commit that won the race. According to Gitlab's event log that commit
was just pushed once, right after 95d33eb and before cf025de as it
shows in master@{14} there. The fact that the same commit shows up
again in master@{9} is interesting.

Now that it has happened again and I've got this data, I'm going to
upgrade git but let me know if this provides any insight in the mean
time.

-Scott
