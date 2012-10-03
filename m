From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: upload-pack is slow with lots of refs
Date: Thu, 4 Oct 2012 00:15:47 +0200
Message-ID: <CACBZZX6yMfeOx6x4iy8beq5niy9HvPq0c8ND5jZkoiJWAgVjfw@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net> <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
 <20121003212007.GC4484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:56:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtKw-0001DP-2e
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab2JCWQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 18:16:10 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48100 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab2JCWQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 18:16:08 -0400
Received: by obbuo13 with SMTP id uo13so7863953obb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AKprTqwWg2pr5hC2XHjwk7kc63NiYAnhjydVQEZFXxE=;
        b=AQWP7LL0hIGbQZKb9xFZnRG8SruAr/AIF0PmjYkVsX9AG+3MgA2u8q+9ReNA9inC7N
         N0H8vbJjnowhORkzRy8aQOywDxSbnZ95YKQtCq+I8shGz56t46kw6qjfqwyHHHmwgyde
         Dq6I//D/WAO7cp1l6c0B8HoKXI3udQ8z5jMUNLWVJBKiUaFkEaVuN47ETjBFTvZEZN1N
         lvJQjxvmVa74ZTPYbUELbGu85ejYRVb2L3iaNtx6v5IcdxWafMfk5u/Pl7El9rrTRH9i
         BGFDWzK1SR/AedWFGm7OEPMd7JtpWqa2n1CxZTgdsyK47mt4LUnu9+80V9ij08eTQbZa
         4l7w==
Received: by 10.60.172.48 with SMTP id az16mr2692325oec.64.1349302567451; Wed,
 03 Oct 2012 15:16:07 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Wed, 3 Oct 2012 15:15:47 -0700 (PDT)
In-Reply-To: <20121003212007.GC4484@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206943>

On Wed, Oct 3, 2012 at 11:20 PM, Jeff King <peff@peff.net> wrote:

Thanks for all that info, it's really useful.

>>  * A co-worker who was working on this today tried it on 1.7.12 and
>>    claimed that it had the same performance characteristics.
>
> That's surprising to me. Can you try to verify those numbers?

I think he was wrong, I tested this on git.git by first creating a lot
of tags:

     parallel --eta "git tag -a -m"{}" test-again-{}" ::: $(git rev-list HEAD)

Then doing:

    git pack-refs --all
    git repack -A -d

And compiled with -g -O3 I get around 1.55 runs/s of git-upload-pack
on 1.7.8 and 2.59/s on the master branch.

>>  * I tried to profile it under gcc -pg && echo -n | ./git-upload-pack
>>    <repo> but it doesn't produce a profile like that, presumably
>>    because the process exits unsuccessfully.
>
> If it's a recent version of Linux, you'll get much nicer results with
> perf. Here's what my 400K-ref case looks like:
>
>   $ time echo 0000 | perf record git-upload-pack . >/dev/null
>   real    0m0.808s
>   user    0m0.660s
>   sys     0m0.136s
>
>   $ perf report | grep -v ^# | head
>   11.40%  git-upload-pack  libc-2.13.so        [.] vfprintf
>    9.70%  git-upload-pack  git-upload-pack     [.] find_pack_entry_one
>    7.64%  git-upload-pack  git-upload-pack     [.] check_refname_format
>    6.81%  git-upload-pack  libc-2.13.so        [.] __memcmp_sse4_1
>    5.79%  git-upload-pack  libc-2.13.so        [.] getenv
>    4.20%  git-upload-pack  libc-2.13.so        [.] __strlen_sse42
>    3.72%  git-upload-pack  git-upload-pack     [.] ref_entry_cmp_sslice
>    3.15%  git-upload-pack  git-upload-pack     [.] read_packed_refs
>    2.65%  git-upload-pack  git-upload-pack     [.] sha1_to_hex
>    2.44%  git-upload-pack  libc-2.13.so        [.] _IO_default_xsputn

FWIW here are my results on the above pathological git.git

    $ uname -r; perf --version; echo 0000 | perf record
./git-upload-pack .>/dev/null; perf report | grep -v ^# | head
    3.2.0-2-amd64
    perf version 3.2.17
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.026 MB perf.data (~1131 samples) ]
        29.08%  git-upload-pack  libz.so.1.2.7       [.] inflate
        17.99%  git-upload-pack  libz.so.1.2.7       [.] 0xaec1
         6.21%  git-upload-pack  libc-2.13.so        [.] 0x117503
         5.69%  git-upload-pack  libcrypto.so.1.0.0  [.] 0x82c3d
         4.87%  git-upload-pack  git-upload-pack     [.] find_pack_entry_one
         3.18%  git-upload-pack  ld-2.13.so          [.] 0x886e
         2.96%  git-upload-pack  libc-2.13.so        [.] vfprintf
         2.83%  git-upload-pack  git-upload-pack     [.] search_for_subdir
         1.56%  git-upload-pack  [kernel.kallsyms]   [k] do_raw_spin_lock
         1.36%  git-upload-pack  libc-2.13.so        [.] vsnprintf

I wonder why your report doesn't note any time in libz. This is on
Debian testing, maybe your OS uses different strip settings so it
doesn't show up?

    $ ldd -r ./git-upload-pack
            linux-vdso.so.1 =>  (0x00007fff621ff000)
            libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f768feee000)
            libcrypto.so.1.0.0 =>
/usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 (0x00007f768fb0a000)
            libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0
(0x00007f768f8ed000)
            libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f768f566000)
            libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f768f362000)
            /lib64/ld-linux-x86-64.so.2 (0x00007f7690117000
