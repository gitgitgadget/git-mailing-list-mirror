From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 14:56:00 -0700
Message-ID: <7E527329-230E-4954-9942-8BB0935ACE4D@gmail.com>
References: <1376900499-662-1-git-send-email-prohaska@zib.de> <1376926879-30846-1-git-send-email-prohaska@zib.de> <CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com> <xmqqeh9p8ut3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 23:56:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBXQp-0002Za-8N
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 23:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab3HSV4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 17:56:06 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:46574 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab3HSV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 17:56:05 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so942984pbc.30
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=pDxKLBexlsBT/E+gPair7nPtjIbHVd6JDoeeWphhDes=;
        b=QBg1WAFB1AlWuMB7BFgkpXdqncu7NsnEG/sNY5mWWcT1s/KsO6WRXKOqkZe5++Dp/E
         1GtnPwGzplEQ76Oe/gO4agFctdDSYJWHf4fYFy8aD+NpvqJXPCGjR+le11Y6bVTFqbNn
         JKMF60Yoye7DGTlJVwCsYltxh56TjmLnUFEz2OyxoV4PHWoboRAHHEVkcAkLdw0N+Geo
         nK8LEMnG4ic64WJO+EW8OOg9ekg1bc7z9i341nw4SGuJZrTnLhg+7XJoHusox5O8fRzU
         PHoZt5lmXg+FJExc6MBLAKkicvKwjEP7AvbIPScaTg+ic8GnPTaFjHGdGFfsdjRSxVL6
         bRCA==
X-Received: by 10.68.221.233 with SMTP id qh9mr15484439pbc.103.1376949363952;
        Mon, 19 Aug 2013 14:56:03 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ys4sm17190337pbb.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 14:56:03 -0700 (PDT)
In-Reply-To: <xmqqeh9p8ut3.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232573>

On Aug 19, 2013, at 10:16, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So why isn't the patch much more straightforward? Like the attached
>> totally untested one that just limits the read/write size to 8MB
>> (which is totally arbitrary, but small enough to not have any latency
>> issues even on slow disks, and big enough that any reasonable IO
>> subsystem will still get good throughput).
>
> Ahh.  OK, not noticing EINVAL unconditionally, but always feed IOs
> in chunks that are big enough for sane systems but small enough for
> broken ones.
>
> That makes sense.  Could somebody on MacOS X test this?

I tested this on both i386 (OS X 32-bit intel) and x86_64 (OS X 64-bit  
intel).

What I tested:

1. I started with branch pu:
    (965adb10 Merge branch 'sg/bash-prompt-lf-in-cwd-test' into pu)

2. I added Steffen's additional test (modified to always run) to t0021:

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e50f0f7..b92e6cb 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -190,4 +190,16 @@ test_expect_success 'required filter clean  
failure' '
	test_must_fail git add test.fc
'

+test_expect_success 'filter large file' '
+	git config filter.largefile.smudge cat &&
+	git config filter.largefile.clean cat &&
+	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
+	echo "2GB filter=largefile" >.gitattributes &&
+	git add 2GB 2>err &&
+	! test -s err &&
+	rm -f 2GB &&
+	git checkout -- 2GB 2>err &&
+	! test -s err
+'
+
test_done

3. I verified that the test fails with an unpatched build on both 32- 
bit and 64-bit.

4. I applied Linus's unmodified patch to wrapper.c.

5. I tested again.  The t0021 test now passes on 64-bit.  It still  
fails on 32-bit for another reason unrelated to Linus's patch.

It fails when attempting the "git add 2GB" line from the new 'filter  
large file' part of the test.  The failure with backtrace:

git(16806,0xa095c720) malloc: *** mmap(size=2147487744) failed (error  
code=12)
*** error: can't allocate region
*** set a breakpoint in malloc_error_break to debug

# NOTE: error code 12 is ENOMEM on OS X

Breakpoint 1, 0x97f634b1 in malloc_error_break ()
(gdb) bt
#0  0x97f634b1 in malloc_error_break ()
#1  0x97f5e49f in szone_error ()
#2  0x97e8b876 in allocate_pages ()
#3  0x97e8c062 in large_and_huge_malloc ()
#4  0x97e831c8 in szone_malloc ()
#5  0x97e82fb8 in malloc_zone_malloc ()
#6  0x97e8c7b2 in realloc ()
#7  0x00128abe in xrealloc (ptr=0x0, size=2147483649) at wrapper.c:100
#8  0x00111a8c in strbuf_grow (sb=0xbfffe634, extra=2147483648) at  
strbuf.c:74
#9  0x00112bb9 in strbuf_read (sb=0xbfffe634, fd=6, hint=2548572518)  
at strbuf.c:349
#10 0x0009b899 in apply_filter (path=<value temporarily unavailable,  
due to optimizations>, src=0x1000000 ' ' <repeats 200 times>...,  
len=2147483648, dst=0xbfffe774, cmd=0x402980 "cat") at convert.c:407
#11 0x0009c6f6 in convert_to_git (path=0x4028b4 "2GB", src=0x1000000 '  
' <repeats 200 times>..., len=2147483648, dst=0xbfffe774,  
checksafe=SAFE_CRLF_WARN) at convert.c:764
#12 0x0010bb38 in index_mem (sha1=0x402330 "", buf=0x1000000,  
size=2147483648, type=OBJ_BLOB, path=0x4028b4 "2GB", flags=1) at  
sha1_file.c:3044
#13 0x0010bf57 in index_core [inlined] () at /private/var/tmp/src/git/ 
sha1_file.c:3101
#14 0x0010bf57 in index_fd (sha1=0x402330 "", fd=5, st=0xbfffe900,  
type=OBJ_BLOB, path=0x4028b4 "2GB", flags=1) at sha1_file.c:3139
#15 0x0010c05e in index_path (sha1=0x402330 "", path=0x4028b4 "2GB",  
st=0xbfffe900, flags=1) at sha1_file.c:3157
#16 0x000e82f4 in add_to_index (istate=0x1a8820, path=0x4028b4 "2GB",  
st=0xbfffe900, flags=0) at read-cache.c:665
#17 0x000e87c8 in add_file_to_index (istate=0x1a8820, path=0x4028b4  
"2GB", flags=0) at read-cache.c:694
#18 0x0000440a in cmd_add (argc=<value temporarily unavailable, due to  
optimizations>, argv=0xbffff584, prefix=0x0) at builtin/add.c:299
#19 0x00002e1f in run_builtin [inlined] () at /private/var/tmp/src/git/ 
git.c:303
#20 0x00002e1f in handle_internal_command (argc=2, argv=0xbffff584) at  
git.c:466
#21 0x000032d4 in run_argv [inlined] () at /private/var/tmp/src/git/ 
git.c:512
#22 0x000032d4 in main (argc=2, av=0xbfffe28c) at git.c:595

The size 2147487744 is 2GB + 4096 bytes.  Apparently git does not  
support a filter for a file unless the file can fit entirely into  
git's memory space.  Normally a single 2GB + 4096 byte allocation  
works in an OS X 32-bit process, but something else is apparently  
eating up a large portion of the memory space in this case (perhaps an  
mmap'd copy?).  In any case, if the file being filtered was closer to  
4GB in size it would always fail on 32-bit regardless.

The fact that the entire file is read into memory when applying the  
filter does not seem like a good thing (see #7-#10 above).

--Kyle
