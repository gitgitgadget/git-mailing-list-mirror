From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Wed, 20 Nov 2013 11:15:47 +0100
Message-ID: <CABPQNSaWTMCeCCnxkRV-Cri7-iQrRknHfJvvN_2Rs9V51OS81w@mail.gmail.com>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
 <7v4nffpbct.fsf@alter.siamese.dyndns.org> <CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
 <7vbo8j600q.fsf@alter.siamese.dyndns.org> <CAEDE8507jPW4sKW7-xX5-+3YpFgfzkXzeskCNRrD7T6ynxgdNA@mail.gmail.com>
 <7va9o2zba9.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Filipe Cabecinhas <filcab@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 11:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj4pl-0007d1-Hj
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 11:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab3KTKQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 05:16:29 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:47557 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab3KTKQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 05:16:28 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so5851899ieb.39
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZpzeqZWNdSi9sGENrtvlikMk/9EGuUJZebMmc0Af2kI=;
        b=w8Vd3Cj0gW2o0SG9NWStUAcleB4rWLsIsh1Xutkwi0gBdByapgXNPTOt3ulieNn2at
         +UfBYYbtokL+S1+7CNwwMmYhZEPKSB5iXsHBHsMWJf4XgpCbG+xXCogZI7fkvyeQrKBi
         QGCYgttAzgdpIZiQ5sabmwTGCXY7FImWhGFpcg//b0eeEIUBqRHV0E2L4t6Wzp3wlycB
         MNFvHrR6goNAwRKJVu0fu9fkHqc2z4RI/l3d8Z3HGVFTJ53JQhSPsF33cWLGCVUszGBY
         3QwfpBOSa5ReEYIlzkUn59CvWONW0QaT1vWnFX7h7H3IsBAWE8O8u50QO4jtrpgrthDi
         6ByQ==
X-Received: by 10.50.17.9 with SMTP id k9mr392594igd.3.1384942587722; Wed, 20
 Nov 2013 02:16:27 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Wed, 20 Nov 2013 02:15:47 -0800 (PST)
In-Reply-To: <7va9o2zba9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238069>

I know I'm extremely late to the party, and this patch has already
landed, but...

On Sat, May 11, 2013 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Filipe Cabecinhas <filcab@gmail.com> writes:
>
>> Due to a bug in the Darwin kernel, write() calls have a maximum size of
>> INT_MAX bytes.
>>
>> This patch introduces a new compat function: clipped_write
>> This function behaves the same as write() but will write, at most, INT_MAX
>> characters.
>> It may be necessary to include this function on Windows, too.

We are already doing something similar for Windows in mingw_write (see
compat/mingw.c), but with a much smaller size.

It feels a bit pointless to duplicate this logic.

> diff --git a/compat/clipped-write.c b/compat/clipped-write.c
> new file mode 100644
> index 0000000..9183698
> --- /dev/null
> +++ b/compat/clipped-write.c
> @@ -0,0 +1,13 @@
> +#include <limits.h>
> +#include <unistd.h>
> +
> +/*
> + * Version of write that will write at most INT_MAX bytes.
> + * Workaround a xnu bug on Mac OS X
> + */
> +ssize_t clipped_write(int fildes, const void *buf, size_t nbyte)
> +{
> +       if (nbyte > INT_MAX)
> +               nbyte = INT_MAX;
> +       return write(fildes, buf, nbyte);
> +}

If we were to reuse this logic with Windows, we'd need to have some
way of overriding the max-size of the write.
