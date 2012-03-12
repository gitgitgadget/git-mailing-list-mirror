From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Mon, 12 Mar 2012 18:42:14 +0700
Message-ID: <CACsJy8CyLgKrEAriS-uLU9qG6ahBeQ6qLbvHiLvsbTjMZsMW+g@mail.gmail.com>
References: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
 <1331519549-28090-3-git-send-email-pclouds@gmail.com> <87y5r684t6.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 12:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S73eM-0006KK-V7
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 12:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab2CLLmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 07:42:46 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36385 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab2CLLmp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 07:42:45 -0400
Received: by wibhq7 with SMTP id hq7so3574041wib.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CkjjTb6b0s0CmZ08UUi/u2Jggnoww/quvcgdRybF8Vw=;
        b=vb/R47ZeII/fXHBquBUc1Na/dgpDzzxYXQcknvmN41jHgxYh3RMr1u40XPahOIfP3J
         egSYQRgcYY8/dixFsifQCUYyknOrxaOJTs/cztT3vHHWy0s1eu8A2t/mWpUiQb7NM4jM
         S84h3BfEVcppBa6b4pXFDNR+6/Qn5OzEgEb/+Hi8rae6rYBKsmE5HLEccoQZ9UWVvAC2
         gD7AG82QWR8Eyt/8DgKoMThsqkKmkD+61DaiSIArYJDksp8exclc/6EYcn5EoJDtVucy
         kgk77d40wlIOOXoHfphVRNFRKcs/s4rNo+0Jw3u9DTJWbS2VWb/yJMY/C1w6PxIKvu7T
         w09w==
Received: by 10.180.103.97 with SMTP id fv1mr26640553wib.17.1331552564454;
 Mon, 12 Mar 2012 04:42:44 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Mon, 12 Mar 2012 04:42:14 -0700 (PDT)
In-Reply-To: <87y5r684t6.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192855>

2012/3/12 Thomas Rast <trast@inf.ethz.ch>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> This puts delta resolving on each base on a separate thread, one bas=
e
>> cache per thread. Per-thread data is grouped in struct thread_local.
>> When running with nr_threads =3D=3D 1, no pthreads calls are made. T=
he
>> system essentially runs in non-thread mode.
>
> As discussed when we took the git-grep measurements, it may be
> interesting to have a way to run 1 thread. =C2=A0Can you put in such =
an
> option?

Sorry I wasn't clear, nr_threads =3D=3D 1 is equivalent to --threads=3D=
1. So
yes it supports running in non-thread mode.

>> An experiment on a Xeon 24 core machine with linux-2.6.git shows tha=
t
>> performance does not increase proportional to the number of cores. S=
o
>> by default, we use maximum 3 cores. Some numbers with --threads from=
 1
>> to 16:
>>
>> 1..4
>> real =C2=A0 =C2=A01m16.310s =C2=A00m48.183s =C2=A00m37.866s =C2=A00m=
32.834s
>> user =C2=A0 =C2=A01m13.773s =C2=A01m15.537s =C2=A01m15.781s =C2=A01m=
16.233s
>> sys =C2=A0 =C2=A0 0m2.480s =C2=A0 0m3.936s =C2=A0 0m4.448s =C2=A0 0m=
4.852s
>>
>> 5..8
>> real =C2=A0 =C2=A00m33.170s =C2=A00m30.369s =C2=A00m28.406s =C2=A00m=
26.968s
>> user =C2=A0 =C2=A01m31.474s =C2=A01m30.322s =C2=A01m29.562s =C2=A01m=
28.694s
>> sys =C2=A0 =C2=A0 0m6.096s =C2=A0 0m6.268s =C2=A0 0m6.684s =C2=A0 0m=
7.172s
>
> Interesting. =C2=A0Is this a real 24-core machine or 12*2 hyperthread=
ed?
> Does it use Turbo Boost and how far (how fast and on how many cores
> simultaneously) does that go?

I'll check on that later.

> I'm asking because if Turbo Boost starts to wear off around 4 cores,
> like these measurements suggest, then it may not be beneficial to spa=
wn
> threads on 2*2HT CPUs (found in many laptops) where Turbo Boost only
> really works if you only use a single core.

That might explain why it performs poorly on my two (probably HT)
cores laptop after 4 threads. I was worried there was some contention
in the code (and failed to find one) that made it perform worse as
more threads were spawn. Any pointers for identifying cpu features in
linux?

> Oh, and could you write a perf test for this? :-)

Yeah, about that, index-pack is mostly used as part of git-fetch or
git-clone. Maybe we need to add --threads to those commands too, then
we can see how clone/fetch performs. I'll need such tests anyway if
I'm going to push for cheaper connectivity check in git-fetch in
another thread.

I guess one test with --threads=3D1, one with threads=3D2 and one witho=
ut
--threads. Any ideas? We can try testing it on half available cores,
all cores, double available cores, but that would require exporting
online_cpus(), perhaps via test command. I didn't see grep --threads
perf test either (wanted to use it as template..)
--=20
Duy
