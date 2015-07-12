From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 10/16] worktree: make branch creation distinct from
 worktree population
Date: Sun, 12 Jul 2015 09:48:24 +0700
Message-ID: <CACsJy8A8CeyeYZnMpbdWW-etohp3TWzGrro1khzD=8skydm6Cg@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
 <1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
 <CACsJy8A8QkeFa3FyCkv8dp-J52NGGaN-AV3oG7W8tNtYqDO-cw@mail.gmail.com> <CAPig+cSiPeJskyanLAv71LuFoqPirUJ2FL0B0BsoT8BEVrE3LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 04:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE7K6-0003aE-SL
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 04:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbGLCsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 22:48:55 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35685 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbbGLCsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 22:48:54 -0400
Received: by igcqs7 with SMTP id qs7so36559492igc.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CzP4vMGAVyLCOlzQzxE1eaDSRu/cwi3fa8+R6rB1Y1M=;
        b=wNnsoFwiLqs6PEuM+QoPi9FrqdRTFI99v7oQYQXfxNRuLkEFJHvVvGSxW+ZjXwQe2G
         lFsD/5yx3P1NjjyxOmI9BFl8acTkxr2X6e6J7ZVpA+zHdQa74cqno1sl1kwKPhDTWVP5
         lrTGDSvV2k1aUZurble6yi0lzWH+eR8nNPLHhqJ9+nt/6FbYDkJ2qHdZr+YhFH4GL/dn
         jwrqnaOq/pEDzaPQiQhUsd9/JZSzjeH63+xc6XeE8cCaf7bmt9egGXh3+lijOA3tWBGP
         67XMWs1IX+pCZ8Z92EBV88LPJDN1KWNuHYInoYSYMLafhaMHi92dZgp3Y5Zu/yp1kG6p
         qsow==
X-Received: by 10.107.134.22 with SMTP id i22mr11772045iod.111.1436669333578;
 Sat, 11 Jul 2015 19:48:53 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sat, 11 Jul 2015 19:48:24 -0700 (PDT)
In-Reply-To: <CAPig+cSiPeJskyanLAv71LuFoqPirUJ2FL0B0BsoT8BEVrE3LA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273882>

On Sun, Jul 12, 2015 at 9:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jul 11, 2015 at 9:20 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Jul 11, 2015 at 7:05 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> The plan is eventually to populate the new worktree via "git reset
>>> --hard" rather than "git checkout". Thus, rather than piggybacking on
>>> git-checkout's -b/-B ability to create a new branch at checkout time,
>>> git-worktree will need to do so itself.
>>>
>>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>>> ---
>>>
>>> I considered calling branch-related API, such as create_branch(),
>>> directly, however, git-branch provides extra value which may be useful
>>> in the future (such as when --track and --orphan get added to
>>> git-worktree), so it seemed wise to re-use git-branch's implementation
>>> rather than duplicating the functionality. If this proves the wrong
>>> choice, then the series can either be re-rolled or follow-on patches can
>>> address the issue.
>>
>> I don't know much about ref handling code (especially after the big
>> transaction update), so i may be wrong, but do we need to invalidate
>> some caches in refs.c after this? The same for update-ref in the other
>> patch. We may need to re-read the index after 'reset --hard' too if we
>> ever need to do touch the index after that (unlikely though in the
>> case of 'worktree add')
>
> I'm not sure I understand. Are you talking about this patch's
> implementation or a possible future change which uses the C API rather
> than git-branch?
>
> If you're talking about this patch, then I don't think we need to do
> anything more, as the "git branch" and "git reset --hard" invocations
> are separate process invocations which shouldn't affect the current
> worktree or the current "git worktree add" process.

The "shouldn't affect" is potentially a problem.If the current
'worktree add' process caches something (in ref handling, for example)
that the 'git branch' process changes, then we may need to invalidate
cache in 'worktree add' process after run_command(). I guess it's ok
in this case since all we do is run_command(), we do not lookup refs
or anything else afterwards.
-- 
Duy
