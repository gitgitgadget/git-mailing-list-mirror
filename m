From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] match_basename: use strncmp instead of strcmp
Date: Sat, 9 Mar 2013 16:58:39 +0700
Message-ID: <CACsJy8D-ZJrC7n5ky9sc_UoenOLTg0h6tEczp=-U9ppn820P-g@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362802190-7331-4-git-send-email-pclouds@gmail.com> <7v4nglf1w3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 10:59:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEGZA-00045l-7U
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 10:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab3CIJ7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Mar 2013 04:59:12 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:41916 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab3CIJ7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Mar 2013 04:59:11 -0500
Received: by mail-la0-f41.google.com with SMTP id fo12so2490282lab.28
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=KMy49r7BYkwZJmW93GRl8ICHg3IVGkz1dTCKD6oXJKM=;
        b=ShPRKRZLv7fzVwiK/U1Qw6hbAKXZzqrPEmqo7HMwI0FDn/s59A7lMTzN4PepIFwqUt
         toEkJXxdG53kElyUl5tbw2nCPo02316m/bG0BvYH4+NP82thWM6yGu0/iAvpnESxv7h9
         hhmvc19xoS9g0at+YPmZRlpLuHKXk5WLKLe+l2gpVgf9m28Yei2s1jdqxwS3Gd2FcgMv
         wSmi9usN9aD/XBakymS2UjUYAlGsidq8esZUXIzshMRRV5Wn3r/DL0pmDZabyU9+Qf67
         b6FDWsYSA75zJAdsSWmoNRjEsaZUk4kcJJ9tI0sVylni4J2dEYzGlmGOVKoDlSG1tXKn
         EFJQ==
X-Received: by 10.112.39.106 with SMTP id o10mr2233450lbk.23.1362823149430;
 Sat, 09 Mar 2013 01:59:09 -0800 (PST)
Received: by 10.114.25.226 with HTTP; Sat, 9 Mar 2013 01:58:39 -0800 (PST)
In-Reply-To: <7v4nglf1w3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217716>

On Sat, Mar 9, 2013 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> strncmp provides length information, compared to strcmp, which could
>> be taken advantage by the implementation. Even better, we could chec=
k
>> if the lengths are equal before calling strncmp, eliminating a bit o=
f
>> strncmp calls.
>
> I think I am a bit slower than my usual self tonight, but I am
> utterly confused by the above.
>
> strncmp() compares _only_ up to the first n bytes, so when you are
> using it for equality, it is not "we could check length", but is "we
> MUST check they match to the length of the shorter string", if you
> want to obtain not just faster but correct result.
>
> Am I mistaken?

Yeap, the description is a bit misleading. Although you could get away
with length check by doing !strncmp(a, b, strlen(a)+1).

> Even if you are using strcmp() that yields ordering not just
> equality, it can return a correct result as soon as it hits the
> first bytes that are different; I doubt using strncmp() contributes
> to the performance very much.  Comparing lengths before doing
> byte-for-byte comparison could help because you can reject two
> strings with different lengths without looking at them.
>
> At the same time, I wonder if we can take advantage of the fact that
> these call sites only care about equality and not ordering.

I tried to push it further and compare hash before do the actual
string comparison. It slowed things down (hopefully because the cost
of hashing, the same one from name-hash.c, not because I did it
wrong).
--=20
Duy
