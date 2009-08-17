From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 02:53:17 +0100
Message-ID: <4A88B80D.40804@draigBrady.com>
References: <4A85F270.20703@draigBrady.com> <87eirbef3c.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bug-coreutils@gnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 03:57:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McrTK-0005tb-Ch
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 03:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbZHQB5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 21:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756471AbZHQB5J
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 21:57:09 -0400
Received: from mail121.emailantidote.com ([80.169.59.121]:64372 "EHLO
	SC-MTA-02.mxsweep.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753612AbZHQB5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 21:57:08 -0400
Received: from tombstone.lincor.com ([84.203.137.218]) by SC-MTA-02.mxsweep.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Mon, 17 Aug 2009 02:57:05 +0100
Received: from [192.168.2.25] (crom.labs.lincor.com [192.168.2.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tombstone.lincor.com (Postfix) with ESMTP id 08F156158122;
	Mon, 17 Aug 2009 02:57:02 +0100 (IST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071008)
In-Reply-To: <87eirbef3c.fsf@master.homenet>
X-Enigmail-Version: 0.95.0
X-OriginalArrivalTime: 17 Aug 2009 01:57:05.0279 (UTC) FILETIME=[053AC0F0:01CA1EDE]
x-MXSweep-CtasdSpam: Unknown
x-MXSweep-CtasdVirus: Unknown
x-Ctasd-RefID: str=0001.0A090201.4A88B8F3.002E,ss=1,fgs=0
x-MXSweep-KeywordsCount: 0
x-MXSweep-MetaScanResult: Clean
x-MXSweep-MetaScanThreat: 
x-MXSweep-VirusScanned: 17/08/2009 01:57:06
x-MXPurifier-SpamScore: 0
x-MXPurifier-VirusScore: 0
x-MXSweep-Threat: Clean
X-MXUniqueID: eaff0b1f-a1d4-49a9-b27d-da6b45fdb625
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126106>

Giuseppe Scrivano wrote:
> Hi P=C3=A1draig,
>=20
> I tried to reproduce your results but I wasn't able to do it.  The
> biggest difference on a 300MB file I noticed was approximately 15% us=
ing
> on both implementations -O2, and 5% using -O3.
> My GCC version is "gcc (Debian 4.3.3-14) 4.3.3" and the CPU is: Intel=
(R)
> Pentium(R) D CPU 3.20GHz.
>=20
> I also spent some time trying to improve the gnulib SHA1 implementati=
on
> and it seems a lookup table can improve things a bit.
>=20
> Can you please try the patch that I have attached and tell me which
> performance difference (if any) you get?

Thanks for looking at this Giuseppe
and sorry for not mentioning my GCC and CPU.

Note the binaries below is compiled with
$(rpm -q --qf=3D"%{OPTFLAGS}\n" coreutils)
for consistency, which on my F11 machines is:

  -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=3D2 -fexceptions
  -fstack-protector --param=3Dssp-buffer-size=3D4 -m32 -march=3Di586
  -mtune=3Dgeneric -fasynchronous-unwind-tables -D_GNU_SOURCE=3D1

Testing on 2 machines I have here:

$ rpm -q gcc
gcc-4.4.1-2.fc11.i586
$ grep "model name" /proc/cpuinfo | head -n1 | tr -s '[:blank:]' ' '
model name : Intel(R) Pentium(R) M processor 1.70GHz
$ truncate -s300MB sha1.test
$ time sha1sum sha1.test
real    0m3.540s
$ time linus-sha1 sha1.test
real    0m2.319s (-34%)
$ time  giuseppe-sha1sum sha1.test
real    0m3.513s (-.8%)

$ rpm -q gcc
gcc-4.4.1-2.fc11.i586
$ grep "model name" /proc/cpuinfo | head -n1 | tr -s '[:blank:]' ' '
model name : Intel(R) Core(TM) i7 CPU 920 @ 2.67GHz
$ truncate -s300MB sha1.test
$ time sha1sum sha1.test
real    0m1.857s
$ time linus-sha1 sha1.test
real    0m1.102s (-40%)
$ time giuseppe-sha1sum sha1.test
real    0m1.932s (+ 4%)

cheers,
P=C3=A1draig.
