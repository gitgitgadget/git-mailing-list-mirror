From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 21:33:46 +0200
Message-ID: <AANLkTimk4cLDjj0xKgshm-Xqh7G2FeNA5Y-DXLmkEi3s@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com>
 <AANLkTin3+PzYcQEaaxgr9_5mgDGO5oiYDyBD_2tJqCTk@mail.gmail.com>
 <201104011927.03366.j6t@kdbg.org> <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:34:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5k6p-0007sw-7t
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 21:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738Ab1DATeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 15:34:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59590 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab1DATeH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 15:34:07 -0400
Received: by fxm17 with SMTP id 17so2826851fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9wtgzGO0q+ID/YgeVDzd8zNrvf2d8GyitMH4iV0W+zI=;
        b=lVZ+tvLLYlA6MKNeYHg9U7OeCwXhOGrENKzHBkEDlkZQDylVFQu2GO3BwYUGMBHnlx
         ANLCQ+wudxOzASi7y+mvSc16YqI7ikyWq4wxaZtDOx0P0mQOBejIM3Jf6gMlZAVxXXOC
         +ueFtJrUqi9lajqZdX3Lq3EKTYVe5fR/Bw7t0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=BZp8dTJ+VhvicIjMA9OBI8dQMtxE+TJ/kT4A3NaddyqaSH74bNnSC/aaw4aKXa0kEV
         Q2g+FaJWfsxcIyfScIN1Ywtgxeg3txTsPpgswnnCgYbXphVJQT/L0KwN93a06TzmTeBy
         SPZhs/8l+2wwltzrMx6OIqSqcFpgDNtef85Ag=
Received: by 10.223.96.16 with SMTP id f16mr752316fan.146.1301686446152; Fri,
 01 Apr 2011 12:34:06 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 12:33:46 -0700 (PDT)
In-Reply-To: <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170610>

On Fri, Apr 1, 2011 at 9:26 PM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> On Fri, Apr 1, 2011 at 7:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Freitag, 1. April 2011, Erik Faye-Lund wrote:
>>> On Fri, Apr 1, 2011 at 11:41 AM, Erik Faye-Lund <kusmabite@gmail.co=
m> wrote:
>>> > On Thu, Mar 31, 2011 at 8:45 PM, Jeff King <peff@peff.net> wrote:
>>> >> =A0 =A0 =A0 =A0kill(async->pid, 15);
>>> >> =A0#else
>>> >> - =A0 =A0 =A0 /* no clue */
>>> >> + =A0 =A0 =A0 pthread_cancel(async->tid);
>>> >
>>> > My worry about terminating a thread that's currently holding a mu=
tex
>>> > (implicitly through the CRT?) still applies though...
>>>
>>> OK, I've read up on thread-cancellation, and this code seems correc=
t.
>>> pthread_cancel doesn't kill the thread right away, it just signals =
a
>>> cancellation-event, which is checked for at certain
>>> cancellation-points. A lot of the CRT functions are defined as
>>> cancellation points, so it'll be a matter for us Win32-guys to
>>> implement pthread_testcancel() and inject that into the
>>> function-wrappers of the CRT functions that are marked as
>>> cancellation-points.
>>
>> That's not going to happen. We cannot implement pthread_cancel() on =
Windows
>> because it would have to be able to interrupt blocking system calls.
>> (TerminateThread() is a no-no, given all the caveats about leaking s=
ystem
>> resources that are mentioned in the manual.)
>>
>
> Did you read my suggestion? I was talking about implementing
> cancellation-points, just like on other platforms. This should not
> lead to TerminateThread, but instead a conditional ExitThread from th=
e
> thread in question.
>
> Something like this (I've only added a cancellation-point at close,
> just to illustrate what I mean):
>
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 878b1de..253be14 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -302,6 +302,14 @@ int mingw_open (const char *filename, int oflags=
, ...)
> =A0 =A0 =A0 =A0return fd;
> =A0}
>
> +#undef close
> +int mingw_close(int fd)
> +{
> + =A0 =A0 =A0 int ret =3D close(fd);
> + =A0 =A0 =A0 pthread_testcancel();
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0#undef write
> =A0ssize_t mingw_write(int fd, const void *buf, size_t count)
> =A0{
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 62eccd3..3e904c8 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -175,6 +175,9 @@ int mingw_rmdir(const char *path);
> =A0int mingw_open (const char *filename, int oflags, ...);
> =A0#define open mingw_open
>
> +int mingw_close(int fd);
> +#define close mingw_close
> +
> =A0ssize_t mingw_write(int fd, const void *buf, size_t count);
> =A0#define write mingw_write
>
> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 010e875..47d620b 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -18,6 +18,7 @@ static unsigned __stdcall win32_start_routine(void =
*arg)
> =A0 =A0 =A0 =A0pthread_t *thread =3D arg;
> =A0 =A0 =A0 =A0thread->tid =3D GetCurrentThreadId();
> =A0 =A0 =A0 =A0thread->arg =3D thread->start_routine(thread->arg);
> + =A0 =A0 =A0 CloseHandle(thread->cancel_event);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -26,6 +27,9 @@ int pthread_create(pthread_t *thread, const void *u=
nused,
> =A0{
> =A0 =A0 =A0 =A0thread->arg =3D arg;
> =A0 =A0 =A0 =A0thread->start_routine =3D start_routine;
> + =A0 =A0 =A0 thread->cancel_event =3D CreateEvent(NULL, FALSE, FALSE=
, NULL);
> + =A0 =A0 =A0 if (!thread->cancel_event)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("failed to create event");
> =A0 =A0 =A0 =A0thread->handle =3D (HANDLE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_beginthreadex(NULL, 0, win32_start_ro=
utine, thread, 0, NULL);
>
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index 2e20548..7fce39d 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -56,6 +56,7 @@ extern int pthread_cond_broadcast(pthread_cond_t *c=
ond);
> =A0*/
> =A0typedef struct {
> =A0 =A0 =A0 =A0HANDLE handle;
> + =A0 =A0 =A0 HANDLE cancel_event;
> =A0 =A0 =A0 =A0void *(*start_routine)(void*);
> =A0 =A0 =A0 =A0void *arg;
> =A0 =A0 =A0 =A0DWORD tid;
> @@ -96,4 +97,13 @@ static inline void *pthread_getspecific(pthread_ke=
y_t key)
> =A0 =A0 =A0 =A0return TlsGetValue(key);
> =A0}
>
> +#define pthread_cancel(a) SetEvent(a.cancel_event)
> +
> +static inline void pthread_testcancel(void)
> +{
> + =A0 =A0 =A0 pthread_t thread =3D pthread_self();
> + =A0 =A0 =A0 if (WaitForSingleObject(thread.cancel_event, 0))

That should be:
-	if (WaitForSingleObject(thread.cancel_event, 0))
+	if (WaitForSingleObject(thread.cancel_event, 0) =3D=3D WAIT_OBJECT_0)
=2E..Of course.
