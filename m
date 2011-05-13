From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Fri, 13 May 2011 10:56:54 -0400
Message-ID: <BANLkTi=NdVUUZ=_bACzyeMGS3JWs0EMbWA@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
 <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com> <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shuang He <shuang.he@intel.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 16:57:25 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKtnx-0001zP-1k
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 16:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759395Ab1EMO5R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 10:57:17 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:37097 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758703Ab1EMO5Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 10:57:16 -0400
Received: by pxi16 with SMTP id 16so1720565pxi.4
        for <multiple recipients>; Fri, 13 May 2011 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ie7QdyIfZUwTMXrhQtduTYeZ+czjKkchG6VS6xBX//c=;
        b=Ge7Syv3sMWzQHPkkmL9u5JE/6N9eWHl2364cUnGu0SMWoJ9RGPta1VGyFrLuCGrj6B
         4NoreqSsoJdSTN9towmltkg65BK3R1TuyQaHqGA7kNYuD6yh7AIyjh1/Ok99wJcfHnRk
         fHvlW5QxkczISPk4dBuAT3qS/D9A58ELtrL90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=FnIBuccDQ8T9OpLn4Th3Dk+A5d5c4hHQ7lkTxqxHFir9vzwAUlg6Ot9EudyqDnCXMu
         2Oi+2+SYs6e0n1ntDWxEy8sp6vOHCCdN/McvuAH/tsuBU+nAdaxshZzLPdiN2ogti4Zr
         qsIaySVxhX147lO9DHwoDFwtW3pBdvxEdIJlA=
Received: by 10.68.51.194 with SMTP id m2mr2289565pbo.180.1305298634065; Fri,
 13 May 2011 07:57:14 -0700 (PDT)
Received: by 10.68.41.197 with HTTP; Fri, 13 May 2011 07:56:54 -0700 (PDT)
In-Reply-To: <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com>
X-Google-Sender-Auth: a25XyeT2y0XY6I_b5girSa_-ZOc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173542>

On Fri, May 13, 2011 at 9:38 AM, Andrew Lutomirski <luto@mit.edu> wrote=
:
> On Fri, May 13, 2011 at 4:20 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Thu, May 12, 2011 at 7:15 PM, Andrew Lutomirski <luto@mit.edu> wr=
ote:
>>>
>>> OK, this sucks. =A0In the course of bisecting this, I've hit two ot=
her
>>> apparently unrelated bugs that prevent my from testing large number=
s
>>> of kernels. =A0Do I have two questions:
>>>
>>> 1. Anyone have any ideas from looking at the log?
>>>
>>> It looks like most of what's left is network code, so cc netdev.
>>>
>>> 2. =A0The !&$#@ bisection is skipping all over the place. =A0I've s=
een
>>> 2.6.37 versions and all manner of -rc's out of order. =A0Linus, and
>>> other people who like pontificating about git bisection: is there a=
ny
>>> way to get the bisection to follow Linus' tree? =A0I think that if
>>> bisect could be persuaded to consider only changes that are reached=
 by
>>> following only the *first* merge parent all the way from the bad
>>> revision to the good revision, then the bisection would build versi=
ons
>>> that were at least good enough for Linus to pull and might have few=
er
>>> bisection-killing bugs.
>>>
>>> (This isn't a new idea [1], and git rev-list --bisect --first-paren=
t
>>> isn't so bad except that it doesn't bisect.)
>>
>> Did you forget to put the reference [1] in your email? Was it this o=
ne
>> you were thinking about:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/165433/
>
> No, it was this:
>
> http://stackoverflow.com/questions/5638211/how-do-you-get-git-bisect-=
to-ignore-merged-branches
>

Sadly even that's not enough.  I finished the bisection (by
standard-ish techniques but with a bit of overriding of git bisect's
choices and occasional merging of newer versions of -linus to get
something that would boot) and it pointed to a commit that wasn't the
culprit.

The problem is that 2.6.39-rc7 is bad, 2.6.38 (and 2.6.38.{5,6}) is
good, but 2.6.38-rc5 is bad and fails identically to 2.6.39-rc7.  I
think that git bisect makes the assumption that ancestors of a good
commit are good, and that just isn't true for this bug.

So what I really want is a fancy version of git bisect that makes no
assumptions about the relationship of good and bad commits in the
graph and just finds me a commit that is bad but for which all parents
are good or vice versa.

I'm currently bisecting the other way to find the commit before 2.6.38
that fixed the bug, since there's presumably less churn there than in
the early bits of 2.6.39.

--Andy
