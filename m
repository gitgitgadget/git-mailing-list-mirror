From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with textconv
 filter
Date: Mon, 29 Oct 2012 21:19:48 +0100
Message-ID: <508EE4E4.1080407@arcor.de>
References: <508C29E4.5000801@arcor.de> <20121028120104.GE11434@sigill.intra.peff.net> <508D8DF7.7040007@arcor.de> <20121029060524.GB4457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 21:20:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSvod-0007rt-IV
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 21:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab2J2UTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 16:19:55 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:35698 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752923Ab2J2UTx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2012 16:19:53 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id C17B7AA32E;
	Mon, 29 Oct 2012 21:19:49 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id C5F2846E01B;
	Mon, 29 Oct 2012 21:19:49 +0100 (CET)
Received: from [10.0.0.2] (188-22-38-93.adsl.highway.telekom.at [188.22.38.93])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTPA id 5243E108819;
	Mon, 29 Oct 2012 21:19:49 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 5243E108819
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351541989; bh=cr5JWVWGt0JXFj+E5D2N2tJnojAdW2/BiJkIXlSEo6o=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=VfPJSq9m6kEJr7swFTk/yG/kOIE9BD7n+zYgRRbHhtXnKU5/8tAM8IPk8Sxi4ETO4
	 NC6QL7HNWI0iJoqQJoli3DQiVT706CLCKO5CHntocbXmQEUX5/OOZF/ev91KUNFJ1g
	 J17jG10ZsG+Akw2SE295UetnNVyuEhm/EUcwaCpU=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <20121029060524.GB4457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208637>

On 2012-10-29 07:05, Jeff King wrote:
> On Sun, Oct 28, 2012 at 08:56:39PM +0100, Peter Oberndorfer wrote:
>
>>> The patch below should fix it. I added tests, but please try your
>>> real-world test case on it to double-check.
>> I tested your patch, but now it crashes for another reason :-)
> Well, that's progress, right? :)
Sure :-)
>
>> i have a file with exactly 12288(0x3000) bytes in the repository.
>> When the file is loaded, the data is placed luckily so the data end
>> falls at a page boundary.
>> Later diff_grep() calls regexec() which calls strlen() on the loaded buffer
>> and ends up reading beyond the actual data into the next page
>> which is not allocated and causes a pagefault.
>> Or it could possibly (randomly) match the regex on data that is not
>> actually part of a file...
> Yuck. For the most part, we treat blob content (and generally most
> object content) as a sized buffer. However, there are some spots which,
> either through laziness or because a code interface expects a string, we
> pass the value as a string. This works because the object-reading code
> puts an extra NUL at the end of our buffer to handle just such an
> instance. So we might prematurely end if the object contains embedded
> NULs, but we would never read past the end.
>
> The code to read the output of a textconv filter does not do this
> explicitly. I would think it would get it for free by virtue of reading
> into a strbuf, though. I'll try to investigate.
I could reproduce with my 0x3000 bytes file on linux. The buffer is not
read with a trailing null byte it is mapped by mmap in
diff_populate_filespec...
So i think we will not get away with expecting a trailing null :-/

For me the key to reproduce the problem was to have 2 commits.
Adding the file in the root commit it did not work. [1]

Greetings Peter
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

[1]
kumbayo@home:~/src$ mkdir git_mmap_crash2
kumbayo@home:~/src$ cd git_mmap_crash2
kumbayo@home:~/src/git_mmap_crash2$ git init
kumbayo@home:~/src/git_mmap_crash2$ echo blah>blah
kumbayo@home:~/src/git_mmap_crash2$ git add blah
kumbayo@home:~/src/git_mmap_crash2$ git commit -m blah
[master (Basis-Version) 3458422] blah
diff_populate_filespec -> xmmap for blah size:0x5 returned: 0xb7206000
 1 file changed, 1 insertion(+)
 create mode 100644 blah
kumbayo@home:~/src/git_mmap_crash2$ perl -e 'print "-" x 0x3000 '> asdf.txt
kumbayo@home:~/src/git_mmap_crash2$ git add asdf.txt
kumbayo@home:~/src/git_mmap_crash2$ git commit -m crashy
[master 5cf2c5f] crashy
diff_populate_filespec -> xmmap for asdf.txt size:0x3000 returned:
0xb771e000
 1 file changed, 1 insertion(+)
 create mode 100644 asdf.txt

kumbayo@soybean:~/src/git_mmap_crash2$ valgrind git diff-tree -Ganything HEAD
==8388== Memcheck, a memory error detector
==8388== Copyright (C) 2002-2011, and GNU GPL'd, by Julian Seward et al.
==8388== Using Valgrind-3.7.0 and LibVEX; rerun with -h for copyright info
==8388== Command: git diff-tree -Ganything HEAD
==8388==
==8388== Conditional jump or move depends on uninitialised value(s)
==8388==    at 0x405ADD8: inflateReset2 (in /lib/i386-linux-gnu/libz.so.1.2.3.4)
==8388==    by 0xA0: ???
==8388==
==8388== Conditional jump or move depends on uninitialised value(s)
==8388==    at 0x405ADD8: inflateReset2 (in /lib/i386-linux-gnu/libz.so.1.2.3.4)
==8388==    by 0x7F: ???
==8388==


==8388== Conditional jump or move depends on uninitialised value(s)


==8388==    at 0x405ADD8: inflateReset2 (in /lib/i386-linux-gnu/libz.so.1.2.3.4)


==8388==    by 0x30: ???


==8388==


==8388== Conditional jump or move depends on uninitialised value(s)


==8388==    at 0x405ADD8: inflateReset2 (in /lib/i386-linux-gnu/libz.so.1.2.3.4)


==8388==    by 0x50: ???


==8388==


diffcore_pickaxe_grep


diff_populate_filespec -> xmmap for asdf.txt size:0x3000 returned: 0x4035000


==8388== Invalid read of size 1


==8388==    at 0x402C683: __GI_strlen (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)


==8388==    by 0x430581F: regexec@@GLIBC_2.3.4 (regexec.c:245)


==8388==    by 0x814489D: diff_grep (diffcore-pickaxe.c:110)
==8388==    by 0x8144B89: pickaxe.constprop.6 (diffcore-pickaxe.c:40)
==8388==    by 0x8144DCD: diffcore_pickaxe_grep (diffcore-pickaxe.c:155)
==8388==    by 0x80DCE64: diffcore_std (diff.c:4638)
==8388==    by 0x80F0B20: log_tree_diff_flush (log-tree.c:696)
==8388==  Address 0x4038000 is not stack'd, malloc'd or (recently) free'd
==8388==
==8388==
==8388== Process terminating with default action of signal 11 (SIGSEGV)
==8388==  Access not within mapped region at address 0x4038000
==8388==    at 0x402C683: __GI_strlen (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==8388==    by 0x430581F: regexec@@GLIBC_2.3.4 (regexec.c:245)
==8388==    by 0x814489D: diff_grep (diffcore-pickaxe.c:110)
==8388==    by 0x8144B89: pickaxe.constprop.6 (diffcore-pickaxe.c:40)
==8388==    by 0x8144DCD: diffcore_pickaxe_grep (diffcore-pickaxe.c:155)
==8388==    by 0x80DCE64: diffcore_std (diff.c:4638)
==8388==    by 0x80F0B20: log_tree_diff_flush (log-tree.c:696)
==8388==  If you believe this happened as a result of a stack
==8388==  overflow in your program's main thread (unlikely but
==8388==  possible), you can try to increase the size of the
==8388==  main thread stack using the --main-stacksize= flag.
==8388==  The main thread stack size used in this run was 8388608.
==8388==
==8388== HEAP SUMMARY:
==8388==     in use at exit: 86,229 bytes in 69 blocks
==8388==   total heap usage: 193 allocs, 124 frees, 259,991 bytes allocated
==8388==
==8388== LEAK SUMMARY:
==8388==    definitely lost: 65 bytes in 1 blocks
==8388==    indirectly lost: 0 bytes in 0 blocks
==8388==      possibly lost: 0 bytes in 0 blocks
==8388==    still reachable: 86,164 bytes in 68 blocks
==8388==         suppressed: 0 bytes in 0 blocks
==8388== Rerun with --leak-check=full to see details of leaked memory
==8388==
==8388== For counts of detected and suppressed errors, rerun with: -v
==8388== Use --track-origins=yes to see where uninitialised values come from
==8388== ERROR SUMMARY: 7 errors from 5 contexts (suppressed: 0 from 0)
