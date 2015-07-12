From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/16] worktree: make branch creation distinct from
 worktree population
Date: Sat, 11 Jul 2015 23:14:08 -0400
Message-ID: <CAPig+cQcE0CkNCY6rbzRfjptesawPjeqGx9+rtVhCOADJzcU2Q@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
	<1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
	<CACsJy8A8QkeFa3FyCkv8dp-J52NGGaN-AV3oG7W8tNtYqDO-cw@mail.gmail.com>
	<CAPig+cSiPeJskyanLAv71LuFoqPirUJ2FL0B0BsoT8BEVrE3LA@mail.gmail.com>
	<CACsJy8A8CeyeYZnMpbdWW-etohp3TWzGrro1khzD=8skydm6Cg@mail.gmail.com>
	<CAPig+cT-1juGLZK+F1Cy+MDE8+_bPqnX6fgfpoMnd2Qypu3oZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 05:14:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE7iY-0001CV-JA
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 05:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbbGLDOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 23:14:10 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33582 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbbGLDOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 23:14:09 -0400
Received: by ykeo3 with SMTP id o3so171130421yke.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2Y+//ftX61QWwB5zUUcF318hF2lz5GOnzFZy1+Z60us=;
        b=cOxFezxkqvKU200pUcopcUj3xH5pL8VDC/AD2tuPSXU5euY49Wy8pdjgtaGSzUU7r9
         /RSs9dbwZQ0HCAijQysqIZs/dslyONlJrGVpfzAi8bmRxiUueonqu9Ycu7mT3mP3kYKH
         p+cGHoM+51di/TqErWunY6OD20BxpH7zxceATlJEcHbpJw8zQ7avFFFdJtA98+n/JI59
         Y2IdqcPUHGh4m7ZgHRVvmDQ6fVG1qqrmWVb4lO9wOJ0Ey2LhQ/3YR/YAVV+JzXEzcls0
         9WNH1j6RJdLUdbYwvyShS8UyaXWsHweYMDUVytOWGCgY4MXkm49rxWDhi69hOwel/pfp
         e+hg==
X-Received: by 10.170.220.214 with SMTP id m205mr31497640ykf.13.1436670848418;
 Sat, 11 Jul 2015 20:14:08 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 11 Jul 2015 20:14:08 -0700 (PDT)
In-Reply-To: <CAPig+cT-1juGLZK+F1Cy+MDE8+_bPqnX6fgfpoMnd2Qypu3oZQ@mail.gmail.com>
X-Google-Sender-Auth: MgkAuM8h39FuqkkQUzuMmUN9YxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273884>

On Sat, Jul 11, 2015 at 11:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jul 11, 2015 at 10:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> The "shouldn't affect" is potentially a problem.If the current
>> 'worktree add' process caches something (in ref handling, for example)
>> that the 'git branch' process changes, then we may need to invalidate
>> cache in 'worktree add' process after run_command(). I guess it's ok
>> in this case since all we do is run_command(), we do not lookup refs
>> or anything else afterwards.
>
> With this patch series applied, the code effectively does this:
>
>     branch = ...
>     if (create_new_branch) {
>         exec "git branch newbranch branch"
>         branch = newbranch;
>     }
>     if (ref_exists(branch) && !detach)
>         exec "git symbolic-ref HEAD branch"
>     else
>         exec "git update-ref HEAD $(git rev-parse branch)"
>     exec "git reset --hard"
>
> So, if I understand your concern correctly, then you are worried that,
> following the git-branch invocation, ref_exists() could return the
> wrong answer with a pluggable ref-backend since it might be answering
> based upon stale information. Is that what you mean? If so, I can see
> how that it could be an issue. (As far as I can tell, the current
> file-based backend doesn't have a problem with this since it's hitting
> the filesystem directly to answer the ref_exists() question.)

I meant for this final sentence to end like this:

     ...to answer the ref_exists() question, but it still seems
     fragile since some future change could introduce caching.
