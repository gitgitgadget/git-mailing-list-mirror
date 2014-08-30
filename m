From: Jonas 'Sortie' Termansen <Sortie@Maxsi.org>
Subject: Re: progress.c does not compile under Mac OS X
Date: Sun, 31 Aug 2014 01:12:31 +0200
Message-ID: <54025A5F.1030602@Maxsi.org>
References: <540235EC.2020303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 01:12:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNrp0-0005Ww-F0
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 01:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbaH3XMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 19:12:34 -0400
Received: from csmtp5.one.com ([195.47.247.105]:40652 "EHLO csmtp5.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaH3XMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 19:12:34 -0400
Received: from [192.168.1.2] (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp5.one.com (Postfix) with ESMTPA id 7B0F0400055AB;
	Sat, 30 Aug 2014 23:12:31 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <540235EC.2020303@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256273>

Oh,

I'm a bit confused here - lots of things happening. Submitting patches =
to
projects is usually fairly simple; it's excitingly fresh to get a bunch=
 of
replies, having the patch set revised, more replies, then a further rev=
ised
patch set gets merged to a development branch, and then I get suddenly =
get
emails about breaking the build on OS X. Let's see if I can figure this=
 out. :-)

My original patch had a minor bug where it forgot to compatibility-wrap=
 the
CLOCK_MONOTONIC constant. Surprisingly, it turns out even in 2014 OS X =
doesn't
have the clock_gettime interface. What a silly operating system.

Jacob Keller revised my patch set and added compatibility macros that e=
mulate
timer_foo using setitimer. Turns out, it had a few typos of its own.

The revised patch set got slightly changed and was merged to the pu bra=
nch,
which is where you are having build trouble now.

Alright, so to recover, first appropriately add this to git-compat-util=
=2Eh:

+#ifndef CLOCK_MOTOTONIC
+#define CLOCK_MONOTONIC 1 /* dummy */
+#define

Secondly, there is a typo where an underscore is used instead of a peri=
od.

-       _ivalue_it_value.tv_usec =3D value.it_value.tv_nsec / 1000L;   =
           \
+       _ivalue.it_value.tv_usec =3D value.it_value.tv_nsec / 1000L;   =
           \

Third, there needs to be an end brace before the while:

-while (0)
+} while (0)

That should fix the immediate breakage, I believe.

Looking closer, there are a bunch of additional issues here:

+#define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) =
(sevp), (void) (timerp), errno =3D ENOSYS, -1)
+#define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) =
(sevp), (void) (timerp), 0)

This emulates a timer_create that always fails. That's not what we are =
trying to
do, we want to emulate one that always works. It should return 0 instea=
d of
setting errno to ENOSYS and returning -1. (My original patch set made t=
he
replacement timer_create this this way, but at that time I was not tryi=
ng to
emulate the interface, just stub it.)

=46inally patch set also fails to break with platforms with a broken ti=
mer_settime
but a working setitimer. If that is something we want to support? Might=
 as well.

On 08/30/2014 10:37 PM, Torsten B=C3=B6gershausen wrote:
> And then we have the question why we do not check the return value of
> timer_create() in progress.c#66:

It's because the old code didn't check the result value. Secondly it's =
because
this code is non-essential, if it fails, there is really no choice but =
to carry
on anyways. I admit it's probably not a good idea to make timer_settime=
 time
with an uninitialized timer id. The likelihood is low though as git onl=
y needs
one timer - but I agree it's prudent to check the error codes.

On 08/30/2014 10:37 PM, Torsten B=C3=B6gershausen wrote:
> It feels as if the macros in git-compat-util.h could be converted int=
o real
> functions, in compat/timer_settime.c (or so) so that we can test-comp=
ile under
> Linux)

This is my preferred route as well.

I hope that sorts things out. I'll be submitting a full V2 of my patch =
set
shortly that should work reliably on all systems. For now, you can fix =
the build
by applying the above fixes, or perhaps revert the commits as they are
troublesome. :-)

Jonas
