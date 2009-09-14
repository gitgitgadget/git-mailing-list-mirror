From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 13:40:02 +0200
Message-ID: <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
	 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
	 <20090914105750.GB9216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 13:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn9uk-0007wz-Q0
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 13:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZINLkB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2009 07:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZINLkA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 07:40:00 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:65256 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZINLkA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2009 07:40:00 -0400
Received: by bwz19 with SMTP id 19so2007425bwz.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8EWThg3zC7cWNEzDdYAoQZ0OsbAThvsCFlQdn8DxJWg=;
        b=SKvsn9oCwueR/mVPzhmfFclpeSWp2cxrIXJferGOeZ/KSpDBPTiTIqQlq4wPdCZP7K
         9FLy8jMIDgtvm2MK5OG8b9np35dr7hwuS3X+wXQbgLxq5Xyjc8jRNG45doJCZTkuPzkK
         jke2BIomnticXaGzBAr5yjPr4uVMf2fjKWjTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PutZ+s3k2OUQaKV9cOWhbdZfSA18o5Npisa79K7Rp2EOxCdeP4RtncArnfxtBqPKH1
         rVdoF1NGV1vVVpegLRNZpBq9X3P5iTFNnZWI67durwUsf+Y3M1DBxJ0atROogFWitTcU
         oAOOH2qps0YQl3r7/6e+trYUjLFnk9msUiOZk=
Received: by 10.204.25.73 with SMTP id y9mr5097362bkb.40.1252928402312; Mon, 
	14 Sep 2009 04:40:02 -0700 (PDT)
In-Reply-To: <20090914105750.GB9216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128447>

On Mon, Sep 14, 2009 at 12:57 PM, Jeff King <peff@peff.net> wrote:
>
> I didn't see a patch 1/2, so maybe it impacts this in some way, but b=
y
> itself, I don't think this patch is a good idea. See below.

That's odd. It's listed in my git-folder on GMail as sent to the
mailing-list, but I can't find it in any of the list-archives. They
were both sent through the same instance of "git send-email". I guess
I'll just re-send it. It shouldn't affect this patch directly, though.

The patch basically moved the NORETURN before the function-name, as
this is a placement where more compilers supports
declaration-specifications.

>> ---
>>
>> __attribute__((noreturn)) is, according to the GCC documentation, ab=
out
>> two things: code generation (performance, really) and warnings.
>>
>> On the warnings-side, we need to keep the code warning-free for
>> compilers who doesn't support noreturn anyway, so hiding potential
>> warnings through this mechanism is probably not a good idea in the
>> first place.
>
> [Your justification text would almost certainly be useful as part of =
the
> commit message itself, and should go there.]

OK, I'll include it in the next round.

> Unfortunately, this patch _introduces_ warnings when running with gcc=
,
> as it now thinks those function pointers return (which means it think=
s
> die() returns). So simply removing the NORETURN is not a good idea.

Yeah, this is unacceptable. I can't believe I missed this - sorry about=
 that!

> If I understand you correctly, the problem is that there are actually
> three classes of compilers:
>
> =A01. Ones which understand some NORETURN syntax for both functions a=
nd
> =A0 =A0 function pointers, and correctly trace returns through both (=
e.g.,
> =A0 =A0 gcc).
>
> =A02. Ones which understand some NORETURN syntax for just functions, =
and
> =A0 =A0 complain about it on function pointers. We currently turn off
> =A0 =A0 NORETURN for these compilers (from your commit message, MSVC,
> =A0 =A0 for example).
>
> =A03. Ones which have no concept of NORETURN at all.
>
> I think the right solution to turn on NORETURN for (2) is to split it
> into two cases: NORETURN and NORETURN_PTR. Gcc platforms can define b=
oth
> identically, platforms under (2) above can define NORETURN_PTR as emp=
ty,
> and (3) will keep both off.

Yeah, this could work. I initially suggested doing this, but Junio
suggested removing NORETURN all together. I didn't think that was a
good idea for die() etc, thus this patch.

> I do have to wonder, though. What do compilers that fall under (2) do
> with calls to function pointers from NORETURN functions? Do they assu=
me
> they don't return, or that they do? Or do they not check that NORETUR=
N
> functions actually don't return?
>
> I.e., what does this program do under MSVC:
>
> #include <stdlib.h>
> void (*exit_fun)(int) =3D exit;
> static void die(void) __attribute__((__noreturn__));
> static void die(void) { exit_fun(1); }
> int main(void) { die(); }

Well, it fails to compile ;)

If your change it around this way (which is basically what 1/2 + a
separate patch that is cooking in msysgit for a litte while longer is
supposed to do), it does compiles without warnings even on the highest
warning level:

-static void die(void) __attribute__((__noreturn__));
+static void __declspec(noreturn) die(void);

> In gcc, it rightly complains:
>
> =A0foo.c: In function =91die=92:
> =A0foo.c:4: warning: =91noreturn=92 function does return

Yeah. So we need a portable (enough) way of showing it that it does
die. How about abort()?

-static void die(void) { exit_fun(1); }
+static void die(void) { exit_fun(1); abort(); }

Adding abort() makes the warning go away here, at least. And reaching
this point is an error anyway, it means that one of the functions
passed to set_die_routine() does not hold up it's guarantees. Your
suggestion (double defines) would make this a compile-time warning
instead of a run-time error, which I find much more elegant. However,
it's questionable how much this means in reality - there's only two
call-sites for set_die_routine() ATM. Do we expect it to grow a lot?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
