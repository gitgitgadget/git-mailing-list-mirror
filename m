From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: Why Git is so fast
Date: Thu, 30 Apr 2009 23:36:07 +0200
Organization: private
Message-ID: <8663gllt88.fsf@broadpark.no>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
 <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
 <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org>
 <86iqkllw0c.fsf@broadpark.no> <20090430204033.GV23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 23:36:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzdvq-0008F7-P5
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 23:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbZD3Vgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbZD3Vga
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 17:36:30 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:64491 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZD3Vg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 17:36:29 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIX00E56O0TG3D0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 30 Apr 2009 23:36:29 +0200 (CEST)
Received: from localhost ([80.202.166.238]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIX00ENOO0R8L60@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 30 Apr 2009 23:36:29 +0200 (CEST)
In-reply-to: <20090430204033.GV23604@spearce.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118047>

* "Shawn O. Pearce" <spearce@spearce.org> writes:
|>      4) The "static inline void hashcpy(....)" in cache.h could then
|>         maybe be written like this:
|
| Its already done as "memcpy(a, b, 20)" which most compilers will
| inline and probably reduce to 5 word moves anyway.  That's why
| hashcpy() itself is inline.

  But would the compiler be able to trust that the hashcpy() is always
  called with correct word alignment on variables a and b?

  I made a test and compiled git with:

    make USE_NSEC=1 CFLAGS="-march=core2 -mtune=core2 -O2 -g2 -fno-stack-protector" clean all

  compiler: gcc (Gentoo 4.3.3-r2 p1.1, pie-10.1.5) 4.3.3
  CPU: Intel(R) Core(TM)2 CPU T7200 @ 2.00GHz GenuineIntel

  Then used gdb to get the following:

(gdb) disassemble write_sha1_file
Dump of assembler code for function write_sha1_file:
0x080e3830 <write_sha1_file+0>:	push   %ebp
0x080e3831 <write_sha1_file+1>:	mov    %esp,%ebp
0x080e3833 <write_sha1_file+3>:	sub    $0x58,%esp
0x080e3836 <write_sha1_file+6>:	lea    -0x10(%ebp),%eax
0x080e3839 <write_sha1_file+9>:	mov    %ebx,-0xc(%ebp)
0x080e383c <write_sha1_file+12>:	mov    %esi,-0x8(%ebp)
0x080e383f <write_sha1_file+15>:	mov    %edi,-0x4(%ebp)
0x080e3842 <write_sha1_file+18>:	mov    0x14(%ebp),%ebx
0x080e3845 <write_sha1_file+21>:	mov    %eax,0x8(%esp)
0x080e3849 <write_sha1_file+25>:	lea    -0x44(%ebp),%edi
0x080e384c <write_sha1_file+28>:	lea    -0x24(%ebp),%esi
0x080e384f <write_sha1_file+31>:	mov    %edi,0x4(%esp)
0x080e3853 <write_sha1_file+35>:	mov    %esi,(%esp)
0x080e3856 <write_sha1_file+38>:	mov    0x10(%ebp),%ecx
0x080e3859 <write_sha1_file+41>:	mov    0xc(%ebp),%edx
0x080e385c <write_sha1_file+44>:	mov    0x8(%ebp),%eax
0x080e385f <write_sha1_file+47>:	call   0x80e0350 <write_sha1_file_prepare>
0x080e3864 <write_sha1_file+52>:	test   %ebx,%ebx
0x080e3866 <write_sha1_file+54>:	je     0x80e3885 <write_sha1_file+85>

0x080e3868 <write_sha1_file+56>:	mov    -0x24(%ebp),%eax
0x080e386b <write_sha1_file+59>:	mov    %eax,(%ebx)
0x080e386d <write_sha1_file+61>:	mov    -0x20(%ebp),%eax
0x080e3870 <write_sha1_file+64>:	mov    %eax,0x4(%ebx)
0x080e3873 <write_sha1_file+67>:	mov    -0x1c(%ebp),%eax
0x080e3876 <write_sha1_file+70>:	mov    %eax,0x8(%ebx)
0x080e3879 <write_sha1_file+73>:	mov    -0x18(%ebp),%eax
0x080e387c <write_sha1_file+76>:	mov    %eax,0xc(%ebx)
0x080e387f <write_sha1_file+79>:	mov    -0x14(%ebp),%eax
0x080e3882 <write_sha1_file+82>:	mov    %eax,0x10(%ebx)

  I admit that I am not particular familar with intel machine
  instructions, but I guess that the above 10 mov instructions is the
  result for the compiled inline hashcpy() in the write_sha1_file()
  function in sha1_file.c

  Question: would it be possible for the compiler to compile it down to
  just 5 mov instructions if we had used unsigned 32 bits type?  Or is
  this the best we can reasonable hope for inside the write_sha1_file()
  function?

  I checked 3 other output of "disassemble function_foo", and it seems
  that those 3 functions I checked got 10 mov instructions for the
  inline hashcpy(), as far as I can tell.

0x080e3885 <write_sha1_file+85>:	mov    %esi,(%esp)
0x080e3888 <write_sha1_file+88>:	call   0x80e3800 <has_sha1_file>
0x080e388d <write_sha1_file+93>:	xor    %edx,%edx
0x080e388f <write_sha1_file+95>:	test   %eax,%eax
0x080e3891 <write_sha1_file+97>:	jne    0x80e38b6 <write_sha1_file+134>
0x080e3893 <write_sha1_file+99>:	mov    0xc(%ebp),%eax
0x080e3896 <write_sha1_file+102>:	mov    %edi,%edx
0x080e3898 <write_sha1_file+104>:	mov    %eax,0x4(%esp)
0x080e389c <write_sha1_file+108>:	mov    -0x10(%ebp),%ecx
0x080e389f <write_sha1_file+111>:	mov    0x8(%ebp),%eax
0x080e38a2 <write_sha1_file+114>:	movl   $0x0,0x8(%esp)
0x080e38aa <write_sha1_file+122>:	mov    %eax,(%esp)
0x080e38ad <write_sha1_file+125>:	mov    %esi,%eax
0x080e38af <write_sha1_file+127>:	call   0x80e1e40 <write_loose_object>
0x080e38b4 <write_sha1_file+132>:	mov    %eax,%edx
0x080e38b6 <write_sha1_file+134>:	mov    %edx,%eax
0x080e38b8 <write_sha1_file+136>:	mov    -0xc(%ebp),%ebx
0x080e38bb <write_sha1_file+139>:	mov    -0x8(%ebp),%esi
0x080e38be <write_sha1_file+142>:	mov    -0x4(%ebp),%edi
0x080e38c1 <write_sha1_file+145>:	leave  
0x080e38c2 <write_sha1_file+146>:	ret    
End of assembler dump.
(gdb) 

  So, maybe the compiler is doing the right thing after all?

  -- kjetil
