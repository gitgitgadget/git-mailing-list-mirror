From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 11/16] rev-list: add bitmap mode to speed up lists
Date: Wed, 26 Jun 2013 03:45:26 +0200
Message-ID: <CAFFjANSYoRGFDx109kMWJtYAO4TaTwSW0NCaemnrERuwakfpGg@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-12-git-send-email-tanoku@gmail.com> <87mwqdlvsq.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 26 03:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urenv-00046V-Ba
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 03:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab3FZBpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 21:45:47 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:62798 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3FZBpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 21:45:46 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so10228908vbg.11
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Tmsjx+nv0fLYFqjwDp2s7p+Iff8KYVHbBCAt5Iji07k=;
        b=jVOokCbD3DWhWvVsTx8dD6MgzxPZEqq+oPvaRZ98Cf46A6rmRtCl4+YfYY6Bm9zDMp
         SYN0LuVVCUzvc56cZdEJuLOtrEdRDN/9OYnnaGGWOnJNpO/1POmXGaDsO53YxwsGVYUn
         mjLianAFYPBCyvbO+ikYE+n3AVD/UBETdySyj9VUqisvfOKcHEKGzlunDp8O4vUFVT26
         78rXC1uSAtM3lBhpVGJSPqGbbCCYXtofkWSFTthEiRg/XrmiEktO4ZVax9J/wstischF
         5ci0kzJ0f78q03AuT/t6QTXZ2rlzZaf34vjZy7wg5csWCrLtb6eXIHh459yF5dnXeIlf
         CtaQ==
X-Received: by 10.220.144.13 with SMTP id x13mr945997vcu.21.1372211146141;
 Tue, 25 Jun 2013 18:45:46 -0700 (PDT)
Received: by 10.221.45.131 with HTTP; Tue, 25 Jun 2013 18:45:26 -0700 (PDT)
In-Reply-To: <87mwqdlvsq.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229019>

I'm afraid I cannot reproduce the segfault locally (assuming you're
performing the rev-list on the git/git repository). Could you please
send me more information, and a core dump if possible?

On Tue, Jun 25, 2013 at 6:22 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Vicent Marti <tanoku@gmail.com> writes:
>
>> Calling `git rev-list --use-bitmaps [committish]` is the equivalent
>> of `git rev-list --objects`, but the rev list is performed based on
>> a bitmap result instead of using a manual counting objects phase.
>
> Why would we ever want to not --use-bitmaps, once it actually works?
> I.e., shouldn't this be the default if pack.usebitmaps is set (or
> possibly even core.usebitmaps for these things)?
>
>> These are some example timings for `torvalds/linux`:
>>
>>       $ time ../git/git rev-list --objects master > /dev/null
>>
>>       real    0m25.567s
>>       user    0m25.148s
>>       sys     0m0.384s
>>
>>       $ time ../git/git rev-list --use-bitmaps master > /dev/null
>>
>>       real    0m0.393s
>>       user    0m0.356s
>>       sys     0m0.036s
>
> I see your badass numbers, and raise you a critical issue:
>
>   $ time git rev-list --use-bitmaps --count --left-right origin/pu...origin/next
>   Segmentation fault
>
>   real    0m0.408s
>   user    0m0.383s
>   sys     0m0.022s
>
> It actually seems to be related solely to having negated commits in the
> walk:
>
>   thomas@linux-k42r:~/g(next u+65)$ time git rev-list --use-bitmaps --count origin/pu
>   32315
>
>   real    0m0.041s
>   user    0m0.034s
>   sys     0m0.006s
>   thomas@linux-k42r:~/g(next u+65)$ time git rev-list --use-bitmaps --count origin/pu ^origin/next
>   Segmentation fault
>
>   real    0m0.460s
>   user    0m0.214s
>   sys     0m0.244s
>
> I also can't help noticing that the time spent generating the segfault
> would have sufficed to generate the answer "the old way" as well:
>
>   $ time git rev-list --count --left-right origin/pu...origin/next
>   189     125
>
>   real    0m0.409s
>   user    0m0.386s
>   sys     0m0.022s
>
> Can we use the same trick to speed up merge base computation and then
> --left-right?  The latter is a component of __git_ps1 and can get
> somewhat slow in some cases, so it would be nice to make it really fast,
> too.
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
