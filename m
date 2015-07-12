From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/16] worktree: make branch creation distinct from
 worktree population
Date: Sat, 11 Jul 2015 23:10:52 -0400
Message-ID: <CAPig+cT-1juGLZK+F1Cy+MDE8+_bPqnX6fgfpoMnd2Qypu3oZQ@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
	<1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
	<CACsJy8A8QkeFa3FyCkv8dp-J52NGGaN-AV3oG7W8tNtYqDO-cw@mail.gmail.com>
	<CAPig+cSiPeJskyanLAv71LuFoqPirUJ2FL0B0BsoT8BEVrE3LA@mail.gmail.com>
	<CACsJy8A8CeyeYZnMpbdWW-etohp3TWzGrro1khzD=8skydm6Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 05:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE7fO-0007na-Mg
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 05:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbbGLDKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 23:10:54 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36695 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbGLDKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 23:10:53 -0400
Received: by ykay190 with SMTP id y190so15544795yka.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 20:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QfjtmYao+Qhyz1Wd/q6PQvznRBZjX+qG9cFIzKF3Ny4=;
        b=Vcu8xFhuAgh+Dt37SpdFcvBEm/zb4+mwrvDSh7STIXJy4J2m/ZBW7QeBzS199P35Hd
         kV9mJIaVKp8Ym87DZ+JtevCe6JlYfn0dvPxTBdvAvOpmDm91Jo91miCaT5jfGB79+srS
         lwmzLvayOTPx7t/tBI8oTvnNIpxO0hs6PsDoGX/xNEJR3VhMBCUJeohI7BnT2K4dt7F4
         J8yz87pH4dgrR0UdCaYPGerHYB4BOww72QCza7RNntnvUU0RmagcTR1ES9yW6E4DeTWi
         1DJ3T4w8EhKQD8vAK82J4ho8DfEhlkMl6SJn4jouweX43x9BfOr0WP6z/kxQml/KOKeD
         y4QA==
X-Received: by 10.170.63.196 with SMTP id f187mr31348815ykf.82.1436670652962;
 Sat, 11 Jul 2015 20:10:52 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 11 Jul 2015 20:10:52 -0700 (PDT)
In-Reply-To: <CACsJy8A8CeyeYZnMpbdWW-etohp3TWzGrro1khzD=8skydm6Cg@mail.gmail.com>
X-Google-Sender-Auth: nU2uJaF61uZnZXtFAm4Vuffa7JM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273883>

On Sat, Jul 11, 2015 at 10:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 12, 2015 at 9:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Jul 11, 2015 at 9:20 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sat, Jul 11, 2015 at 7:05 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> The plan is eventually to populate the new worktree via "git reset
>>>> --hard" rather than "git checkout". Thus, rather than piggybacking on
>>>> git-checkout's -b/-B ability to create a new branch at checkout time,
>>>> git-worktree will need to do so itself.
>>>
>>> I don't know much about ref handling code (especially after the big
>>> transaction update), so i may be wrong, but do we need to invalidate
>>> some caches in refs.c after this? The same for update-ref in the other
>>> patch. We may need to re-read the index after 'reset --hard' too if we
>>> ever need to do touch the index after that (unlikely though in the
>>> case of 'worktree add')
>>
>> I'm not sure I understand. Are you talking about this patch's
>> implementation or a possible future change which uses the C API rather
>> than git-branch?
>>
>> If you're talking about this patch, then I don't think we need to do
>> anything more, as the "git branch" and "git reset --hard" invocations
>> are separate process invocations which shouldn't affect the current
>> worktree or the current "git worktree add" process.
>
> The "shouldn't affect" is potentially a problem.If the current
> 'worktree add' process caches something (in ref handling, for example)
> that the 'git branch' process changes, then we may need to invalidate
> cache in 'worktree add' process after run_command(). I guess it's ok
> in this case since all we do is run_command(), we do not lookup refs
> or anything else afterwards.

With this patch series applied, the code effectively does this:

    branch = ...
    if (create_new_branch) {
        exec "git branch newbranch branch"
        branch = newbranch;
    }
    if (ref_exists(branch) && !detach)
        exec "git symbolic-ref HEAD branch"
    else
        exec "git update-ref HEAD $(git rev-parse branch)"
    exec "git reset --hard"

So, if I understand your concern correctly, then you are worried that,
following the git-branch invocation, ref_exists() could return the
wrong answer with a pluggable ref-backend since it might be answering
based upon stale information. Is that what you mean? If so, I can see
how that it could be an issue. (As far as I can tell, the current
file-based backend doesn't have a problem with this since it's hitting
the filesystem directly to answer the ref_exists() question.)
