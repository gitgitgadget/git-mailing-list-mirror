From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: assert failed in submodule edge case
Date: Mon, 13 Apr 2015 18:55:57 +0200
Message-ID: <1428944157.13660.8.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:56:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhhea-0000Wk-6T
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 18:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbbDMQ4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 12:56:03 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33780 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbDMQ4A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 12:56:00 -0400
Received: by wgin8 with SMTP id n8so87901628wgi.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 09:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:content-type
         :mime-version:content-transfer-encoding;
        bh=eRgnER3u0c02XOxpJXnO0wcC0MsFop4gxg/609sAPCM=;
        b=BCFf2vQEpwNsp9pntd2wEfUMrdeBXwVHxhg6cmfV2qtPIPNTx2oMHtkSct1ugZDC0v
         sOZRZvQPEM+TvFvvV5TQiOrWtvWxUab70tExWswIts/8nTsFLrXI1f+9BozoUs9Ruduv
         UjW/wnKZJSFjCr0p/gnLv9mN1TA4w/mgoOQ8b3EdxcK2641Y0LXayLcgLKPV4e5XBGnc
         s18mcZwt2LMeei71tCBx82n1XatOh//faJTu9xPl4SFIFwR+Ir63HDoh/wVwIdiw1lxV
         Upc6EiDOXkix4aN0SSkoX56SXlz1PIBWK/KwzF7j0E0kQF/+svem++SJw9HInKHLFC+0
         65Nw==
X-Gm-Message-State: ALoCoQkEELYI5Og6TRPgRWvmBTRLMY07/SZ4LvB8ty0jSr5ZSMEbH6+azGEN05VdoUFm1gKWsJ1g
X-Received: by 10.180.83.193 with SMTP id s1mr22844829wiy.22.1428944159590;
        Mon, 13 Apr 2015 09:55:59 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id ng5sm12252604wic.24.2015.04.13.09.55.58
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2015 09:55:58 -0700 (PDT)
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267095>

Reported by djanos_ in #git: git add segfaults when you manage to
confuse it with a submodule in the index that is no longer a submodule.

Here's his script to reproduce the segfault:

mkdir segfault
cd segfault

mkdir subrepo
cd subrepo

git init .
echo a > a
git add a
git commit -m "a"

cd ..

git init .
git add .

cd subrepo
rm -rf .git
git add .

This last git add will now barf:
git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.

These all work as I think they are intended to:
$ git -C segfault add subrepo/a
fatal: Pathspec 'subrepo/a' is in submodule 'subrepo'
$ git -C segfault/subrepo add a
fatal: Pathspec 'a' is in submodule 'subrepo'

And this does nothing, it also doesn't crash:

$ git -C segfault add subrepo

GDB backtrace below, this is with next as of e6f3401.

Starting program: /home/dennis/code/git/git -C segfault/subrepo add .
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.

Program received signal SIGABRT, Aborted.
0x00007ffff702ae37 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
56	../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  0x00007ffff702ae37 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
#1  0x00007ffff702c528 in __GI_abort () at abort.c:89
#2  0x00007ffff7023ce6 in __assert_fail_base (fmt=0x7ffff7173c08 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", 
    assertion=assertion@entry=0x560660 "item->nowildcard_len <= item->len && item->prefix <= item->len", file=file@entry=0x560826 "pathspec.c", line=line@entry=317, 
    function=function@entry=0x560850 <__PRETTY_FUNCTION__.22237> "prefix_pathspec") at assert.c:92
#3  0x00007ffff7023d92 in __GI___assert_fail (assertion=assertion@entry=0x560660 "item->nowildcard_len <= item->len && item->prefix <= item->len", 
    file=file@entry=0x560826 "pathspec.c", line=line@entry=317, function=function@entry=0x560850 <__PRETTY_FUNCTION__.22237> "prefix_pathspec") at assert.c:101
#4  0x00000000004d6a37 in prefix_pathspec (elt=0x7fffffffdaf1 ".", prefixlen=8, prefix=0x7dd09f "subrepo/", flags=50, raw=0x7fffffffd648, 
    p_short_magic=<synthetic pointer>, item=<optimized out>) at pathspec.c:316
#5  parse_pathspec (pathspec=pathspec@entry=0x7fffffffd240, magic_mask=magic_mask@entry=0, flags=flags@entry=50, prefix=prefix@entry=0x7dd09f "subrepo/", 
    argv=argv@entry=0x7fffffffd648) at pathspec.c:417
#6  0x000000000040698c in cmd_add (argc=<optimized out>, argv=0x7fffffffd648, prefix=0x7dd09f "subrepo/") at builtin/add.c:370
#7  0x0000000000406001 in run_builtin (argv=0x7fffffffd640, argc=2, p=0x79d740 <commands>) at git.c:350
#8  handle_builtin (argc=2, argv=0x7fffffffd640) at git.c:532
#9  0x0000000000405151 in run_argv (argv=0x7fffffffd458, argcp=0x7fffffffd43c) at git.c:578
#10 main (argc=2, av=<optimized out>) at git.c:686

I dig a bit into pathspec.c and it looks like the
PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE code in prefix_pathspec is only
stripping out paths inside the submodule, not the submodule itself.

I also guess that it shouldn't as otherwise you can't ever 'git add' a
submodule. So I have no idea how to proceed, or even what the correct
behaviour of 'git add' should be in this case. I do think that failing
an assert() to tell a user he's doing something unexpected/silly/wrong
isn't the right thing to do though :)

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
