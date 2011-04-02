From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Sat, 2 Apr 2011 14:27:57 +0200
Message-ID: <AANLkTikN=fSNvgmJfT8grBL=zb9fU680=K6H5h6dzWpf@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104012142.22065.j6t@kdbg.org>
 <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
 <201104012218.07872.j6t@kdbg.org> <AANLkTi=ec9azPovJoDVO6kyXEik4uFQu3dZNxAJyvDY=@mail.gmail.com>
 <20110401211649.GA16787@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 02 14:28:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5zwH-0007pm-7s
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 14:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749Ab1DBM2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2011 08:28:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63421 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab1DBM2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2011 08:28:18 -0400
Received: by fxm17 with SMTP id 17so3108408fxm.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oW1ZulxouEbC1hPZRtbY/UuK7DbV1B41fm1/rimJfwc=;
        b=jBC/0DaliOqm4wmcUezV5efP9UhMIpc+NIVqVxy7aSqkJxONexDlis5xEbJKsXns1l
         ZqnrlaglkE3M3DRhkh2QYXDeD5RICfztwTSQQIcMZR9QVgCofsSM/3kXbGeFsB53K+KE
         YW7mCePHRQU4AsPxayj4ePiR0BdLkT1V0siDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=L57hurJ68MLq4EtK73Rc6ez9a9ZMkkqVs+SaJ9xViP7Kka5lXRFnxQZILIXR3kzI3L
         eR4YlIrWMbWflOneeC6kI3xSZaBPtB1l8RufhHeiN8LlwEm2DGYvQQvat7nJFQmlvtLD
         FTLgbLBG/+cd0ShakPiMHR7XgDZ2l/fTDPhDA=
Received: by 10.223.110.21 with SMTP id l21mr2827154fap.70.1301747297075; Sat,
 02 Apr 2011 05:28:17 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Sat, 2 Apr 2011 05:27:57 -0700 (PDT)
In-Reply-To: <20110401211649.GA16787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170648>

On Fri, Apr 1, 2011 at 11:16 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 01, 2011 at 10:31:42PM +0200, Erik Faye-Lund wrote:
>
>> On Fri, Apr 1, 2011 at 10:18 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > On Freitag, 1. April 2011, Erik Faye-Lund wrote:
>> >> On Fri, Apr 1, 2011 at 9:42 PM, Johannes Sixt <j6t@kdbg.org> wrot=
e:
>> >> > But this does not help the case at hand in any way. How would y=
ou
>> >> > interrupt a thread that is blocked in ReadFile()? The point of
>> >> > pthread_cancel() is that it interrupts blocked system calls
>> >>
>> >> There is no mention of such a guarantee in POSIX (section 2.9.5 T=
hread
>> >> Cancellation), so relying on that is undefined behavior.
>> >
>> > In the paragraph before the bulleted list at the end of "Cancellat=
ion Points":
>> >
>> > "...If a thread has cancelability enabled and a cancellation reque=
st is made
>> > with the thread as a target while the thread is suspended at a can=
cellation
>> > point, the thread shall be awakened and the cancellation request s=
hall be
>> > acted upon..."
>> >
>>
>> A blocking thread and a suspended are two different matters. A
>> suspended thread is a thread that has been explicitly suspended by
>> wait, waitpid, sleep, pause etc. These functions explicitly say that
>> they suspend the thread ("shall suspend the calling thread until"),
>> while read etc does not ("shall block the calling thread until").
>>
>> Similarly, making a blocking read/write fail (or terminate mid-way) =
is
>> not the same thing as awakening the thread.
>>
>> I see how some people can read something like this into this section=
,
>> but I think it's pretty clear - this is not what it's talking about.
>> In fact, the more I read the relevant texts, the more convinced I ge=
t
>> that implementations that does terminate read/write strictly speakin=
g
>> is in violation of the standard.
>
> What about the text right before the bit that Johannes quoted:
>
> =A0The side effects of acting upon a cancellation request while suspe=
nded
> =A0during a call of a function are the same as the side effects that =
may
> =A0be seen in a single-threaded program when a call to a function is
> =A0interrupted by a signal and the given function returns [EINTR]. An=
y
> =A0such side effects occur before any cancellation cleanup handlers a=
re
> =A0called.
>

Yeah, this is much closer, because it explicitly defines the behavior
to "fail" in the same way as when a signal interrupts a wait (which is
not simply awakening the thread). The text has the same problem for
this purpose as the one Johannes quoted; it talks about suspension,
not necessarily blocking. But it's mention of side-effects makes me
suspect that they mean blocking when they say suspension in this case,
because none of the functions that are documented as "blocking" seems
to have any side-effects in this case.

So yes, I think this is the most reasonable interpretation of this
paragraph. Thanks for making me re-read it :)

> I agree it would be nicer if it explicitly said "when you are in a
> function which is a cancellation point, pending cancellation requests
> which are delivered are acuted upon immediately".
>
> But it is implied to me by the surrounding text, and it's the only
> sensible behavior IMHO.

I tend to agree with you on this.

> Plus it seems to be what at least glibc pthreads
> does on Linux, so I'm going to assume that people smarter than me
> thought about it and came up with the same interpretation.
>
> My test program was:
>
> -- >8 --
> #include <pthread.h>
> #include <unistd.h>
> #include <stdio.h>
>
> void *child(void *data)
> {
> =A0char buf[32];
> =A0int r;
>
> =A0fprintf(stderr, "child reading from stdin...\n");
> =A0r =3D read(0, buf, sizeof(buf));
> =A0fprintf(stderr, "child read returned %d\n", r);
> =A0return NULL;
> }
>
> int main(void)
> {
> =A0pthread_t t;
> =A0void *r;
>
> =A0pthread_create(&t, NULL, child, NULL);
> =A0sleep(3);
> =A0pthread_cancel(t);
>
> =A0pthread_join(t, &r);
> =A0if (r =3D=3D PTHREAD_CANCELED)
> =A0 =A0fprintf(stderr, "thread was canceled\n");
> =A0else
> =A0 =A0fprintf(stderr, "thread returned %p\n", r);
>
> =A0return 0;
> }
> -- >8 --
>
> If you input something before 3 seconds is up, the thread prints its
> message and returns NULL. But if you let it go, the cancel interrupts
> the read().
>

I'm not sure I agree that measured behavior is the same as defined
operation. But it does support the best theory we have.

So now we're left to figure out how to safely terminate a blocking
read on versions of Windows earlier than Windows Vista. Perhaps just
letting it time-out (assuming it does), and handle the cancellation at
the end of read() is acceptable (when there's no support for
CancelSynchronousIo, that is)? After all, this deadlock hasn't been
observed on threaded implementations making this issue kind of
theoretical on Windows, no? Also, this seems to be roughly how
pthreads-win32 implements cancellation...
