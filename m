From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: assert failed in submodule edge case
Date: Thu, 16 Apr 2015 21:27:40 +0200
Message-ID: <55300D2C.9030903@web.de>
References: <1428944157.13660.8.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 16 21:27:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YipS1-0001tc-9S
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 21:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbDPT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 15:27:46 -0400
Received: from mout.web.de ([212.227.15.14]:51393 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbbDPT1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 15:27:44 -0400
Received: from [192.168.178.41] ([79.211.97.138]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Lp9kK-1ZEsTy0v2q-00etNE; Thu, 16 Apr 2015 21:27:42
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1428944157.13660.8.camel@kaarsemaker.net>
X-Provags-ID: V03:K0:vlPck8/DaLJ6LcykEjdKxeERGJY1/Iq1D7D6h6GK1Pn3WI3i7f7
 XF3SXFNkbTXKt86UioiszAcSRW6y4i4yTFfc0DXh+Ks2irSOL2ggtC1sFAIXGVvVlr4rN9r
 ZiEahuJNW9YoMrUnxsteUkkaNwFOHYAleFyDPfzn1Wpjb7MV7uPcXMmWgYZeqokuTk6/vKi
 lVWl/LT42kQwOKqMFyMOA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267330>

Am 13.04.2015 um 18:55 schrieb Dennis Kaarsemaker:
> Reported by djanos_ in #git: git add segfaults when you manage to
> confuse it with a submodule in the index that is no longer a submodule.
>
> Here's his script to reproduce the segfault:
>
> mkdir segfault
> cd segfault
>
> mkdir subrepo
> cd subrepo
>
> git init .
> echo a > a
> git add a
> git commit -m "a"
>
> cd ..
>
> git init .
> git add .

If you add a "git rm -f --cached subrepo" here the problem goes away.

> cd subrepo
> rm -rf .git
> git add .
>
> This last git add will now barf:
> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.
>
> These all work as I think they are intended to:
> $ git -C segfault add subrepo/a
> fatal: Pathspec 'subrepo/a' is in submodule 'subrepo'
> $ git -C segfault/subrepo add a
> fatal: Pathspec 'a' is in submodule 'subrepo'
>
> And this does nothing, it also doesn't crash:
>
> $ git -C segfault add subrepo
>
> GDB backtrace below, this is with next as of e6f3401.
>
> Starting program: /home/dennis/code/git/git -C segfault/subrepo add .
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.
>
> Program received signal SIGABRT, Aborted.
> 0x00007ffff702ae37 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> 56	../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff702ae37 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #1  0x00007ffff702c528 in __GI_abort () at abort.c:89
> #2  0x00007ffff7023ce6 in __assert_fail_base (fmt=0x7ffff7173c08 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
>      assertion=assertion@entry=0x560660 "item->nowildcard_len <= item->len && item->prefix <= item->len", file=file@entry=0x560826 "pathspec.c", line=line@entry=317,
>      function=function@entry=0x560850 <__PRETTY_FUNCTION__.22237> "prefix_pathspec") at assert.c:92
> #3  0x00007ffff7023d92 in __GI___assert_fail (assertion=assertion@entry=0x560660 "item->nowildcard_len <= item->len && item->prefix <= item->len",
>      file=file@entry=0x560826 "pathspec.c", line=line@entry=317, function=function@entry=0x560850 <__PRETTY_FUNCTION__.22237> "prefix_pathspec") at assert.c:101
> #4  0x00000000004d6a37 in prefix_pathspec (elt=0x7fffffffdaf1 ".", prefixlen=8, prefix=0x7dd09f "subrepo/", flags=50, raw=0x7fffffffd648,
>      p_short_magic=<synthetic pointer>, item=<optimized out>) at pathspec.c:316
> #5  parse_pathspec (pathspec=pathspec@entry=0x7fffffffd240, magic_mask=magic_mask@entry=0, flags=flags@entry=50, prefix=prefix@entry=0x7dd09f "subrepo/",
>      argv=argv@entry=0x7fffffffd648) at pathspec.c:417
> #6  0x000000000040698c in cmd_add (argc=<optimized out>, argv=0x7fffffffd648, prefix=0x7dd09f "subrepo/") at builtin/add.c:370
> #7  0x0000000000406001 in run_builtin (argv=0x7fffffffd640, argc=2, p=0x79d740 <commands>) at git.c:350
> #8  handle_builtin (argc=2, argv=0x7fffffffd640) at git.c:532
> #9  0x0000000000405151 in run_argv (argv=0x7fffffffd458, argcp=0x7fffffffd43c) at git.c:578
> #10 main (argc=2, av=<optimized out>) at git.c:686
>
> I dig a bit into pathspec.c and it looks like the
> PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE code in prefix_pathspec is only
> stripping out paths inside the submodule, not the submodule itself.
>
> I also guess that it shouldn't as otherwise you can't ever 'git add' a
> submodule. So I have no idea how to proceed, or even what the correct
> behaviour of 'git add' should be in this case. I do think that failing
> an assert() to tell a user he's doing something unexpected/silly/wrong
> isn't the right thing to do though :)

The problem seems to be that "subrepo" is still registered as a
submodule in the index. But we should see a proper error message
instead of an assert in that case ... CCed Duy who knows much
more about pathspec.c than me.
