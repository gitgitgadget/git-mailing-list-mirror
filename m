From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 02/11] strbuf: add non-variadic function 
	strbuf_vaddf()
Date: Fri, 27 Nov 2009 00:37:27 +0100
Message-ID: <40aa078e0911261537r40b19dffqf019848dcad23fef@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
	 <7vskc2ksnn.fsf@alter.siamese.dyndns.org>
	 <40aa078e0911260238rd0c90cag126709d1de5f50de@mail.gmail.com>
	 <7vbpip86q5.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	dotzenlabs@gmail.com, Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 00:37:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDnu3-0005Wo-IR
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 00:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZKZXhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 18:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbZKZXhX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 18:37:23 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:38980 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZKZXhW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 18:37:22 -0500
Received: by ewy19 with SMTP id 19so944136ewy.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 15:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vMeRYIIoiZlfX+7e5Wh76XblmMGdEJbyAPHVs1m3URE=;
        b=YPppYoiwWCF5NZUTt51RvV2k9IiISvGu8uZCVkzET0+kIsrhoX/e+NpRleMA417WYO
         or71UL4apgNy903dxqyOubZQmdnX6nfi/K3tmLXeiCXNNN0GImP7FD0yX/IJWd/bjUMt
         Fnjp7hAsLyAmvVsxNBjHuljFny9jzDyNYieVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=NiGYkX69PSOjUm9I8G9rbD7kjp0egkk90Kpkc5QxcOxzyW+QKjEMPNVg0AVcf3acUR
         cJvsdbRH4zs9v/BV/98Tiwy62a+Kwgj7enjCCjoy+ybt9tPnS0afpmYG3pzkJbNKqhWS
         JcthM878QUCx/Zkbic+1c61je8PbnIx4r9oTc=
Received: by 10.216.89.137 with SMTP id c9mr95464wef.228.1259278647275; Thu, 
	26 Nov 2009 15:37:27 -0800 (PST)
In-Reply-To: <7vbpip86q5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133848>

On Thu, Nov 26, 2009 at 7:46 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>> In practice it seems that something like the following works
>> portably-enough for many applications, dunno if it's something we'll
>> be happy with:
>> #ifndef va_copy
>> #define va_copy(a,b) ((a) =3D (b))
>> #endif
>
> Since an obvious implementation of va_list would be to make it a poin=
ter
> into the stack frame, doing the above would work on many systems. =A0=
On
> esoteric systems that needs something different (e.g. where va_list i=
s
> implemented as a size-1 array of pointers, va_copy(a,b) needs to be a=
n
> assignment (*(a) =3D *(b))), people can add compatibility macro later=
=2E
>
> Historically some systems that do have a suitable implementation had =
it
> under the name __va_copy() instead, so it would have been better to d=
efine
> it as something like:
>
> =A0 =A0#ifndef va_copy
> =A0 =A0# ifdef __va_copy
> =A0 =A0# define va_copy(a,b) __va_copy(a,b)
> =A0 =A0# else
> =A0 =A0# /* fallback for the most obvious implementation of va_list *=
/
> =A0 =A0# define va_copy(a,b) ((a) =3D (b))
> =A0 =A0# endif
> =A0 =A0#endif
>
> But I do not know it still matters in practice anymore.

Perhaps I can do one better: use memcpy instead of standard
assignment. The Autoconf manual[1] suggests that it's more portable.
Something like this:

#ifndef va_copy
# ifdef __va_copy
#  define va_copy(a,b) __va_copy(a,b)
# else
#  define va_copy(a,b) memcpy(&a, &b, sizeof (va_list))
# endif
#endif

I'll add this to git-compat-util.h this for the next round unless
someone yells really loud at me.

*[1] http://www.gnu.org/software/hello/manual/autoconf/Function-Portabi=
lity.html#index-g_t_0040code_007bva_005fcopy_007d-357
--=20
Erik "kusma" Faye-Lund
