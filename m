From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Fri, 15 Aug 2014 21:50:11 +0200
Message-ID: <CAPuZ2NFJiUt1p_OfefswS8O8_BA6mQy=PStmYyNw=ABZCOQprQ@mail.gmail.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
	<xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFcJ5FFeJP=0-oG59fs=3ztenoPOGWOZKfZDdHpLGOYeA@mail.gmail.com>
	<xmqqiolw2dqc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 21:50:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XINW3-00031t-K1
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 21:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbaHOTuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 15:50:19 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38825 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaHOTuT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 15:50:19 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so3953320pad.39
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3ilVEPQbcRIBI5k2ju/WkjtLZZlhIZf6YayVjl91DPU=;
        b=cH5U5q5hfSUeUEil//UrewojE/MY5Wg990KQT3mO5gMdsYlxfxH76C+Hx03Zu7/4GG
         24Xn1mXOteg+JpCxhnAd/MvCYOR7Zx2D2zuqjJZGXPXPhMr2hDmLRchK3kNYcud88RQr
         L9rKfC/d/pPGQOat4z4rjjijY2jeikMQ1z/E2bFHdGT/kXuk4xVT9NEQvHDkrkKAT12f
         bkVvLbX7JenIe36dyQPoCsnpjEI5DU5CR6+Zo21esE0MGjPvMWsH8Ln3T42/NsFpmM41
         CLh2bbZaIeg7yo1oGlBhE/CI5SV/CrQ4wcJqOPUy7bb0LauDUr9Zciisuhpd5zem1e8a
         hAvQ==
X-Received: by 10.66.251.132 with SMTP id zk4mr15114645pac.47.1408132212021;
 Fri, 15 Aug 2014 12:50:12 -0700 (PDT)
Received: by 10.70.43.170 with HTTP; Fri, 15 Aug 2014 12:50:11 -0700 (PDT)
In-Reply-To: <xmqqiolw2dqc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255302>

On Thu, Aug 14, 2014 at 1:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Being a conservative, I'd rather avoid doing any magic during
> read_cache() time. "ls-files -s" for example should show the four
> stages so that the "broken" state can be inspected.
>
Well, only read_cache_unmerged() is modified in the sent patch, so no
magic is done in read_cache(), I'd also avoid changes there. Indeed
with the patch, "ls-files -s" can be used to inspect the problem
without further problems.

> Instead, I suspect that the code paths with problematic iterations
> over the index entries that assume that having stage #0 entry for a
> path guarantees that there will not be any higher stage entry first
> need to be identified (you already said "add" and "reset" may be
> problematic, there may be others, or they may be the only ones, I
> dunno), and then the most sensible one, which would be different
> from case to case, among various possibilities need to be chosen as
> a fix to each of them:
>
> (1) the loop may be fixed to ignore/skip unmerged entries;
> (2) the loop may be fixed to ignore/skip the merged entry;
> (3) the loop may be fixed not to spin indefinitely on a path with
> mixed entries; or
> (4) the command should error out.
>
git reset will clean the index anyway if the loop finishes, would it
be ok? I think that it'd be acceptable for git reset --hard to clean
the index as git checkout -f already does it even in this case.

git merge is also affected by the loop in read_cache_unmerged(), but
any of the solutions would be enough for it as only by finishing the
loop with unmerged entries it will die without commiting the cache to
the index file.

For git add probably the best option is to error out and ask the user
to check "git ls-files -s" to investigate the problem and decide what
to do.

The error message given by "git commit -a" is a bit confusing in this
case, I can take a look to this too.

I'll try to prepare a patch with these cases, and rethinking the loop
to avoid future problems there, I think that is a bit dangerous to
look for the position of a path entry (with index_name_pos) for the
next iteration.

> Yes, it would be more work, but I'd feel safer if the following
> worked:
>
> $ git ls-files -s
> 100644 3cc58df83752123644fef39faab2393af643b1d2 0 conflict
> 100644 f70f10e4db19068f79bc43844b49f3eece45c4e8 1 conflict
> 100644 3cc58df83752123644fef39faab2393af643b1d2 2 conflict
> 100644 223b7836fb19fdf64ba2d3cd6173c6a283141f78 3 conflict
> $ >empty
> $ git add empty
> 100644 3cc58df83752123644fef39faab2393af643b1d2 0 conflict
> 100644 f70f10e4db19068f79bc43844b49f3eece45c4e8 1 conflict
> 100644 3cc58df83752123644fef39faab2393af643b1d2 2 conflict
> 100644 223b7836fb19fdf64ba2d3cd6173c6a283141f78 3 conflict
> 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0 empty
> $ git cat-file blob :empty >output
> $ cmp empty output && echo OK
> OK
>
> which would be impossible to do if we nuked the "problematic" stages
> whenever we read the index, I am afraid.
>
This works with the first patch as read_cache() is not modified, and
git add would only clean the entries for the paths passed as
arguments.

>> BTW, I didn't know "git cat-file blob 0:$path", but I only manage to
>> get "Not a valid object name" fatals. How is it supposed to be used?
>
> That was a typo of ":$n:$path" (where 0 <= $n <= 3).
Great, thanks!
