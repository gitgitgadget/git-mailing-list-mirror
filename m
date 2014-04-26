From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] blame: large-scale performance rewrite
Date: Sat, 26 Apr 2014 09:01:22 -0700
Message-ID: <CAJo=hJs=ap=Ct_PzOsO=vHmDVMvUF+nvbB7b67bgnmug+Yrohg@mail.gmail.com>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
 <CAJo=hJukmej1rJXuVoECwd7AxmSue8Wmv4rBmCHEYcWBWNarSw@mail.gmail.com> <87wqec8rb5.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 18:02:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We53Y-0000Im-Ex
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 18:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbaDZQBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 12:01:45 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:45745 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbaDZQBn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 12:01:43 -0400
Received: by mail-wg0-f49.google.com with SMTP id a1so4704304wgh.8
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dmo3h/kUd39VFJhxAuDTKq6Tm1su/4TO+q5hyUMy6LY=;
        b=e+eMmD4mkWQYS1bFqOIeRv7CqUFTnarHWFHcbAd40XqiBOsJDCISMxvmxDIGIi7WJv
         A85XsHYbTwsdLjjpoNzWfieN6KNfSdmYWmWJTKf2E6oC0Su7uyJDchYdQopMoP7u7cg+
         F9XQKUxTTPwSRIPcycLSLDNRC//rYej3n7Ot4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dmo3h/kUd39VFJhxAuDTKq6Tm1su/4TO+q5hyUMy6LY=;
        b=J+PQTMjXE9jZPaSha7lclLHYpGvM4T+HHk1CW54Zjb5O/YOuTR0Bpv4SiF7mTlrsrR
         QluhI01mhL3Y0CwaFdbxabZGsbr4UVQ8ZPy8v8hKXgKtSePilhFKpmY44q0LJQfvs82f
         HxDKdPQACRGEym2c8ib/qsj/+BdLJ64lcfvcaekiX752RwxaW2yj7jyOlIIBaCP/EgyJ
         sWqSJizLpuW9SCQFINubsiTtXoCEmj8vT829ZuNff6PaMvFIL1jd+Tu8LvkN6/APOdL1
         JgzAEuaZa8ic/kH4kTQMuCZgH405Xiuzv2M89sO0zdRc39GXXOonmSzAlo9qEUGwov8W
         plTQ==
X-Gm-Message-State: ALoCoQm6iAhGiPQ2E928GkVjLHsJ9Ns9PZPLMz9u3m+4K2mOLGaGBxl1nUHImt126gemSDtXLcch
X-Received: by 10.180.206.205 with SMTP id lq13mr8241375wic.11.1398528102087;
 Sat, 26 Apr 2014 09:01:42 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Sat, 26 Apr 2014 09:01:22 -0700 (PDT)
In-Reply-To: <87wqec8rb5.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247158>

On Sat, Apr 26, 2014 at 12:48 AM, David Kastrup <dak@gnu.org> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> On Fri, Apr 25, 2014 at 4:56 PM, David Kastrup <dak@gnu.org> wrote:
>>> The previous implementation used a single sorted linear list of blame
>>> entries for organizing all partial or completed work.  Every subtask had
>>> to scan the whole list, with most entries not being relevant to the
>>> task.  The resulting run-time was quadratic to the number of separate
>>> chunks.
>>>
>>> This change gives every subtask its own data to work with.  Subtasks are
>>> organized into "struct origin" chains hanging off particular commits.
>>> Commits are organized into a priority queue, processing them in commit
>>> date order in order to keep most of the work affecting a particular blob
>>> collated even in the presence of an extensive merge history.
>>
>> Without reading the code, this sounds like how JGit runs blame.
>>
>>> For large files with a diversified history, a speedup by a factor of 3
>>> or more is not unusual.
>>
>> And JGit was already usually slower than git-core. Now it will be even
>> slower! :-)
>
> If your statement about JGit is accurate, it should likely have beat Git
> for large use cases (where the performance improvements are most
> important) as O(n) beats O(n^2) in the long run.

Agreed.

In a few cases yes, JGit did beat git-core at blame running time.
Unfortunately according to my profiling blame performance is still
dominated by inflation and scanning of commit and tree objects to
identify unmodified blobs and advance to the next scapegoat ancestor.

Its entirely possible my blame implementation in JGit is still doing
something stupid. Or its possible JIT translated Java just takes
longer than natively compiled C. I am including JVM startup and JIT
time in the timing comparison with git-core.

> Apart from the objective measurement of "total time", the more
> subjective impression of interactive/incremental response (like in git
> gui blame) where the order of results will significantly differ (current
> git-blame --incremental focuses on getting blames resolved in
> first-lines-first manner, the proposed git-blame rather works on a
> newest-commits-first basis which might better match typical use cases)
> might be worth reporting.

Seeing this fill during execution was the initial motivation I had for
writing git gui blame. I don't think anyone cares about the order it
displays in. In fact ordering my timestamp may be more what the user
wants anyway, as you suggest above.

Thanks for doing this. Unfortunately I can't read the patch itself as
I am also trying to improve JGit's blame code for $DAY_JOB, and JGit
is BSD licensed.
