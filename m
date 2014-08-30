From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: progress.c does not compile under Mac OS X
Date: Sat, 30 Aug 2014 22:37:00 +0200
Message-ID: <540235EC.2020303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: sortie@maxsi.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:37:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNpOa-0000OS-80
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 22:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaH3UhF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 16:37:05 -0400
Received: from mout.web.de ([212.227.15.3]:58726 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbaH3UhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 16:37:04 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LbImQ-1Y7aWl09tq-00kx7t; Sat, 30 Aug 2014 22:37:01
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:0UUd2FzeEX4rLqPeBP6GzvV5jMI04fzsG/W5TaUMH36p7iCUiSr
 sX1woXTRRZWJAaMfeGx3/T9vSkFo/3jISVXg9wBj2JCwJN/vwPgnTEL5MEx3ITfeasg3ipu
 LzrKhapfRh+OYgmKhLXOCKEf6vS+AfOp18ZDpc2wGJAhIwxIUpzuxeOjwpy5hLxJNoGNdiS
 l7T1wPF+ISmOc+w6GXvfw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256262>

progress.c:66: error: =E2=80=98CLOCK_MONOTONIC=E2=80=99 undeclared (fir=
st use in this function)

You can not cast a undeclared into void in git-compat-uitl.h:
#define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) (=
sevp), (void) (timerp), errno=20


Removing the cast of a define into (void) makes the compilation error i=
n line 66 go away:
 #ifdef NO_TIMER_SETTIME
-#define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) =
(sevp), (void) (timerp), errno =3D ENOSYS, -1)
+#define timer_create(clockid, sevp, timerp) ((void) (sevp), (void) (ti=
merp), errno =3D ENOSYS, -1)
=20
But now we have a bunch of other problems:

progress.c:71: warning: assignment makes integer from pointer without a=
 cast
progress.c:71: error: invalid operands to binary / (have =E2=80=98long =
int *=E2=80=99 and =E2=80=98long int=E2=80=99)
progress.c:71: warning: statement with no effect
progress.c:71: error: =E2=80=98_ivalue_it_value=E2=80=99 undeclared (fi=
rst use in this function)
progress.c:71: error: (Each undeclared identifier is reported only once
progress.c:71: error: for each function it appears in.)
progress.c:71: error: invalid operands to binary / (have =E2=80=98long =
int *=E2=80=99 and =E2=80=98long int=E2=80=99)
progress.c:74: error: expected =E2=80=98while=E2=80=99 before =E2=80=98=
static=E2=80=99
progress.c:82: error: nested functions are disabled, use -fnested-funct=
ions to re-enable
progress.c:82: error: invalid storage class for function =E2=80=98displ=
ay=E2=80=99
progress.c: In function =E2=80=98display=E2=80=99:
progress.c:92: warning: implicit declaration of function =E2=80=98clear=
_progress_signal=E2=80=99
progress.c: In function =E2=80=98set_progress_signal=E2=80=99:
progress.c:126: error: nested functions are disabled, use -fnested-func=
tions to re-enable
progress.c:126: error: invalid storage class for function =E2=80=98thro=
ughput_string=E2=80=99
progress.c:135: error: nested functions are disabled, use -fnested-func=
tions to re-enable
progress.c:199: error: nested functions are disabled, use -fnested-func=
tions to re-enable
progress.c:205: error: nested functions are disabled, use -fnested-func=
tions to re-enable
progress.c:225: error: nested functions are disabled, use -fnested-func=
tions to re-enable
progress.c:230: error: nested functions are disabled, use -fnested-func=
tions to re-enable
progress.c:235: error: nested functions are disabled, use -fnested-func=
tions to re-enable
progress.c:264: error: expected declaration or statement at end of inpu=
t


----------------
And then we have the question why we do not check the return value of t=
imer_create() in progress.c#66:

timer_create(CLOCK_MONOTONIC, &sev, &progress_timer);

value.it_interval.tv_sec =3D 1;
value.it_interval.tv_nsec =3D 0;
value.it_value =3D value.it_interval;
timer_settime(progress_timer, 0, &value, NULL);
--------------
Should it be something like this ?
if (!timer_create(CLOCK_MONOTONIC, &sev, &progress_timer)) {
  value.it_interval.tv_sec =3D 1;
  value.it_interval.tv_nsec =3D 0;
  value.it_value =3D value.it_interval;
  timer_settime(progress_timer, 0, &value, NULL);
}

(And possibly more changes to handle errors when calling
timer_delete(progress_timer)


(Sorry, no, I don't have a patch at hand.
 It feels as if the macros in git-compat-util.h could be converted into=
 real functions,
 in compat/timer_settime.c (or so) so that we can test-compile under Li=
nux)
