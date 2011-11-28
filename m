From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/6] echo usernames as they are typed
Date: Mon, 28 Nov 2011 10:36:21 +0100
Message-ID: <CABPQNSbLvWh-ivaqBk-Du+kwZvV3t+ajEJhHATRzyGZbHYyM=Q@mail.gmail.com>
References: <20111124105801.GA6168@sigill.intra.peff.net> <20111127082744.GA32068@sigill.intra.peff.net>
 <CABPQNSb09kxjvdvz2P-WqU2VtMspaaA8ujTNLJ4+MuCrV=2zsw@mail.gmail.com> <20111128035321.GA15640@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 10:37:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUxeB-0003tf-C8
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 10:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab1K1JhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 04:37:04 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33558 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab1K1JhD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 04:37:03 -0500
Received: by yenl6 with SMTP id l6so2650225yen.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=S9NFk8A7Af/jb7Py69U8c8XXyp+V5hd9RPWXWwucBaM=;
        b=UYRBttk63QRZy0Fxi1UmX3x0T2Pj/owbeFcPcRK+x5K6SclWHgPR4yL//DunCgKwTJ
         V87OtlvyIQwRhZecliIZi0pXMGmy0yDVvxT7XE8PClsfQPp3RjnJlEkin8JSq0H8G/5z
         SwxXfi64bk8vd+gkDpKATgTjbcH1fwUNr20Eo=
Received: by 10.68.199.131 with SMTP id jk3mr52018447pbc.105.1322473022123;
 Mon, 28 Nov 2011 01:37:02 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Mon, 28 Nov 2011 01:36:21 -0800 (PST)
In-Reply-To: <20111128035321.GA15640@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186007>

On Mon, Nov 28, 2011 at 4:53 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 27, 2011 at 10:17:26AM +0100, Erik Faye-Lund wrote:
>
>> > And here's something I've been meaning to do on top: actually echo
>> > characters at the username prompt. We can't do this portably, but =
we can
>> > at least stub out a compatibility layer and let each system do som=
ething
>> > sensible.
>>
>> Interesting, I've been working on something pretty similar: getting
>> rid of getpass usage all together:
>>
>> https://github.com/kusma/git/tree/work/askpass
>>
>> My reason to write a getpass replacement was to avoid capping input =
to
>> PASS_MAX, which can be as low as 8 characters (and AFAIK is just tha=
t
>> on Solaris)...
>
> Yeah, if there are really bad getpass implementations, we would want =
to
> work around them. If we are going to do so, it might make sense to
> combine the effort with my getpass_echo wrapper, as they are really t=
he
> same function, modulo tweaking the echo settings.
>

My thinking exactly ;)

> It would also be nice to make getpass a little more predictable. If
> /dev/tty can't be opened, glibc's getpass will fall back to writing t=
he
> prompt to stderr and reading the password from stdin. But we definite=
ly
> don't want to do that in git-remote-curl, where stdin is already talk=
ing
> a special protocol with the parent fetch process.
>
> So I think it might be best to just write our own getpass. However,
> your implementation looks wrong to me:
>

It probably is, yes. It was a very naive attempt ;)

>> diff --git a/password.c b/password.c
>> new file mode 100644
>> index 0000000..727ed84
>> --- /dev/null
>> +++ b/password.c
>> @@ -0,0 +1,94 @@
>> +#include "cache.h"
>> +#include "git-compat-util.h"
>> +#include "strbuf.h"
>> +#include "run-command.h"
>> +
>> +#ifndef WIN32
>> +
>> +static void ask_password(struct strbuf *sb, const char *prompt)
>> +{
>> + =A0 =A0 struct termios attr;
>> + =A0 =A0 tcflag_t c_lflag;
>> +
>> + =A0 =A0 if (tcgetattr(1, &attr) < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("tcgetattr failed!");
>> + =A0 =A0 c_lflag =3D attr.c_lflag;
>
> This is getting the terminal attributes for stdout. But in many
> cases, stdout will not be connected to the terminal (in particular,
> remote-curl, as I mentioned above, will have its stdio connected to t=
he
> parent fetch process). =A0Stderr is a better guess, as you do here:
>
>> + =A0 =A0 fputs(prompt, stderr);
>
> but even that is not foolproof. With getpass(), this should work:
>
> =A0git clone ... 2>errors
>
> with the prompt going to the terminal. But it doesn't with your patch=
=2E
>
> You really want to open "/dev/tty" on most Unix systems (which is wha=
t
> getpass() does).

Yes, you're right. Opening "/dev/tty" is much better. But what happens
for processes started by GUI applications (with no easily observable
tty, if any)? Does open simply fail? If so, is it desirable for us to
fail in that case?

> I have no idea what would be appropriate on Windows.
>

It's pretty similar, but not exactly: CreateFile("CONIN$", ...) or
CreateFile("CONOUT$", ...), depending on if you want the read-handle
or the write-handle... I can probably cook up something a bit more
concrete, though.

But _getch() that we already use always reads from the console
(according to MSDN, I haven't actually tested this myself:
http://msdn.microsoft.com/en-us/library/078sfkak%28v=3DVS.80%29.aspx).
But I don't think this allows us to fail when no console is attached.
Question is, should we fail in such cases? Windows does have an API to
prompt for passwords in a GUI window... Perhaps fallbacking to those
are the way to go? Something like:

if (GetConsoleWindow()) {
	/*  normal console-stuff */
} else {
	/* call CredUIPromptForWindowsCredentials(...) instead */
}

This might be nicer towards GUI tools, but it requires us to
explicitly ask for a password (and possibly a username at the same
time)...

>> + =A0 =A0 for (;;) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int c =3D getchar();
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (c =3D=3D EOF || c =3D=3D '\n')
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addch(sb, c);
>> + =A0 =A0 }
>
> And this is even worse. You're reading from stdin, which will get
> whatever cruft is in the pipe coming from the parent process (or may
> even cause a hang, as the parent is probably blocking waiting to read
> from the child helper).
>

Yeah, thanks for pointing these glitches out ;)
