From: Anthony Foiani <anthony.foiani@gmail.com>
Subject: Re: [PATCH] Improve errors from 'git diff --no-index'.
Date: Sun, 22 May 2011 20:35:40 -0600
Message-ID: <BANLkTinKpSP5oEms914TWD7Tsjab1B87QQ@mail.gmail.com>
References: <4dd98da1.1bf98e0a.4eb4.6fc5@mx.google.com>
	<7vlixyw4cx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 04:35:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOKzj-00025D-Bh
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 04:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab1EWCfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 22:35:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62682 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670Ab1EWCfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2011 22:35:41 -0400
Received: by bwz15 with SMTP id 15so4344139bwz.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 19:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a9mhxTwBLnRK45Q9fnBOWVNuF5vwUhHwCmIwkmCO37U=;
        b=mggYTEyadBGIY9Di9akoagOe8wcyPY6U+GRCCipnL2HnoYjkajlomsc3d70hsEBaV2
         VTG2xpaILANHq7ffd8w4eiY795zO/NPswd6RS3ZTifHGYSqYRXWu0jagkqM8iDr1r2zU
         kDwS/TNB5XfPkZ6XzvLUk7EZsy+gDj8S+Ywjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=evl+yqhIpgXo03BNWZL75C6Bf6jgTjhPWMwlbvm1odnRazVzirM1HeQJfQCENHuMLE
         u8NHgmO7xu0KPC4xSk/MV+oj9l137jx/8tYuaxeJkl58/pgOSpH8n479+J/i+vb+CNIB
         nMBTgRgCcu15CNx0yB8nrSIXVDwZGCOwrbdtI=
Received: by 10.204.25.66 with SMTP id y2mr1658140bkb.153.1306118140472; Sun,
 22 May 2011 19:35:40 -0700 (PDT)
Received: by 10.204.181.68 with HTTP; Sun, 22 May 2011 19:35:40 -0700 (PDT)
In-Reply-To: <7vlixyw4cx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174220>

Junio --

On Sun, May 22, 2011 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Anthony Foiani <anthony.foiani@gmail.com> writes:
>
>> I accidentally tried to use "git diff" when I wasn't within a git
>> repository, only to be confused by getting a usage message with no
>> particular error output.
>
> I do not understand this at all.
>
> =C2=A0 =C2=A0$ cd /
> =C2=A0 =C2=A0$ git diff
> =C2=A0 =C2=A0usage: git diff [--no-index] <path> <path>
>
> What's unclear about it?

It's hard for me to explain right now, as I just spent a few hours
figuring out exactly what "git diff" assumed would happen.  And now
that I have done that study, I would not need anything beyond the
original error message, either.

But when I screwed up earlier today, I was somewhat taken aback by the
fact that I kept on getting the same usage message with no indication
of what the heck I was doing wrong:

$ git diff -b main.c
usage: git diff [--no-index] <path> <path>
$ git diff --cached -b main.c
usage: git diff [--no-index] <path> <path>
$ git diff -b HEAD -- main.c
usage: git diff [--no-index] <path> <path>
$ git diff -b -- main.c
usage: git diff [--no-index] <path> <path>

It would have saved me a chunk of time to have one of my diagnostics
(in this case, "not in a git repo") to knock some sense into me
earlier.

*shrug* Toss it in the bit-bucket if you like, but the work's already
been done. And I happen to find the new code more readable than the
previous triple-negative and de Morgan's-expanded conditionals, but
that's of course personal taste.

=46or that matter, the existing code was already doing many of these
checks, but not communicating the results back in any way other than
presenting a usage string. I apparently interpreted that as "you're
calling me wrong", not "you're using me wrong".

There might be a bug even in the previous code, though: there's an odd
early exit from 'path_outside_repo' for absolute pathnames, but I got
lost in the multiple negations and could never quite convince myself
of its correctness (or lack thereof).

Either way, thanks for all your work on git!

Best regards,
Tony
