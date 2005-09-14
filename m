From: Wayne Scott <wsc9tt@gmail.com>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 13:40:27 -0500
Message-ID: <59a6e583050914114054b1564d@mail.gmail.com>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	 <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
Reply-To: wsc9tt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 20:41:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFcBc-00044B-Dm
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 20:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVINSkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 14:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVINSkg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 14:40:36 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:57646 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932301AbVINSkg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 14:40:36 -0400
Received: by xproxy.gmail.com with SMTP id i28so35894wxd
        for <git@vger.kernel.org>; Wed, 14 Sep 2005 11:40:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qbmcW5eZ+SZpueNZRm5WV1TWMl7I17iC5Q0i3bH5jYnmsJHIb57hr2mxhItROZmdNWQVoY1ZePue/zy+/PaguqKaHHCdu6bfXFVsqkB8l4cM9ga4xX+x+CvPCMVROA6wHG7z0A8h4ABURuW2SfDUqYVmZZTGd3socAtHiNznPFQ=
Received: by 10.70.84.13 with SMTP id h13mr374644wxb;
        Wed, 14 Sep 2005 11:40:27 -0700 (PDT)
Received: by 10.70.7.3 with HTTP; Wed, 14 Sep 2005 11:40:27 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8552>

On 9/14/05, Junio C Hamano <junkio@cox.net> wrote:
> Wayne Scott <wsc9tt@gmail.com> writes:
> 
> > Look at the diffs between ad6571a78ac74e9fa27e581834709067dba459af and
> > it's parent with and without rename detection enabled.  (In linux-2.6
> > git tree)
> 
> > Notice how the the fact that include/asm-ppc64/termios.h is
> > deleted gets lost?  Looks broken to me.
> 
> I suspect that what is deleted is not asm-ppc64/termios.h but
> asm-ppc/termios.h.  The below is an output without grep which
> seems to confuse things.
> 
> $ git-diff-tree -r -M ad6571a78ac74e9fa27e581834709067dba459af |
>   sed -ne 's/^.* \([AMCRDU]\)/\1/p'
> R092    include/asm-ppc64/mman.h        include/asm-powerpc/mman.h
> R097    include/asm-ppc64/termbits.h    include/asm-powerpc/termbits.h
> R098    include/asm-ppc64/termios.h     include/asm-powerpc/termios.h
> D       include/asm-ppc/mman.h
> D       include/asm-ppc/termbits.h
> D       include/asm-ppc/termios.h
> 
> $ git-diff-tree -r ad6571a78ac74e9fa27e581834709067dba459af |
>   sed -ne 's/^.* \([AMCRDU]\)/\1/p'
> A       include/asm-powerpc/mman.h
> A       include/asm-powerpc/termbits.h
> A       include/asm-powerpc/termios.h
> D       include/asm-ppc/mman.h
> D       include/asm-ppc/termbits.h
> D       include/asm-ppc/termios.h
> D       include/asm-ppc64/mman.h
> D       include/asm-ppc64/termbits.h
> D       include/asm-ppc64/termios.h
> 
> The first 3 A and last 3 D are accounted for in the -M output as
> renames from asm-ppc64 to asm-powerpc.  Middle 3 D from asm-ppc
> are shown in the -M output.  So I do not think we are losing
> anything.  Am I missing something?


Odd.  I get the same answer on my x86 box:
$ git-diff-tree -r -M ad6571a78ac74e9fa27e581834709067dba459af |   sed
-ne 's/^.* \([AMCRDU]\)/\1/p'
R092    include/asm-ppc64/mman.h        include/asm-powerpc/mman.h
R097    include/asm-ppc64/termbits.h    include/asm-powerpc/termbits.h
R098    include/asm-ppc64/termios.h     include/asm-powerpc/termios.h
D       include/asm-ppc/mman.h
D       include/asm-ppc/termbits.h
D       include/asm-ppc/termios.h

But here is the output on my quad xeon running in 64-bit mode: (fedora core 2)

$ git-diff-tree -r -M ad6571a78ac74e9fa27e581834709067dba459af |   sed
-ne 's/^.* \([AMCRDU]\)/\1/p'
R092    include/asm-ppc64/mman.h        include/asm-powerpc/mman.h
R097    include/asm-ppc64/termbits.h    include/asm-powerpc/termbits.h
A       include/asm-powerpc/termios.h
D       include/asm-ppc/mman.h
D       include/asm-ppc/termbits.h
D       include/asm-ppc/termios.h

This is the same version of git both rebuilt just for this test.

However, I noticed a whole collection of errors from valgrind when I
run this command line:

==13457== Invalid read of size 4
==13457==    at 0x805402C: locate_rename_dst (diffcore-rename.c:28)
==13457==    by 0x805464B: diffcore_rename (diffcore-rename.c:356)
==13457==    by 0x805249D: diffcore_std (diff.c:1093)
==13457==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13457==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13457==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13457==    by 0x804A884: main (diff-tree.c:551)
==13457==  Address 0x1BBD781C is 20 bytes inside a block of size 71 free'd
==13457==    at 0x1B9003C3: free (vg_replace_malloc.c:235)
==13457==    by 0x805205B: diff_free_filepair (diff.c:775)
==13457==    by 0x805422A: diffcore_rename (diffcore-rename.c:415)
==13457==    by 0x805249D: diffcore_std (diff.c:1093)
==13457==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13457==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13457==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13457==    by 0x804A884: main (diff-tree.c:551)
==13457== 
==13457== Invalid read of size 1
==13457==    at 0x1B90140D: strcmp (mac_replace_strmem.c:332)
==13457==    by 0x8054038: locate_rename_dst (diffcore-rename.c:28)
==13457==    by 0x805464B: diffcore_rename (diffcore-rename.c:356)
==13457==    by 0x805249D: diffcore_std (diff.c:1093)
==13457==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13457==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13457==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13457==    by 0x804A884: main (diff-tree.c:551)
==13457==  Address 0x1BBD7830 is 40 bytes inside a block of size 71 free'd
==13457==    at 0x1B9003C3: free (vg_replace_malloc.c:235)
==13457==    by 0x805205B: diff_free_filepair (diff.c:775)
==13457==    by 0x805422A: diffcore_rename (diffcore-rename.c:415)
==13457==    by 0x805249D: diffcore_std (diff.c:1093)
==13457==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13457==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13457==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13457==    by 0x804A884: main (diff-tree.c:551)
==13457== 
==13457== Invalid read of size 1
==13457==    at 0x1B901423: strcmp (mac_replace_strmem.c:332)
==13457==    by 0x8054038: locate_rename_dst (diffcore-rename.c:28)
==13457==    by 0x805464B: diffcore_rename (diffcore-rename.c:356)
==13457==    by 0x805249D: diffcore_std (diff.c:1093)
==13457==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13457==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13457==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13457==    by 0x804A884: main (diff-tree.c:551)
==13504== Invalid read of size 4
==13504==    at 0x805402C: locate_rename_dst (diffcore-rename.c:28)
==13504==    by 0x805464B: diffcore_rename (diffcore-rename.c:356)
==13504==    by 0x805249D: diffcore_std (diff.c:1093)
==13504==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13504==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13504==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13504==    by 0x804A884: main (diff-tree.c:551)
==13504==  Address 0x1BBD781C is 20 bytes inside a block of size 71 free'd
==13504==    at 0x1B9003C3: free (vg_replace_malloc.c:235)
==13504==    by 0x805205B: diff_free_filepair (diff.c:775)
==13504==    by 0x805422A: diffcore_rename (diffcore-rename.c:415)
==13504==    by 0x805249D: diffcore_std (diff.c:1093)
==13504==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13504==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13504==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13504==    by 0x804A884: main (diff-tree.c:551)
==13504== 
==13504== Invalid read of size 1
==13504==    at 0x1B90140D: strcmp (mac_replace_strmem.c:332)
==13504==    by 0x8054038: locate_rename_dst (diffcore-rename.c:28)
==13504==    by 0x805464B: diffcore_rename (diffcore-rename.c:356)
==13504==    by 0x805249D: diffcore_std (diff.c:1093)
==13504==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13504==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13504==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13504==    by 0x804A884: main (diff-tree.c:551)
==13504==  Address 0x1BBD7830 is 40 bytes inside a block of size 71 free'd
==13504==    at 0x1B9003C3: free (vg_replace_malloc.c:235)
==13504==    by 0x805205B: diff_free_filepair (diff.c:775)
==13504==    by 0x805422A: diffcore_rename (diffcore-rename.c:415)
==13504==    by 0x805249D: diffcore_std (diff.c:1093)
==13504==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13504==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13504==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13504==    by 0x804A884: main (diff-tree.c:551)
==13504== 
==13504== Invalid read of size 1
==13504==    at 0x1B901423: strcmp (mac_replace_strmem.c:332)
==13504==    by 0x8054038: locate_rename_dst (diffcore-rename.c:28)
==13504==    by 0x805464B: diffcore_rename (diffcore-rename.c:356)
==13504==    by 0x805249D: diffcore_std (diff.c:1093)
==13504==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13504==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13504==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13504==    by 0x804A884: main (diff-tree.c:551)
==13504==  Address 0x1BBD7831 is 41 bytes inside a block of size 71 free'd
==13504==    at 0x1B9003C3: free (vg_replace_malloc.c:235)
==13504==    by 0x805205B: diff_free_filepair (diff.c:775)
==13504==    by 0x805422A: diffcore_rename (diffcore-rename.c:415)
==13504==    by 0x805249D: diffcore_std (diff.c:1093)
==13504==    by 0x8049B48: call_diff_flush (diff-tree.c:273)
==13504==    by 0x804A225: diff_tree_sha1_top (diff-tree.c:298)
==13504==    by 0x804A30B: diff_tree_commit (diff-tree.c:363)
==13504==    by 0x804A884: main (diff-tree.c:551)
==13504== 

Perhaps that explains the difference.

-Wayne
