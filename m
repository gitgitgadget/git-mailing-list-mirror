From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 4/4] use wrapper for unchecked setenv/putenv calls
Date: Thu, 15 Dec 2011 19:04:21 +0100
Message-ID: <CABPQNSY+Q=Dt8oKodJMqRRb+ADdfDgQTxWKDfOpHvb5L9J=vvw@mail.gmail.com>
References: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
 <1323871631-2872-5-git-send-email-kusmabite@gmail.com> <20111214181658.GA1691@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, schwab@linux-m68k.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 19:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbFgH-0002OG-Ir
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 19:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759025Ab1LOSFD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 13:05:03 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57964 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab1LOSFC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2011 13:05:02 -0500
Received: by dajs34 with SMTP id s34so1508798daj.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 10:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=jkSE8BAaioZ1+YBYDCq+Bxvw62P+jfIn6DUoma2fxOY=;
        b=dYmkm5+79DorrCaZ1UCr2+QAT++jAE7utmrPRwhHnw+HCz8OaK4PjH/p96V7EvlVIw
         kUPdsN+kJnY9+LthGwwB//03WFlJmni/ZXzvoI6GAJ1p45kjVoNSLlIJEHKEryRHtsey
         k0FG6f3Qg4a5aCRB18LmStDHrQGrgkr/hBpR8=
Received: by 10.68.72.9 with SMTP id z9mr11298816pbu.124.1323972302290; Thu,
 15 Dec 2011 10:05:02 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Thu, 15 Dec 2011 10:04:21 -0800 (PST)
In-Reply-To: <20111214181658.GA1691@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187217>

On Wed, Dec 14, 2011 at 7:16 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 14, 2011 at 03:07:11PM +0100, Erik Faye-Lund wrote:
>
>> This avoids us from accidentally dropping state, possibly leading
>> to unexpected behaviour.
>
> I do think this is fine in a "be extra cautious" kind of way.
>
>> This is especially important on Windows, where the maximum size of
>> the environment is 32 kB.
>
> But does your patch actually detect that? As Andreas pointed out, the=
se
> limits don't typically come into play at setenv time. Instead, the
> environment is allocated on the heap, and then the result is passed t=
o
> exec/spawn, which will fail.
>
> So your patch is really detecting a failure to malloc, not an overflo=
w
> of the environment size, and Windows is just as (un)likely to run out=
 of
> heap as any other platform.
>

You are right; I just assumed that our setenv was implemented on top
of SetEnvironmentVariable, which does impose max-limits on setting (if
I read the documentation correctly):
http://msdn.microsoft.com/en-us/library/windows/desktop/ms686206(v=3Dvs=
=2E85).aspx

But we don't. We have mingw_setenv, which simply modifies environ.

> You can check how your platform behaves by applying this patch:
>
> diff --git a/git.c b/git.c
> index f10e434..57f6b12 100644
> --- a/git.c
> +++ b/git.c
> @@ -223,6 +223,16 @@ static int handle_alias(int *argcp, const char *=
**argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0alias_=
argv[i] =3D (*argv)[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0alias_argv[argc] =3D N=
ULL;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* make gigantic enviro=
nment */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len=
 =3D 256 * 1024;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *b=
uf =3D xmalloc(len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(=
buf, 'z', len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[len=
-1] =3D '\0';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (set=
env("FOO", buf, 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 die("setenv failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D run_command_v_=
opt(alias_argv, RUN_USING_SHELL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret >=3D 0) =A0 /*=
 normal exit */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(r=
et);
>
> and then running:
>
> =A0git -c alias.foo=3D'!echo ok' foo
>
> which yields:
>
> =A0fatal: cannot exec 'echo ok': Argument list too long
>
> on Linux.
>

Yeah, but I'm getting:
$ git -c alias.foo=3D'!echo ok' foo
ok

Which is strange to me.

But if I do:
$ git -c alias.foo=3D'!echo $FOO' foo

it does echo a bunch of 'z's. And we get the expected amount:
$ git -c alias.foo=3D'!echo $FOO' foo | wc -c
 262144

This strikes me as very strange, because we end up calling the ANSI
version of CreateProcess with an environment-block beyond 32767 chars,
which MSDN says should fail:

"The ANSI version of this function, CreateProcessA fails if the total
size of the environment block for the process exceeds 32,767
characters."

http://msdn.microsoft.com/en-us/library/windows/desktop/ms682425(v=3Dvs=
=2E85).aspx

Oh well, this is strange behavior in a good way; I'm not going to compl=
ain :P
