From: Chris Li <git@chrisli.org>
Subject: Re: [PATCH] git-p4: don't convert utf16 files.
Date: Sun, 21 Aug 2011 12:09:15 -0700
Message-ID: <CANeU7QkwekmnCQKG3DqyhW54hk7boL+FQSOOviJ3gn5K7++cjg@mail.gmail.com>
References: <CANeU7QmGJTr4V-tWzuPnP2P=9eQbGDgQxv2phAVbGXjU5tqYPQ@mail.gmail.com>
	<20110821152156.GA30299@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eberhard Beilharz <eb1@sil.org>,
	Jordan Zimmerman <jzimmerman@netflix.com>,
	Mike Crowe <mac@mcrowe.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 21:09:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvDOc-00079a-KQ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 21:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab1HUTJR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 15:09:17 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55426 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307Ab1HUTJQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 15:09:16 -0400
Received: by qyk38 with SMTP id 38so1010536qyk.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zk8EFfVuJIGQDRaglB5Sfmml3Iky0RTJfgJzZ4P9l7A=;
        b=cH/F1m1HiK2/PKoPYBlNGcm7hdUnPEfO8RUX9/3ri9Xi1JuLUZkoe8d2vCzpTr8MdF
         uFK6G1O0yIHyTmcHLRs9qbq4rtQgGPI/uAJCSmzQ4Rn1xwNiIzpWb9v1uJ7AycYf2xpL
         BfEeXasw73DIDu9IYenP4j6edJjb3V1yZuDrs=
Received: by 10.229.149.8 with SMTP id r8mr810808qcv.293.1313953755819; Sun,
 21 Aug 2011 12:09:15 -0700 (PDT)
Received: by 10.229.149.15 with HTTP; Sun, 21 Aug 2011 12:09:15 -0700 (PDT)
In-Reply-To: <20110821152156.GA30299@arf.padd.com>
X-Google-Sender-Auth: mVFkSGx3y-ER7gzqyW0PcYoWgG8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179808>

On Sun, Aug 21, 2011 at 8:21 AM, Pete Wyckoff <pw@padd.com> wrote:

>> Using the "p4 print -o tmpfile depotfile" can avoid this
>> convertion (and possible failure) all together.
>
> This isn't contrib/fast-import/git-p4. =A0Searching around, I
> discovered a 2009 fork of git-p4 that is fairly active. =A0CC-ing
> some of the names I found on github.

Oops. I forget I am trying some other git-p4 and this patch is
not for git-core. The git-p4 in git-core repository has the same
problem. I was original using the git-core one, hit the bug. Then
I try some other branch and found the same problem, I just forget
which git repository I am at. Silly me.

Let me redo a patch for git.

>
> Here's one such repo:
>
> =A0 =A0http://github.com/ermshiperete/git-p4
>
> Git's git-p4 doesn't try to do anything special with utf-16. =A0It
> does \r\n mangling, but not $Keyword$ removal, then just streams
> it to disk however p4 sends it. =A0That's close to what you're
> trying to do here.

No, it is not the same. Here is what I find out. If you ask use
"p4 print" to fetch a perforce utf16 file, perforce convert that file i=
nto
utf8 before it send out to stdout. I guess the perforce guys assume
p4 print is used for terminal console. If the git-p4 just stream to dis=
k,
then you  those file are effective checkout as utf8, which is about
half the size of the original utf16 file.

I never like those utf16 files, I think those file should be check in
as binary. But some one did check in the utf16 in the repository I
use at work, Now I have to deal with it. I guess the reason perforce
want to know about utf16 is to do the \r\n conversion properly on
those utf16 files. The file in question is the windows .mc file.
It contain different language translation of the error message.

So git-p4 in git-core effectively converted the perforce utf16 file to
utf8 during import.

However, if I do "p4 print -o filename". Perforce will write the file i=
n
the original utf16 format. I don't need to do the utf8 to utf16 convers=
ion,
which can failed and it does in my case.

The git-p4 in git-core need the same treatment. I will work out a patch
and resubmit that later.

Thanks

Chris
