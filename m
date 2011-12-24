From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Sat, 24 Dec 2011 02:39:11 +0100
Message-ID: <CACBZZX67WhcdhXdqOm8gZHW7C3YMbV2KzeytwjHwsnF=8-M_+w@mail.gmail.com>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <CACBZZX6hboo4wu3fOs+CHnxsdmedxw72GFMVttQzmHzpcZbqoQ@mail.gmail.com> <87mxaihpiq.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Dec 24 02:39:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReGaa-0006Hd-Th
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 02:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab1LXBjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Dec 2011 20:39:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59969 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab1LXBjf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Dec 2011 20:39:35 -0500
Received: by eaad14 with SMTP id d14so3102441eaa.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 17:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NRKAKBjw3GH4JMolHSlyuC2xP8gvlqJH719aQGEYWKI=;
        b=ESdo452mUwGL/yqJ7fsRA4a0P7Ya7vy2keYkWyCXyFlF4R7ckIf0Al49VLw7Ne1Zv2
         7GATofyP8dPyVlCu3gj0l6gnS41INtQhMXe8AdM4Z3Ot3BVMri6wSCOoa+dYU1gDNDmH
         LNSPr8+dmVOeNOCMoVU37Wgm0njH0O5mvusIM=
Received: by 10.205.128.12 with SMTP id hc12mr4472231bkc.133.1324690772208;
 Fri, 23 Dec 2011 17:39:32 -0800 (PST)
Received: by 10.204.181.83 with HTTP; Fri, 23 Dec 2011 17:39:11 -0800 (PST)
In-Reply-To: <87mxaihpiq.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187649>

2011/12/23 Thomas Rast <trast@student.ethz.ch>:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Dec 2, 2011 at 14:07, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>>
>>> I conjecture that this is caused by contention on
>>> read_sha1_mutex. [...] So disable threading entirely when not
>>> scanning the worktree
>>
>> Why does git-grep even need to keep a mutex to call read_sha1_file()=
?
>> It's inherently a read-only operation isn't it? If the lock is neede=
d
>> because data is being shared between threads in sha1_file.c shouldn'=
t
>> we tackle that instead of completely disabling threading?
>
> The problem is that all sorts of data is shared. =C2=A0See
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/186618
>
> But I need to go through it again, there are some races and double lo=
cks
> in the posted version.

I mentioned this on IRC, but I thought I'd bring it up here too.

Is the expensive part of git-grep all the setup work, or the actual
traversal and searching? I'm guessing it's the latter.

In that case an easy way to do git-grep in parallel would be to simply
spawn multiple sub-processes, e.g. if we had 1000 files and 4 cores:

 1. Split the 1000 into 4 parts 250 each.
 2. Spawn 4 processes as: git grep <pattern> -- <250 files>
 3. Aggregate all of the results in the parent process
