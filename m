From: Ivan Kanis <expire-by-2010-08-11@kanis.fr>
Subject: Re: Git server eats all memory
Date: Fri, 06 Aug 2010 19:23:17 +0200
Message-ID: <87hbj74pve.fsf@kanis.fr>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, jnareb@gmail.com,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, jaredhance@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 06 19:23:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhQdo-0002Vs-NY
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 19:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935006Ab0HFRX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 13:23:26 -0400
Received: from kanis.fr ([75.127.73.245]:1130 "EHLO kanis.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933884Ab0HFRXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 13:23:23 -0400
Received: from [89.83.137.164] (helo=tao)
	by kanis.fr with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <expire-by-2010-08-11@kanis.fr>)
	id 1OhQdd-0003bb-6r; Fri, 06 Aug 2010 13:23:21 -0400
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
In-Reply-To: <AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Fri, 6 Aug 2010 11:51:33 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152798>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> Naah, git pack-objects needs list of commit tips. Try
> git for-each-ref|cut -c 1-40|git pack-objects --all --stdout > /dev/null

Jared Hance <jaredhance@gmail.com> wrote:

> I would look in the code for malloc calls that don't have a free call,
> or spots where free calls might not be hit.

Hello Jared and Nguyen,

Thank you Nguyen for your command. I can now reproduce the problem
without needing the network. I have been following Jared lead today on
a potential memory leak. Here is what I found out.

I downloaded the latest release of git 1.7.2.1 and compiled it with
debugging support. I ran valgrind on the command and found two memory
leaks. I put the output at the bottom of the e-mail as it's not very
interesting. I patched one of the leak in pack_objects.c but got the
same problem: over 4G of memory consumption for a 4G repository.

I've come to the conclusion that it's not a memory leak. 

This afternoon I put macro around the following functions: xmalloc
xmallocz, xrealloc, xcalloc and xmmap. It reported the line of code and
size passed in each functions. I then run the result through a script
that totaled the amount used by each bit of code.

Here are the top 3 consumers:

| function | source                     | size in M |
|----------+----------------------------+-----------|
| xrealloc | builtin/pack-objects.c:690 |        86 |
| xmallocz | patch-delta.c:36           |       301 |
| xmmap    | sha1_file.c:772            |      4393 |

I expected the malloc to take 4G but was surprised it didn't. It seems
to be mmap taking all the memory. I am not familiar with that function,
it looks like it's mapping memory to a file... Is it reasonable to mmap
so much memory?

Today I chatted with someone on freenode #git and he reported the same
problem on his 2G repository, I am glad I am not the only one seeing
this ;)

I tried reading the code but it's going over my head. I'll look at is
some more next monday.

If anyone is familiar with the code source of git I would love to have
some insight into this.

Take care,

Ivan Kanis

PS: output of valgrind --leak-check=full

65 bytes in 1 blocks are definitely lost in loss record 4 of 7
   at 0x4C2260E: malloc (vg_replace_malloc.c:207)
   by 0x4C22797: realloc (vg_replace_malloc.c:429)
   by 0x4C600D: xrealloc (wrapper.c:80)
   by 0x4B7939: strbuf_grow (strbuf.c:70)
   by 0x4B80BA: strbuf_addf (strbuf.c:201)
   by 0x4832EF: system_path (exec_cmd.c:37)
   by 0x483411: setup_path (exec_cmd.c:104)
   by 0x404AF2: main (git.c:536)

512 bytes in 1 blocks are definitely lost in loss record 5 of 8
   at 0x4C203E4: calloc (vg_replace_malloc.c:397)
   by 0x4C5F9D: xcalloc (wrapper.c:96)
   by 0x445741: cmd_pack_objects (pack-objects.c:2117)
   by 0x4048EE: handle_internal_command (git.c:270)
   by 0x404B03: main (git.c:470)
-- 
http://kanis.fr

Everything should be made as simple as possible, but not simpler.
    -- Albert Einstein 
