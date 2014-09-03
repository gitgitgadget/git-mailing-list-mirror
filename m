From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Wed, 03 Sep 2014 20:45:41 +0200
Message-ID: <540761D5.5040501@web.de>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com> <5406B4EF.3050301@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>,
	Jonas 'Sortie' Termansen <sortie@maxsi.org>,
	Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPFZJ-0005Aa-BV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 20:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbaICSp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 14:45:56 -0400
Received: from mout.web.de ([212.227.15.4]:62832 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbaICSpz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 14:45:55 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MhDlp-1Xkv8w285B-00MOr7; Wed, 03 Sep 2014 20:45:51
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <5406B4EF.3050301@kdbg.org>
X-Provags-ID: V03:K0:n4nrGkh6C8Nvfj+7N0M/PqLQYdEENYKXfnSUtAJ1zU0YOnlRthH
 acyrTX54w7WnW7hK509QuFAk3idYgQPbrgaAqv7f91MBHOap83S8HeFpeE27/+sMyHVAdG6
 JoTUlC7h4kLz3zW8VCpY00kiKKKQXpwgCvdg7cYPWrXFPHaFD+YWMP+i0DO/tTd2r+WDqMU
 XaRcEgxb7eSLSBWVMX4vw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256401>

On 2014-09-03 08.27, Johannes Sixt wrote:
> Am 03.09.2014 00:06, schrieb Junio C Hamano:
>> * jt/timer-settime (2014-08-29) 9 commits
>>  - use timer_settime() for new platforms
>>  - autoconf: check for timer_settime()
>>  - autoconf: check for struct itimerspec
>>  - autoconf: check for struct sigevent
>>  - autoconf: check for struct timespec
>>  - autoconf: check for timer_t
>>  - autoconf: check for setitimer()
>>  - autoconf: check for struct itimerval
>>  - git-compat-util.h: add missing semicolon after struct itimerval
>>
>>  Need a rerolled one.
> 
> Yes. Please mark the MinGW build as not having timer_settime. Better
> yet, implement it in compat/mingw.c to replace its setitimer()
> implementation.
> 
> As a bug report, currently, I get
> 
>     CC progress.o
> progress.c: In function 'set_progress_signal':
> progress.c:66: error: 'CLOCK_MONOTONIC' undeclared (first use in this
> function)
> 
> even though I have NO_TIMER_SETTIME set in my config.mak (but no other
> of new configuration options that this series introduces).
> 
> But IMHO, this topic goes in a wrong direction. "Avoid deprecated
> interfaces" is way overrated. It would be preferable (IMHO) to implement
> setitimer() in compat/ for systems that don't have it.
> 
> -- Hannes
 
I tend to agree:

grep "ifeq.*uname_S" config.mak.uname  | wc
reports 21 different OS versions, where Git can use setitimer(),
and that has been working quite well.

The getitimer() function call appeared in 4.2BSD, and even if
POSIX papers recommends the use of timers API (timer_gettime(2), timer_settime(2),
the current implementation in real existing OS may stay available for a long time.

The patch-series is addressing one single system.

Could we think about writing a setitimer() implementation which uses
the new POSIX timer_settime(2) for systems which do not have getitimer() ?

Or is somebody able to test all platforms which currently are supported by Git ?
