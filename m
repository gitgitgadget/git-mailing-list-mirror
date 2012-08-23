From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Support generate poison .mo files for testing
Date: Thu, 23 Aug 2012 18:00:57 +0700
Message-ID: <CACsJy8Ak0iR9WytPys1uy=M52TVh+0y4DWrv63Efvie4nsRORA@mail.gmail.com>
References: <7va9xofbgo.fsf@alter.siamese.dyndns.org> <1345613246-4053-1-git-send-email-pclouds@gmail.com>
 <7vtxvuand1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 13:01:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4VAN-0001PN-OH
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 13:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369Ab2HWLBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 07:01:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39015 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030351Ab2HWLB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 07:01:28 -0400
Received: by ialo24 with SMTP id o24so1114347ial.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=upTwm2saB8RoNAT77HMTD/w5yleJJuzZmzyd6Re4jlY=;
        b=J7eiHUm7PHeRjhK4BA7aP9ZA8KArjP/qWf/hDaUYQ0Lb+dm8TapIQrS1CJ9c38laBc
         Pt5c+7jJO5k8qd6TGJiChpDSVRp65ywHJcQqxfbO/2TCm7tEN3pwEJIrJ4gGewmcrfTw
         DtnvXGcGJlUpnIUAgh1/GnaEuvQHl+CctZ/YDmJqt/tZ8vy6n6Jbu/Bx/KEfJqnfJLj1
         qxNlVeHzghem1JghJrP5BEmXBrQ3GamwUHMo5r4dhKvUvWW3eNXun9XIXFV/grNRFZVN
         tBUcKeHHq9ND6/OHkcSDV3y+ysUK5GWZk/pDr7OOdNOkLy7VDWal1hyEmkMTaUFQ4ZfS
         9MuA==
Received: by 10.42.60.139 with SMTP id q11mr814924ich.53.1345719688032; Thu,
 23 Aug 2012 04:01:28 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Thu, 23 Aug 2012 04:00:57 -0700 (PDT)
In-Reply-To: <7vtxvuand1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204146>

On Wed, Aug 22, 2012 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> why are you special casing a run of non-blank letters that begin
> with a dollar sign (swapping two ints is done with "%2$d %1$d", a
> percent still at the beginning, so there must be something else I am
> missing)?

'$' is for shell variables. I should separate it from C messages. All
these because now that we run the (fake) translation through gettext
toolchain, it'll catch us if we don't preserve dynamic parts
correctly.

> Also why do you stop at isspace()?  Isn't a " " (space) a flag that
> means "If the first character of a signed conversion is not a sign
> or if a signed conversion results in no characters, a <space> shall
> be prefixed to the result."

A hurry attempt to get past msgfmt. I should refine these code, either by...

> As the flags, min-width, precision, and length do not share the same
> character as the conversion that has to come at the end, I think you
> only want to do something like
>
>         /*
>          * conversion specifier characters, taken from:
>          * http://pubs.opengroup.org/onlinepubs/9699919799/functions/printf.html
>          */
>         static const char printf_conversion[] = "diouxXfFeEgGaAcspnCS%";
>
>         ...
>
>         while (msg < end) {
>                 if (*msg == '%') {
>                         strbuf_addch(buf, *msg++);
>                         while (msg < end) {
>                                 int ch = *msg++;
>                                 strbuf_addch(buf, ch);
>                                 if (strchr(printf_conversion, ch))
>                                         break;
>                         }
>                         /* copied the printf part literally */
>                         continue;
>                 }
>                 ... keep \n ...
>                 ... muck with string ...
>         }
>
> perhaps?

following this, or copying the matching logic from msgfmt source.
-- 
Duy
