From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Wed, 19 Mar 2014 17:28:27 +0700
Message-ID: <CACsJy8A7ESSjfHqr96_yYjNsE-A1Sf=8+rmRfGrjML0+fCWTTg@mail.gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
 <CACsJy8BOZa6vJU_s9sxYrtSdpL-4PDTpbo6r6TC8z2LD1GtkMQ@mail.gmail.com> <CAHOQ7J_Wmjo6AJRQra2UDWX3WRboD+-4SaGCHYOUgRR+NyUX4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 11:29:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQDkZ-0004wU-4L
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 11:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933825AbaCSK30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 06:29:26 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:50172 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933797AbaCSK26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 06:28:58 -0400
Received: by mail-qc0-f169.google.com with SMTP id i17so9469224qcy.14
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hfoOf5c2G8GHxMAfiQzHraJTG9UgEN7AGXCnip5U4aQ=;
        b=RGt9p8vu+T2tSucaNRIWhbPQ5onMP/GfxHfaPrhBfimZj+uZI9fclgnliuDtiaLLSu
         /TmUPxMXN2gpe2prKjlhQ6VOaOgFTTpwloOJy8Ljqsf7Z+m283er0irJGHXpzTZT1wPq
         Dc+dNTPv7aDdqCsqPbdrH54J5UcnWe5MxI/D/xrKMQu6/Af2uOlPbaLwdXDPp73kbGiM
         tVk/6IbzyYTCkLrXwVaUaarEA8U4wX/kLnC/qRv2DNNYMnHuHNxnYy+tNpRjto7QgKqo
         MbLI0EDkW2gprZ/lhnF8MVj4o7GKj2ZHwkHEssMcsGIyg4Cm4EZKTIuAUTQYUNWSyNhX
         XXZg==
X-Received: by 10.140.40.5 with SMTP id w5mr39201143qgw.65.1395224937560; Wed,
 19 Mar 2014 03:28:57 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Wed, 19 Mar 2014 03:28:27 -0700 (PDT)
In-Reply-To: <CAHOQ7J_Wmjo6AJRQra2UDWX3WRboD+-4SaGCHYOUgRR+NyUX4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244428>

On Wed, Mar 19, 2014 at 2:50 PM, Stefan Zager <szager@chromium.org> wrote:
> On Wed, Mar 19, 2014 at 12:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Mar 19, 2014 at 7:46 AM,  <szager@chromium.org> wrote:
>>> This adds a Windows implementation of pread.  Note that it is NOT
>>> safe to intersperse calls to read() and pread() on a file
>>> descriptor.  According to the ReadFile spec, using the 'overlapped'
>>> argument should not affect the implicit position pointer of the
>>> descriptor.  Experiments have shown that this is, in fact, a lie.
>>
>> If I understand it correctly, new pread() is added because
>> compat/pread.c does not work because of some other read() in between?
>> Where are those read() (I can only see one in index-pack.c, but there
>> could be some hidden read()..)
>
> I *think* it's the call to fixup_pack_header_footer(), but I'm not 100% sure.
>
> I suppose it would be possible to fix the immediate problem just by
> using one fd per thread, without a new pread implementation.  But it
> seems better overall to have a pread() implementation that is
> thread-safe as long as read() and pread() aren't interspersed; and
> then convert all existing read() calls to pread().  That would be a
> good follow-up patch...

I still don't understand how compat/pread.c does not work with pack_fd
per thread. I don't have Windows to test, but I forced compat/pread.c
on on Linux with similar pack_fd changes and it worked fine, helgrind
only complained about progress.c.

A pread() implementation that is thread-safe with condition sounds
like an invite for trouble later. And I don't think converting read()
to pread() is a good idea. Platforms that rely on pread() will hit
first because of more use of compat/pread.c. read() seeks while
pread() does not, so we have to audit more code..
-- 
Duy
