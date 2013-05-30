From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 13:29:02 +0100
Message-ID: <CAJ-05NM9EhikDBP0izqWrnLbZW6RcHq_cH-20YTE08SZw5fjqA@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<20130530114808.GD17475@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 30 14:29:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1yg-0005q4-F4
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411Ab3E3M3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 08:29:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54773 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab3E3M3E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 08:29:04 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so388699obb.19
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=D7vwxE+tUiktZZ9LFlgRiDj7RVCSO8Jk5hur4fbX4zM=;
        b=YV7HDDkHpBHgNBFwKn6N3QLQg55Pkku72uR+bexFeRi9ge/VS0vLyJqMy40mMAmp4X
         1oAu1PUBnDhC7aofDs10/CQxcPf7KjleFElvANJiZkRSdaSjqU5/6Wp6q3mH8wlXY8O3
         0Q83x3JYIBNTZPTdJWhNRyLOA8jIRE2b5LhiciVVZp+gYRI0d4l0fI12Ezn2nETzImLS
         koGLs+mrtLcZfSHOTjGv0m0AUgZ7Li+fYTQj7BGR/lZF9L2PCmnZNS0Immnp/MqqDr04
         1wWckHu23KnWNpIsDulK/snvMJmhz81uq6QteZmBRiDrCqBIPckpsbOWKmq6Q505WEz7
         sxsA==
X-Received: by 10.182.233.227 with SMTP id tz3mr4051495obc.23.1369916942945;
 Thu, 30 May 2013 05:29:02 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Thu, 30 May 2013 05:29:02 -0700 (PDT)
In-Reply-To: <20130530114808.GD17475@serenity.lan>
X-Google-Sender-Auth: GGfuTCixgkq1QXLxUNZdXbiiyaw
X-Gm-Message-State: ALoCoQmN4brI+zhLH+Wn/YOlS0fs+lHGmm5x2SV9u/qGk6QMFlgF8Jd3wxZNZTXNKMyZtz6iZQYd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225977>

The repo is a fairly hairy one as it includes two historically
un-related but content related repos which I'm the process of
cherry-picking stuff across.

11:58 ajb@sloy/x86_64 [work.git] >git count-objects -v
count: 493
size: 4572
in-pack: 399307
packs: 1
size-pack: 1930755
prune-packable: 0
garbage: 0
size-garbage: 0

This was after a repack which did have slight negative effect on
performance. The pack file is:

13:27 ajb@sloy/x86_64 [work.git] >ls -lh ./.git/objects/pack/*
-r--r--r-- 1 ajb cvs  11M May 30 11:56
=2E/.git/objects/pack/pack-a9ba133a6f25ffa74c3c407e09ab030f8745b201.idx
-r--r--r-- 1 ajb cvs 1.9G May 30 11:56
=2E/.git/objects/pack/pack-a9ba133a6f25ffa74c3c407e09ab030f8745b201.pac=
k

I ran perf on it and the top items in the report where:

 41.58%   git  libcrypto.so.1.0.0  [.] 0x6ae73
 33.96%   git  libz.so.1.2.3.4     [.] 0xe0ec
 10.39%   git  libz.so.1.2.3.4     [.] adler32
  2.03%   git  [kernel.kallsyms]   [k] clear_page_c

So I'm guessing it's spending a lot of non-cache efficient time
un-packing and processing the deltas?

--
Alex.

On 30 May 2013 12:48, John Keeping <john@keeping.me.uk> wrote:
> On Thu, May 30, 2013 at 11:38:32AM +0100, Alex Benn=C3=A9e wrote:
>> One factor might be the size of my repo (.git is around 2.4G). Could
>> this just be due to computational cost of searching through large
>> packs to walk the commit chain? Is there any way to make this easier
>> for git to do?
>
> What does "git count-objects -v" say for your repository?
>
> You may find that performance improves if you repack with "git gc
> --aggressive".



--=20
Alex, homepage: http://www.bennee.com/~alex/
