From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Fri, 13 May 2011 09:38:18 -0400
Message-ID: <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com> <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shuang He <shuang.he@intel.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 15:38:49 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKsZr-0005GJ-8i
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 15:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109Ab1EMNik convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 09:38:40 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:42386 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082Ab1EMNii convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 09:38:38 -0400
Received: by pxi16 with SMTP id 16so1678658pxi.4
        for <multiple recipients>; Fri, 13 May 2011 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Jgo60QWD81QXjHbRagVtlTnsnXZpPihopC8b3X+6Y/Y=;
        b=tX+4QRWt9CRCFh6iL7rnNfbXM9I3+TdLkURNdoNh9g59L6B7D0o26Ql84WxM1oMcbf
         JTNJ7bi5+FmrZnJCZf073cRpSQpvO4IDMsPw/+Q/yw5ELd4CspsJFes8Ru8pkZ4MaCIe
         Wf7gYRnApkz94h5mmU9V9W/F3O/FAIZgBeyvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=au0tGK3suA6GbaLza2V2Ku/nb4zR9V7AGG6X+H7P2Ds8J1I6oTJXCqrVhfAN8puUax
         kzax88xS1odGR1MgZBUQdzRLNxNk1ItoBGiGq0XA7t4QRv6KrRUfT5gKpsh4fKijrDQi
         DS+JViR8PnKK2gBsPAJy9B6amGoIk0txD0yAg=
Received: by 10.68.48.168 with SMTP id m8mr2245201pbn.113.1305293918073; Fri,
 13 May 2011 06:38:38 -0700 (PDT)
Received: by 10.68.41.197 with HTTP; Fri, 13 May 2011 06:38:18 -0700 (PDT)
In-Reply-To: <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com>
X-Google-Sender-Auth: -tgTD_W66QvVrbTuV8la9oj1zAs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173537>

On Fri, May 13, 2011 at 4:20 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, May 12, 2011 at 7:15 PM, Andrew Lutomirski <luto@mit.edu> wro=
te:
>>
>> OK, this sucks. =A0In the course of bisecting this, I've hit two oth=
er
>> apparently unrelated bugs that prevent my from testing large numbers
>> of kernels. =A0Do I have two questions:
>>
>> 1. Anyone have any ideas from looking at the log?
>>
>> It looks like most of what's left is network code, so cc netdev.
>>
>> 2. =A0The !&$#@ bisection is skipping all over the place. =A0I've se=
en
>> 2.6.37 versions and all manner of -rc's out of order. =A0Linus, and
>> other people who like pontificating about git bisection: is there an=
y
>> way to get the bisection to follow Linus' tree? =A0I think that if
>> bisect could be persuaded to consider only changes that are reached =
by
>> following only the *first* merge parent all the way from the bad
>> revision to the good revision, then the bisection would build versio=
ns
>> that were at least good enough for Linus to pull and might have fewe=
r
>> bisection-killing bugs.
>>
>> (This isn't a new idea [1], and git rev-list --bisect --first-parent
>> isn't so bad except that it doesn't bisect.)
>
> Did you forget to put the reference [1] in your email? Was it this on=
e
> you were thinking about:
>
> http://thread.gmane.org/gmane.comp.version-control.git/165433/

No, it was this:

http://stackoverflow.com/questions/5638211/how-do-you-get-git-bisect-to=
-ignore-merged-branches

--Andy

>
> ?
>
> Thanks,
> Christian.
>
