From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Undefined reference to __builtin_ctzll
Date: Wed, 13 Aug 2014 12:15:44 +0200
Message-ID: <CABPQNSZw4vwhF8m+TWrbuOSaV5ycRGm1oeCu42j96_T+f3xtTg@mail.gmail.com>
References: <CAAC8vw4EzaEM13TWzEW9QUuc-qdZFhPfEA9z1=KjCE0Brzotjg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?0KDQsNC00L7RgdC70LDQsiDQmdC+0LLRh9C10LI=?= 
	<radoslav.tm@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 12:16:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHVbe-0005kb-9r
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 12:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbaHMKQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 06:16:27 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:48260 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbaHMKQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2014 06:16:25 -0400
Received: by mail-ig0-f171.google.com with SMTP id l13so9655971iga.16
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=EDrzs3oO/pP2HKucumaiphSVlH1hmTizI6waqB0DWGc=;
        b=lL0nPgruPGbPrbEXooxGKb5UyZSyh4zimKI2J0P4W5R6HABUUN55LxoLEOujYZPBSw
         wggdHfUcgCiR871Br9+lDuCS5+XP6ore/HmUcGMo0iTXBeBdIosbdsAz0D9y0kgKVnJo
         kNApX06zTVM4DN7UO/Fnbq18QeueUNPcYdaEwuTyOyXkHqIBP7Qdlf8Bx3uV6cFQLG4G
         IcUWLEyGPvjr3vNGybSZValxd64ufxq4X0hnXl0dLrZWOPFLlcs+7CYc1oAJ8dCinA9Q
         ogIhDJMzNrPOUhjDczE6sY0G18YuW9elDBo6zBmDkoMArGPqAEfKXxd148VrwlWLtOpS
         PpSg==
X-Received: by 10.50.4.9 with SMTP id g9mr6152731igg.42.1407924984636; Wed, 13
 Aug 2014 03:16:24 -0700 (PDT)
Received: by 10.64.123.5 with HTTP; Wed, 13 Aug 2014 03:15:44 -0700 (PDT)
In-Reply-To: <CAAC8vw4EzaEM13TWzEW9QUuc-qdZFhPfEA9z1=KjCE0Brzotjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255192>

On Wed, Aug 13, 2014 at 10:36 AM, =D0=A0=D0=B0=D0=B4=D0=BE=D1=81=D0=BB=D0=
=B0=D0=B2 =D0=99=D0=BE=D0=B2=D1=87=D0=B5=D0=B2 <radoslav.tm@gmail.com> =
wrote:
> Dear GIT community,
>
>
> I found myself in situation where I had to install GIT on Debian 3.1
> sarge.  It comes with GCC 3.3.5. I tried to built from source but the
> libgcc was not providing the ctzll function, thus I decided to put an
> implementation.
>
>
> I do not know how to post and do a nice patch (and whether somebody
> will care), but I guess, for reference I can post my solution. Just
> appended in compat/strlcpy.c the following:
>
>
> int __builtin_ctzll (long long x)
> {
>         int i;
>         for (i =3D 0; i < 8 * sizeof (long long); ++i)
>                 if (x & ((long long) 1  << i))
>                         break;
>         return i;
> }
>
>
> I guess that some ifdef macro can be used to detect compiler version
> or missing __builtin_ctzll.

It seems __builtin_ctzll is only available in GCC 3.4.0 and beyond, so
I think a better fix is something like this:

diff --git a/ewah/ewok.h b/ewah/ewok.h
index 43adeb5..2700fa3 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -47,7 +47,7 @@ static inline uint32_t ewah_bit_popcount64(uint64_t x=
)
  return (x * 0x0101010101010101ULL) >> 56;
 }

-#ifdef __GNUC__
+#if (__GNUC__ =3D=3D 3 && __GNUC_MINOR__ >=3D 4) || __GNUC__ > 3
 #define ewah_bit_ctz64(x) __builtin_ctzll(x)
 #else
 static inline int ewah_bit_ctz64(uint64_t x)
