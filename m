From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Wed, 25 Aug 2010 19:40:40 +0200
Message-ID: <AANLkTinboi+L3fvC___pULO0u_ZBNNOM6er+chxt7s07@mail.gmail.com>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
 <40aa078e1002080318n16918f91r5a5f4cd9b76a8436@mail.gmail.com>
 <AANLkTimk+SsmiHk7zWCTEeghk3sYjapDCDeZX=TP9UH_@mail.gmail.com> <201008242124.23890.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 25 19:41:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoJyI-00058o-0e
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 19:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab0HYRlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 13:41:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45873 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0HYRlD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 13:41:03 -0400
Received: by vws3 with SMTP id 3so775033vws.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=OlrETCU5L3AOp26cjwSJ+mD9TPxfhL7X6jo8ocQua3Q=;
        b=RLXUvBaufy5Wo6hmawYcNg1txBlqxakWHV1ml8bUomLBSIOSYzx1kiDjGLArX+aHrA
         LRUUbSYCskkBgTgM7Mna+OPhl53rCrKklCT2MM7jJF5H961yUJSgqFfbYDvzjhteNFKN
         X+t7ETgSd4HrWnC9XkMuIw1jazJpDGy/wlusc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ZNUyjNSdIW5QsQYIQhbRbl/BazYB3MAliBvRpGtUHuq9TfsBF7eFZxdnaRiNo+Iosu
         RI6BHJLvmUhVVCP3pxiUH9qfpPw+w8RUZpZtzHzN8DvMMmBQsZ3DFsEuqGv0sFlPekjQ
         zn28gv9zvuIlfTgRA3psZecWk+VI6Y0q0Q8fs=
Received: by 10.220.88.224 with SMTP id b32mr5351612vcm.217.1282758061441;
 Wed, 25 Aug 2010 10:41:01 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Wed, 25 Aug 2010 10:40:40 -0700 (PDT)
In-Reply-To: <201008242124.23890.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154450>

On Tue, Aug 24, 2010 at 9:24 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Montag, 23. August 2010, Erik Faye-Lund wrote:
>> - The culprit seems to be our poll-emulation. My understanding is th=
at
>> poll() was called by create_pack_file() in upload-pack.c with nfds=3D=
1
>> (it's 2 until one of the fds are closed) when there's no data
>> available in the pipe. Since our poll() always returns POLLIN when
>> nfds=3D1, the check for xread(...) =3D=3D 0 further down in
>> create_pack_file() cause the fd to be closed, leading to an error on
>> the client-side.
>> - =A0Just removing the nfds=3D1-hack works for me, but I'm suspectin=
g the
>> nfds=3D1-hack is there for some socket-reason. So instead I've repla=
ced
>> our poll-emulation with gnulib's in my branch (with a couple of
>> patches on top), and it seems to do the trick for me. I still haven'=
t
>> tested it heavily, though.
>
> The nfds =3D=3D 1 hack is an "optimization": When only one channel mu=
st be
> observed, then we can let (x)read() wait for data instead of doing it=
 inside
> poll() in some way.
>

OK, thanks for the clarification. Unfortunately, this optimization
breaks down in some cases (like the one I described).

> I'm not happy with our poll emulation because it contains a busy-loop=
=2E
> Gnulib's version looks quite capable, but I haven't studied it in det=
ail.
> Until then, I trust that it does the right thing.
>

Well, I've found (and supplied patches for) a couple of bugs in it,
but apart from that it seems quite sane. So yeah, I think it might be
the best way forward.

But I'm curious, what's the best way of import a couple of foreign
source files, while maintaining a couple of patches on top of them?
I'm thinking that perhaps a import-commit followed by the patches
would make it easier to merge in changes than to just import the
patched version, but I'm not entirely sure how to do such a merge
without merging a full subtree...
