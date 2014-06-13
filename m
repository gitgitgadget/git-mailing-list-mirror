From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Our merge bases sometimes suck
Date: Fri, 13 Jun 2014 17:52:57 +0200
Message-ID: <539B1E59.1030604@gmail.com>
References: <539A25BF.4060501@alum.mit.edu> <539AC690.6000906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 17:53:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvTn0-0005Pv-M3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 17:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbaFMPxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 11:53:06 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:58099 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbaFMPxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 11:53:03 -0400
Received: by mail-wg0-f48.google.com with SMTP id n12so2852306wgh.31
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=CtKEmVjHmRkrepFU2CnuK3zpFq1ASwAi/gaoLAFOhPo=;
        b=xxr+RguEY6hr0gk4jqJoD1291xZ8T9SgLtdiZFsd+HGQAzwaYeNh/9P78wlFtikv7I
         z1DwJv2HVUpIqvJhtEumjyhZAn+3SJlCJ9ijnzGo2YPeHMXelwCBF09ewMD/sC74q45O
         Uskk6yU0RXhrQ+J6R+hf/jjtcrARodl1l/KCqoQi1akQoKRd03OmCTHIUiwK0uz110a6
         oMrQ7FSYiQ9t/eg3Cbhlww4t9RKWP+HY/ZH/r8gwtxuIWQiQv+in2njj4GO3BrCckQFU
         ZPxmRsPDirN3SdykfSa3hcTCodEOwoIQm4ctcJOdCLAgjYZFUtT+aQiMqndcY9jqQzLd
         TE6w==
X-Received: by 10.194.161.168 with SMTP id xt8mr5673174wjb.35.1402674781502;
        Fri, 13 Jun 2014 08:53:01 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id 8sm12636491eea.10.2014.06.13.08.52.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 08:53:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539AC690.6000906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251605>

W dniu 2014-06-13 11:38, Michael J Gruber pisze:
> Michael Haggerty venit, vidit, dixit 13.06.2014 00:12:
>> I've been thinking a lot about merge bases lately and think I have
>> discovered something interesting.
>>
>> tl;dr:
>>
>> When two branches have multiple merge bases,
>>
>>      git merge-base $master $branch
>>
>> picks one merge base more or less arbitrarily.  Here I describe a
>> criterion for picking a "best" merge base.  When the best merge base
>> is used, the diff output by
>>
>>      git diff $master...$branch
>>
>> becomes shorter and simpler--sometimes dramatically so.  I have
>> quantified the improvement by analyzing historical merges from the G=
it
>> project (see attached image).  Best merge bases might also help redu=
ce
>> conflicts when conducting merges.
>>
>
> Everytime I looked at our merge base code, my head started spinning. =
So
> it's admirable you even started this endeavor :)
>
> We use merge bases for several things:
>
> - merging
> - resolving "A...B" rev notation (rev-list and friends), aka symmetri=
c
> difference
> - left/right selection/annotation of commits (rev-list/log)
> - resolving "diff A...B", which may be a handy notation, but is horri=
bly
> misleading because it is a very unsymmetric form of diff

I don't know if it has been fixed, but there is a difference
between "git diff A...B" when A and B have one merge base, and
"git diff A...B" when there are more than one merge base.

When there is one merge base, "git diff A...B" returns simple
unified diff equivalent to "git diff $(git merge-base A B) B".
It is unsymmetric.

But where there are more than one merge base, by design or by
accident for "git diff A...B" git 1.9.2 / 1.7.4 returns

    git diff --cc $(git merge-base --all A B) A B

which is *symmetric*, and is combined not unified diff.

--=20
Jakub Nar=C4=99bski
