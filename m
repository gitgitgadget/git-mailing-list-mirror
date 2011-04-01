From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 21:26:41 +0200
Message-ID: <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com>
 <AANLkTin3+PzYcQEaaxgr9_5mgDGO5oiYDyBD_2tJqCTk@mail.gmail.com> <201104011927.03366.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:27:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5jzy-0003vc-SI
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 21:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1DAT1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 15:27:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48923 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1DAT1D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 15:27:03 -0400
Received: by fxm17 with SMTP id 17so2823316fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=G64UPZYsXM25hkDNwdzDuqbwWY1+QJcuMa2Zp0G80z8=;
        b=u49OjLqNUZC1IiUvko6fPfDrnNMZb3ZF22KaDl/Slu2l7FxrDgTnjteuPizqL7VcTd
         AMgG6+pmbeI+I46Jp4RKUZBW318Vhe7ioCdgx4sHnfB7a6Kxn6fV1WE5+n1YJNqlRS0c
         HFfdMjTfuNfOj685g2bHUSMdf8Xsl/hgCA8w4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=sDBkF0MYPMpvPOsUZo9U6LTvgCm9NOPo4tl/ssDgGjNsYiWWaodR1I9peYOh3emGdm
         o5lowOv7eO5XkMtr7fPjoh9XtwvZ1eWBtWLIWnjVvNtMHeic8KI4UfRMgVYQ0aivLBfw
         ERw/Z/iX2DM074dg63nJFE66MVbDnmr4YJXSQ=
Received: by 10.223.35.147 with SMTP id p19mr4748687fad.13.1301686022127; Fri,
 01 Apr 2011 12:27:02 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 12:26:41 -0700 (PDT)
In-Reply-To: <201104011927.03366.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170609>

On Fri, Apr 1, 2011 at 7:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 1. April 2011, Erik Faye-Lund wrote:
>> On Fri, Apr 1, 2011 at 11:41 AM, Erik Faye-Lund <kusmabite@gmail.com=
> wrote:
>> > On Thu, Mar 31, 2011 at 8:45 PM, Jeff King <peff@peff.net> wrote:
>> >> =A0 =A0 =A0 =A0kill(async->pid, 15);
>> >> =A0#else
>> >> - =A0 =A0 =A0 /* no clue */
>> >> + =A0 =A0 =A0 pthread_cancel(async->tid);
>> >
>> > My worry about terminating a thread that's currently holding a mut=
ex
>> > (implicitly through the CRT?) still applies though...
>>
>> OK, I've read up on thread-cancellation, and this code seems correct=
=2E
>> pthread_cancel doesn't kill the thread right away, it just signals a
>> cancellation-event, which is checked for at certain
>> cancellation-points. A lot of the CRT functions are defined as
>> cancellation points, so it'll be a matter for us Win32-guys to
>> implement pthread_testcancel() and inject that into the
>> function-wrappers of the CRT functions that are marked as
>> cancellation-points.
>
> That's not going to happen. We cannot implement pthread_cancel() on W=
indows
> because it would have to be able to interrupt blocking system calls.
> (TerminateThread() is a no-no, given all the caveats about leaking sy=
stem
> resources that are mentioned in the manual.)
>

Did you read my suggestion? I was talking about implementing
cancellation-points, just like on other platforms. This should not
lead to TerminateThread, but instead a conditional ExitThread from the
thread in question.

Something like this (I've only added a cancellation-point at close,
just to illustrate what I mean):


diff --git a/compat/mingw.c b/compat/mingw.c
index 878b1de..253be14 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -302,6 +302,14 @@ int mingw_open (const char *filename, int oflags, =
=2E..)
 	return fd;
 }

+#undef close
+int mingw_close(int fd)
+{
+	int ret =3D close(fd);
+	pthread_testcancel();
+	return ret;
+}
+
 #undef write
 ssize_t mingw_write(int fd, const void *buf, size_t count)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 62eccd3..3e904c8 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -175,6 +175,9 @@ int mingw_rmdir(const char *path);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open

+int mingw_close(int fd);
+#define close mingw_close
+
 ssize_t mingw_write(int fd, const void *buf, size_t count);
 #define write mingw_write

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 010e875..47d620b 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -18,6 +18,7 @@ static unsigned __stdcall win32_start_routine(void *a=
rg)
 	pthread_t *thread =3D arg;
 	thread->tid =3D GetCurrentThreadId();
 	thread->arg =3D thread->start_routine(thread->arg);
+	CloseHandle(thread->cancel_event);
 	return 0;
 }

@@ -26,6 +27,9 @@ int pthread_create(pthread_t *thread, const void *unu=
sed,
 {
 	thread->arg =3D arg;
 	thread->start_routine =3D start_routine;
+	thread->cancel_event =3D CreateEvent(NULL, FALSE, FALSE, NULL);
+	if (!thread->cancel_event)
+		die("failed to create event");
 	thread->handle =3D (HANDLE)
 		_beginthreadex(NULL, 0, win32_start_routine, thread, 0, NULL);

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 2e20548..7fce39d 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -56,6 +56,7 @@ extern int pthread_cond_broadcast(pthread_cond_t *con=
d);
  */
 typedef struct {
 	HANDLE handle;
+	HANDLE cancel_event;
 	void *(*start_routine)(void*);
 	void *arg;
 	DWORD tid;
@@ -96,4 +97,13 @@ static inline void *pthread_getspecific(pthread_key_=
t key)
 	return TlsGetValue(key);
 }

+#define pthread_cancel(a) SetEvent(a.cancel_event)
+
+static inline void pthread_testcancel(void)
+{
+	pthread_t thread =3D pthread_self();
+	if (WaitForSingleObject(thread.cancel_event, 0))
+		pthread_exit(NULL);
+}
+
 #endif /* PTHREAD_H */
